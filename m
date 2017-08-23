Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 00FE920899
	for <e@80x24.org>; Wed, 23 Aug 2017 16:56:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932280AbdHWQ4k (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Aug 2017 12:56:40 -0400
Received: from mail-pg0-f47.google.com ([74.125.83.47]:34965 "EHLO
        mail-pg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932262AbdHWQ4i (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Aug 2017 12:56:38 -0400
Received: by mail-pg0-f47.google.com with SMTP id u191so2421879pgc.2
        for <git@vger.kernel.org>; Wed, 23 Aug 2017 09:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=5XN9juEfSiD+1dgNqCj3DPI/odEy2zEP/2gtjCh+6Qo=;
        b=Ll5SjFPq8BJTMp4F2NMnmIaQTgSsgPrmx8bZnDk2FZIln6TlNiBx2dqwEweYF3sREi
         2C9DDDn5NwuFc7uXP+dLgU9CLhcxP14sYb4olEjOvJT/vELR6tReNy6EgLIxx9iPE0JA
         ZJh8MBVWHAKzDHnoepNE9bnmdMJMtHLHKsk/ARTjoChB8vZEYNSBv7QCHGz/8Bd2DIsT
         bQqfWlkQ4WwEsBc/dB0fHkIUlY1OpACO92rPaPvN/RKAJrSn74KLIrSjAiKcs80H6PKN
         Gw3GoS2T2LsUmy4jb6KBvSUTpiLRsoslvqnb2d8jaVVZx4ZH/+wB9l6r/+ns82SewRk+
         aK5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=5XN9juEfSiD+1dgNqCj3DPI/odEy2zEP/2gtjCh+6Qo=;
        b=HtHBU3ra8dKgFfDfVS2ZW4cjMfUmDZClFRZtp68x74mZhJuQvWdDrdBhGGpAvpwQGC
         bIt8ZITXlR/OS5CtAvXNFaLCBQCsH9lDSarpLDXTxn8/i6nY5MFr6uxy2MdiAZ9+L5ql
         KAPpXX8q+OA/X4VPc/5418cepDjUPGtfCUA/34+2u6DbK8DN6AZD0xZ8scxKG1qXmRxE
         KH+ExNhkntKhc9GhtwYxKj1O6qB6d+sQnAmZxlEgbjqTW3JylM3DzbW3RVnos2ULHHpI
         6uvwbSkmXf45kGwqUmbElCnlCtpF7jUWm3Nh9LNYV3pO7tTuLTYOz8k5WDDdVB4itmFB
         EEvg==
X-Gm-Message-State: AHYfb5g98VtngZnk2X4sCaAuytNwr9K89hepmsylWIpqKDOPE3EyqoEw
        OBKUanLCM+QZ0A==
X-Received: by 10.98.138.92 with SMTP id y89mr3464230pfd.186.1503507397394;
        Wed, 23 Aug 2017 09:56:37 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:402:dc68:f470:52d1:2c63])
        by smtp.gmail.com with ESMTPSA id v187sm3546266pgv.67.2017.08.23.09.56.36
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 23 Aug 2017 09:56:36 -0700 (PDT)
Date:   Wed, 23 Aug 2017 09:56:34 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jeffrey Walton <noloader@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>, Git List <git@vger.kernel.org>
Subject: Re: How to force a push to succeed?
Message-ID: <20170823165634.GI13924@aiede.mtv.corp.google.com>
References: <CAH8yC8=A0-geqduTNNJw0yb1BREqsB75_bKSp+06Rb5fY6oiuQ@mail.gmail.com>
 <CAGZ79kYyO4zvmTvMpxpFyBEs4f=xoy_-UeSbmi9W-OCFz0kCwQ@mail.gmail.com>
 <CAH8yC8nu7zDmkQMZ99SpePXL1WpvvcOdQDAtwdo4WXiPiR3tOQ@mail.gmail.com>
 <CAH8yC8nHnbWTG4hxD+mEHKPS6eWcBb7yMsgN886=aTWaBRhE5A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH8yC8nHnbWTG4hxD+mEHKPS6eWcBb7yMsgN886=aTWaBRhE5A@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jeffrey,

Jeffrey Walton wrote:

> From another testing machine, it looks like the changes have not been
> backed out. The previous operation un-did the ADX gear because it was
> an evolutionary dead-end.
>
> via$ git pull
> From https://github.com/noloader/cryptopp
>  + 66654dd...559fc3b master     -> origin/master  (forced update)

The Git User Manual[1] explains:

| We have already seen how to keep remote-tracking branches up to date
| with git-fetch(1), and how to merge two branches. So you can merge
| in changes from the original repository’s master branch with:
|
| $ git fetch
| $ git merge origin/master
|
| However, the git-pull(1) command provides a way to do this in one step:
|
| $ git pull origin master

There is also some discussion of that in "git help pull".

But that doesn't appear to be what you want to do.  You are not
looking to incorporate remote changes into your local branch,
preserving any changes that are in your local branch --- instead, you
are looking to move to what the remote server has, overwriting any
changes that are in your local branch.

You can do that with

	git fetch
	git reset --hard origin/master

See also the discussion of --force in "git help push".

I also recommend looking at the Git Tutorial[2].  When it introduces
"git reset --hard" to back out changes, it says:

| $ git reset --hard HEAD^ # reset your current branch and working
|                          # directory to its state at HEAD^
|
| Be careful with that last command: in addition to losing any changes
| in the working directory, it will also remove all later commits from
| this branch. If this branch is the only branch containing those
| commits, they will be lost. Also, don’t use git reset on a
| publicly-visible branch that other developers pull from, as it will
| force needless merges on other developers to clean up the history.
| If you need to undo changes that you have pushed, use git revert
| instead.

If you have ideas about how it could explain this better (or even
better, how commands could behave to avoid needing such explanation)
then I would be happy to hear them.

(Side note: I am starting to wonder whether what you were looking for
was something like "git revert", especially if this is a project
involving more than one person.)

> You know, I look at how fucked up yet another simple workflow is, and
> all I can do is wonder. It is absolutely amazing. Its like the project
> goes out of its way to make simple tasks difficult.

I understand your frustration, but accusing people of trying to make
your life difficult isn't a particularly productive way to get help
from them.

For the future, some ways to get good results are

- to describe the background of what you are trying to do
- to describe where you looked for answers, so that we know what
  documentation to improve

The #git IRC channel on freenode can also be helpful for real-time
help.  But I encourage you to also keep writing here so that we know
what documentation and workflows to improve.

Thanks and hope that helps,
Jonatha

[1] https://www.kernel.org/pub/software/scm/git/docs/user-manual.html#getting-updates-With-git-pull
[2] https://www.kernel.org/pub/software/scm/git/docs/gittutorial.html
