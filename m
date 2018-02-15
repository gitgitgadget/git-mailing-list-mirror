Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 847CD1F404
	for <e@80x24.org>; Thu, 15 Feb 2018 21:33:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1163297AbeBOVdh (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Feb 2018 16:33:37 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:39330 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162678AbeBOVde (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Feb 2018 16:33:34 -0500
Received: by mail-wm0-f68.google.com with SMTP id b21so3433792wme.4
        for <git@vger.kernel.org>; Thu, 15 Feb 2018 13:33:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=3453dt5yXKjA4xIWhMIO9cB2l2WtSe7FLGXASN2iIFg=;
        b=T5/9mOQRGr1RHEKBRldbMwA5JstXfhUcSpY3bm9c5HPtEjrN45KYSYSWDr6rXHIZiB
         3DK5U/9Dc/krpFHNioI0SVD5YlapgRiK9L/N2qWMsV6tosuLUyqMrMJUZyB1J0FPgu8M
         pdlkqJ1IwWRBu/IA8xF3msQobeb5+cy+dp0vorwES/JEklFzziJQN3GU6Dhdid+vl4mw
         sLBGqFG8z3LrQ84dSTBgFdbmZJFRNZla9bSaE6ijRdwbNL49AmmnVrgoltnxrTDVutPs
         eJ/YKSG4hS0Vdwy+rIBSHudKk/ylAIrwdltyk/AZLQOZ353A7GBVAZehaE+JjV49oLqh
         mE4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=3453dt5yXKjA4xIWhMIO9cB2l2WtSe7FLGXASN2iIFg=;
        b=iT2U/vx8LUVPGTuOjCWxeXfafOCCWnpqYh4BQxreqz0qP+Dbwkv+qsHwqJqIOcHrhx
         wA0qhgp8GHbG9bAGcxASwL+RksnawFmp+np8B17kFBWM8XLqYYiUzAKWA6zlB/yRhKqQ
         weUcojZF/BBJ4LufltcnZtyNxCshje5Q4+od2bX4mdirKLt8qSlVPWxp44EQyUuFAHay
         +blodkYKT/hitE0i7CShem8qwZ3QKOT5x0YKGJIyZgie537ILcz5t4W92WKptfYMi55F
         g+Q8iFP6fLmEKBJy7YSu0ZrQFZTEVBT0tRTOFNWaOog0+gQaSQ1fLi7AE750kagyu0at
         PoTQ==
X-Gm-Message-State: APf1xPAa3dycA7aq7sgPlcbYgDaErmHQYRzMc4GeTruvtZgeqUScasOH
        Oy4lWkTdGt9nNQgMXPP/r58=
X-Google-Smtp-Source: AH8x227eLfBly9hOA6JS2bavkZZ/4ylbdasBLj+CL6V1Tu9g2GyRKgGW6AqOi/NsEBit+b4KfCp5Ww==
X-Received: by 10.28.52.4 with SMTP id b4mr3544225wma.90.1518730412687;
        Thu, 15 Feb 2018 13:33:32 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id s2sm1324406wmf.0.2018.02.15.13.33.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 15 Feb 2018 13:33:31 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
        Matthieu Moy <git@matthieu-moy.fr>, Petr Baudis <pasky@ucw.cz>,
        Benoit Bourbie <bbourbie@slb.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jari Aalto <jari.aalto@cante.net>,
        Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
        Marcus Griep <marcus@griep.us>
Subject: Re: [PATCH 8/8] perl: hard-depend on the File::{Temp,Spec} modules
References: <20180214222146.10655-1-avarab@gmail.com>
        <20180214222146.10655-9-avarab@gmail.com>
        <20180214235404.GH136185@aiede.svl.corp.google.com>
        <87r2pmf0hs.fsf@evledraar.gmail.com>
Date:   Thu, 15 Feb 2018 13:33:31 -0800
In-Reply-To: <87r2pmf0hs.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Thu, 15 Feb 2018 21:42:39 +0100")
Message-ID: <xmqqd1167xas.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> On Wed, Feb 14 2018, Jonathan Nieder jotted:
>
>> Ævar Arnfjörð Bjarmason wrote:
>>
>>> --- a/perl/Git.pm
>>> +++ b/perl/Git.pm
>>> @@ -1324,8 +1324,9 @@ sub _temp_cache {
>>>  }
>>>
>>>  sub _verify_require {
>>> -	eval { require File::Temp; require File::Spec; };
>>> -	$@ and throw Error::Simple($@);
>>> +	require File::Temp;
>>> +	require File::Spec;
>>> +	return;
>>
>> Same question as in the other patches: any reason not to simplify by
>> using 'use' at the top of the file instead?
>
> I was just going for the minimal change, but yeah, that makes
> sense. Will do that in v2.

Yes, if we are making them hard dependency, unless a major part of
the perl/Git.pm can be used without hitting _verify_require in the
current code, there is no point using "require only if we use it"
pattern.  As _verify_require is used even in the Git::repository
constructor, I think it makes more sense to have "use" upfront for
these two modules.

