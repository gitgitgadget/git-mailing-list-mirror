Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9CD8C211B3
	for <e@80x24.org>; Thu,  6 Dec 2018 18:41:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726030AbeLFSlX (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Dec 2018 13:41:23 -0500
Received: from mail-wm1-f46.google.com ([209.85.128.46]:54628 "EHLO
        mail-wm1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725908AbeLFSlX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Dec 2018 13:41:23 -0500
Received: by mail-wm1-f46.google.com with SMTP id z18so1999772wmc.4
        for <git@vger.kernel.org>; Thu, 06 Dec 2018 10:41:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=TNzm+i7PuQsBCAQdyznP3ULv53Uz6UErCpOZIOGkjro=;
        b=rBs+1cybqPqTQuDEf0TWfk7VCYbPqpa49a+pQom/HJVZapDJV3z7/s5Mydt5ARXZSB
         OnnTgkNWhhbmnb2FGiHuSyYff5p7Qe5xR3ryis6AxmJPF3ne9qE9lB+/QVKh75BetMfT
         UZJloffwIh9vTnamUzlYF3RgsfH3Ajj+FXRKY8VpxUIz2w1ym3R2tCqbTQsWBH9PeOnX
         XOwT9U8hL2jZgFbxKbUKwRFSan1xdmT6aZatJvwmtqge+E5h/ZjZpGtY48KDjnaPzTpf
         Z+GRDeNLNmb0FsVEPGEtQPQClR9YhYaQUgeC6tnT39HG9c+Dnz7pei5o5u4zRnor0Mf6
         vF1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=TNzm+i7PuQsBCAQdyznP3ULv53Uz6UErCpOZIOGkjro=;
        b=EdM78tOB6yxQlEQ03PcF6Jh5sDEf5Oke6tYFQrjFxVfZdF6p1NnadZP6HzLe5X4YGG
         149aJCNU06tFifzGddsCIxzdbQN86+uOqATfyvPM7J9raIecdqIqNOW2YrIMXMd9NiC+
         6hTPNOyq6hKSazE3ENvzmJlY6OQvsUnKwwZYVs8AEt4cIyBGqTvFUGNl+ai9Bdjo1CYL
         K37v2BbiMmGqjgZTPTdHFvwqTkk2vS7egWfIdeClUaeOW8mKa3EPvGcfq067+y1Yh6ZS
         p4K7xvircjyPwP6zo2YMwGHmzc+Bk/ZFVKsLUiZgZ9u5I0gNrABwyx1+kLGRkkbIm4GG
         TXJg==
X-Gm-Message-State: AA+aEWZennI1l/3mtdMTGr+QXbITbeF+2687Db4asuaf5mmTd1nuCxPI
        QKggMBQ1TQGUn9igDw4=
X-Google-Smtp-Source: AFSGD/WVqNcpw+iHsGf2ktA+prsN23F/0mvqo+pcLnq/Mc6+TMxZ8cuj+9xRbhIM4potZ9Tci5vwAQ==
X-Received: by 2002:a1c:99ce:: with SMTP id b197mr15388127wme.75.1544121680525;
        Thu, 06 Dec 2018 10:41:20 -0800 (PST)
Received: from [192.168.25.100] (ip-178-203-230-40.hsi10.unitymediagroup.de. [178.203.230.40])
        by smtp.googlemail.com with ESMTPSA id f192sm2468226wmd.12.2018.12.06.10.41.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Dec 2018 10:41:19 -0800 (PST)
Subject: Re: BUG: CR marker ^M doesn't show up in '-' lines of diffs when the
 ending of the removed line is CR+LF
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Sixt <j6t@kdbg.org>,
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
 <xmqqmupnh0lo.fsf@gitster-ct.c.googlers.com>
 <7796f0ac-d3db-68f9-89fa-9262d2187f57@googlemail.com>
 <xmqq1s6vbhdr.fsf@gitster-ct.c.googlers.com>
From:   =?UTF-8?Q?Frank_Sch=c3=a4fer?= <fschaefer.oss@googlemail.com>
Message-ID: <d04ff31e-c8e9-23fe-6ed1-597e32c1f4ab@googlemail.com>
Date:   Thu, 6 Dec 2018 19:42:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <xmqq1s6vbhdr.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: de-DE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Am 06.12.18 um 01:58 schrieb Junio C Hamano:
> Frank Schäfer <fschaefer.oss@googlemail.com> writes:
>
>> Just to be sure that I'm not missing anything here:
>> What's your definition of "LF in repository, CRLF in working tree" in
>> terms of config parameters ?
> :::Documentation/config/core.txt:::
>
> core.autocrlf::
> 	Setting this variable to "true" is the same as setting
> 	the `text` attribute to "auto" on all files and core.eol to "crlf".
> 	Set to true if you want to have `CRLF` line endings in your
> 	working directory and the repository has LF line endings.
> 	This variable can be set to 'input',
> 	in which case no output conversion is performed.
Argh... crap. I was missing that I have to set the "text" attribute
manually...
Thats why core.eol=crlf didn't make a difference in my tests. :/

Let me thoroughly re-validate all cases.
I will likely not find the time for that before Monday, but I think that
break could be helpful. ;)

Regards,
Frank

