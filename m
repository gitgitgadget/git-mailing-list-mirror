Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 765B71F87F
	for <e@80x24.org>; Tue, 13 Nov 2018 19:53:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729564AbeKNFwk (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Nov 2018 00:52:40 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40355 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727428AbeKNFwk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Nov 2018 00:52:40 -0500
Received: by mail-wr1-f68.google.com with SMTP id p4so5519740wrt.7
        for <git@vger.kernel.org>; Tue, 13 Nov 2018 11:53:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jmDLoo6kZfelvQ9Ge0mn06fBMNaVk+08qn68q9tPH80=;
        b=P6H9y6091K/ArjZpKtVZMUem3yaMTtM2oc+LtoO8xNNa/Zo4SKNup6Jk/avxmdTMOa
         OZ3X5fWtIo5TtOtSOpMghARpIXdsVvfAyzTt8O754CYe8rPMmw3Y/qmujpfM6hkC5YA3
         wwBQJpHjlLLSknUR1bi7ReUZaInVY3rY/LFlxf/X4ZibHZlqZqZ7RbiGK5Vxodt8vm5L
         pIzEnUhYs+DQmBCR5QK42uTzoHc8PwyNPZ1ZDnXvhwI4ywtZn1wTO443gKpJqpLyg6kb
         QHFHbkv1OMCcJAcB/t4xeZPcvpTY3TjRUTs93/HUcuu3HTAyGi77RN46j2u/8e/7AHJW
         t0CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jmDLoo6kZfelvQ9Ge0mn06fBMNaVk+08qn68q9tPH80=;
        b=IECPlw8E/4raxz40X+SJrQn6n3/GMvCVhTWx6/f7aBmXiH4xNrN1EsqGoUay19bFXw
         iNNXpcW8ldwFBv8nPMDmMn7IMfzFL/wd5xo4F4x23tkF566K6cQ9IwPHwmHNBEw1E1r2
         PdKZfRumjgSHGmrkt4DCdHcQ+lTu4ieCjZOWej7dCi7TIVB+aw9nzbX3FXboGX807Jy7
         T1OgLXe2sBRGxv79iwuBzMvUCaXUgI9xgSk5iBZMKwiHFPkEpdZbatLyMus8mcFNnzV1
         zIWMi3cOMPzxgHnzUI+EfNPgaf+9n1/gCPGbtxV2Ds1VwK6OZfCpqNwPQi/NkOURUFCN
         EQkg==
X-Gm-Message-State: AGRZ1gLfjVv2RvyNgXJ21F04ilh7RsiqKqPJJeYFPobUnSXC/UJA0RTz
        0gBVJXQaob1+Cr+lGSMnMsahPRw+Xgs=
X-Google-Smtp-Source: AJdET5c9ktjuvse3c19yz6mP/vFzVyo7OcCWJ5lyt7CDdwwcP7ELUeTjP+DMrOABj5X/H4K/9JvqkQ==
X-Received: by 2002:adf:ba8b:: with SMTP id p11-v6mr6055426wrg.203.1542138779999;
        Tue, 13 Nov 2018 11:52:59 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id y7-v6sm13828560wmy.27.2018.11.13.11.52.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Nov 2018 11:52:59 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Stefan Beller <sbeller@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 3/7] push: improve the error shown on unqualified <dst> push
Date:   Tue, 13 Nov 2018 19:52:41 +0000
Message-Id: <20181113195245.14296-4-avarab@gmail.com>
X-Mailer: git-send-email 2.19.1.1182.g4ecb1133ce
In-Reply-To: <20181026230741.23321-1-avarab@gmail.com>
References: <20181026230741.23321-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Improve the error message added in f8aae12034 ("push: allow
unqualified dest refspecs to DWIM", 2008-04-23), which before this
change looks like this:

    $ git push avar v2.19.0^{commit}:newbranch -n
    error: unable to push to unqualified destination: newbranch
    The destination refspec neither matches an existing ref on the remote nor
    begins with refs/, and we are unable to guess a prefix based on the source ref.
    error: failed to push some refs to 'git@github.com:avar/git.git'

This message needed to be read very carefully to spot how to fix the
error, i.e. to push to refs/heads/newbranch. Now the message will look
like this instead:

    $ ./git-push avar v2.19.0^{commit}:newbranch -n
    error: The destination you provided is not a full refname (i.e.,
    starting with "refs/"). We tried to guess what you meant by:

    - Looking for a ref that matches 'newbranch' on the remote side.
    - Checking if the <src> being pushed ('v2.19.0^{commit}')
      is a ref in "refs/{heads,tags}/". If so we add a corresponding
      refs/{heads,tags}/ prefix on the remote side.

    Neither worked, so we gave up. You must fully qualify the ref.
    error: failed to push some refs to 'git@github.com:avar/git.git'

This improvement is the result of on-list discussion in [1] and [2],
as well as my own fixes / reformatting / phrasing on top.

The suggestion by Jeff on-list was to make that second bullet point
"Looking at the refname of the local source.". The version being added
here is more verbose, but also more accurate. saying "local source"
could refer to any ref in the local refstore, including something in
refs/remotes/*. A later change will teach guess_ref() to infer a ref
type from remote-tracking refs, so let's not confuse the two.

While I'm at it, add a "TRANSLATORS" comment since the message has
gotten more complex and it's not as clear what the two %s's refer to.

1. https://public-inbox.org/git/20181010205505.GB12949@sigill.intra.peff.net/
2. https://public-inbox.org/git/xmqqbm81lb7c.fsf@gitster-ct.c.googlers.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 remote.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/remote.c b/remote.c
index 35fe8a178f..15da4019c3 100644
--- a/remote.c
+++ b/remote.c
@@ -1049,12 +1049,22 @@ static int match_explicit(struct ref *src, struct ref *dst,
 			matched_dst = make_linked_ref(dst_guess, dst_tail);
 			free(dst_guess);
 		} else {
-			error(_("unable to push to unqualified destination: %s\n"
-				"The destination refspec neither matches an "
-				"existing ref on the remote nor\n"
-				"begins with refs/, and we are unable to "
-				"guess a prefix based on the source ref."),
-			      dst_value);
+			/*
+			 * TRANSLATORS: "matches '%s'%" is the <dst>
+			 * part of "git push <remote> <src>:<dst>"
+			 * push, and "being pushed ('%s')" is the
+			 * <src>.
+			 */
+			error(_("The destination you provided is not a full refname (i.e.,\n"
+				"starting with \"refs/\"). We tried to guess what you meant by:\n"
+				"\n"
+				"- Looking for a ref that matches '%s' on the remote side.\n"
+				"- Checking if the <src> being pushed ('%s')\n"
+				"  is a ref in \"refs/{heads,tags}/\". If so we add a corresponding\n"
+				"  refs/{heads,tags}/ prefix on the remote side.\n"
+				"\n"
+				"Neither worked, so we gave up. You must fully qualify the ref."),
+			      dst_value, matched_src->name);
 		}
 		break;
 	default:
-- 
2.19.1.1182.g4ecb1133ce

