Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795569023;
	b=c5wfhRy5dRDXEmpsonfZEllIGI5Zxfp62KOMb+nJQ7gOHPrUzwRayTpyljJyVI/81vwr
	 ikFpfdZss7QTUSwQ3CRxmqIWgPJ4YQqpVE3vQUipG5449JSo0jOVlSHz/fO7Ppck8ic3i
	 oy8dDXtuwkN8T90xmcrt6WnG/F8NbsXck11u/etD9rCZYmd02EYW83AmycSXrwm/7SxJM
	 9Fra/LpeQQBr11HYHvXZNbCuI+eVhjmidwKlrWSES9HEh+QJPZ3mqdrevvD1mAWvbY1yp
	 AotZmIJdSQXPrTWI+7239Q0XhNJPnZu0yhT3doeF57AtnE65DgwcP+DTABVD/WtCh/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795569023;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=1NShw6AvkDGGRahCGrljj13oeZ+zSPOQX3iifd19h1w=;
	b=WnC45dn6qJ7Lsq8+cpWV/38zI1EF4YNZy5NoglrsY2IJrtypngfUG5s6FKj0nJbUzQZw
	 51TcH3cBGtrO/LxJOXwce8pILtdFm4kxyXr6IOF1vzeLCl/cscJUEh7vk9L1qTZqcR8Vt
	 RDjJVA6QA6FJv9eVMTcxvo9p2nWVfrTHFxzUI+u47sRPoIsmuvIVmyFLtgEWvCA6UjgNc
	 dDzliftCYojBxQyRUbIGYUPiinPgw4xu+TmWJAxdTYUnXxUvk4Vh5dzi6ctCK5YdZyWxo
	 scukR/8nlodCS+x+VV94oaR7/2nkXOFe9/ZR57FwRTdkikd0+SNJtqlHIq9bRwclzUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xFqN8CN9;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 365E8606A31E
	for <git@vger.kernel.org>; Wed, 25 Nov 2026 01:10:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 365E8606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xFqN8CN9
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4bb6057b333so24347475e9.3
        for <git@vger.kernel.org>; Tue, 24 Nov 2026 17:10:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795569021; x=1796173821; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1NShw6AvkDGGRahCGrljj13oeZ+zSPOQX3iifd19h1w=;
        b=xFqN8CN9ApDXWDTgjv+M01NMQ/dYGXxYVz1ZuO0HZDpYWbyIXV3GMPd+iV6vSTZcv1
         OI5JGjE0DuPdEZtHqFWCf+5TzTXfWG6lp7kz2eXbXzc9Bj7LDhLJqtq16RKUev/naPiQ
         XZV1iFMhBIjJofUJFIUYt03hbUuqqeApx/oRsoSaMfTdBX82fbFwIYshh3Ne1O7onTpd
         YBo465iOxLruK16mfiA3uXv9z2BemLQpxXRjmsHnK0dkZ2T2rIHnJGBYeATIaw1bqe5p
         eat+UEBSx4D4mykI8ywzT5z2cu1LZ7XLIprFTlgie1A5PFDgB3Jug07UhQCcKwv3x9BA
         gcCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795569021; x=1796173821;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1NShw6AvkDGGRahCGrljj13oeZ+zSPOQX3iifd19h1w=;
        b=PDeLz/+upqrhadmDp0MYkp/Rlcwmr3hW9G0yxQx8qhDmJNpZaKdFiBp9KgQmHapCDC
         Qj7SVNLhx+b1qP/wBcxutHWp0EEUQImaJFgtxPTPz5N9WFkjwhqp6JIfxoqk3wPYkY9X
         dkl0i3E13DvkZRuuUr/Nm8SzVLBe8UgflUHkQhufyQ1nuTDRKSgoepjRdnsSeTK1r8B7
         01kEtxLptFjYaRspWOjpWIVYqoOayCxg3l6auPkEBibIR+JZ9xUhWsf9/ouv/aTke7AM
         gYW1bX71nNoon4FavoORaCx6g1Ie3PttlJRxpJI3OyDdnBrWczg0aQf2j5onvdShk/kE
         ha1A==
X-Gm-Message-State: APuU4Z9Ep1KzJ1AHgxKCSWm5PnTy84+Dw2ZH3Rx4IlkhjdapHa1jAZ1k
	w+vZRKqbroUU2ptKDDOB79lZHLPK+EP8vBeyFeb7tD7hAASNvcxyJzGELzwcjHCGfbc=
