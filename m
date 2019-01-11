Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 08477211B4
	for <e@80x24.org>; Fri, 11 Jan 2019 17:37:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731396AbfAKRhX (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Jan 2019 12:37:23 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37324 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbfAKRhW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Jan 2019 12:37:22 -0500
Received: by mail-wm1-f66.google.com with SMTP id g67so3158269wmd.2
        for <git@vger.kernel.org>; Fri, 11 Jan 2019 09:37:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=xoovvAtpQ2Gth/+nbit1Cc2VNDdJcZywJLzVS7V6kLY=;
        b=KzBG4GVGPRsrgy1OH1Z20+lbHqU0Ebkp4vvkpg8wZv56OlW9GvaN/oBvJBNBPOSqif
         3162XOlQ3nkKLu2HhbwhdDs2bTulcUHsmSUlYYrdRIBPzkJjuE8deXLsnJjfpqTzJBH4
         rIJOXZvvAOBbcrqNRWLoztKzRVy5szK/jOqWKxAYh5NBasBF41GtYrXhwySghnUB0deJ
         Va9aDSUgYBoR9pKVltLqKK+R571T2+egj0XeBya9auhKnIMnFRiUAUDKIjE3sX5RuisX
         ETp1Fov2JzOS/oFRTW8Sz2Tm30mDgMz4foAQTxJs50wWRoFeXFLpcoiOX5KKnaxblFe7
         8iJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=xoovvAtpQ2Gth/+nbit1Cc2VNDdJcZywJLzVS7V6kLY=;
        b=HdgCXAI5TlzgHRjwZoZEGE2UkKZVXLXRRs65/3ouw2lyHicPaX9FJCHprLB87yPADu
         9fEDeHHQX80p4CRj1yDF6E6Ft7/FXA5nldEUCa2i6sru1gzPVdZPRi3nbjKlSrLV6DMk
         NRWiUDEPACm0rNKJqrhBN1xMnKyOlqVw1utaliDjosM1302F386OzsXA5bEoRuVmGTmF
         kpns+v6XOlBTJXofdChIzaUx3wGiazfPCKFOXqqn/MiZXChNuPSPkCHXyiUdKznqo6MD
         BFHlitZimGmBp2xbNc9fU4C0Xt8Jt7IRnU/AZaWiiAefScYb2ZgXc4uH1AfWsNcT1qs7
         YKng==
X-Gm-Message-State: AJcUukcVrSS0+4ZgTD6f7vWWyrWd1NosK1b77dL60sWyp3aATAPDPJdx
        rBLjUjfNakboXTuOYguH++jkfPT1
X-Google-Smtp-Source: ALg8bN51jlqrMI+WsLUXQhdmsvnlbKqicuyUQD3WgHocXNk9BchI7jcVlX2bozQFsNaT0ooDlcWSlw==
X-Received: by 2002:a1c:20cb:: with SMTP id g194mr3054597wmg.77.1547228240775;
        Fri, 11 Jan 2019 09:37:20 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id s66sm16242396wmf.34.2019.01.11.09.37.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 11 Jan 2019 09:37:19 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Issac Trotts <issac.trotts@gmail.com>
Cc:     git@vger.kernel.org, Noemi Mercado <noemi@sourcegraph.com>,
        Issac Trotts <issactrotts@google.com>
Subject: Re: [PATCH] log: add %S option (like --source) to log --format
References: <20190108132048.57142-1-issactrotts@google.com>
        <xmqqmuoa4wp7.fsf@gitster-ct.c.googlers.com>
        <CANdyxMzDevigyMTCixjV7bfa-UZ1vknwxt0X=RGc6LZz7F4UXQ@mail.gmail.com>
Date:   Fri, 11 Jan 2019 09:37:19 -0800
In-Reply-To: <CANdyxMzDevigyMTCixjV7bfa-UZ1vknwxt0X=RGc6LZz7F4UXQ@mail.gmail.com>
        (Issac Trotts's message of "Thu, 10 Jan 2019 22:28:41 -0800")
Message-ID: <xmqqh8efyu28.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Issac Trotts <issac.trotts@gmail.com> writes:

> On Tue, Jan 8, 2019 at 2:21 PM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> issac.trotts@gmail.com writes:
>>
>> > From: Issac Trotts <issac.trotts@gmail.com>
>>
>> Heh, I'll edit this line to match S-o-b: below.
>
> Thanks. Otherwise I have to set up git send-email again on my work laptop.

This in-body From: line is either (1) something you would write
yourself in your MUA, in which case you can just write your Google
address, or (2) the author identity a tool picks up and insert at
the body of the message for you, in which case you would make sure
that the commit is made under your Google identity (e.g. "commit
--amend --author=...").  Either case, I am not sure where the need
for send-email comes from.

