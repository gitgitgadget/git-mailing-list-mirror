Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8BAD81F404
	for <e@80x24.org>; Tue, 30 Jan 2018 21:57:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752490AbeA3V5B (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Jan 2018 16:57:01 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36183 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751826AbeA3V5A (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jan 2018 16:57:00 -0500
Received: by mail-wm0-f66.google.com with SMTP id f3so4128468wmc.1
        for <git@vger.kernel.org>; Tue, 30 Jan 2018 13:57:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=oeRpQgaXhRNBrFzVU0KOrq4hTHsECPeCwF6io2lJSh0=;
        b=Yi8uD3OwVCHdb3Ks49qmPLAJzabKlIna4gCj4ezW/5mLc+1E48azch5EhqzMDPfGi+
         C4jWf/XgscAxDruzFuuRvdH+ET97o7CugrOzx5T/Sbkng7IYv9x+ms6Ayassg/uSgMRA
         GmtiPCIOHdDv//GUvn54oFgqCZ1pKn48lsAQ7/lveSF+cGk40fV+AXXFM8/CBsUCP5ao
         3IISKvOsEZPfOt0AJ10T1qoonXBqyUcmmXNTuy5jVoL7sWv1WU4MDGVP0N4pg2KqOCPv
         tAz0BJ0Zp/AcY+d2WxYs01RrnNKYLsr6dwYHMK/3TtLPAdSbS6tN8s8o29vtBgb9uCWo
         hoFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=oeRpQgaXhRNBrFzVU0KOrq4hTHsECPeCwF6io2lJSh0=;
        b=tCMNpJLU0BfEIuwLEP9PHUWPVfhJpqDbt62sM2ePcfguMAhzibuTqi8gHOzBYs3wz7
         0LSq1WfjRr+8iWiS5W2BV2kLkGy4nuu18fCkFu9QIo286615OQsCJukWWGiso3EQuXld
         rnWap2/BFRMNbynSDARd/GipG080v9XbWWVNadDYLSZyuVWlvvyTZHk5M9CItWPF9McD
         EdyLFqmufsITyVl32T0yqBhZtIheahaqUmS1xFuS5iesrG2ieQowUrO/uE0HWlk6BmYP
         CrLOMfjjchiof23B5p66K5qwtQ4fVQasrwTHvi9r0Qq6a7dtra1DygNAbFB2xVj3plJp
         6ohg==
X-Gm-Message-State: AKwxytfO/nFNVdzd2DKMc3SjF6xF4I7SBUXKQqI2wzD/ZM8TrlJ9pm8E
        rCOWL91acowgjsp829N7Mp8=
X-Google-Smtp-Source: AH8x225c6Jj006wajk+/fZMa10yJpoSP/menJDwoTAz4g/Tcq4/XHHgKcppFupDQL57n1OJG1+b4Tg==
X-Received: by 10.28.147.66 with SMTP id v63mr20538997wmd.118.1517349419343;
        Tue, 30 Jan 2018 13:56:59 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 186sm17510074wmu.16.2018.01.30.13.56.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 30 Jan 2018 13:56:58 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        Git List <git@vger.kernel.org>, Johannes Sixt <j6t@kdbg.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes.Schindelin@gmx.de
Subject: Re: [PATCH v5 5/7] convert: add 'working-tree-encoding' attribute
References: <xmqqshawfgaa.fsf@gitster.mtv.corp.google.com>
        <20180129201908.9398-1-tboegi@web.de>
        <xmqqzi4vt8n1.fsf@gitster-ct.c.googlers.com>
        <396FBDFA-606F-41D9-988C-D6886089BC15@gmail.com>
Date:   Tue, 30 Jan 2018 13:56:57 -0800
In-Reply-To: <396FBDFA-606F-41D9-988C-D6886089BC15@gmail.com> (Lars
        Schneider's message of "Tue, 30 Jan 2018 21:31:58 +0100")
Message-ID: <xmqqfu6nrowm.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Lars Schneider <larsxschneider@gmail.com> writes:

>> On 30 Jan 2018, at 21:05, Junio C Hamano <gitster@pobox.com> wrote:
>> 
>> tboegi@web.de writes:
>> 
>>> +	if ((conv_flags & CONV_WRITE_OBJECT) && !strcmp(enc->name, "SHIFT-JIS")) {
>>> +		char *re_src;
>>> +		int re_src_len;
>> 
>> I think it is a bad idea to 
>> 
>> (1) not check without CONV_WRITE_OBJECT here.
>
> The idea is to perform the roundtrip check *only* if we 
> actually write to Git. In all other cases we don't care
> if the encoding roundtrips.
>
> "git checkout" is such a case where we don't care as 
> noted by Peff here:
> https://public-inbox.org/git/20171215095838.GA3567@sigill.intra.peff.net/
>
> Do you agree?

I am not sure why this is special cased and other codepaths have "if
WRITE_OBJECT then die, otherwise error" checks, so no, I do not
agree with your reasoning, at least not yet.