X-Gm-Gg: AZFdTZeLrzeUYF3mjK1ILy6ZJYX6WMeQypJfuse+giZxPBUvLBQviobT7ZJdu+Uzd83
	hpyvkYw0RI9apAvfG1/ItnqM9QQpJZNUTmAXzD4tWEhrJ2z8ebNeIRAEupqGKQ8He78fc5G8Jem
	DzdhwG4uS0Hgkn0t98TQCoUM0rHEttfU/J7Fg2K5TXYlD2S5JiN5AcgPnv41I9yBLT/JL2+LOw9
	SCONwVz/foOmmPDoeP1Hp4qkCvxkkL5Jn/mgcQ8J3Iq/Bftx+lV86dmUQRyWik4XVC2N0UnvCtq
	Yz6RqoaG7+9Er9Rp6Y3wM2OR21hd01k7r15MyTVZdNVTL8ai+Ny+ANYA3vSdp60r+m5vRgVyDE1
	t6E32TID1zAkDBosrE1x1pupBUJkedgnsyG0tcPY2/rF+FXcI1aQs9VXVZP2W43ebCz4KiLMGK2
	4gK86ZEJJwU+VJB194tkhWwEhU5Wn6xvJ7XcZmAT0fIfr61bEy7yCi07E5af5hMX6NJxyQIXY1C
	Lf8W5PRDXbrxu27zoY8rjNwegpoeyZ4pLZkZLacCvJJdP65rmm6ik87WOM3n0Cbr4fJU2lvFSdW
	WzLvsIeE4NYrB1aB5dauwOahWvxXJZaAdzoKhdcRkp30Lu2OCKhtA+WzHOHZGVtpV/tf7qeNeFI
	i+VH0kic5YFG1Gv674H7y6W6hqkVxbOWzgeRs1hjHq3rUJ6YBzQB0
X-Received: by 2002:a05:600c:3b0e:b0:4a1:efba:511 with SMTP id 5b1f17b1804b1-4bb8882508emr351753285e9.35.1795569021374;
        Tue, 24 Nov 2026 17:10:21 -0800 (PST)
