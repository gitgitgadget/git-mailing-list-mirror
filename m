Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 488A91F404
	for <e@80x24.org>; Wed,  7 Mar 2018 22:59:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933858AbeCGW7C (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Mar 2018 17:59:02 -0500
Received: from mail-wm0-f45.google.com ([74.125.82.45]:39553 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754500AbeCGW7B (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Mar 2018 17:59:01 -0500
Received: by mail-wm0-f45.google.com with SMTP id i3so7665041wmi.4
        for <git@vger.kernel.org>; Wed, 07 Mar 2018 14:59:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=QgLkAbr4ZDVEYWWFW8uJ+z0+R3tvXpB3r0DiPE42L8M=;
        b=am5fajtCH0HIrmN3THUeHH5e/LvS8T+Nd85Zcaasb7ylGpwpwpOaID/bE5WAvGZQTM
         Y3hIYzERqUcG/JPkbiIjl07HKvuw6umu8QFjfAcITj9WnT2ZWJcHk1DMGQc4wW7dYIL4
         5aCSZEoP2kla/tK+Kl6ortlsUO2kCpZTSweLa9rZlpUjuwECUpKn0Z84zyM7W02Rcli6
         J5LHUY5vcVwGAjBYoCutVvPL85dyoPjfAiXq3a9w7KICHor9j0VQsI+72H2spkAnGXBb
         nKuBEBwSXsIrrEFssIVyYiYDzUp/3m1OE7o+PyRgZDhmp2zSBX5nHcMaGMd4DZ1OOzm/
         Rg3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=QgLkAbr4ZDVEYWWFW8uJ+z0+R3tvXpB3r0DiPE42L8M=;
        b=JeELSNllet58bCXAYOL+ni8BCdpqxMcP734PTmSZvB6hprWVn8cJYoD+zX4tE2ETdS
         dQovqz1/HCSpILMwVuF4VMwGD0crl4MUszIwDxTgfVEc9w2DTnkTqR5fqPAXRNXDfxGv
         yMJhMUulhjoRqzHvPDcAzXQSONJI6pag/psYzP8kILsf9v5AgGLxInFmkChq1klNIvpo
         fb9X+tWWNHQzgcs4dY4fTkMc4+eBYUuWE4dbsRxIV+Z/octZCOl2vFU14bPz2uxSIiUg
         OE9JPQ8N8tXzYEgwX7ePcJxiBBnzNzHjOIn416DxA+mMHe4gTkGeE4bL59LU+jBI+ocD
         z6Tw==
X-Gm-Message-State: AElRT7G0xm8KQa9MUxxnS3oreavFrRMcqdY08tXf/D2leSZAAShbfPJ/
        1iZjx44YEo/6gz/YwmyggG8=
X-Google-Smtp-Source: AG47ELsHtkSHgzlKdnExzlM90quc55nGow1e8kxAVVoi0nFaJFHXn6GR4xNyTyxxFdJB3KD5KsLkpw==
X-Received: by 10.28.17.77 with SMTP id 74mr15562684wmr.67.1520463540543;
        Wed, 07 Mar 2018 14:59:00 -0800 (PST)
Received: from [10.6.133.146] (135.red-80-28-119.staticip.rima-tde.net. [80.28.119.135])
        by smtp.gmail.com with ESMTPSA id 8sm17746231wmf.13.2018.03.07.14.58.59
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 07 Mar 2018 14:59:00 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v10 9/9] convert: add round trip check based on 'core.checkRoundtripEncoding'
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <xmqqzi3jxzus.fsf@gitster-ct.c.googlers.com>
Date:   Wed, 7 Mar 2018 23:58:58 +0100
Cc:     lars.schneider@autodesk.com, git@vger.kernel.org, tboegi@web.de,
        j6t@kdbg.org, sunshine@sunshineco.com, peff@peff.net,
        ramsay@ramsayjones.plus.com, Johannes.Schindelin@gmx.de
Content-Transfer-Encoding: 7bit
Message-Id: <F974DE28-D4EE-4BC6-9AE8-BF5F79FACC86@gmail.com>
References: <20180307173026.30058-1-lars.schneider@autodesk.com> <20180307173026.30058-10-lars.schneider@autodesk.com> <xmqqmuzjzmfi.fsf@gitster-ct.c.googlers.com> <40C38F6A-E536-4C7E-981F-B15746C103B5@gmail.com> <xmqqzi3jxzus.fsf@gitster-ct.c.googlers.com>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 07 Mar 2018, at 23:52, Junio C Hamano <gitster@pobox.com> wrote:
> 
> Lars Schneider <larsxschneider@gmail.com> writes:
> 
>> I don't think HT makes too much sense. However, isspace() is nice
>> and I will use it. Being more permissive on the inputs should hurt.
> 
> You are being incoherent in these three sentences.  If you want to
> be more strict and only allow SP, then isspace() is already too
> broad, as it does allow HT (and even CR and LF).

I meant "Being more permissive on the inputs shouldN'T hurt." :-)


> I do think HT makes just as much sense as SP, though, so if you use
> isspace(), that would be perfectly fine.

OK!

- Lars

