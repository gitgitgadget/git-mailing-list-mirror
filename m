Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C80B91F404
	for <e@80x24.org>; Thu, 22 Feb 2018 20:42:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751387AbeBVUmH (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Feb 2018 15:42:07 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35575 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750805AbeBVUmG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Feb 2018 15:42:06 -0500
Received: by mail-wm0-f66.google.com with SMTP id x21so841218wmh.0
        for <git@vger.kernel.org>; Thu, 22 Feb 2018 12:42:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=HZzL1x5UsT+zr5buTeoys/VswjeSS8MNZxyElILGwdI=;
        b=lqjpJ05frytvJpqpoMtxBRBJjcU19cZc+5ATg1XGZl7zsg6iWMjpVSOYVPLXO7DQRY
         K5u3W62zAs2g6JJblRpS47HJiIwE0ly9BRtjmpDOtbv/l1BruyjH9wzE0g0pKcmX8UqL
         +SGr+yZUqBsu/C6aaKtqhEkWg/Y7d/PvMPAtlm/unLlrhmh9XtDSjtWSxKY2ifQWGDTK
         0F6KBmumMkCJjmm/YPwP9h3EtfesEcW3ws1T+4r2ulGpxtfj7gZq8RkhayAzzthKbypp
         OhKeWOJbxqxZSgxztJdqF68P2S0o/flUv6o9Pi+zdr2bWkQvEvOppBYjJgt7B09ZcIXz
         Ic7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=HZzL1x5UsT+zr5buTeoys/VswjeSS8MNZxyElILGwdI=;
        b=iN/wVH/CzoO84GJbkTJxb4n/NkUGaFZFiROjawgMzry8M5fD0xbXRFBerrgTyHCiom
         zz0xW8UJwC4/MSZiNCwJp5E5yNHX8QaoLdHFbssB8L4FMVlYYhAy8aqKx3GfOhQ9UmY+
         Jv7s2HgLgDHIuHuOHcbkW0uJvOeFHUwyMbH6l5UqdTNS2n+HSIrfH+7YehQIAVbpZNYM
         2sRz2sAzJPzOZr3123m1541KD7IcRQ1hnBU5HBTaYPI2EY6OToNnPeRE+j19xdYfBQmJ
         70q7iS/kkdyLlxzhNyZHajfgO8iC1AwdGJPn0vJhri6/6oXsxjZtnSNrdzhIENooGPHx
         O+lQ==
X-Gm-Message-State: APf1xPBloCpmVLthpL48t0+jcUtIJ4kj9i8ZKIzqIdaRLnAP480ueGmo
        oLSh3CCyyiWwf79WSwTFXB0=
X-Google-Smtp-Source: AG47ELs75dGtQNxlvJ4MzqNJKEwkTFdKnHf2B5cRfZnnV05PNDNhFD3egNDMB8Lhk4O8k8gtK4ufzA==
X-Received: by 10.28.247.11 with SMTP id v11mr376346wmh.27.1519332124942;
        Thu, 22 Feb 2018 12:42:04 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id z73sm336559wmc.3.2018.02.22.12.42.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 22 Feb 2018 12:42:04 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     marmot1123 <marmot.motoki@gmail.com>, git <git@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] Fix misconversion of gitsubmodule.txt
References: <01020161b30b99df-5029ec2b-a5cb-475b-b54f-9879a117a7f3-000000@eu-west-1.amazonses.com>
        <01020161bcb6b2b5-6a915ec6-57e5-4619-b281-0e2a193c69a2-000000@eu-west-1.amazonses.com>
        <CAGZ79kYLtXJZA865DS2JRi1RRw_L0t=f1iKJzvN+Uyroeg-pbw@mail.gmail.com>
        <xmqqy3jkvkr9.fsf@gitster-ct.c.googlers.com>
        <CAGZ79kZMkuek_yVAfrTBz6jbeamc3JDjPg2JTnYb45tONAj1iQ@mail.gmail.com>
