Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 74A311F461
	for <e@80x24.org>; Fri, 12 Jul 2019 16:24:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbfGLQY6 (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Jul 2019 12:24:58 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42837 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726977AbfGLQY6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Jul 2019 12:24:58 -0400
Received: by mail-pg1-f193.google.com with SMTP id t132so4746269pgb.9
        for <git@vger.kernel.org>; Fri, 12 Jul 2019 09:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OKX66RROM2t+7laOIFmiGO5MtK8f1EsyDOE4HsmRLFI=;
        b=uCN4C/xJrQd3BTERwvOpDmpbpDfwm453FbNsMbr97tjdDuVKKcS7nZTO0hSOdtGr5p
         cupfyhgfA2uDHc4H0UmzL5lbFCEuT/64Gs2S4yuTZPVFB7fHo8WPRzt9c97lAQFuTqDj
         sLfODT3pHfRU6QchuMwAlR7YJ9fpauTY201wQM7wpUN4omDQgRNlR7MwjvFuSfl1iNCE
         R4OJjZi+HU6WneODuT00ectwGPwa50AvNBJfIuviEQqU6KJ8LHXn+4h2U4N70puPGXe6
         ubMaaHQOHTdZdrv44Cb1jhfaO1/1wAs4MRdoUVqyxve3qciahI/st/2NBg9U2uCsMhqS
         CoLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OKX66RROM2t+7laOIFmiGO5MtK8f1EsyDOE4HsmRLFI=;
        b=S7OcL8998HZaoYmevmhefIAbTRDaI/07nz2jr1wwwfrNjdXmrpwYOImZwLsifMwdsG
         E9rC4iQxBLpsOkHWfZt1Ll1EYK4GZuy2ihvoKyRFrth1c+7iYtjtGkltzGFe52eYGA3t
         GLjO1vU/kHPvDlCyZka+JVxTb1kvjkC1KN8KAn5YHxgy4pJEBOBYvxY+hn+o7pRwlxpF
         F9yH9ID2LCppOGunQ6sv76HpMTKnMv6e4ibwWpaEHrvIsbNqsFo7/q4UNB/U4dGG0Ivg
         i2Yai8zCNwPPLJcwousWe0Enl9R49gROfxYbn1sTp0kkfULIGACtmtws6DCOK7yQk4lV
         dSvA==
X-Gm-Message-State: APjAAAWsvyHTL+aZy8LhbtcIU2uYUFJxmVtXfSV4K3q7kaX9AMYpW/eU
        dAid/EpngPlmzb05FCVYnMI=
X-Google-Smtp-Source: APXvYqxcYsZKZJ846UvU4FXna2Z6uJeGNC/JcfHY0XT8jfL7GzLCkdYok6Ik90kqArQ1WlVqcAdbmw==
X-Received: by 2002:a17:90a:3270:: with SMTP id k103mr12286403pjb.54.1562948697222;
        Fri, 12 Jul 2019 09:24:57 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id w18sm12272587pfj.37.2019.07.12.09.24.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 12 Jul 2019 09:24:56 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Bryan Turner <bturner@atlassian.com>, usbuser@mailbox.org,
        Elijah Newren <newren@gmail.com>
Subject: Re: Unexpected or wrong ff, no-ff and ff-only behaviour
Date:   Fri, 12 Jul 2019 09:24:50 -0700
Message-Id: <20190712162450.21898-1-newren@gmail.com>
X-Mailer: git-send-email 2.22.0.429.gbb0a79e5f4
In-Reply-To: <87blxz9xbh.fsf@osv.gnss.ru>
References: <87blxz9xbh.fsf@osv.gnss.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 12, 2019 at 6:50 AM Sergey Organov <sorganov@gmail.com> wrote:
>
> That said, even if we rather all do agree rebase workflow is always
> inferior to merge one, is it satisfactory excuse to actively resist
> otherwise logical behavior of 'git merge' that is even documented? I
> don't think so.
>
> Thus, one way or another, I'd still vote for keeping options description
> intact, and rather fix the implementation to match the manual, i.e.,
> make the --[no]-ff actually orthogonal to --ff-only.

This seems like it's asking for trouble.  --ff-only and --no-ff,
ignoring any knowledge of what they do, are contradictory by their
names.  Attempting to explain to users that they are not opposites but
can be used together compatibly sounds very problematic to me.

But let me dig a little deeper into your statement of "resisting
otherwise logical behavior of 'git merge" that is even documented."
Going back to when the --ff-only option was introduced:

commit 134748353b2a71a34f899c9b1326ccf7ae082412
Author: Björn Gustavsson <bgustavsson@gmail.com>
Date:   Thu Oct 29 23:08:31 2009 +0100

    Teach 'git merge' and 'git pull' the option --ff-only
   
    For convenience in scripts and aliases, add the option
    --ff-only to only allow fast-forwards (and up-to-date,
    despite the name).
   
    Disallow combining --ff-only and --no-ff, since they
    flatly contradict each other.

We see that the original author even stated pretty clearly and
strongly that these were polar opposite options.  Our description
today of --ff-only is the same one he introduced in that patch, and I
always read the description the same way I think he did: that it
implied a polar opposite of --no-ff.  You and Bryan came along and
pointed out that the description was actually ambiguous and could be
interpreted a different way...and I then had to re-read the text a
time or two after you pointed it out to see the alternate reading.  I
totally admit that the wording is apparently ambiguous and can be read
the way you have, but I don't at all see that as a reason to keep the
documentation as-is.  Either it should be clarified to rule out what
you and usbuser wanted and perhaps misunderstood it to do, or if the
behavior is changed then it should be clarified so that folks like me
don't read it to behave as it has since Björn added it.

Personally, I think that if new functionality is wanted, it should
definitely go in a different flag (perhaps someone can find something
shorter than --no-ff-and-only-if-ff-is-possible).  But I think Junio
makes a pretty good argument to be leery of such a new option, and
Brian points out how to easily get this behavior by just stringing
together a merge-base command with merge --no-ff.

That's just my $0.02, but since this is the second time in the thread
that I've suggested improving the documentation, here's a patch to do
so:


-- 8< --
Subject: [PATCH] merge-options.txt: clarify meaning of various ff-related
 options

As discovered on the mailing list, some of the descriptions of the
ff-related options were unclear.  Try to be more precise with what these
options do.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/merge-options.txt | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/Documentation/merge-options.txt b/Documentation/merge-options.txt
index 79a00d2a4a..e888c99d48 100644
--- a/Documentation/merge-options.txt
+++ b/Documentation/merge-options.txt
@@ -40,20 +40,21 @@ set to `no` at the beginning of them.
 	case of a merge conflict.
 
 --ff::
-	When the merge resolves as a fast-forward, only update the branch
-	pointer, without creating a merge commit.  This is the default
-	behavior.
+	When the merge resolves as a fast-forward, only update the
+	branch pointer (without creating a merge commit).  When a fast
+	forward update is not possible, create a merge commit.  This is
+	the default behavior.
 
 --no-ff::
-	Create a merge commit even when the merge resolves as a
-	fast-forward.  This is the default behaviour when merging an
-	annotated (and possibly signed) tag that is not stored in
-	its natural place in 'refs/tags/' hierarchy.
+	Create a merge commit even when the merge could instead resolve
+	as a fast-forward.  This is the default behaviour when merging
+	an annotated (and possibly signed) tag that is not stored in its
+	natural place in 'refs/tags/' hierarchy.
 
 --ff-only::
-	Refuse to merge and exit with a non-zero status unless the
-	current `HEAD` is already up to date or the merge can be
-	resolved as a fast-forward.
+	When possible, resolve the merge as a fast-forward (do not
+	create a merge commit).  When not possible, refuse to merge and
+	exit with a non-zero status.
 
 -S[<keyid>]::
 --gpg-sign[=<keyid>]::
-- 
2.22.0.429.gbb0a79e5f4

