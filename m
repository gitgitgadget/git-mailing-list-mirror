Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EEC641FCA9
	for <e@80x24.org>; Sat, 10 Sep 2016 10:32:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752340AbcIJKcx (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Sep 2016 06:32:53 -0400
Received: from mail-wm0-f53.google.com ([74.125.82.53]:35858 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750861AbcIJKcw (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Sep 2016 06:32:52 -0400
Received: by mail-wm0-f53.google.com with SMTP id b187so67914098wme.1
        for <git@vger.kernel.org>; Sat, 10 Sep 2016 03:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=QMjZHv0/u26CMuBGg5wgWelhznASeXiOslYYle/c7KI=;
        b=tEwg0+rt8eNh5NgVrlB5b5+QB2GNu50nvj9A8ZDb3572DIg2Y8JAx46J9bflAj+1Bb
         AhMWYvtWswpMAauXCvSAkCMAtoAouWapBvUjs0ec2zJJ+57shgS6/xZrSSasBvzry181
         BlYBWvusFfgRKrSjWtT9PLOpf2fhK/0STVUgyuk6lQmqnnVx3HxRBOjGs6ImncLpn0ri
         /rGujJh6+FTg0Wf7+dgHLrEsbf7+OTHdZdUcO9TOtwuHAbuvQXG5l4uxutSYLlgzud1A
         eASf+4xnvkF0JnDquw7lUToOZOtO9J+YNa+Hyn9qCyDTlSouq6pLBhVQcPjVIXm0WwLb
         mzXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=QMjZHv0/u26CMuBGg5wgWelhznASeXiOslYYle/c7KI=;
        b=BNhlT02Ht1Lmuuuf35One9eDGZ7muTAM3jmGMvYx3Zngc6PCo1lDxlcc+1cpPb55V5
         IMfjHSCI9MMh6KyPjiSUthhzRuSqpLz9H8/JbWFDSQioIMXOO6wfY0Zs9MdBjp4nuF1K
         Kgm6fCiuVl/CzIJR1s6f7Op7NQZ5PBXUI/gltka/A0KvSZ9PbhvmfVCu7VeJDi2BgrUI
         TOHl8JNjnI/l5vBGGPGeKM/GL0uieM9ekjB3EZLtJuVFcb4ukHjpuHgn8wMIDCMF6yFg
         7IZiHw4SfGjMTPynea405zHbjd9vWdnsXpHuK6ZlKAJaS3+DNAFhDBmzxMHDntWj91TE
         WWww==
X-Gm-Message-State: AE9vXwOMuxVvnvjjBIBbf0LwnciKmICWXuHGKRAmj7w6lDUiwrB/slilY1Wo9F946+QXlA==
X-Received: by 10.194.216.37 with SMTP id on5mr7030548wjc.158.1473503570621;
        Sat, 10 Sep 2016 03:32:50 -0700 (PDT)
Received: from [192.168.1.26] (adby20.neoplus.adsl.tpnet.pl. [79.184.24.20])
        by smtp.googlemail.com with ESMTPSA id i131sm2301557wmg.10.2016.09.10.03.32.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 10 Sep 2016 03:32:49 -0700 (PDT)
Subject: Re: How to simulate a real checkout to test a new smudge filter?
To:     john smith <wempwer@gmail.com>, Junio C Hamano <gitster@pobox.com>
References: <CAKmQUfa_U-g6vC+SjbQSicEUwO+WofNfzezEEwikeOAeL31W5g@mail.gmail.com>
 <b71adc54-2ae6-ef8e-1dca-0883cd617e6e@web.de>
 <CAKmQUfbemaid61xPyvNheLM2jVGXGjiyF_x=NZnxkZ=5wccQ=Q@mail.gmail.com>
 <e17a88cd-2de7-dc84-2262-743e82d8b047@gmail.com>
 <CAKmQUfafCP6ZwUm7Ec5n2PzvNzBHnFWEJL1usMTFB6Ef0m=8pw@mail.gmail.com>
 <xmqqwpik8zy3.fsf@gitster.mtv.corp.google.com>
 <CAKmQUfYCUq=kUTau1-3NjjPVBk6WkP3KdTjgMC8sZtU8h=H4iQ@mail.gmail.com>
Cc:     =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>,
        git@vger.kernel.org
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <a00fa147-291c-536c-35da-56f88221e0f8@gmail.com>
Date:   Sat, 10 Sep 2016 12:32:47 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <CAKmQUfYCUq=kUTau1-3NjjPVBk6WkP3KdTjgMC8sZtU8h=H4iQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

W dniu 10.09.2016 o 01:07, john smith pisze:
> On 9/10/16, Junio C Hamano <gitster@pobox.com> wrote:
>> The clean and smudge operations should look _only_ at the contents
>> they are filtering, and nothing else, and the clean/smudge filtering
>> mechanism is designed to support that use case.  It is not designed
>> to do things like embedding the name of the branch that is being
>> checked out into the result.
> 
> Ok, I think I get it. It was actually my original problem with smudge
> filters because I wanted them to be run after *every* checkout even if
> file contents stayed the same (hence the subject).

And that's not the case, for performance reasons.

> 
> Now Jakub suggested post-checkout hook in conjunction with only clean
> filter for my problem of managing dotfiles but I think I don't fully
> get it.  The problem is that in the scenario presented in my last
> e-mail clean filter is run in the situation which doesn't like a
> checkin to me.  Is `git checkout <PATH>' doing a *checkin*" under the
> hood so that the clean filter is called?  What does actually `checkin'
> mean in Git?  I thought that checkin it's the same as committing a
> file into the repository.

I was wrong, I'm sorry. My mistake.

You would need post-checkout hook together with clean / smudge filters
(though you could get by without smudge filter, at least in theory...).
The `post-checkout` hook could run e.g. "git checkout -- '*.conf'"
to force use of smudge filter, after checking that it was a change
of branch ("git checkout <commit-ish>").  See githooks(5) for details
(last, third parameter passed to hook script is 1, rather than 0).

Unfortunately I don't see a way to query .gitattributes files to
find out all patterns that match specific attribute; you would need
to duplicate configuration:

  .gitattributes:
  *.conf filter=transform

  .git/config
  [filter "transform"]
  	clean  = replace-with-placeholder %f
  	smudge = expand-with-branchname %f

  .git/hooks/post-checkout
  #!/bin/sh

  test "$3" -eq "1" && git checkout -- '*.conf'

Or something like that.
-- 
Jakub Narębski

