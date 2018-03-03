Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 77A371F404
	for <e@80x24.org>; Sat,  3 Mar 2018 15:46:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752145AbeCCPqX (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Mar 2018 10:46:23 -0500
Received: from mail-wr0-f169.google.com ([209.85.128.169]:34948 "EHLO
        mail-wr0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751995AbeCCPqW (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Mar 2018 10:46:22 -0500
Received: by mail-wr0-f169.google.com with SMTP id l43so13005819wrc.2
        for <git@vger.kernel.org>; Sat, 03 Mar 2018 07:46:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HdESwWyRvWi64WtJZ4D26iqaJMhpXfVYwtIDLIxfIEk=;
        b=qFe3ABLp6pKyW3qeJmuvxbJOC2a6mVzCv2/gN0drz2FZOfpaYNLwUJldagII+G0KpD
         IYjBqMcoU+/Mfq+Kg7G5ebtgABaxRu2UXLV/qBZZGnC3PCBeeAENDpk6VTaR7XeJUywa
         8jQ1GvAkHlHuLQiLu5ahVkMBJl27UycKupzAy99smOtJ36xzAd5hbrZPwZybasZPHY6C
         KGe4Os/RsSU1jObMJUF3zAF0EtIYPNtV/qffF79JbE7OgB3uGs8iFztEB08H8AQ2Fzno
         1WGUc2ImpA316+gBE9f/Pjgea1+h0PkVH5CvQUEiOwAKlghAvpbQjfNK4SIVPy5ZABJB
         Jh4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HdESwWyRvWi64WtJZ4D26iqaJMhpXfVYwtIDLIxfIEk=;
        b=FzQPGafGmI4UqiECP0Bcs2x5PgAiyCy15jc4aQG89gjp3aaIdbtLGRsCVRyN7IBD34
         ZM2Js5gY6GrweGVvZYt+ENz72QmOKhNcW8rD4o1CgAGRcNZFCeeMBXHFG5GI2dd81L8M
         p2xTBldUApfpfNphCvKgXzzqeKJz696zDBbcB1BZjtqyUl9qfSqADNVAkgMJCtkNGLE6
         JFmZXUy0ruxCn9QCqETCWDjaIpbzq0CxFd35FjvdJaPNH08K1PWMSUWlMp7XIC4CND/8
         TT1YrZJshD2R4oP/A0eITmjb6Zh3UNzn9aviuX7FAUTKvEVWDsFK04cybOShgi+JneqQ
         jUFA==
X-Gm-Message-State: APf1xPCK62jVm1TwNxooc19ej7R2R68TXD7DnV/Kd2Q7QZ4gFUUQI0Nz
        S4zJtmBjHem+ffPQT21EA8dXh7en
X-Google-Smtp-Source: AG47ELve3+ZxqqVF672v7ognhtapg6aakaKUMmu3T1xBRelHmqmZY2HkYrJ9/nsgEiy+uVyW5fZYDA==
X-Received: by 10.223.166.135 with SMTP id t7mr7635782wrc.260.1520091981218;
        Sat, 03 Mar 2018 07:46:21 -0800 (PST)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id n24sm4777438wmi.21.2018.03.03.07.46.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 03 Mar 2018 07:46:20 -0800 (PST)
Date:   Sat, 3 Mar 2018 15:46:54 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Marc Strapetz <marc.strapetz@syntevo.com>
Cc:     git@vger.kernel.org
Subject: Re: git stash push -u always warns "pathspec '...' did not match any
 files"
Message-ID: <20180303154654.GH2130@hank>
References: <349f9369-b799-4f7b-bda1-33bcbd7ea067@syntevo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <349f9369-b799-4f7b-bda1-33bcbd7ea067@syntevo.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/03, Marc Strapetz wrote:
> Reproducible in a test repository with following steps:
> 
> $ touch untracked
> $ git stash push -u -- untracked
> Saved working directory and index state WIP on master: 0096475 init
> fatal: pathspec 'untracked' did not match any files
> error: unrecognized input
> 
> The file is stashed correctly, though.
> 
> Tested with Git 2.16.2 on Linux and Windows.

Thanks for the bug report and the reproduction recipe.  The following
patch should fix it:

--- >8 ---
Subject: [PATCH] stash push: avoid printing errors

Currently 'git stash push -u -- <pathspec>' prints the following errors
if <pathspec> only matches untracked files:

    fatal: pathspec 'untracked' did not match any files
    error: unrecognized input

This is because we first clean up the untracked files using 'git clean
<pathspec>', and then use a command chain involving 'git add -u
<pathspec>' and 'git apply' to clear the changes to files that are in
the index and were stashed.

As the <pathspec> only includes untracked files that were already
removed by 'git clean', the 'git add' call will barf, and so will 'git
apply', as there are no changes that need to be applied.

Fix this by making sure to only call this command chain if there are
still files that match <pathspec> after the call to 'git clean'.

Reported-by: Marc Strapetz <marc.strapetz@syntevo.com>
Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 git-stash.sh     | 2 +-
 t/t3903-stash.sh | 7 +++++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/git-stash.sh b/git-stash.sh
index fc8f8ae640..058ad0bed8 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -320,7 +320,7 @@ push_stash () {
 			git clean --force --quiet -d $CLEAN_X_OPTION -- "$@"
 		fi
 
-		if test $# != 0
+		if test $# != 0 && git ls-files --error-unmatch -- "$@" >/dev/null 2>/dev/null
 		then
 			git add -u -- "$@" |
 			git checkout-index -z --force --stdin
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index aefde7b172..506004aece 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -1096,4 +1096,11 @@ test_expect_success 'stash -- <subdir> works with binary files' '
 	test_path_is_file subdir/untracked
 '
 
+test_expect_success 'stash -- <untracked> doesnt print error' '
+	>untracked &&
+	git stash push -u -- untracked 2>actual&&
+	test_path_is_missing untracked &&
+	test_line_count = 0 actual
+'
+
 test_done
-- 
2.16.2.395.g2e18187dfd