Received: from HP ([102.0.122.2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb884b39b6sm435336135e9.12.2026.11.24.17.10.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 17:10:20 -0800 (PST)
From: Tanga Joris <tangajoris@gmail.com>
To: git@vger.kernel.org
Cc: siddharthasthana31@gmail.com,
	phillip.wood@dunelm.org.uk,
	gitster@pobox.com,
	jackrawlings2011@gmail.com,
	christian.couder@gmail.com,
	kaartic.sivaraam@gmail.com,
	usmanakinyemi202@gmail.com,
	Tanga Joris <tangajoris@gmail.com>
Subject: [Outreachy PATCH v4 0/2] apply: reject corrupt "diff --git" headers
Date: Wed, 25 Nov 2026 04:10:00 +0300
Message-ID: <20261125011002.589285-1-tangajoris@gmail.com>
X-Mailer: git-send-email 2.56.0.388.g09a996e1ff
In-Reply-To: <20261117004348.806694-1-tangajoris@gmail.com>
References: <20261117004348.806694-1-tangajoris@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

"git apply --check" dies on an assertion in check_preimage() for some
patches with a broken "diff --git" header. This series reports these
patches as errors instead.

1/2 rejects a "diff --git" line with no header lines after it.
2/2 rejects a new file with a "---" line before "new file mode", and
a deleted file with a "+++" line before "deleted file mode".

Changes since v3:
 - 1/2 now rejects every empty "diff --git" header right away, as
   Junio suggested, instead of only when a non-git patch follows it.
 - Dropped v3's 1/3. It fixed a leak that only happened when apply
   skipped an empty header, which it no longer does.
 - The test for a "diff --git" line followed by another one now
   expects the error.
 - 2/2 is unchanged.

Tanga Joris (2):
  apply: reject an empty "diff --git" header
  apply: reject new and deleted files that have both names

 apply.c                    |  26 ++++++-
 t/t4133-apply-filenames.sh | 135 +++++++++++++++++++++++++++++++++++++
 2 files changed, 159 insertions(+), 2 deletions(-)

Range-diff against v3:
1:  8136f837a9 < -:  ---------- apply: free the old def_name in parse_git_diff_header()
2:  048574a48f ! 1:  3fe5c26a25 apply: reject a patch after an empty "diff --git" line
    @@ Metadata
     Author: Tanga Joris <tangajoris@gmail.com>
     
      ## Commit message ##
    -    apply: reject a patch after an empty "diff --git" line
    +    apply: reject an empty "diff --git" header
     
         When a "diff --git" line is followed by a line that is not a git
         header line, such as a blank line or an indented "new file mode"
    @@ Commit message
         file, it applies. But its "old mode" and "new mode" lines are
         ignored.
     
    -    These are corrupt patches. "git diff" does not produce them. So
    -    report the empty header as an error, instead of reading the patch
    -    that follows it. This also rejects a "diff --git" line that is
    -    followed by other text and then a non-git patch, which used to apply.
    -    A "diff --git" line followed by another "diff --git" line is handled
    -    as before, because 206de27efa ignores empty headers on purpose. Only
    -    a patch that is read under an empty header is a problem.
    +    When 206de27efa was written, Git printed the "diff --git" line before
    +    running diff, so a path with nothing really changed could end up
    +    with just that line. ec1fcc16af (Show original and resulting blob
    +    object info in diff output, 2005-10-07) added the "index" line, and a
    +    pure rename or mode change has its own header lines. So today's Git
    +    does not write an empty "diff --git" header, and one in a patch means
    +    the patch is corrupt. Report it as an error, instead of skipping it.
    +
    +    This also rejects a "diff --git" line followed directly by another
    +    one, which used to be skipped, and one followed by other text and
    +    then a non-git patch, which used to apply. Text between patches is
    +    still ignored, unless one of its lines starts with "diff --git ".
     
         Reported-by: Gingrspacecadet <jackrawlings2011@gmail.com>
         Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
    +    Helped-by: Junio C Hamano <gitster@pobox.com>
         Signed-off-by: Tanga Joris <tangajoris@gmail.com>
     
      ## apply.c ##
    -@@ apply.c: static int find_header(struct apply_state *state,
    - 		       struct patch *patch)
    - {
    - 	unsigned long offset, len;
    -+	int empty_git_hdr_linenr = 0;
    - 
    - 	patch->is_toplevel_relative = 0;
    - 	patch->is_rename = patch->is_copy = 0;
     @@ apply.c: static int find_header(struct apply_state *state,
      		 * or mode change, so we handle that specially
      		 */
    @@ apply.c: static int find_header(struct apply_state *state,
      			if (git_hdr_len < 0)
      				return -128;
     -			if (git_hdr_len <= len)
    +-				continue;
     +			if (git_hdr_len <= len) {
    -+				empty_git_hdr_linenr = linenr;
    - 				continue;
    ++				error(_("corrupt patch: empty \"diff --git\" header at %s:%d"),
    ++				      state->patch_input_file, linenr);
    ++				return -128;
     +			}
      			*hdrsize = git_hdr_len;
      			return offset;
      		}
    -@@ apply.c: static int find_header(struct apply_state *state,
    - 		if (size < nextlen + 14 || memcmp("@@ -", line + len + nextlen, 4))
    - 			continue;
    - 
    -+		/* Git does not write a patch under an empty git header */
    -+		if (empty_git_hdr_linenr) {
    -+			error(_("corrupt patch: empty \"diff --git\" header at %s:%d"),
    -+			      state->patch_input_file, empty_git_hdr_linenr);
    -+			return -128;
    -+		}
    -+
    - 		/* Ok, we'll consider it a patch */
    - 		if (parse_traditional_patch(state, line, line+len, patch))
    - 			return -128;
     
      ## t/t4133-apply-filenames.sh ##
     @@ t/t4133-apply-filenames.sh: test_expect_success 'apply diff with old filename missing from headers' '
    @@ t/t4133-apply-filenames.sh: test_expect_success 'apply diff with old filename mi
     +	reject_empty_git_header later_line.diff 3
     +'
     +
    - test_expect_success 'ignore an empty "diff --git" line before a git patch' '
    - 	test_when_finished "rm -f g" &&
    - 	echo 1 >g &&
    ++test_expect_success 'reject a "diff --git" line followed by another' '
    ++	test_when_finished "rm -f g" &&
    ++	echo 1 >g &&
    ++	cat >empty_section.diff <<-\EOF &&
    ++	diff --git a/g b/g
    ++	diff --git a/g b/g
    ++	index d00491f..0cfbf08 100644
    ++	--- a/g
    ++	+++ b/g
    ++	@@ -1 +1 @@
    ++	-1
    ++	+2
    ++	EOF
    ++	reject_empty_git_header empty_section.diff 1 &&
    ++	echo 1 >expect &&
    ++	test_cmp expect g
    ++'
    ++
    + test_done
3:  b3da07db98 ! 2:  91277ef405 apply: reject new and deleted files that have both names
    @@ apply.c: int parse_git_diff_header(struct strbuf *root,
      }
     
      ## t/t4133-apply-filenames.sh ##
    -@@ t/t4133-apply-filenames.sh: test_expect_success 'ignore an empty "diff --git" line before a git patch' '
    +@@ t/t4133-apply-filenames.sh: test_expect_success 'reject a "diff --git" line followed by another' '
      	test_cmp expect g
      '
      

base-commit: 77904e546de3bd940621092ecec47a88d0cede5d
-- 
2.43.0

