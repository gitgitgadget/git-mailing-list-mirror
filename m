Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A19E81F404
	for <e@80x24.org>; Fri,  9 Mar 2018 20:23:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751249AbeCIUXA (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Mar 2018 15:23:00 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:33492 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932320AbeCIUW6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Mar 2018 15:22:58 -0500
Received: by mail-wr0-f196.google.com with SMTP id v18so10161863wrv.0
        for <git@vger.kernel.org>; Fri, 09 Mar 2018 12:22:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Gsd6hE/DPLle20GffgSxKOgCmQnrp7Az/Hw/HzByt4E=;
        b=Gb1tFRq3t1ieKb2ug8wnEfXB0080pxD6KNfKqZyM2Y9I8zHEByNLV6uKUW61EWbF8R
         oaGM/Mb7zpsMX4mIxMQx2Wg5KJO5OxRsHt9MJgYCyyjMjhMJ/+Rkap6FOlCSFfiM6tUS
         rGaOSpqMB/HFyBcRQ/voi/gZYqrxv16ww44VL5qfaNZSoqN3jvFoJSUf3qsoxNN+BqJo
         TH32WvTNzEhuk+zUUpKaTUKpz5PFdmWGv3lnALyUAeWE8+PWz4JYFqOby7PRrNPgIxDr
         YxbibCV3t97QwAJ6HWfgex+7on2ZYHWz6VQ/iSRA/kpQQisna82BU4ye1SUlj0lkmKyD
         gaQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Gsd6hE/DPLle20GffgSxKOgCmQnrp7Az/Hw/HzByt4E=;
        b=ITEAceyYcu3maeQ9Z0Dq8UMaDYwIJsACibKz2z+8w42cmokFbVJz0KApvSoWjMtnHy
         maox9nFZ7ZcymX+W9ECX89uTkY0wYcortt60bkL7Wplf4ZznHyqljaHj5GKdKH358z04
         zz8lw/ZWIFsTlivJNhJIjagZ+reOldg9V2kcvuCE8ZyWfBhys33lT4TMY/99xNPiEPpX
         96TSAVEr+9MPxWpDnvImf0URDsu4YdP6mt6Sdt99pCz47pjzwknYVYpg5lJi43oYf1XW
         I4+HeCZMUEH5C1Akdjj/8bkmceY0lZlqHx55lqGvMU84XXstESbulXHYdTP/NSsqHmuj
         uSUQ==
X-Gm-Message-State: APf1xPAaYzGhUu57nUa6ycpJhmk0bCec1GE9KlLf4nZEethlEJIiVxIq
        ac0qKaEqXUN8h0EknGhfewI=
X-Google-Smtp-Source: AG47ELsHKx8G9nCSFKi3HNZ/eQ9z2WmsQK4nfZUuWO/SwsdKevsZS+/t1Icocx+Bm24Qv/HmhFP3ig==
X-Received: by 10.223.170.219 with SMTP id i27mr27004007wrc.107.1520626976939;
        Fri, 09 Mar 2018 12:22:56 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id h188sm1792103wmf.37.2018.03.09.12.22.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 09 Mar 2018 12:22:56 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Lars Schneider <lars.schneider@autodesk.com>,
        Git List <git@vger.kernel.org>,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkg?= =?utf-8?B?Tmfhu41j?= Duy 
        <pclouds@gmail.com>, Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v11 10/10] convert: add round trip check based on 'core.checkRoundtripEncoding'
References: <20180309173536.62012-1-lars.schneider@autodesk.com>
        <20180309173536.62012-11-lars.schneider@autodesk.com>
        <CAPig+cTH7wmrBwiyBxr=D1g6dTw65ZRfGPX_ok2PYaMoGJk0Dg@mail.gmail.com>
Date:   Fri, 09 Mar 2018 12:22:55 -0800
In-Reply-To: <CAPig+cTH7wmrBwiyBxr=D1g6dTw65ZRfGPX_ok2PYaMoGJk0Dg@mail.gmail.com>
        (Eric Sunshine's message of "Fri, 9 Mar 2018 15:18:08 -0500")
Message-ID: <xmqq1sgt578g.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Fri, Mar 9, 2018 at 12:35 PM,  <lars.schneider@autodesk.com> wrote:
>> [...]
>> Add 'core.checkRoundtripEncoding', which contains a comma separated
>> list of encodings, to define for what encodings Git should check the
>> conversion round trip if they are used in the 'working-tree-encoding'
>> attribute.
>> [...]
>> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
>> ---
>> diff --git a/convert.c b/convert.c
>> @@ -1150,7 +1227,7 @@ static const char *git_path_check_encoding(struct attr_check_item *check)
>>         /* Don't encode to the default encoding */
>> -       if (!strcasecmp(value, default_encoding))
>> +       if (is_encoding_utf8(value) && is_encoding_utf8(default_encoding))
>>                 return NULL;
>
> This change belongs in 6/10, not 10/10, methinks.

It is actually worse than that, no?  When default_encoding is
(somehow) configured not to be UTF-8, e.g. "Shift_JIS", we used to
avoid converting from Shift_JIS to Shift_JIS, but the optimization
no longer happens with this code.

In any case, I think same_encoding() is probably a good thing to use
here at step 6/10, so the point is moot, I guess.
