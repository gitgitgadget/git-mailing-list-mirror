Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 224A41F428
	for <e@80x24.org>; Thu, 28 Dec 2017 06:10:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751409AbdL1GKh (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Dec 2017 01:10:37 -0500
Received: from mail-pl0-f48.google.com ([209.85.160.48]:41502 "EHLO
        mail-pl0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750862AbdL1GKf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Dec 2017 01:10:35 -0500
Received: by mail-pl0-f48.google.com with SMTP id g2so20672965pli.8
        for <git@vger.kernel.org>; Wed, 27 Dec 2017 22:10:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=bdRT4pfsoPllLUVIwKGufBB5NWpjxkDzf7lr1iCU9FY=;
        b=tfaX/YPnc//R5haUkyLBhvlqVmoJ6D33uUhUcEnphPqEbVNJLakkBJy5W1rXFnlNNf
         ZKZjBktOkPyyBF33w4Mk/U1/KGWGkVsp+sqOm0wquSDGKOb409AYLcdQFkq+P+RPhBkb
         VLFmYKQELh8QZDkDmetIKZ6ij1hGSjC9faaNm8/VMsUj3NNbdKa9IPGBoU0rkWht3yTj
         Rv0p19SJJ4Gt3Z/7U9XReylb6iFiSsZUtiLrJT9QeWaXJLR5lukB+En0dtz4/umkskmN
         FCkauCnkCPGgqtvdf/uBhEY4+vJ4DQ1QbKvDYhkFjOJqaI62FDhT3SAryZsoDznQyB5S
         YKJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=bdRT4pfsoPllLUVIwKGufBB5NWpjxkDzf7lr1iCU9FY=;
        b=E7RYkAhHGeV1mW3oTCyyJK2UrJxKtHs2HVYjPrFitWM3lTQJm7lX6FeuJQhCbn8mvD
         pz2EP9dY30BGdwhk2NS+UeT/R76gEynPUynqgVkg7+bdA58omaGykTjzLlAkloITajer
         om2FXrdxh5ajHCMzW0mJYmNou/7O3qkR/dKQItuVpUyX5FQtaFRl/x8GW3hwKG8rP1x5
         /+VcKn/H0szTrMihirwpPtnmSgDiGoqmtpIg84WMGWmq2RlMhAXOyR3/O4BKPsyQXEOJ
         UamUaVAtXphLyXaXgM/x8RLfc9swg730hMXvJ4Od7z9meHMbdiJ0WlYyXiWCcjnCaYrc
         Xy1Q==
X-Gm-Message-State: AKGB3mKKc7LzWLtUS6p6YaULWYqkUA4Ebwx1xGvyuAg+IB8XcZLZFapg
        w2ng0cZd+XqBT/dciPSRIhQ=
X-Google-Smtp-Source: ACJfBosiep3TKwLuH3pYYalrTP8rxdirg86rwwshuUm/F9X97j4Wp7vbqHOYVWXwiYGkJXAp1B9a1w==
X-Received: by 10.84.245.15 with SMTP id i15mr31805213pll.402.1514441434892;
        Wed, 27 Dec 2017 22:10:34 -0800 (PST)
Received: from duynguyen.vn.dektech.internal ([14.161.14.188])
        by smtp.gmail.com with ESMTPSA id r1sm69827575pfg.98.2017.12.27.22.10.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Dec 2017 22:10:33 -0800 (PST)
Date:   Thu, 28 Dec 2017 13:10:27 +0700
From:   Duy Nguyen <pclouds@gmail.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>,
        Ben Peart <benpeart@microsoft.com>
Subject: Re: [PATCH] status: add a failing test showing a core.untrackedCache
 bug
Message-ID: <20171228061027.GA22308@duynguyen.vn.dektech.internal>
References: <20171222140032.21180-1-avarab@gmail.com>
 <xmqqlghoniuk.fsf@gitster.mtv.corp.google.com>
 <87mv24qa2y.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87mv24qa2y.fsf@evledraar.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 27, 2017 at 07:50:29PM +0100, Ævar Arnfjörð Bjarmason wrote:
> > This needs SYMLINKS prereq, which in turn means it cannot be tested
> > on certain platforms.  I thought Duy's answer was that this does not
> > need to involve a symbolic link at all?  If so, perhaps we can have
> > another test that does not need symlink?
> 
> ... as soon as I figure out how to add such a non-symlink test as well
> (seems sensible to test both), but I can't bring it to fail without
> symlinks, I just adjusted my test script to do this instead:
> 
>     (
>         rm -rf /tmp/testrepo &&
>         git init /tmp/testrepo &&
>         cd /tmp/testrepo &&
>         mkdir x y &&
>         touch x/a y/b &&
>         git add x/a y/b &&
>         git commit -msnap &&
>         git rm -rf y &&
>         mkdir y &&
>         touch y/c &&
>         git add y &&
>         git commit -msnap2 &&
>         git checkout HEAD~ &&
>         git status &&
>         git checkout master &&
>         sleep 1 &&
>         git status &&
>         git status
>     )
> 
> Duy, what am I missing here?

The problem is there, it's just easier to see or verify with
symlinks. Below is my test patch on top of your original one. Two
points:

- if you look at the test-dump-untracked-cache output, you can see the
  saved cache is wrong. The line

    /one/ 0000000000000000000000000000000000000000 recurse valid

  should not be there because that implies that cached travesal of
  root includes the directory "one" which does not exist on disk
  anymore. With the fix, this line is gone.

- We silently ignore opendir() error, the changes in dir.c shows this

    warning: could not open directory 'one/': Not a directory

  It opendir() again because it finds out the stat data of directory
  "one" in the cache does not match stat data of the (real) file
  "one".

  If "one" is a symlink, opendir() would be succesful and we go in
  anyway. If it's a file, we ignore it, accidentally make the second
  git-status output clean and pass the test.

Report opendir() errors is a good and should be done regardless (i'm
just not sure if it should be a fatal error or a warning like this, I
guess die() is a bit too much).

The remaining question is how we write this test. Verify with
test-dump-untracked-cache is easiest but less intuitive, I
guess. While using symlinks shows the problem clearly but not
portable. Or the third option, if we error something out, you could
check that git-status has clean stderr.

Which way to go?

-- 8< --
diff --git a/dir.c b/dir.c
index 3c54366a17..868f544d72 100644
--- a/dir.c
+++ b/dir.c
@@ -1783,15 +1783,20 @@ static int open_cached_dir(struct cached_dir *cdir,
 			   struct strbuf *path,
 			   int check_only)
 {
+	const char *c_path;
+
 	memset(cdir, 0, sizeof(*cdir));
 	cdir->untracked = untracked;
 	if (valid_cached_dir(dir, untracked, istate, path, check_only))
 		return 0;
-	cdir->fdir = opendir(path->len ? path->buf : ".");
+	c_path = path->len ? path->buf : ".";
+	cdir->fdir = opendir(c_path);
 	if (dir->untracked)
 		dir->untracked->dir_opened++;
-	if (!cdir->fdir)
+	if (!cdir->fdir) {
+		warning_errno(_("could not open directory '%s'"), c_path);
 		return -1;
+	}
 	return 0;
 }
 
diff --git a/t/t7063-status-untracked-cache.sh b/t/t7063-status-untracked-cache.sh
index 7cf1e2c091..ca63b80ca7 100755
--- a/t/t7063-status-untracked-cache.sh
+++ b/t/t7063-status-untracked-cache.sh
@@ -702,7 +702,7 @@ test_expect_success 'setup worktree for symlink test' '
 	git add one/file two/file &&
 	git commit -m"first commit" &&
 	git rm -rf one &&
-	ln -s two one &&
+	cp two/file one &&
 	git add one &&
 	git commit -m"second commit"
 '
@@ -714,6 +714,7 @@ test_expect_failure '"status" after symlink replacement should be clean with UC=
 	git checkout master &&
 	avoid_racy &&
 	status_is_clean &&
+	test-dump-untracked-cache &&
 	status_is_clean
 '
 
-- 8< --
