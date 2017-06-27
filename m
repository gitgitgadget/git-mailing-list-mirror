Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D9D3020401
	for <e@80x24.org>; Tue, 27 Jun 2017 18:08:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753211AbdF0SH6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Jun 2017 14:07:58 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33775 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753167AbdF0SH5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jun 2017 14:07:57 -0400
Received: by mail-wm0-f65.google.com with SMTP id j85so7261145wmj.0
        for <git@vger.kernel.org>; Tue, 27 Jun 2017 11:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=QE05up2QN9C8htjZiHS5GvOcExMWXJB2w1HGpK0lLQI=;
        b=qK3X3yUfy9oUnrXr7DMJq16H9j6Kiv95ZZ8tGcUhsfElVzB9Ksu1clIe8OdTKSuyTI
         Fuogs9TRRhRKSdlaQK/ac7zlnRcIEAGwKbLnuA7RN72oIVIQ/rrVVr7pFsFNWUJvfR44
         R/4KzSFFPL6ppEiHwTr5V3DuChcSTS5i0J4jotUPcxQXd3uE+XvUQxSBADaho1Up5dDQ
         HQX8N3HcwjaCKh0v84fZErh5A5ux40wVaoZB0NxyfXA0NEYvDl4k5aeZJIGD8C3rbPsK
         w45fUJb0MgDhNuS8QOuhizyQUxwcqS7QhPNndubEbgkejE1SoYer9IZt1RLWWbKFq1z/
         4vMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=QE05up2QN9C8htjZiHS5GvOcExMWXJB2w1HGpK0lLQI=;
        b=njW7XRTh43pyK1YDqht+lYukC1WQAUZaTWiRf6q0SFGNsi6OZxqm+BKldemCpxd4xI
         zFXIf2RL/ShmDKw0DloT6TR2h8yZa13/LQTYawOLzZZHf1mbGiEWgBqR97btuoYPl6p0
         YG0o/TmDdqJo6RnvUq8bz0jV7Lvr6g04yYWgeqPH2Z1i58PnV8+DMcwq+MZDin6zLGHW
         rWFtaSC59a3DhBwz/UMFcSqKBk98v4zZEDpXwOC8jsjsoaM9ZFT3CQ0ARbz5oZJ0/OcJ
         DV0RtrbFtCVym90JRMeO0OAQTEGLJ5Dh9lUU+LY8Skv7r41BcPvP8goznTCwR7LTO41n
         60NA==
X-Gm-Message-State: AKS2vOyOf6dQQ4o6MD2nWHx1LN0g2bZPqov1jCpc8A8utBoPRyehwUaQ
        RzzYcSc4wieXKw==
X-Received: by 10.80.226.204 with SMTP id q12mr4993241edl.37.1498586870678;
        Tue, 27 Jun 2017 11:07:50 -0700 (PDT)
Received: from snth (g74110.upc-g.chello.nl. [80.57.74.110])
        by smtp.gmail.com with ESMTPSA id e28sm1370214ede.14.2017.06.27.11.07.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Jun 2017 11:07:49 -0700 (PDT)
Received: from avar by snth with local (Exim 4.84_2)
        (envelope-from <avarab@gmail.com>)
        id 1dPutw-0005s7-U6; Tue, 27 Jun 2017 20:07:48 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Michael Kebe <michael.kebe@gmail.com>,
        "Liam R . Howlett" <Liam.Howlett@Oracle.com>,
        Adam Dinwoodie <adam@dinwoodie.org>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 1/3] sha1dc: update from my PR #36
References: <20170627121718.12078-1-avarab@gmail.com> <CAKKM46tHq13XiW5C8sux3=PZ1VHSu_npG8ExfWwcPD7rkZkyRQ@mail.gmail.com> <20170627121718.12078-2-avarab@gmail.com> <xmqqmv8t317c.fsf@gitster.mtv.corp.google.com> <xmqqinjh2zqu.fsf@gitster.mtv.corp.google.com>
User-agent: Debian GNU/Linux 8.8 (jessie); Emacs 25.1.1; mu4e 0.9.19
In-reply-to: <xmqqinjh2zqu.fsf@gitster.mtv.corp.google.com>
Date:   Tue, 27 Jun 2017 20:07:48 +0200
Message-ID: <87y3sdjocr.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jun 27 2017, Junio C. Hamano jotted:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:
>>
>>> +#else /* Not under GCC-alike or glibc or <processor whitelist>  or <processor blacklist> */
>>> +
>>> +#ifdef _BIG_ENDIAN
>>> +/*
>>> + * Solaris / illumos defines either _LITTLE_ENDIAN or _BIG_ENDIAN in
>>> + * <sys/isa_defs.h>.
>>> + */
>>> +#define SHA1DC_BIGENDIAN
>>
>> This makes readers of this patch wonder why we assume platforms
>> won't define _LITTLE_ENDIAN and _BIG_ENDIAN at the same time, just
>> like we saw in the section with __BIG_ENDIAN above.
>
> To be a bit more constructive, I'd feel it MUCH safer, if this "If
> _BIG_ENDIAN is defined, set SHA1DC_BIGENDIAN" is done _ONLY_ when
> we definitively KNOW that we are on Solaris, something like:
>
> 	#if defined(__sun) && defined(_BIG_ENDIAN)
> 	/*
> 	 * Solaris ...
> 	 */
> 	#define SHA1DC_BIGENDIAN
> 	#endif

Yes, this would be better, but I don't know what macro test to use to
test for Solaris. Oracle documents defined(sun), but that doesn't work
on the Solaris versions we tested, and looking/searching illumos headers
I didn't find anything obvious.

The __sun define is ours, and would work for us, but upstream couldn't
take it.

>> Thanks, but this is starting to feel like watching a whack-a-mole
>> played while blindfolded.  At some point, somebody upstream should
>> declare that enough is enough and introduce the "SHA1DC_FORCE_ENDIAN"
>> macro.
