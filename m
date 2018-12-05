Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 991B7211B3
	for <e@80x24.org>; Wed,  5 Dec 2018 19:28:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728209AbeLET2T (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Dec 2018 14:28:19 -0500
Received: from mail-wm1-f45.google.com ([209.85.128.45]:53285 "EHLO
        mail-wm1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727349AbeLET2T (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Dec 2018 14:28:19 -0500
Received: by mail-wm1-f45.google.com with SMTP id y1so14399441wmi.3
        for <git@vger.kernel.org>; Wed, 05 Dec 2018 11:28:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=5TAJCf5Lir/Sc+l7coDITrAkrNLqPcfrfUCooPv53Rc=;
        b=rVKSj5wTTyUl9gzhCasDi2MPaWEgRsom97DgRVc6A3SFMnwii1HjP/1KOjqiCBr+pU
         NvSKcw+J1DfA0+C7kC3liaSdiS21ggvIRFzM6URraV5tRMt0bxiMSf9/PKsc8J882krj
         c5lwAiUE26seu9ho5yjCuGMcGjK8SMStYRY2TnZyKmnhbNWtlWwGUOeclqEjVW8SFzyI
         gVVkb+llMS4mFAV3zv/xGns5QVQY4eQdj7FiEM0KTOh+nZSa9b+KI93EK+AoQbew7YbW
         sDLBaKtZfFsmsHkQfF2zo4lLUXHk4Pgco9r2pNIhvYA7GdZGYCEbBIrvL8qCPrIMD6iT
         z9YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=5TAJCf5Lir/Sc+l7coDITrAkrNLqPcfrfUCooPv53Rc=;
        b=oGH/wOQSZ1wyJ1egsj8m1bS71EqsIx6aQv47jPoK0lYBN/SkIATEiWjvZs+g3uf3eD
         qBKsx9fcTCFo7ZiKjCK1HlSkmfO2hDobJqgou0tQtRc0dhLrUKp3XSlnW7cjm3EXbXMX
         M80rbMSmoH7apXX9AWrJMCtpdwCF6SU6q5+TPJsrNLDFtP7JUvsbQgf4fTOVQU7JyxYR
         u8NJS7JZKP4Xv+Z/ZSeluRGRWpgtSUOQT4C0+hk1DDnoq2l/6geDmoMQDl1G7wugQFyB
         nt5MfLFRrRsN2nJAUcwqi8qU9N0mVaZJllxsYN3n5MPs8DTYTAUu8sH2i/f9/v2uTTRZ
         9zbg==
X-Gm-Message-State: AA+aEWZ3/s8ZiRGjXYUoi17QLLct67sSSc+/N4d2u7yUfgtrxe91a5Zo
        Jhp9S1Dp9LVzLnC+tuQ=
X-Google-Smtp-Source: AFSGD/X8qM9XHXzps+I3uVf9jCghuuh2s7Vv31AGxcMK1NYDftMUTtVKYdFSOcSLhO5qk041zPTGpg==
X-Received: by 2002:a1c:888d:: with SMTP id k135mr17735504wmd.137.1544038097120;
        Wed, 05 Dec 2018 11:28:17 -0800 (PST)
Received: from [192.168.25.100] (ip-176-199-47-168.hsi06.unitymediagroup.de. [176.199.47.168])
        by smtp.googlemail.com with ESMTPSA id c129sm11216065wma.48.2018.12.05.11.28.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Dec 2018 11:28:16 -0800 (PST)
Subject: Re: BUG: CR marker ^M doesn't show up in '-' lines of diffs when the
 ending of the removed line is CR+LF
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
References: <1f068f3a-d636-9b9c-f501-51d33412b964@googlemail.com>
 <4dca3f64-4851-6d48-8266-dfe55f597739@kdbg.org>
 <edadf857-2d4b-f058-5e07-286afb312901@googlemail.com>
 <80ffe850-b966-a37b-09bd-44e04d769944@kdbg.org>
 <2858f03b-89a7-be52-501f-55b6d281bebc@googlemail.com>
 <30442f9c-a1cb-4635-d8e3-a301d94a56fd@kdbg.org>
 <xmqqzhtwzghr.fsf@gitster-ct.c.googlers.com>
 <f06b734a-fc8e-221a-c983-f2ab9daba17f@kdbg.org>
 <xmqqva4jv2kc.fsf@gitster-ct.c.googlers.com>
 <3e24a770-47fc-50e4-d757-1e4a28dcd019@kdbg.org>
 <xmqqk1kwr5tp.fsf@gitster-ct.c.googlers.com>
 <7a4ecc75-2dc4-041b-3d12-46cddae0a27f@googlemail.com>
 <3572b619-0603-d16d-392c-4cc8e0bc4614@kdbg.org>
From:   =?UTF-8?Q?Frank_Sch=c3=a4fer?= <fschaefer.oss@googlemail.com>
Message-ID: <de3bd8e1-cdd7-5fcf-0912-a216cc8cb3e9@googlemail.com>
Date:   Wed, 5 Dec 2018 20:29:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <3572b619-0603-d16d-392c-4cc8e0bc4614@kdbg.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: de-DE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Am 02.12.18 um 22:22 schrieb Johannes Sixt:
> Am 02.12.18 um 20:31 schrieb Frank Schäfer:
>> With other words:
>> "If CR comes immediately before a LF, do the following with *all* lines:
>> <RESET> after the CR if eol=lf but do not <RESET> after the CR if
>> eol=crlf."
>
> Why? It is the pager's duty to highlight CR, IMO. If it doesn't, but
> the user wants to see them, then they are using the wrong pager or the
> wrong pager settings.
AFAIU Junios explanation it's not the pagers fault.

>
> As far as I am concerned, I do not have any of my files marked as
> eol=crlf, but I do *not* want to see ^M in the pager. I.e., having git
> insert <RESET> between CR and LF would do the wrong thing for me.
>
But doing the same thing in added lines is doing the right thing for you ?
Or are you suggesting to fix the behavior of added lines instead ?
In any case, inconsistent behavior is not what we want.

Regards,
Frank

