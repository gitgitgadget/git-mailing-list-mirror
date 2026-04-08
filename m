Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03CEF391505
	for <git@vger.kernel.org>; Wed,  8 Apr 2026 20:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775679993; cv=none; b=LX/3jznlCPxs5aFkTAK1+vv6XRRTnpw4rcq/oa6NW/H/uhr/TIBBuB5VINEZU3rW7hsLl+nknCBhpU/PRTxnOX7tE1gBA4pIaci8ySTyw7fybs31180q3QGLoVAeXO3r6Up2HT9dS1Ybmqvq/E+TKg5ul094SoJq6QLJ+UNF5Yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775679993; c=relaxed/simple;
	bh=Ytl9o+LHIHaNAOdqy70i7uUQubRYz6X0wM82lRV4ZDU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Sm3B/VgZ3X5fGXGAC9c22hdmN5WKJCZGUTyrCEuW+waGV+3GItaDhEezYDyHUCvizY3g4SJXnf0qu+aoMwyRRxpQoqIvmAm2HvgEYT0vaQqt1L1H7nd3fS7E4gpisOwJVYs4EXvxKpaegmqAt926cx1GpPmB7yM4AbHAuVTPY2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RAfZ/tAq; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RAfZ/tAq"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2b23f90f53aso2310765ad.0
        for <git@vger.kernel.org>; Wed, 08 Apr 2026 13:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775679991; x=1776284791; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zBsZTaINFeDLVL7WqGaqZ2HcI08KQvJE4wjLzWju9hE=;
        b=RAfZ/tAqoZXrZjSY/rbpwTdWBLtbTv8noQ8LuneT/8aXqDWRj1X8YR/w6Q/zQ6z8fh
         fouBrV5Y8K/UFwcp607R/VhN+R89eIw+fiqwE2oaHF3A6+CMtm0awIjllkEGUxpnwceg
         1S2v0+g0UNrkCgMhKIx55uL9RTvNWOt5TeEnMc8LGQE/1cNkEK3puBVlXp6e32iyeEKh
         8DxTglmKr6AW6ePc7mgmmD7ow7Q49YFgQGsML6V9gvM3zEKM7j8RktE3nQWXMw1ttRhw
         9tdntKL87nA1z/cyAGi+US/NZUG8vq6RiA29jOmL73/Ik38rY3FnmCYY5p8XXjqreYlV
         Sa+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775679991; x=1776284791;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zBsZTaINFeDLVL7WqGaqZ2HcI08KQvJE4wjLzWju9hE=;
        b=rxvcuyAsO4Gk+Ni90E8pobrx9cdx4fV31H8i9HhGx9wmACQy/IMdcMuNgEAMQr0ecg
         dbz194GKnZjMBDOkRj9zQm9+ozrnKrzzSq74i9WVXLcE8X5b4pQXHs33iMg9La3/KjcN
         4Y9VZPMD77kupkuUmfaK2kfVS8aVHW4cSGoH8U22Cyu0tgnOElhdZ065J6nEBYbhaCYQ
         Fasd2WJwKCALlThOquYWP4SMiPCA8jwszywO9sxb6k+E3aSPpRJu8sMrH3dwRbvyp4ne
         rIJR8H6PZE9F4ZSWiiH8MJvkFXSmdg1IdbSsIzloPymszEwXGQTn0EsIrpmgqqf/uFjb
         EWIQ==
X-Gm-Message-State: AOJu0YykRL2JNPye3/PgLWy+zM9pEXDKO/faJtmb02np5il9fP3T+Ujb
	dhKjd3Ij1AYYCReDSwAXryU8dojKfhey2FuhKI5ojeugf6C5matqjhWqHcb4Lg==
X-Gm-Gg: AeBDietgvSnzEJr6g2HDveX5cKTxsx+LGGVTLY2v4Qrx7MFwdMxAJV5CaFiyRLFfl7q
	2WfOZINI+By81yZaATjPACDNCMi2DCCnNST0pcXix5QuE/6EFTrbA+n8Yd+02eNdoRMl0Ypj01+
	0PgdvjM4doeqxrWvS15FoyXdGtVGK4b+49cMFxWI0J3nzmrtTRBdmRLH68IjB8G4ROL5Ty0mEjr
	5BHwUM+4XaqgPrpFckagITfnTJZ3Pmyp61HcSxQXm4nFuJjKozMRTp/dia9vbpK3omzuYvVPNjQ
	YRi69KF/xwB8zAD4+WyFSIVY22Wmk5b/TP+AieaaYG802WsJTzccXF+ImrHK2gqFIFCTjiGm822
	4rfR+/6RnLJsuvz3qa05GimwezvV2FaHaRWgjcXW9AuwIYX6tXIkPvICApNMSIHPB/KSaxitIPP
	Q+9oQYW//ty7lJSP8ml6n2SYGWMqUn
