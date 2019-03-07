Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2FA0120248
	for <e@80x24.org>; Thu,  7 Mar 2019 09:38:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726216AbfCGJiU (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Mar 2019 04:38:20 -0500
Received: from mail-wm1-f54.google.com ([209.85.128.54]:39510 "EHLO
        mail-wm1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbfCGJiU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Mar 2019 04:38:20 -0500
Received: by mail-wm1-f54.google.com with SMTP id z84so8534438wmg.4
        for <git@vger.kernel.org>; Thu, 07 Mar 2019 01:38:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2Y8t+pGmKQq2xFK2j0+xuZv9AeC4/Jtby0hJoA3q9zw=;
        b=Ey93kWQLbXQ1lOIkfb6FECvhYlnuR2PY4Lkemm2z023c3y4umxy4uFSnUz8QnZFaEx
         m9o5B2q92Yeew+YR0voyduyiTaHVLr23RYdRvzkr5J3eKsV88JIDasaUh4hixmCiUwaq
         Uz0B8oZn/5bhP0/JpAkadbnc3enK1kCGGk2IIAQ++9iDsaRSxrMBnraj16PKaC89ytw1
         35KZndIXRUQhl1ksjq9v4oGkfe+JnQ/nne8zaXaoo2YbcYg/c93ZJLtCEb4vBOhi2SqY
         8qh4t8H4V9aZBWyfD6H+AP7d1kewPiaFRxqZvDx2Kn0WVMKeXWCV8h3xOnbmE+5BqCzD
         gH+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:from:to:cc:references
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=2Y8t+pGmKQq2xFK2j0+xuZv9AeC4/Jtby0hJoA3q9zw=;
        b=QLTRsJBGPj5yvN271vBUF2HtMswoaqExFXaT4QeORl37zyqGpWq2GA51eZLwHA3oad
         PzZkUaWRTuuRRCs4QUDnpFEgr/Ey86aTPw/9FxLw6rVs+gl69wvExB/b+/cmBxlFv84N
         Ff9FeuAsh6MAjohrZGO3W/TNBSSPepTd+NC5RWXlMB1upMTFh1DnL5PsSbN2Y+1MA3We
         hBql+kXEq3qch5/SiXsri6LsU2CZA9sudbG/C6xAUntiInSVdbu2di8JYPDUljW4sm82
         X7f7FFlJB73Dcz3ohvyWT7glRmkVvbSmdU/3bVdS9aqDLiF8XdTnc1zKAJtR71FFRf2T
         VFyw==
X-Gm-Message-State: APjAAAXjVNPbedLoqVYpjelffkgP2YOfJta0YOIFn3Dn4GfDqSG6/e2G
        yPxFYJkQdudCCNYkUGpPn+U=
X-Google-Smtp-Source: APXvYqx607Tk/kLaHYWoFS+P+ZCGAFLAF4+YW/8+dQZvzE5tKofe1lmbzltoMCj1ZUE3vI9Dhl94mA==
X-Received: by 2002:a7b:cbd1:: with SMTP id n17mr4956578wmi.21.1551951498071;
        Thu, 07 Mar 2019 01:38:18 -0800 (PST)
Received: from [192.168.2.240] (host-92-22-20-26.as13285.net. [92.22.20.26])
        by smtp.gmail.com with ESMTPSA id u17sm10248284wrg.71.2019.03.07.01.38.17
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Mar 2019 01:38:17 -0800 (PST)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [BUG] worktree local refs weirdness
From:   Phillip Wood <phillip.wood123@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
References: <f6e197f2-886a-5e82-7fc4-c53737dd66cc@gmail.com>
Message-ID: <ec707cbb-96e8-f26f-3d69-b69d29b31737@gmail.com>
Date:   Thu, 7 Mar 2019 09:38:16 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <f6e197f2-886a-5e82-7fc4-c53737dd66cc@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/03/2019 15:57, Phillip Wood wrote:
> When it is run in a worktree 'git for-each-ref' only seems to show refs 
> under refs/rewritten if that directory also exists under $GIT_COMMON_DIR 
> even though they are local to the worktree.
> 
> Initially I thought this was due to $GIT_COMMON_DIR pointing to a bare 
> repo, but that is not the case. However while writing a test case which 
> cloned to a bare repo I noticed it was listing a ref for the HEAD of a 
> worktree in the repo I had cloned from, not the clone itself.

Ignore that last paragraph, it's just showing the branch that got 
created when the worktree was created. The last part of the script is 
redundant, I've updated it below


# setup initial repo
mkdir repo &&
cd repo &&
git init &&
echo a>a &&
git add a &&
git commit -ma &&
#add a worktree and set a ref under refs/rewritten
git worktree add ../worktree-1 &&
cd ../worktree-1 &&
echo 'worktree-1 adding refs/rewritten/a' &&
git update-ref refs/rewritten/a HEAD &&
git rev-parse --verify refs/rewritten/a &&
echo 'refs/rewritten/a exists but is not shown' &&
git for-each-ref &&
# add a ref under refs/rewritten to the main repo
cd ../repo &&
echo 'repo adding refs/rewritten/z' &&
git update-ref refs/rewritten/z HEAD &&
git for-each-ref &&
cd ../worktree-1 &&
echo 'worktree-1 now shows refs/rewritten/a' &&
git for-each-ref

Output
Initialized empty Git repository in /tmp/x/repo/.git/
[master (root-commit) d60b5d6] a
  1 file changed, 1 insertion(+)
  create mode 100644 a
Preparing worktree (new branch 'worktree-1')
HEAD is now at d60b5d6 a
worktree-1 adding refs/rewritten/a
d60b5d6532fe5ed6e3bc3a0233c6de9d86092d13
refs/rewritten/a exists but is not shown
d60b5d6532fe5ed6e3bc3a0233c6de9d86092d13 commit	refs/heads/master
d60b5d6532fe5ed6e3bc3a0233c6de9d86092d13 commit	refs/heads/worktree-1
repo adding refs/rewritten/z
d60b5d6532fe5ed6e3bc3a0233c6de9d86092d13 commit	refs/heads/master
d60b5d6532fe5ed6e3bc3a0233c6de9d86092d13 commit	refs/heads/worktree-1
d60b5d6532fe5ed6e3bc3a0233c6de9d86092d13 commit	refs/rewritten/z
worktree-1 now shows refs/rewritten/a
d60b5d6532fe5ed6e3bc3a0233c6de9d86092d13 commit	refs/heads/master
d60b5d6532fe5ed6e3bc3a0233c6de9d86092d13 commit	refs/heads/worktree-1
d60b5d6532fe5ed6e3bc3a0233c6de9d86092d13 commit	refs/rewritten/a

Best Wishes

Phillip


> 
> The script below reproduces both issues, I've copied the output below 
> it. I'm not sure what's going on or the best way to debug it.
> 
> Best Wishes
> 
> Phillip
> 
> # setup initial repo
> mkdir repo &&
> cd repo &&
> git init &&
> echo a>a &&
> git add a &&
> git commit -ma &&
> #add a worktree and set a ref under refs/rewritten
> git worktree add ../worktree-1 &&
> cd ../worktree-1 &&
> echo 'worktree-1 adding refs/rewritten/a' &&
> git update-ref refs/rewritten/a HEAD &&
> git rev-parse --verify refs/rewritten/a &&
> echo 'refs/rewritten/a exists but is not shown' &&
> git for-each-ref &&
> # add a ref under refs/rewritten to the main repo
> cd ../repo &&
> echo 'repo adding refs/rewritten/z' &&
> git update-ref refs/rewritten/z HEAD &&
> git for-each-ref &&
> cd ../worktree-1 &&
> echo 'worktree-1 now shows refs/rewritten/a' &&
> git for-each-ref &&
> cd .. &&
> # create a bare clone with a worktree
> git clone --bare --no-local repo bare &&
> cd bare &&
> git worktree add ../worktree-2 &&
> cd ../worktree-2 &&
> echo 'worktree-2 adding refs/rewritten/b' &&
> echo 'why does this show refs/worktree-1/head' &&
> echo 'but not refs/rewritten/b?' &&
> git worktree list &&
> git update-ref refs/rewritten/b HEAD &&
> git rev-parse --verify refs/rewritten/b &&
> git for-each-ref
> 
> 
> Output
> Initialized empty Git repository in 
> /home/phil/src/git-utils/dev/git-rewrite/repo/.git/
> [master (root-commit) dc2045a] a
>   1 file changed, 1 insertion(+)
>   create mode 100644 a
> Preparing worktree (new branch 'worktree-1')
> HEAD is now at dc2045a a
> worktree-1 adding refs/rewritten/a
> dc2045a36f38ba4e9bacd8cd86ba74f58a1d4656
> refs/rewritten/a exists but is not shown
> dc2045a36f38ba4e9bacd8cd86ba74f58a1d4656 commit    refs/heads/master
> dc2045a36f38ba4e9bacd8cd86ba74f58a1d4656 commit    refs/heads/worktree-1
> repo adding refs/rewritten/z
> dc2045a36f38ba4e9bacd8cd86ba74f58a1d4656 commit    refs/heads/master
> dc2045a36f38ba4e9bacd8cd86ba74f58a1d4656 commit    refs/heads/worktree-1
> dc2045a36f38ba4e9bacd8cd86ba74f58a1d4656 commit    refs/rewritten/z
> worktree-1 now shows refs/rewritten/a
> dc2045a36f38ba4e9bacd8cd86ba74f58a1d4656 commit    refs/heads/master
> dc2045a36f38ba4e9bacd8cd86ba74f58a1d4656 commit    refs/heads/worktree-1
> dc2045a36f38ba4e9bacd8cd86ba74f58a1d4656 commit    refs/rewritten/a
> Cloning into bare repository 'bare'...
> remote: Enumerating objects: 3, done.
> remote: Counting objects: 100% (3/3), done.
> remote: Total 3 (delta 0), reused 0 (delta 0)
> Receiving objects: 100% (3/3), done.
> Preparing worktree (new branch 'worktree-2')
> HEAD is now at dc2045a a
> worktree-2 adding refs/rewritten/b
> why does this show refs/worktree-1/head
> but not refs/rewritten/b?
> /home/phil/src/git-utils/dev/git-rewrite/bare        (bare)
> /home/phil/src/git-utils/dev/git-rewrite/worktree-2  dc2045a [worktree-2]
> dc2045a36f38ba4e9bacd8cd86ba74f58a1d4656
> dc2045a36f38ba4e9bacd8cd86ba74f58a1d4656 commit    refs/heads/master
> dc2045a36f38ba4e9bacd8cd86ba74f58a1d4656 commit    refs/heads/worktree-1
> dc2045a36f38ba4e9bacd8cd86ba74f58a1d4656 commit    refs/heads/worktree-2
> 
