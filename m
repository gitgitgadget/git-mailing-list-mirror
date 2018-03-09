Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7515C1F404
	for <e@80x24.org>; Fri,  9 Mar 2018 20:27:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751298AbeCIU1b (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Mar 2018 15:27:31 -0500
Received: from mail-qt0-f194.google.com ([209.85.216.194]:39370 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751192AbeCIU1a (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Mar 2018 15:27:30 -0500
Received: by mail-qt0-f194.google.com with SMTP id n9so12363479qtk.6
        for <git@vger.kernel.org>; Fri, 09 Mar 2018 12:27:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=2pZ9bLb1HryAvd0qM5/iAtRgYsHe39w/KAyM/hVlsuE=;
        b=B1vjXpJiuwWm5vvIEpbrjwtnuPOj/Xu9QeMEv2SquHHXRWfiFnC7QTmIQ5bo8fDdje
         wQCqQwb1hV7WPjfeVckKSGC17B1b8smZPlMNvU5n5W5BhvI6lkDAvIboLJVQWV/7xobh
         OKqiI61LYwIfJyZUcaZJJp7HSpSuFnLbYQpY927CjQZRKZKXmBVSWh5lT7GgmQ654ZVl
         hCUIV8H7I8zl4+L7/k9Xo88hrqktbH9N5UanvtvHTm/HDuJrvs5XJyJUVonEgUnqlj0y
         CicpZhO36luVblW/CUbAMNsq7QI++MxzLuPgXsUcCEPIVmjq3ew1l5M+XifFfpnezayj
         yNYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=2pZ9bLb1HryAvd0qM5/iAtRgYsHe39w/KAyM/hVlsuE=;
        b=k7KsgJEhG3EZFIBe2SN8/AmDiiBbjWHSu0jnPOKjpKta0RAcmTKBTGNx7KnCSE4qYF
         XcDOYCiR+FUrPo86M8vl+Xo+peOXmfhjJVDnJ4ZXkg0SuFmBE3rMEmuBlx44gMiAdfv2
         4CHJiWzXshfHIERMCPrvn5PLSgNxH+07AEnCZpHU9/E7/FqAXjPMunvJ3eu0nLfH+bMn
         p0jIpORYAmtC0z26LLaaqjxjgTDx8dvLa6HU9GjTU3pSgiJI90bmMNEKooNyo4owe6uF
         xeIN2WZrZawRZzwcBpNLc8SJE0fDnH6ObmdDXeQZVtyv1KdQXwvZHSVDVsEz2ipV/Lhf
         53xQ==
X-Gm-Message-State: AElRT7FiWt5Mykh/qx1ZfWgVLVZr6dBri020/5z1cD+FYaySYHsWs2/u
        uj4fzzHFxmnI95eYo82/fRaNLXCqHQobZG93MTM=
X-Google-Smtp-Source: AG47ELvkvYOvbJgEpBrXMWm9mL39jcGU2R/EtA4dqLRHrOvTipT/pYPuI/Bq2DfNLPlqZEEr7Qi0nbr3/qn8Rfd9DjQ=
X-Received: by 10.55.88.7 with SMTP id m7mr47757414qkb.133.1520627249690; Fri,
 09 Mar 2018 12:27:29 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.142.14 with HTTP; Fri, 9 Mar 2018 12:27:29 -0800 (PST)
In-Reply-To: <xmqq1sgt578g.fsf@gitster-ct.c.googlers.com>
References: <20180309173536.62012-1-lars.schneider@autodesk.com>
 <20180309173536.62012-11-lars.schneider@autodesk.com> <CAPig+cTH7wmrBwiyBxr=D1g6dTw65ZRfGPX_ok2PYaMoGJk0Dg@mail.gmail.com>
 <xmqq1sgt578g.fsf@gitster-ct.c.googlers.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 9 Mar 2018 15:27:29 -0500
X-Google-Sender-Auth: uju6To3fToO3Cf2OKsEhx81WomI
Message-ID: <CAPig+cQwv_Nmy2P_7xQgzMSMdTUmgp455Tx=jZkj9=VzjJ1XZw@mail.gmail.com>
Subject: Re: [PATCH v11 10/10] convert: add round trip check based on 'core.checkRoundtripEncoding'
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Lars Schneider <lars.schneider@autodesk.com>,
        Git List <git@vger.kernel.org>,
        =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Lars Schneider <larsxschneider@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 9, 2018 at 3:22 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
>> On Fri, Mar 9, 2018 at 12:35 PM,  <lars.schneider@autodesk.com> wrote:
>>>         /* Don't encode to the default encoding */
>>> -       if (!strcasecmp(value, default_encoding))
>>> +       if (is_encoding_utf8(value) && is_encoding_utf8(default_encoding))
>>>                 return NULL;
>>
>> This change belongs in 6/10, not 10/10, methinks.
>
> It is actually worse than that, no?  When default_encoding is
> (somehow) configured not to be UTF-8, e.g. "Shift_JIS", we used to
> avoid converting from Shift_JIS to Shift_JIS, but the optimization
> no longer happens with this code.
>
> In any case, I think same_encoding() is probably a good thing to use
> here at step 6/10, so the point is moot, I guess.

Agreed, same_encoding() would be superior.