X-Received: by 2002:a05:7022:45a6:b0:12b:ebb9:1c18 with SMTP id a92af1059eb24-12bfb7677e7mr12592985c88.31.1775679990763;
        Wed, 08 Apr 2026 13:26:30 -0700 (PDT)
Received: from [127.0.0.1] ([172.184.209.145])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c295de797sm638630c88.12.2026.04.08.13.26.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 13:26:29 -0700 (PDT)
Message-Id: <pull.2156.v5.git.git.1775679988.gitgitgadget@gmail.com>
In-Reply-To: <pull.2156.v4.git.git.1774890003.gitgitgadget@gmail.com>
References: <pull.2156.v4.git.git.1774890003.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 08 Apr 2026 20:26:22 +0000
Subject: [PATCH v5 0/6] Xdiff cleanup part 3
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Yee Cheng Chin <ychin.git@gmail.com>,
    Phillip Wood <phillip.wood123@gmail.com>,
    =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
    Jeff King <peff@peff.net>,
    "D. Ben Knoble" <ben.knoble@gmail.com>,
    SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
    Ezekiel Newren <ezekielnewren@gmail.com>

Changes in v5:

 * drop commit "xdiff/xdl_cleanup_records: simplify INVESTIGATE handling for
   clarity".
 * add braces around the else clause

I didn't see a better way to rewrite how action is used so I reverted to
what it used to be.

Changes in v4:

 * Change SIZE_MAX to PTRDIFF_MAX.

Changes in v3:

 * run make DEVELOPER=1 on each commit and fix all compiler issues

v2 is a radical departure from v1 Changes in v2:

 * make the flow of xdl_cleanup_records() easier to follow

There is no performance or behavioral change introduced in this patch
series.

=== original cover letter bellow ===

Patch series summary:

 * patch 1: Introduce the ivec type
 * patch 2: Create the function xdl_do_classic_diff()
 * patches 3-4: generic cleanup
 * patches 5-8: convert from dstart/dend (in xdfile_t) to
   delta_start/delta_end (in xdfenv_t)
 * patches 9-10: move xdl_cleanup_records(), and related, from xprepare.c to
   xdiffi.c

Things that will be addressed in future patch series:

 * Make xdl_cleanup_records() easier to read
 * convert recs/nrec into an ivec
 * convert changed to an ivec
 * remove reference_index/nreff from xdfile_t and turn it into an ivec
 * splitting minimal_perfect_hash out as its own ivec
 * improve the performance of the classifier and parsing/hashing lines

=== before this patch series typedef struct s_xdfile { xrecord_t *recs;
size_t nrec; ptrdiff_t dstart, dend; bool *changed; size_t *reference_index;
size_t nreff; } xdfile_t;

typedef struct s_xdfenv { xdfile_t xdf1, xdf2; } xdfenv_t;

=== after this patch series typedef struct s_xdfile { xrecord_t *recs;
size_t nrec; bool *changed; size_t *reference_index; size_t nreff; }
xdfile_t;

typedef struct s_xdfenv { xdfile_t xdf1, xdf2; size_t delta_start,
delta_end; size_t mph_size; } xdfenv_t;

Ezekiel Newren (6):
  xdiff/xdl_cleanup_records: delete local recs pointer
  xdiff: use unambiguous types in xdl_bogo_sqrt()
  xdiff/xdl_cleanup_records: use unambiguous types
  xdiff/xdl_cleanup_records: make limits more clear
  xdiff/xdl_cleanup_records: make setting action easier to follow
  xdiff/xdl_cleanup_records: put braces around the else clause

 xdiff/xdiffi.c   |  2 +-
 xdiff/xprepare.c | 56 +++++++++++++++++++++++++++++++-----------------
 xdiff/xutils.c   |  4 ++--
 xdiff/xutils.h   |  2 +-
 4 files changed, 40 insertions(+), 24 deletions(-)


