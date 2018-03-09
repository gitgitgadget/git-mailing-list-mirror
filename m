Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6429F1F404
	for <e@80x24.org>; Fri,  9 Mar 2018 17:20:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932071AbeCIRUv (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Mar 2018 12:20:51 -0500
Received: from mail-wm0-f41.google.com ([74.125.82.41]:39036 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751227AbeCIRUu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Mar 2018 12:20:50 -0500
Received: by mail-wm0-f41.google.com with SMTP id i3so5162814wmi.4
        for <git@vger.kernel.org>; Fri, 09 Mar 2018 09:20:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=4fzdpLZzBxaJ+LZnmH8shxs1BzOG385q9ad2gbcPhQw=;
        b=i4Ghg0yCGcRgaBCcHKpf5/XntD+pVnNmbkIEykHIiaIKrvjFK1wLujASoXhXk8DgyH
         ceHBknT36G2SwGxkXDRLp3AM3NskSJ65r1MzdIhtdv/UBmuC7GkWaX2NVyRNy9GUFZL1
         mpfXAp62AaoLH89h/C85AUGYEJaa6AX5jj4QzQw0J+3JcdmS6ifUG5NvhGOtDluu1q7H
         G65pC07sLWFOMpCv1pRKfwHXqOUujM9HsZJKLOCfmK3inaIzuOdvcRQkcxZ1k+obUCBX
         4cVUd8T48eXNK811tqVAFAdNFRpCTNVsJ3OC8e4t0H6dJYSg0gTOY2F/3+cKYDIgFdf+
         Qujw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=4fzdpLZzBxaJ+LZnmH8shxs1BzOG385q9ad2gbcPhQw=;
        b=iaXDTeU4XhWErXlAaAYUuwS5g3QiIneVXxL/Fy2A5MDe1jUcmfi1yaAPsCICs6ln7Q
         +f8tOPxxWvokU6qCEwsZouUWk4oaN57OBzXf2Kpwti+2rDdFQV3f4Af8ff3/DT4kQXmJ
         zi9uTTdPSaJcdK47q+BH3oN7se6MgmaIGl/YueziBRN73lB3Px5jBd48R8z3ex5sBrXh
         7M0bX5u/FdY1zrDgjUERCUOPfD7XK7hJb1k9PFSJu9ljtSP6Mbrs4JKFYBN35AzAEh+z
         AKtdKun57mndNJ0KVEKVEA96uKn0cDGtoaCAbctlyWmXJZRGkre8W6GzKY+gliqWDax+
         y1lg==
X-Gm-Message-State: AElRT7EkH2cglBtBT5n/t74Jt0dczHHVgpExzDJeoR7fXE1vul17v4sL
        L26Ve+Jv7D1XowKbWiKkTFY=
X-Google-Smtp-Source: AG47ELudF1jfGoIyCnxmNJr8KbfOQaKuf5EQTF8IFhY9sWer8GMmp708OSQ2Mh11Ubh7IDxOVyESow==
X-Received: by 10.28.228.131 with SMTP id b125mr2501455wmh.153.1520616048906;
        Fri, 09 Mar 2018 09:20:48 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id 7sm2225146wry.18.2018.03.09.09.20.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 09 Mar 2018 09:20:48 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Lars Schneider <lars.schneider@autodesk.com>,
        Git Mailing List <git@vger.kernel.org>,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        Johannes Sixt <j6t@kdbg.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v10 3/9] strbuf: add a case insensitive starts_with()
References: <20180307173026.30058-1-lars.schneider@autodesk.com>
        <20180307173026.30058-4-lars.schneider@autodesk.com>
        <CACsJy8DWMmC9mvz783XQFHUopbVMH00LoqpW-CQunzg0qgiEEA@mail.gmail.com>
        <xmqq4llq88ms.fsf@gitster-ct.c.googlers.com>
        <7920610F-8B51-4E8F-83C6-7B29D0EBF852@gmail.com>
Date:   Fri, 09 Mar 2018 09:20:47 -0800
In-Reply-To: <7920610F-8B51-4E8F-83C6-7B29D0EBF852@gmail.com> (Lars
        Schneider's message of "Fri, 9 Mar 2018 16:54:30 +0100")
Message-ID: <xmqqmuzh6u8g.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Lars Schneider <larsxschneider@gmail.com> writes:

> I think following the boost lib makes most sense. Therefore,
> I would like to go with "istarts_with". OK with you?

I don't care too deeply; if we took starts_with() from there, where
what we now want is defined as istarts_with(), then that sounds like
a good thing to do.

Thanks.