Date:   Thu, 22 Feb 2018 12:42:03 -0800
In-Reply-To: <CAGZ79kZMkuek_yVAfrTBz6jbeamc3JDjPg2JTnYb45tONAj1iQ@mail.gmail.com>
        (Stefan Beller's message of "Thu, 22 Feb 2018 12:36:40 -0800")
Message-ID: <xmqqpo4wvjs4.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> On Thu, Feb 22, 2018 at 12:20 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
>>
>> Forgot to say something of your own?  Perhaps wanted to (1) show a
>> sample of a better log message, (2) say "Acked-by", (3) re-raise the
>> point that the same "error" already appears in the same file and it
>> is better to clean them up all at once, or (4) something else?
>
> (2) Acked-by and (4) I-am-sorry-for.

OK, I think the two patches are better squashed into one; in the
larger picture, it really does not matter where the problem
originated from.

Here is what I tentatively queued with copyedited log message.

-- >8 --
From: Motoki Seki <marmot.motoki@gmail.com>
Date: Thu, 22 Feb 2018 08:52:25 +0000
Subject: [PATCH] Documentation/gitsubmodules.txt: avoid non-ASCII apostrophes

In gitsubmodules.txt, a few non-ASCII apostrophes are used to spell
possessive, e.g. "submodule's".  These unfortunately are not
rendered at https://git-scm.com/docs/gitsubmodules correctly by the
renderer used there.

Use ASCII apostrophes instead to work around the problem.  It also
is good to be consistent, as there are possessives spelled with
ASCII apostrophes.

Signed-off-by: Motoki Seki <marmot.motoki@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/gitsubmodules.txt | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/Documentation/gitsubmodules.txt b/Documentation/gitsubmodules.txt
index 46cf120f66..030c974c25 100644
--- a/Documentation/gitsubmodules.txt
+++ b/Documentation/gitsubmodules.txt
@@ -24,7 +24,7 @@ On the filesystem, a submodule usually (but not always - see FORMS below)
 consists of (i) a Git directory located under the `$GIT_DIR/modules/`
 directory of its superproject, (ii) a working directory inside the
 superproject's working directory, and a `.git` file at the root of
-the submodule’s working directory pointing to (i).
+the submodule's working directory pointing to (i).
 
 Assuming the submodule has a Git directory at `$GIT_DIR/modules/foo/`
 and a working directory at `path/to/bar/`, the superproject tracks the
@@ -33,7 +33,7 @@ in its `.gitmodules` file (see linkgit:gitmodules[5]) of the form
 `submodule.foo.path = path/to/bar`.
 
 The `gitlink` entry contains the object name of the commit that the
-superproject expects the submodule’s working directory to be at.
+superproject expects the submodule's working directory to be at.
 
 The section `submodule.foo.*` in the `.gitmodules` file gives additional
 hints to Gits porcelain layer such as where to obtain the submodule via
@@ -132,27 +132,27 @@ using older versions of Git.
 +
 It is possible to construct these old form repositories manually.
 +
-When deinitialized or deleted (see below), the submodule’s Git
+When deinitialized or deleted (see below), the submodule's Git
 directory is automatically moved to `$GIT_DIR/modules/<name>/`
 of the superproject.
 
  * Deinitialized submodule: A `gitlink`, and a `.gitmodules` entry,
-but no submodule working directory. The submodule’s git directory
+but no submodule working directory. The submodule's git directory
 may be there as after deinitializing the git directory is kept around.
 The directory which is supposed to be the working directory is empty instead.
 +
 A submodule can be deinitialized by running `git submodule deinit`.
 Besides emptying the working directory, this command only modifies
-the superproject’s `$GIT_DIR/config` file, so the superproject’s history
+the superproject's `$GIT_DIR/config` file, so the superproject's history
 is not affected. This can be undone using `git submodule init`.
 
  * Deleted submodule: A submodule can be deleted by running
 `git rm <submodule path> && git commit`. This can be undone
 using `git revert`.
 +
-The deletion removes the superproject’s tracking data, which are
+The deletion removes the superproject's tracking data, which are
 both the `gitlink` entry and the section in the `.gitmodules` file.
-The submodule’s working directory is removed from the file
+The submodule's working directory is removed from the file
 system, but the Git directory is kept around as it to make it
 possible to checkout past commits without requiring fetching
 from another repository.
-- 
2.16.2-264-ge3a80781f5



