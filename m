Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CFABC433EF
	for <git@archiver.kernel.org>; Mon, 30 May 2022 20:16:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243204AbiE3UQD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 May 2022 16:16:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243248AbiE3UPp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 May 2022 16:15:45 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 862BD9B198
        for <git@vger.kernel.org>; Mon, 30 May 2022 13:15:40 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id p8so12027677qtx.9
        for <git@vger.kernel.org>; Mon, 30 May 2022 13:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lO/opp8ro4hbMxNxu8TDPJtKq1L9rj1FQzBAQ6dTN/Y=;
        b=gjZhP+rfRYcD5OhwylM9KAsbU0juSGWIBDVvTIvgX5zFpBIaisV98GoLntZtvbMVLQ
         rKGKfNOaIx7LzU5Poo2PFRbxKJuzkkP1DE1Fl1NTd9sVmptCf30t7E/0oygpSLWkOczx
         CzvOmg9sI5XlpT50ojaZIZOSoJ6JgnYqG2JihLpfavNw8k9NC7abxS8GUp4WWyaI8kg4
         fTRuiye8JFs7qhMnE46Y57Rpqz1AhhgOUYO8xM7yEimicYgBX8RH3brSpgSctQkvUUUV
         CuyaU/o104jd4p29qMipqokdN8cCR4XMLwr6DBdQCMbpn3DryyooBf3XW6aIl/vvi/Ak
         rJRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lO/opp8ro4hbMxNxu8TDPJtKq1L9rj1FQzBAQ6dTN/Y=;
        b=U9eNeyajpctH2IwgzYnATgSRTbLB/RwtXF9pBUmbfOp29la1naZ4X7qsz/7oEWSI3Z
         /0t8R4HKjkFI0JZKX8OandYiw3EOSM4ILg8f2hMAYsfR6HuT9YoR2zSLH+mb07ehF2SD
         Lzl6X5HHFjO9nudHnibqG0SNyWjDaddg9sQlGh2xZ92NufL7ZbX4NDYd/4aTjge1YXfi
         RPU4qyuUGIf4drjew8gkWvnlC6+IuIKpva+Z/FoJoAel0qLpIGImfMa4IUhzCnprWtm4
         2SI1kjIZ4h/xa+x2eDdcF/n2KH/B/R8rXnL6+0GZHheo/beDpYL08w7I3GeY87bjoMw3
         zjrA==
X-Gm-Message-State: AOAM530SGMieKh6mFYxsExCtPr7diCS/oUsqm4U/HOpYrsnoT75wfU5V
        xIKY/mdzd0t0LiBjT7MxYII6O0JWMEE=
X-Google-Smtp-Source: ABdhPJzxE/+qbQdGSeP7+UIWDuLQEZ1cOzl3/lyKPnv7sw348zs2HU8wiI+FdjAD2nxYVCMjA0BduQ==
X-Received: by 2002:ac8:4e94:0:b0:2fc:7035:3211 with SMTP id 20-20020ac84e94000000b002fc70353211mr18322665qtp.300.1653941739508;
        Mon, 30 May 2022 13:15:39 -0700 (PDT)
Received: from [192.168.1.127] (173-246-5-136.qc.cable.ebox.net. [173.246.5.136])
        by smtp.gmail.com with ESMTPSA id z207-20020a3765d8000000b0069fc13ce23esm8242443qkb.111.2022.05.30.13.15.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 May 2022 13:15:38 -0700 (PDT)
Subject: Re: Investigating Cirrus CI FreeBSD failures
To:     Ed Maste <emaste@freebsd.org>
Cc:     Git mailing list <git@vger.kernel.org>,
        Carlo Arenas <carenas@gmail.com>
References: <9cc31276-ab78-fa8a-9fb4-b19266911211@gmail.com>
 <CAPyFy2AETzTCJUtbxS+RmygajrUS5XUkZvF-1FVbJ67t61bJtg@mail.gmail.com>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <e31d26ad-3b0b-15c0-262f-4eee83220949@gmail.com>
Date:   Mon, 30 May 2022 16:15:37 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAPyFy2AETzTCJUtbxS+RmygajrUS5XUkZvF-1FVbJ67t61bJtg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ed,

Le 2022-05-30 à 12:09, Ed Maste a écrit :
> On Fri, 20 May 2022 at 20:38, Philippe Blain
> <levraiphilippeblain@gmail.com> wrote:
>>
>> Hi,
>>
>> I spent a bit of time investigating the Git Cirrus-CI failures on FreeBSD.
>> It seems something goes wrong with the Perl installation, as most failures
>> are in t9001-send-email.sh, and the error messages are:
>>
>> ld-elf.so.1: /usr/local/lib/perl5/5.32/mach/CORE/libperl.so.5.32: Undefined symbol "strerror_l@FBSD_1.6"
> 
> Ah, what happened here is that this is picking up the perl package
> built on 12.3 (i.e., the earliest supported FreeBSD 12.x) which added
> strerror_l.
> https://cgit.freebsd.org/src/commit/?id=d3912bec58d0b82509a0973cae02f156986d88fa

OK, so it is expected that the Cirrus 12.2 image would install this newer
version of the perl package which if I understand correctly is not compatible
with this version ?

Is there a way to tell pkg not to update packages to incompatible versions,
or is the FreeBSD policy that as soon as a release is marked as unsupported, 
then no guarantee is made that things (like installing packages) continue working 
on that version ?

> 
>> I know next to nothing about Perl or FreeBSD, but simply changing our image
>> to FreeBSD 13.0 makes all failures in t9001 disappear [2]:
>>
>> ...
>> Is this something that we should do ? Or should we stick to FreeBSD 12
>> and try to debug this installation problem ?
> 
> I expect this could have been addressed also by updating to 12.3.
> Cirrus also supports "matrix" so both could be tested.
> 

For now we opted to just update to 12.3, see [1].

Thanks for your answer,

Philippe.

[1] https://lore.kernel.org/git/20220525125112.86954-1-levraiphilippeblain@gmail.com/
