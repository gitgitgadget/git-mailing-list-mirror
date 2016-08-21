Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A59731F6C1
	for <e@80x24.org>; Sun, 21 Aug 2016 13:49:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753068AbcHUNsP (ORCPT <rfc822;e@80x24.org>);
        Sun, 21 Aug 2016 09:48:15 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35914 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753025AbcHUNsO (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Aug 2016 09:48:14 -0400
Received: by mail-wm0-f65.google.com with SMTP id i138so9716267wmf.3
        for <git@vger.kernel.org>; Sun, 21 Aug 2016 06:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding;
        bh=hTK9svkxCalPWjDuSZiFC82ZLTuRZwIdVK7MOTRmJVE=;
        b=Il78zCdgdHdIE4MAIMae1F2hwh2rBwfHqzr8EetxAzf23nZHHz+ZcpYofabkvnHGo5
         ha1DuT4HoMlWoS2xbjcHD9GgRlqpmlbohCyMbMp9jwqwOnMlSZhV2+NdX4eFfa98VCBL
         MySFNb6TUBd5MwKM15f/JKkm7ISgk4R8RRlMNS3qvBQTGFUN0ezUl0Dr6K+Gc1/P4DnX
         8ZGckxaO1CJWUH9d3oevj0h8TKRgKtOCJV4IHcOZjGIVh4oaVUwI+TxuBlP8t2PTLK5h
         GbI1fTA7zkpE2ub9FzL2tYr1Qq8Ouk8maga8/59tzL4TaygYU9UwrwY965BMBDmjNKBR
         Cc/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=hTK9svkxCalPWjDuSZiFC82ZLTuRZwIdVK7MOTRmJVE=;
        b=ipTrmL8SHCs8eokxmTn5lKcDngDgTwAp/uf9ysEdGOz3fzAyW61y1ntrHy3j1vRfUy
         Z2IEak5WPOj0vGP4o/D+Kqu2HsyFcRj4d2y89b6beD0sqQ085CzfU0SYzVm80LwhZsFq
         9quhxyiCOles1fTxo183eTajq2VSuC9/5L4KaWje+z6pRuQzxnPwnAg4YgEXpFg5GpTx
         yO7aBXSpOw81+1IZtELrY+BhrqToSpYehdPgA87wFW34N+rCLYCVfmtWiBdC2e9f0KdI
         UM4U1rAwsaA2ec428RtmRm9AByNvoClnwNp//jAKONIsN3tLSap1/uP38TnkTfiy9iPB
         vA6g==
X-Gm-Message-State: AEkooutyXuhYjFjXiNvPk1SXAhgw8LmVYfLTU+wS4MzAmX7yZcII6AN4kB+gdb9Zs/WQpA==
X-Received: by 10.194.186.231 with SMTP id fn7mr13852370wjc.164.1471787213444;
        Sun, 21 Aug 2016 06:46:53 -0700 (PDT)
Received: from [192.168.1.26] (deh62.neoplus.adsl.tpnet.pl. [83.23.111.62])
        by smtp.googlemail.com with ESMTPSA id u2sm10255599wmf.5.2016.08.21.06.46.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Aug 2016 06:46:52 -0700 (PDT)
Subject: Re: Extending "extended SHA1" syntax to traverse through gitlinks?
To:     Josh Triplett <josh@joshtriplett.org>, git@vger.kernel.org
References: <20160820225013.l7ynru7hzcmrzff7@x>
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <9bad3d13-3257-2077-a734-f985c375b8d3@gmail.com>
Date:   Sun, 21 Aug 2016 15:46:36 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20160820225013.l7ynru7hzcmrzff7@x>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

W dniu 21.08.2016 o 00:50, Josh Triplett pisze:

> Currently, if you have a branch "somebranch" that contains a gitlink
> "somecommit", you can write "somebranch:somecommit" to refer to the
> commit, just like a tree or blob.  ("man git-rev-parse" defines this
> syntax in the "SPECIFYING REVISIONS" section.)  You can use this
> anywhere you can use a committish, including "git show
> somebranch:somecommit", "git log somebranch:somecommit..anotherbranch",
> or even "git format-patch -1 somebranch:somecommit".
> 
> However, you cannot traverse *through* the gitlink to look at files
> inside its own tree, or to look at other commits relative to that
> commit.  For instance, "somebranch:somecommit:somefile" and
> "somebranch:somecommit~3" do not work.

Note that there is the same problem traversing through trees:
while 'git cat-file -p HEAD:subdir/file' works, the 'HEAD:subdir:file'
doesn't:

  $ git cat-file -p HEAD:subdir:file
  fatal: Not a valid object name HEAD:subdir:file

Though you can do resolve step manually

  $ git cat-file -p $(git rev-parse HEAD:subdir):file

This works.

> 
> I'd love to have a syntax that allows traversing through the gitlink to
> other files or commits.  Ideally, I'd suggest the syntax above, as a
> natural extension of the existing extended syntax.

And with the above manual resolving, you can see the problem with
implementing it: the git-cat-file (in submodule) and git-rev-parse
(in supermodule) are across repository boundary.

Also the problem with proposed syntax is that is not very visible.
But perhaps it is all right.  Maybe :/ as separator would be better,
or using parentheses or braces?

> (That syntax would potentially introduce ambiguity if you had a file
> named "somecommit:somefile" or "somecommit~3".  That doesn't seem like a
> problem, though; the existing syntax already doesn't support accessing a
> file named "x..y" or "x...y", so scripts already can't expect to access
> arbitrary filenames with that syntax without some kind of quoting, which
> we also don't have.)

Errr... what?

  $ echo A..B >A..B
  $ git add A..B
  $ git commit -m 'A..B added'
  [master 2d69af9] A..B added
   1 file changed, 1 insertion(+), 1 deletion(-)
   create mode 100644 A..B
  $ git show HEAD:A..B
  A..B

> 
> Does this seem reasonable?  Would a patch introducing such syntax
> (including documentation and tests) be acceptable?

-- 
Jakub Narębski

