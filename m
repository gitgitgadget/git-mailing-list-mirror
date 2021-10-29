Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6360BC433FE
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 12:11:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45965610EA
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 12:11:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231436AbhJ2MOF (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Oct 2021 08:14:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230273AbhJ2MOE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Oct 2021 08:14:04 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A547C061570;
        Fri, 29 Oct 2021 05:11:36 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 67-20020a1c1946000000b0030d4c90fa87so7455680wmz.2;
        Fri, 29 Oct 2021 05:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=HSZ/wS+5z4Lb2RWX9+sbi4SMMJLj42BfRV1GKLp+s88=;
        b=RXM00UK4x1arSoiXQiWcwF5KEcIbpdcYKYE2m/sReIg0wpGJxrhg8cnvYlljeYdR8h
         uaF9GVaqoQbqEx5rKh5bggblYxm2fX/pkB0D//SbTne2XyYFw7nSr6gFpP/A27VSc8DM
         QtHTZu1pMsPOA8Avo1G6cB0oTexJWg7u2aemRDbz2HFZtam7wcvk9krCPVdu5ArI+JK+
         D2F48YmpWdZehtLkdDLmTWeWIGFkM4WuqA/4WMAJz+o6wKdh5hY2IcScv0AYFe7F1bvj
         p+x/hYY6lihLjgJhf2Kh4wUsP9ULZrNNj25J5+EbK5IxP8J/yg8UUgeuFIFQR6OeNcv8
         OqEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=HSZ/wS+5z4Lb2RWX9+sbi4SMMJLj42BfRV1GKLp+s88=;
        b=LfMLyPb42Ta6sAnTCc00GU7LsXUOWBmtArrRMc51lCiwtW++Qwk5ioPgHXWT/Q8KJM
         5iqEa404jmsR5kgGxtjYKe9VLPT/yEygCxmbM2lv3XVd3FR+CNevP1lnlRJ7Wg2FY9eh
         aUM7z8xnHisJNzoVzdjaQH0QNfrIFvEGQPDoNzMg0zW/wNUEgGzaO300KuSNm6zL3cJe
         CtH7f3rA8yvxBrDoNmLkwhOHOfm9V/YuBuHjobiyn486P60JxWWUW7PzHKNWbTxQt0M8
         AeQzsh7V387/dfh8nJSwhx9/mmIsf1PvvbLvK/XmNP9VE6qTD3Y71ioWwPaWPP7I+sSm
         phqw==
X-Gm-Message-State: AOAM533lnOMVJZlwtA7suYDAQJDcoGUkupuO3k0ONwsHXK12WytYzO2e
        SMpf5Y9GFaHVvbeLfuy+v2w=
X-Google-Smtp-Source: ABdhPJwkgT1LA3yFqjAEejTlEVyuECkExjZtwXmhenxcw8+y+/CzYhY8eUQv0kN2auAe3zpmR41tbQ==
X-Received: by 2002:a05:600c:da:: with SMTP id u26mr18516328wmm.161.1635509494936;
        Fri, 29 Oct 2021 05:11:34 -0700 (PDT)
Received: from [10.168.10.11] ([170.253.36.171])
        by smtp.gmail.com with ESMTPSA id a134sm5272720wmd.9.2021.10.29.05.11.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Oct 2021 05:11:34 -0700 (PDT)
Message-ID: <865e5899-b991-918d-8bc6-ced65a67a566@gmail.com>
Date:   Fri, 29 Oct 2021 14:11:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: Is getpass(3) really obsolete?
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Libc-alpha <libc-alpha@sourceware.org>,
        linux-man <linux-man@vger.kernel.org>, git@vger.kernel.org,
        "tech@openbsd.org" <tech@openbsd.org>,
        Benoit Lecocq <benoit@openbsd.org>,
        Klemens Nanni <kn@openbsd.org>
References: <a0371f24-d8d3-07d9-83a3-00a4bf22c0f5@gmail.com>
 <73ac38a2-c287-4cc1-4e9c-0f9766ac4c0c@gmail.com>
 <211029.86r1c43uwj.gmgdl@evledraar.gmail.com>
From:   "Alejandro Colomar (man-pages)" <alx.manpages@gmail.com>
In-Reply-To: <211029.86r1c43uwj.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ævar,

On 10/29/21 13:40, Ævar Arnfjörð Bjarmason wrote:
> 
> On Fri, Oct 29 2021, Alejandro Colomar (man-pages) wrote:
> 
>> [Add a few CCs, since I mentioned them.]
> 
> [I'm not sure what the full context of this thread is, but just replying
> from the POV of git@ being CC'd on this]

The first message on this thread was mine from '10/29/21 13:15', so 
you've read it all.

The broader context is that I was trying to make the deprecation notices 
more consistent in the Linux manpages, by using the [[deprecated]] 
attribute where appropriate.  While doing that, I found a few cases 
where the deprecation/obsoletion is not so clear to me, such as this one 
([as]ctime[_r](3) is another one, since it is deprecated by POSIX, but 
not by the C standard, but I'll start a different thread with that; and 
isascii(3) is another one, since the user of it should know if the 
character set he's using is compatible with ascii, and in that case it's 
perfectly valid, it's only a case of garbage in garbage out, IMO).

> 
>> On 10/29/21 13:15, Alejandro Colomar wrote:
>>> Hi,
>>> As the manual pages says, SUSv2 marked it as LEGACY, and POSIX
>>> doesn't have it at all.  The manual page goes further and says "This
>>> function is obsolete. Do not use it." in its first lines.
>>> But, glibc doesn't seem to have deprecated this function at all.
>>> And it seems to be the most portable way to get a password, even if
>>> it's not in POSIX.
>>> BSDs have readpassphrase(3), but glibc doesn't, so unless you
>>> recommend
[...]

Cheers,

Alex

-- 
Alejandro Colomar
Linux man-pages comaintainer; https://www.kernel.org/doc/man-pages/
http://www.alejandro-colomar.es/
