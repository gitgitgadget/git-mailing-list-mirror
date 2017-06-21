Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3DDCD20D0C
	for <e@80x24.org>; Wed, 21 Jun 2017 21:56:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751963AbdFUV43 (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Jun 2017 17:56:29 -0400
Received: from mail-wr0-f177.google.com ([209.85.128.177]:33457 "EHLO
        mail-wr0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751835AbdFUV42 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jun 2017 17:56:28 -0400
Received: by mail-wr0-f177.google.com with SMTP id r103so152807593wrb.0
        for <git@vger.kernel.org>; Wed, 21 Jun 2017 14:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=S2SBA9YRT1w9T9HAO0m4mY/bNag8R/sb4j3bvliTVrM=;
        b=EA7fpW+fgzCpxHVM8FvaBkNe1NtMzGrO97RvEZq2Ar79KG2VfmvDcRneVxPuRvmMW/
         87rqufgKQ3FC5pKcTk2s9+UfmhpDWth+OmXIfEUK9oAQuOFdaNRIw6yLfBDmJcukl0+R
         lUInXEnr5emtqBqkv6IXEpRb4gUE0VHqstzlD9LswXYgxDgQZ5dcTfOUNlJf4eL8OUAp
         jqooxR6af4qSlouA5d0MMC0RVZ3gooEMFG9Xtu/E9VHrFFbYZRNYpN/Kefysc8up/V6E
         TzgKFsoe1MqbcSMUVwbIKbhJF1KlWOMr9bmP4542XHjtTYOyM3GmWE8b9YiwuRTQaBlr
         6Cnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=S2SBA9YRT1w9T9HAO0m4mY/bNag8R/sb4j3bvliTVrM=;
        b=K1pSN0krF2MKsAoY9jsoJkn+MBfIFp4yyFs5XAnEOwXq7C60qSzw4cW4qq/oA2GO9H
         IMoCXw06eXN6OEwCDjlVIyhzzZV+RGcd7StTvfNZ9XXvqUOXbVAENqouz/v30pcDhotC
         dCO7ZmO0nvIsoZYpnteEWhjYvwUNSr7iqb3cvKvTEx3DFJYR1QjoJLuvqtZfFlWp5tPV
         B1X7Ti9kHspfFNveB2+kncbB82az09HaLq/k58urGlcfyRmn1yx9cntQza8Jp4g9xbMC
         c/kZeL6xeiVMoQZeEPBwFD1hxuG3sYrsbKoDxbA1Sesaji7oAvk/s6RPt8NYdsdJRBAs
         tK1Q==
X-Gm-Message-State: AKS2vOzAyZ3QJEFwzTsT/b9EU/P+hPT6lOcp88Jcn6Cb2XSPBQCZO06R
        kd0bFi81lA8vSg==
X-Received: by 10.80.186.37 with SMTP id g34mr3808430edc.162.1498082187044;
        Wed, 21 Jun 2017 14:56:27 -0700 (PDT)
Received: from snth ([92.109.130.42])
        by smtp.gmail.com with ESMTPSA id l4sm9520283edb.35.2017.06.21.14.56.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Jun 2017 14:56:26 -0700 (PDT)
Received: from avar by snth with local (Exim 4.84_2)
        (envelope-from <avarab@gmail.com>)
        id 1dNnbt-0000Kc-EH; Wed, 21 Jun 2017 23:56:25 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Eric Wong <e@80x24.org>
Cc:     Tim Hutt <tdhutt@gmail.com>, git@vger.kernel.org
Subject: Re: Monitoring a repository for changes
References: <CAKuVd4Bdhreu6wrwDp1Bia56Db=TXYMQcitsznaRM+QcYVzJnQ@mail.gmail.com> <87efud8jrn.fsf@gmail.com> <20170621195252.GA31582@starla>
User-agent: Debian GNU/Linux 8.8 (jessie); Emacs 25.1.1; mu4e 0.9.19
In-reply-to: <20170621195252.GA31582@starla>
Date:   Wed, 21 Jun 2017 23:56:25 +0200
Message-ID: <87a85180om.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jun 21 2017, Eric Wong jotted:

> Ævar Arnfjörð Bjarmason <avarab@gmail.com> wrote:
>> On Wed, Jun 21 2017, Tim Hutt jotted:
>>
>> > Hi,
>> >
>> > Currently if you want to monitor a repository for changes there are
>> > three options:
>> >
>> > * Polling - run a script to check for updates every 60 seconds.
>> > * Server side hooks
>> > * Web hooks (on Github, Bitbucket etc.)
>> >
>> > Unfortunately for many (most?) cases server-side hooks and web hooks
>> > are not suitable. They require you to both have admin access to the
>> > repo and have a public server available to push updates to. That is a
>> > huge faff when all I want to do is run some local code when a repo is
>> > updated (e.g. play a sound).
>
> Yeah, it kinda sucks that way.
>
> Currently, for one of my public-inbox mirrors which has ssh
> access to the primary server on public-inbox.org, I have:
>
> 	#!/bin/sh
> 	while true
> 	do
> 		# GNU tail(1) uses inotify to avoid polling on Linux
> 		ssh public-inbox.org tail -F /path/to/git-vger.git/info/refs | \
> 				while read sha1 ref
> 		do
> 			for GIT_DIR in git-vger.git
> 			do
> 				export GIT_DIR
> 				git fetch || continue
> 				git update-server-info
> 				public-inbox-index # update Xapian index
> 			done
> 		done
> 	done
>
> It's not perfect as it requires multiple processes on the
> server, but it's better than polling for my limited use.
>
>> > Currently people resort to polling
>> > (https://stackoverflow.com/a/5199111/265521) which is just ugly. I
>> > would like to propose that there should be a forth option that uses a
>> > persistent connection to monitor the repo. It would be used something
>> > like this:
>> >
>> >     git watch https://github.com/git/git.git
>> >
>> > or
>> >
>> >     git watch git@github.com:git/git.git
>> >
>> > It would then print simple messages to stdout. The complexity of what
>> > it prints is up for debate, - it could be something as simple as
>> > "PUSH\n", or it could include more information, e.g. JSON-encoded
>> > information about the commits. I'd be happy with just "PUSH\n" though.
>>
>> Insofar as this could be implemented in some standard way in Git it's
>> likely to have a large overlap with the "protocol v2" that keeps coming
>> up here on-list. You might want to search for past threads discussing
>> that.
>
> Yeah, it hasn't been a priority for me, either...
>
>> > In terms of implementation, the HTTP transport could use Server-Sent
>> > Events, and the SSH transport can pretty much do whatever so that
>> > should be easy.
>>
>> In case you didn't know, any of the non-trivially sized git hosting
>> providers (e.g. github, gitlab) provide you access over ssh, but you
>> can't just run any arbitrary command, it's a tiny set of whitelisted
>> commands. See the "git-shell" manual page (github doesn't use that exact
>> software, but something similar).
>>
>> But overall, it would be nice to have some rationale for this approach
>> other than that you think polling is ugly. There's a lot of advantages
>> to polling for something you don't need near-instantly, e.g. imagine how
>> many active connections a site like GitHub would need to handle if
>> something like this became widely used, that's in a lot of ways harder
>> to scale and load balance than just having clients that poll something
>> that's trivially cached as static content.
>
> Polling becomes more expensive with TLS and high-latency
> connections, and also increases power consumption if done
> frequently for redundancy purposes.
>
> I've long wanted to do something better to allow others to keep
> public-inbox mirrors up-to-date.  Having only 64-128 bytes of
> overhead per userspace per-connection should be totally doable
> based on my experience working on cmogstored; at which point
> port exhaustion will become the limiting factor (or TLS overhead
> for HTTPS).

Come to think of it I should probably have asked you about this, but I
have a one-liner running that polls every 5 minutes, but will stop if I
haven't changed my git.git in a day:

    while true; do if test $(find ~/g/git -type f -mmin -1440 | wc -l) -gt 0; then git pull; else echo too old; fi ; date ; sleep 300; done

> But perhaps a cheaper option might be the traditional email/IRC
> notification and having a client-side process watch for that
> before fetching.

If there was a IRC channel with this info I could/would use that,
getting it via E-Mail would just get me into the same problem
public-inbox is currently solving for me, i.e. I might as well keep the
git ML up-to-date on that machine if I'm going to otherwise need to
subscribe to a "hey there's a new message on the git ML" list :)
