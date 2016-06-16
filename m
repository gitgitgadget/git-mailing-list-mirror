Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.9 required=5.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC1DC1FE4D
	for <e@80x24.org>; Thu, 16 Jun 2016 16:31:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754530AbcFPQbb (ORCPT <rfc822;e@80x24.org>);
	Thu, 16 Jun 2016 12:31:31 -0400
Received: from mail-qk0-f178.google.com ([209.85.220.178]:34592 "EHLO
	mail-qk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754503AbcFPQba (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jun 2016 12:31:30 -0400
Received: by mail-qk0-f178.google.com with SMTP id s186so58784809qkc.1
        for <git@vger.kernel.org>; Thu, 16 Jun 2016 09:31:30 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=CVCWc+hmU5hMJNimmEOWIxNK4x2vGSKnGHJgt2AR58Q=;
        b=Zvta+Bx0TPspIJCAizdLkFJiOOR1zyVFJxCIv2sjPQ5gu6mQNc7euqpeej2syOK9Jk
         PorN2G47meAaek7zWEmKBH4RJ3sWtY9nJRP/vty4Y71F/ZY3Utf4x/KlGb3pQK23zWBG
         uT7Y5nYB2OdvLYdkNVr/5Pyu9gzD4hOlm6/G85rN94PMsQbzl2boFbpgKvVuSc6dWwgU
         exoZ15AvNhf0Ie8I98VJUWHtkwCQ0znX+rGhGqqhWUpZ/CSfBHN02eeYGsjfR4BdRZeG
         +rX504w4nFms0J+q9Kzr5iBVH4uiGV+CIVwDT+b37l2ICYY6ech42IjR9mkoUFh0GO9f
         lgYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=CVCWc+hmU5hMJNimmEOWIxNK4x2vGSKnGHJgt2AR58Q=;
        b=bLAzZ1gZgs07sgu2OeKJfSPkxQcdrvg1+xq6V7Ayk8GrbO0yRNwI9HzeZH2mFdV6KI
         Xx/ODtoMW0yG9IAXyK3RmWpPxD0YeWa+X1O/1Ql6CEYGM1qK5bK1H6xUkhenXv6FXleZ
         4T2h57ND4dysQeXu08RLCRrWTtHCpyiRcqBnLR8i8XgO1IuiCU2S6NSeWVhxHKnjRw9q
         zX3swSG7oICxA46UUHpHs2MLlTP376zCrSeB4XmEdeUqdsS1Hjw4HSk7PjSJaBp5lsDV
         eeS+5p0PxNGZCwj8wHKUuPEa0CA2+l9ndMrRpoBRbySSKfqozvqAIiAzVFS458rxOMMC
         qg7A==
X-Gm-Message-State: ALyK8tIVyF3j/o4kPLJTGP/9s02owWdSiaIT7UDTUi/ZzhhcDTkANZvh1Kze+G7+SjO9M/FN57ko8nK7nE/0KTg+
X-Received: by 10.55.163.200 with SMTP id m191mr6192601qke.175.1466094689400;
 Thu, 16 Jun 2016 09:31:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.237.42.226 with HTTP; Thu, 16 Jun 2016 09:31:28 -0700 (PDT)
In-Reply-To: <CAFOYHZArnE6vJ0U1zJAxytCBJJU5M-VtHbct6Qq4VPfw7-T-2A@mail.gmail.com>
References: <CAFOYHZDw-P0ST8WKoSVxBpbFCiACZpgiDPMfw5MRtFTMosO0rg@mail.gmail.com>
 <CAFOYHZArnE6vJ0U1zJAxytCBJJU5M-VtHbct6Qq4VPfw7-T-2A@mail.gmail.com>
From:	Stefan Beller <sbeller@google.com>
Date:	Thu, 16 Jun 2016 09:31:28 -0700
Message-ID: <CAGZ79kZkWjaRGQ3Sz3ujWyjmKFRzZYCkeNVVNVhgihPVSi7jdQ@mail.gmail.com>
Subject: Re: [bug] assertion in 2.8.4 triggering on old-ish worktree
To:	Chris Packham <judge.packham@gmail.com>
Cc:	GIT <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Wed, Jun 15, 2016 at 10:02 PM, Chris Packham <judge.packham@gmail.com> wrote:
> On Thu, Jun 16, 2016 at 4:59 PM, Chris Packham <judge.packham@gmail.com> wrote:
>> Hi All,
>>
>> I have the git-sh-prompt configured in my .bashrc today I visited an
>> old worktree that I haven't really touched in a few years (sorry can't
>> remember the git version I was using back then). I received the
>> following output when changing to the directory
>>
>> git: pathspec.c:317: prefix_pathspec: Assertion `item->nowildcard_len
>> <= item->len && item->prefix <= item->len' failed.
>>
>> I assume it's one of the git invocations in git-sh-prompt that's
>> hitting the assertion. Any thoughts on what might be triggering it?
>> Any debug I can gather?

The first step would be to identify which git command is actually causing it.
Can you take your  git-sh-prompt and run it step by step to figure out what
command is failing?

The next step after that would be to see if we can reproduce it in a reduced
test case (with no real data) so we can add a regression test and a fix for it.

>
> A bit more info. The directory in question is a uninitialised
> submodule. It doesn't trigger in the root of the parent project.

so it's a

    cd submodule
    git <command>

that is failing?

Thanks,
Stefan

> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
