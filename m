Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C819E1F859
	for <e@80x24.org>; Wed, 31 Aug 2016 13:15:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934598AbcHaNPY (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Aug 2016 09:15:24 -0400
Received: from mail-wm0-f46.google.com ([74.125.82.46]:38513 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934453AbcHaNPS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2016 09:15:18 -0400
Received: by mail-wm0-f46.google.com with SMTP id 1so40207628wmz.1
        for <git@vger.kernel.org>; Wed, 31 Aug 2016 06:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=bLPbp4lVTrxtOFUiEvU5VWsiVK0m4HaAUtUweIY/Zkc=;
        b=VjXCAr5ifVjeGAQbsrqh8Cgdwz2+i295Gcln0c6kUIQqkjEiC7dpU8X5owbSP7HLsE
         HqAnz14gltb5yeK8n6rZiONo+AEoh5E97ocNTH7Q3BTdRkL35QZxjmy+vDdWqJXIe2dz
         bg/bVguwDO8ni5y9hLBz4m0FVAzS9dCH1GP+mNW56nzNANcWsAiA/KSTo2NMcuEl1WCD
         cNqMFIMr8j9H4m9Q5PtKH25Jfz+gK5BxO+dNvs0TTvXGNVGO+xE/UpMczAOqEN3zMFwW
         2jpqgVLJi5zoiv/hFUlHmXu1V8IvKUPDAvpuYlOs78QL2GxOsCoZgYbCYhmXEZmvlCps
         jrFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=bLPbp4lVTrxtOFUiEvU5VWsiVK0m4HaAUtUweIY/Zkc=;
        b=XLXebaCZW4AG5hyv4GqT0IHm6nQs1XJET0EbvXzEtvvBQwehqRYNPbUFGBHc7iWUw/
         mfN/xOV+Kcgq5vdUzXoCdm83ZebXD/Gfvls2Swp591cTDONmVYEAXzWPQo6LyR8zw6jY
         XA0KyfFx9G/5N9bY8YR7n83cc1CakR3UVWj1y3ex6pqRdf7pBd9mGl4WsDCBdPFWYfGy
         +2l4Zssf/d/Ymx0hbtwoevbr7tyhFGpWMfKGT4VTFK7z80qcFfV12NE7xqbt4/jW29sj
         vfHz4WsXOnJrukfQ1qYKmkRoObY4F6ZAGdiWLJMG3m/6wiKxP1pXgOJw7hmMYkmbYUJg
         Gg2w==
X-Gm-Message-State: AE9vXwPCyhQiCbxVTJJVg1qQosXNleqvI3usiToxdsGErNAEnzJ7yPK3ErzmXY3n33msiA==
X-Received: by 10.28.232.149 with SMTP id f21mr9898981wmi.51.1472649283736;
        Wed, 31 Aug 2016 06:14:43 -0700 (PDT)
Received: from [192.168.1.26] (dam9.neoplus.adsl.tpnet.pl. [83.23.12.9])
        by smtp.googlemail.com with ESMTPSA id us9sm44501641wjb.43.2016.08.31.06.14.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Aug 2016 06:14:42 -0700 (PDT)
Subject: Re: [PATCH v6 12/13] convert: add filter.<driver>.process option
To:     =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>,
        Junio C Hamano <gitster@pobox.com>
References: <20160825110752.31581-1-larsxschneider@gmail.com>
 <20160825110752.31581-13-larsxschneider@gmail.com>
 <xmqqzinv6wtg.fsf@gitster.mtv.corp.google.com>
 <7A378528-58DE-4C17-9F00-9708947716DD@gmail.com>
 <xmqqbn0a3wy3.fsf@gitster.mtv.corp.google.com>
 <4020D8E2-77D9-46AE-95DC-F644F7C6FDAF@gmail.com>
 <xmqqmvjt3nht.fsf@gitster.mtv.corp.google.com>
 <20160831045713.GA15209@tb-raspi>
Cc:     Lars Schneider <larsxschneider@gmail.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>, Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Martin-Louis Bright <mlbright@gmail.com>
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <f02e2a1d-7e42-2cf8-9b0d-02034e560835@gmail.com>
Date:   Wed, 31 Aug 2016 15:14:38 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20160831045713.GA15209@tb-raspi>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

W dniu 31.08.2016 o 06:57, Torsten Bögershausen pisze:
> On Tue, Aug 30, 2016 at 03:23:10PM -0700, Junio C Hamano wrote:
>> Lars Schneider <larsxschneider@gmail.com> writes:
>>> On 30 Aug 2016, at 20:59, Junio C Hamano <gitster@pobox.com> wrote:

Torsten, could you please in the future remove irrelevant parts of the
cited email you are responding to?  Thanks in advance,

[...]
>>>> I meant it as primarily an example people can learn from when they
>>>> want to write their own.
>>>
>>> I think `t/t0021/rot13-filter.pl` (part of this patch) serves this purpose 
>>> already.
>>
>> I would expect them to peek at contrib/, but do you seriously expect
>> people to comb through t/ directory?
> 
> How about a filter written in C, and placed in ./t/helper/ ?
>
> At least I feel that a filter in C-language could be a starting point
> for others which prefer, depending on the task the filter is going to do,
> to use shell scripts, perl, python or any other high-level language.

People do not look into t/helper/ area, but they do into contrib/.
Git provides examples on how to use its features there (among other
things).  Examples for how use the fast-import feature / protocol
are here, in contrib/fast-import.

I think that C language would be not a good choice, as required
low level wrangling of the protocol would obscure the relevant parts,
... well perhaps except if pkt-line was reused.  High-level language
would be better.  The contrib/fast-import directory includes examples
in shell script, Perl and Python.  The same could be done here
(possibly with more languages).
 
> A test case, where data can not be filtered, would be a minimum.
> As Jakub pointed out, you can use iconv with good and bad data.

The iconv might be good example, but I think it is not a practical
one; are there development environments that do not handle UTF-8?

More practical would be to have for example LFS-ish solution of
storing files as-is in a specified directory.  ROT13 is also good,
if not a very practical example.  Or rezipping all ZIP-compression
based files (ODF, JAR/WAR, DOCX / OOXML, CBZ, EPUB, APK, etc.).

-- 
Jakub Narębski

