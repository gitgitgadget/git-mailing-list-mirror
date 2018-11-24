Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 00F3D1F97E
	for <e@80x24.org>; Sat, 24 Nov 2018 14:50:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbeKYBjE (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Nov 2018 20:39:04 -0500
Received: from mail-wr1-f53.google.com ([209.85.221.53]:33258 "EHLO
        mail-wr1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726576AbeKYBjE (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Nov 2018 20:39:04 -0500
Received: by mail-wr1-f53.google.com with SMTP id c14so9103296wrr.0
        for <git@vger.kernel.org>; Sat, 24 Nov 2018 06:50:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=eGgiAbh2hGSpOF3EDL7VUZj+fY5lgYP/RMtZ5HyQ+ek=;
        b=i5jnZ4E9ZY6bCNL5EfkHTMTEX5xfSNMym+d9/cSn9X+naPG4Fjhhm514H1eGHijAqX
         ZTei0fX9j7L45z6HMQpfX8HlZ2dEmIv2ToPcrRHjNNF5eYBtpkg6blAb9DZzCifK2gpq
         9+yLTiTmGro5Y67x+ewmETELIj1Mnz2l+qI1TPW0LRmFLHdc49zKiatefVSI7uWNSDsP
         HIB7HgIwpao7zOFHS4FtXtekdgfPF0i24ituLc/yWetn9VG5j8RkDviaALRn/S1/Ghi/
         BD3rS4mOUrPvWu2tHiOj+L837+aev4zs/aacr5qh2xMU4UUyu7SsetbLKilykP3P0kEh
         pVkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=eGgiAbh2hGSpOF3EDL7VUZj+fY5lgYP/RMtZ5HyQ+ek=;
        b=WeA+zHGe5JlVEcikq9oNa2LphVUqa1rH8jtCoOaI9CQ2yDCrw4wC/xxQ4kGQ5AJvvF
         4VY86MjY9CEPNLQV/Q1sGYTQ7luqaUAoKq7SBNO6CQCk5c+ur4RIXdFbJ8ZjKY3Ee5eS
         Q/sK6wOBnvD/Wc80QG1YloziuxYgCGcvNbpzwcDl+qsyZwwgDPTKy7lUayHDXtvGc1Bu
         rnRcdAbvdgi3n9HAHzTlHSFAy5Y/mXCgX6pRGDiGVcZGP4BYr1b5fZBvF943njD5JfcO
         p7vG78ZLtIMHIyJgxyDkL8FfgSMCMm0gzykJPdxzzT0xwZkrKm3cCF/l5dGQFA3/KZ0Y
         Q8vQ==
X-Gm-Message-State: AA+aEWaSlNXwbERJ15Vv2pXZEOaRiWdN5sNh1ln8KHvudicI7l/jyHVA
        3JwvCyiTx1ovbHVdM/A=
X-Google-Smtp-Source: AFSGD/WYLbjBguOSk/W0hiknO3QfQuJ8AOwHtnU0Gap/i3u+Sr+spbWsQUhw/okoGUuws5j9wOCW7g==
X-Received: by 2002:adf:c042:: with SMTP id c2mr5715731wrf.158.1543071027477;
        Sat, 24 Nov 2018 06:50:27 -0800 (PST)
Received: from [192.168.25.100] (ip-176-198-174-189.hsi05.unitymediagroup.de. [176.198.174.189])
        by smtp.googlemail.com with ESMTPSA id k73sm16700806wmd.36.2018.11.24.06.50.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 24 Nov 2018 06:50:26 -0800 (PST)
Subject: Re: BUG: CR marker ^M doesn't show up in '-' lines of diffs when the
 ending of the removed line is CR+LF
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     git@vger.kernel.org
References: <1f068f3a-d636-9b9c-f501-51d33412b964@googlemail.com>
 <4dca3f64-4851-6d48-8266-dfe55f597739@kdbg.org>
From:   =?UTF-8?Q?Frank_Sch=c3=a4fer?= <fschaefer.oss@googlemail.com>
Message-ID: <edadf857-2d4b-f058-5e07-286afb312901@googlemail.com>
Date:   Sat, 24 Nov 2018 15:51:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <4dca3f64-4851-6d48-8266-dfe55f597739@kdbg.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: de-DE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 23.11.18 um 22:47 schrieb Johannes Sixt:
> Am 23.11.18 um 19:19 schrieb Frank Schäfer:
>> The CR marker ^M doesn't show up in '-' lines of diffs when the ending
>> of the removed line is CR+LF.
>> It shows up as expected in '-' lines when the ending of the removed line
>> is CR only.
>> It also always shows up as expected in '+' lines.
>
> Is your repository configured to (1) highlight whitespace errors in
> diff output and (2) to leave CRLF alone in text files?
I'm using the default configuration, so whitespace is set to
trailing-space, but cr-at-eol is not set.

>
> If so, then it is just a side-effect of this combination, an illusion,
> so to say: The CR in the CRLF combo is trailing whitespace. The 'git
> diff' marks it by inserting an escape sequence to switch the color
> before ^M and another escape sequence to reset to color after ^M. This
> breaks the CRLF combination apart, so that the pager does not process
> it as a combined CRLF sequence; it displays the lone CR as ^M.
Urghh... so that needs to be fixed.
Why does it work correctly with '+' lines ?

>
> It is easy to achieve the opposite effect, i.e., that ^M is not
> displayed. For example with these lines in .git/info/attributes or
> .gitattributes:
>
> *.cpp
> whitespace=trailing-space,cr-at-eol,indent-with-non-tab,space-before-tab
> *.h
> whitespace=trailing-space,cr-at-eol,indent-with-non-tab,space-before-tab
>
> Note the cr-at-eol. (There may be shorter versions to achieve a
> similar effect.)
With cr-at-eol, ^M indeed doesn't show up anymore in '+' lines with
CR+LF line endings. That's correct/expected.
'-' lines with CR+LF line endings are displayed correctly in this case, too.
However, ^M still shows up in '+' and '-' lines with CR line endings.

Hmm... is CR-only line termination supported at all ?
E.g. 'eol' can be set to 'lf' or 'crlf' but not 'cr'...

Regards,
Frank

>
> -- Hannes
