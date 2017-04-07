Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F33A720966
	for <e@80x24.org>; Fri,  7 Apr 2017 16:14:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756141AbdDGQO3 (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Apr 2017 12:14:29 -0400
Received: from mail-lf0-f44.google.com ([209.85.215.44]:34246 "EHLO
        mail-lf0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755546AbdDGQO1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Apr 2017 12:14:27 -0400
Received: by mail-lf0-f44.google.com with SMTP id z15so44664545lfd.1
        for <git@vger.kernel.org>; Fri, 07 Apr 2017 09:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=jUgcDdXrsDxaqKZnhOzHxe0KsziqeGkOmR1qPfOF8wU=;
        b=mKViX2zDZ955XAEMqWd/iQWEaj5Tr92FFlmtAT07BZi2r1PW5wSOuOu0Mrf3v0vktz
         NjwqUvU+TbUmCWUakO4EawtCxIZyOJYi1a2nf7i4m2CsgFSgoia9pWIW60nd8qoS5A8k
         GnWbcXTA1tqoG9I9s3jxC0JOOO062/kg/CzDaKR5oTarRNWnMcb6haE9gv5T9M0jNqcN
         GTg5RuEeH9012JiOocHMkDS+E45GQmS5uEDcteB/Xs/3ffgP2s1P0n82ImnMMwm5fFh+
         m1FHmYf4Y8gAZ9bu7CI2aoHTthwxtdhsh1WaPaEULPp0KtbzMH4Z7MdzfNcTcxqR7oJw
         6N6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=jUgcDdXrsDxaqKZnhOzHxe0KsziqeGkOmR1qPfOF8wU=;
        b=Bk4i4/9E1Mtm4PZDbDn36cmE0WRTgj2kBhhsvfMKajFVv665TAWtTCYmQz4lQbxH6H
         WQowghgyn6jV6HqR1ohQrvPRndDXFKxPSF7pZPoNxJudX8hhYgsUkbBoRI45C5nPHtnr
         YdA6J7Bf0aCalBd3F662J19dkdp2AowB541IIul7PSCvyUH8u4Z1nA0ppeYrL0LdXqLz
         69Ze0U6oDtqoYOnttq4lg5PO7oxt0RLKsupwlcfWOAEwq6CwMCl9Izq6LeCWBVAToj5L
         S0WCzsyg1a6aOUXBL9ixc9TkVCNQCutgL1LCMW9MV8ljq4KvzE1SyyHAbojLSOC0GJsM
         9QYw==
X-Gm-Message-State: AN3rC/4MB7kLo2VJ27pDx9/yHtLYJ2XNkC7gnqD1LvK19S4dgY3yPXGnt1Sgcn2AAaXCTWW2U6RKgwmOeaq1oQ==
X-Received: by 10.25.24.217 with SMTP id 86mr1807269lfy.12.1491581665887; Fri,
 07 Apr 2017 09:14:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.145.30 with HTTP; Fri, 7 Apr 2017 09:14:05 -0700 (PDT)
In-Reply-To: <ee8e8671-066b-311e-8cad-31a1ab22eec7@grubix.eu>
References: <20170317222842.GP26789@aiede.mtv.corp.google.com>
 <20170317225110.13417-1-sbeller@google.com> <xmqq60j75psk.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kayeSxFTJr3Q1atFgOyR74PzQyCLiejuZxh7+wTGGb=ww@mail.gmail.com>
 <xmqqbmsvx1ey.fsf@gitster.mtv.corp.google.com> <20170320185038.GU26789@aiede.mtv.corp.google.com>
 <CACsJy8CBmfj8wY+LQzEshJT0Ya+nmAGs=K8b1Nyr3qinvCo4kA@mail.gmail.com>
 <xmqqvar2ska7.fsf@gitster.mtv.corp.google.com> <3c16aea8-be53-ef41-d43f-7b4e8ca15d7d@drmicha.warpmail.net>
 <xmqqd1d7ev2q.fsf@gitster.mtv.corp.google.com> <CACsJy8BNYmYarZqnERhsO8LDxdsMsviUMs3Co6C4Ed7W9OvDJQ@mail.gmail.com>
 <ee8e8671-066b-311e-8cad-31a1ab22eec7@grubix.eu>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Fri, 7 Apr 2017 09:14:05 -0700
Message-ID: <CA+P7+xotTt3e=yCp=ajHM7pV6Am_MZj5+e71-vCV1+utOa1XJg@mail.gmail.com>
Subject: Re: [PATCH] Documentation/git-worktree: use working tree for trees on
 the file system
To:     Michael J Gruber <git@grubix.eu>
Cc:     Duy Nguyen <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 7, 2017 at 6:59 AM, Michael J Gruber <git@grubix.eu> wrote:
> Duy Nguyen venit, vidit, dixit 25.03.2017 13:07:
>> On Fri, Mar 24, 2017 at 12:55 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>> Michael J Gruber <git@drmicha.warpmail.net> writes:
>>>
>>>> Are we at a point where we can still rename the new feature at least? If
>>>> yes, and keeping everything else is mandatory, than "workspace" or
>>>> "working space" may be a serious contender for naming the new thing.
>>>
>>> I do not have a good answer to the first question, but workspace
>>> does sound like a good name for what this feature is trying to
>>> achieve.
>>>
>>
>> Now is not too late to rename the command from worktree to workspace
>> (and keep "worktree" as an alias that will be eventually deleted).
>> Should we do it? I would keep file names, function names... unchanged
>> though, not worth the amount of new conflicts.
>
> I guess I would go for a full change. Our technical documentation often
> merely consists of the source code, so we should reduce potential
> confusion there, too.
>
> Michael

Yes, changing the command name but not all the code would cause more
confusion in the long run.

However, personally I never confused "worktree" and "working trees"
myself. I fee like they are related concepts anyways, in that a fresh
clone has one worktree which its its working tree. Renaming it all to
workspace doesn't bother me either.

Thanks,
Jake