base-commit: ca1db8a0f7dc0dbea892e99f5b37c5fe5861be71
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2156%2Fezekielnewren%2Fxdiff-cleanup-3-v5
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2156/ezekielnewren/xdiff-cleanup-3-v5
Pull-Request: https://github.com/git/git/pull/2156

Range-diff vs v4:

 1:  da32a9747c = 1:  b31924a949 xdiff/xdl_cleanup_records: delete local recs pointer
 2:  86b0ad100c = 2:  1822166fef xdiff: use unambiguous types in xdl_bogo_sqrt()
 3:  39a35365ae = 3:  85aa0da90c xdiff/xdl_cleanup_records: use unambiguous types
 4:  75fe3ea125 = 4:  fec2b0f38a xdiff/xdl_cleanup_records: make limits more clear
 5:  0cf1412d01 = 5:  88c68fa89a xdiff/xdl_cleanup_records: make setting action easier to follow
 6:  fd14ccafc4 ! 6:  699e198fa9 xdiff/xdl_cleanup_records: simplify INVESTIGATE handling for clarity
     @@ Metadata
      Author: Ezekiel Newren <ezekielnewren@gmail.com>
      
       ## Commit message ##
     -    xdiff/xdl_cleanup_records: simplify INVESTIGATE handling for clarity
     -
     -    Make it clear that INVESTIGATE is turned into KEEP or DISCARD based on
     -    the result of xdl_clean_mmatch() which reduces actionX[i] into a
     -    boolean value.
     +    xdiff/xdl_cleanup_records: put braces around the else clause
      
          Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
      
       ## xdiff/xprepare.c ##
      @@ xdiff/xprepare.c: static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xd
     - 	 */
     - 	xdf1->nreff = 0;
     - 	for (i = xdf1->dstart; i <= xdf1->dend; i++) {
     --		if (action1[i] == KEEP ||
     --		    (action1[i] == INVESTIGATE && !xdl_clean_mmatch(action1, i, xdf1->dstart, xdf1->dend))) {
     -+		if (action1[i] == INVESTIGATE) {
     -+			if (!xdl_clean_mmatch(action1, i, xdf1->dstart, xdf1->dend))
     -+				action1[i] = KEEP;
     -+			else
     -+				action1[i] = DISCARD;
     -+		}
     -+
     -+		if (action1[i] == KEEP) {
     + 		    (action1[i] == INVESTIGATE && !xdl_clean_mmatch(action1, i, xdf1->dstart, xdf1->dend))) {
       			xdf1->reference_index[xdf1->nreff++] = i;
     --			/* changed[i] remains false, i.e. keep */
     + 			/* changed[i] remains false, i.e. keep */
      -		} else
     -+			/* changed[i] remains false */
     -+		} else if (action1[i] == DISCARD)
     ++		} else {
       			xdf1->changed[i] = true;
     --			/* i.e. discard */
     -+		else
     -+			BUG("Illegal state for action1[i]");
     + 			/* i.e. discard */
     ++		}
       	}
       
       	xdf2->nreff = 0;
     - 	for (i = xdf2->dstart; i <= xdf2->dend; i++) {
     --		if (action2[i] == KEEP ||
     --		    (action2[i] == INVESTIGATE && !xdl_clean_mmatch(action2, i, xdf2->dstart, xdf2->dend))) {
     -+		if (action2[i] == INVESTIGATE) {
     -+			if (!xdl_clean_mmatch(action2, i, xdf2->dstart, xdf2->dend))
     -+				action2[i] = KEEP;
     -+			else
     -+				action2[i] = DISCARD;
     -+		}
     -+
     -+		if (action2[i] == KEEP) {
     +@@ xdiff/xprepare.c: static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xd
     + 		    (action2[i] == INVESTIGATE && !xdl_clean_mmatch(action2, i, xdf2->dstart, xdf2->dend))) {
       			xdf2->reference_index[xdf2->nreff++] = i;
     --			/* changed[i] remains false, i.e. keep */
     + 			/* changed[i] remains false, i.e. keep */
      -		} else
     -+			/* changed[i] remains false */
     -+		} else if (action2[i] == DISCARD)
     ++		} else {
       			xdf2->changed[i] = true;
     --			/* i.e. discard */
     -+		else
     -+			BUG("Illegal state for action2[i]");
     + 			/* i.e. discard */
     ++		}
       	}
       
       cleanup:

-- 
gitgitgadget
