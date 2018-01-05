Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2AC0B1F428
	for <e@80x24.org>; Fri,  5 Jan 2018 19:34:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752696AbeAETeD (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Jan 2018 14:34:03 -0500
Received: from mout.web.de ([217.72.192.78]:56019 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752627AbeAETeB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Jan 2018 14:34:01 -0500
Received: from macce.local ([195.198.252.176]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Lrs70-1etvpF2HVu-013b7o; Fri, 05
 Jan 2018 20:33:47 +0100
Subject: Re: [PATCH v3 1/1] convert_to_git(): checksafe becomes int conv_flags
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
        Lars Schneider <lars.schneider@autodesk.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>, patrick@luehne.de
References: <96B6CD4C-0A0C-47F5-922D-B8BAFB832FD1@gmail.com>
 <20180101215959.1460-1-tboegi@web.de>
 <B45F57FC-E798-4C8F-9C40-200944D86029@gmail.com>
From:   =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Message-ID: <08dbcad8-5827-b56b-6586-55592e41003f@web.de>
Date:   Fri, 5 Jan 2018 20:33:46 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:52.0)
 Gecko/20100101 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <B45F57FC-E798-4C8F-9C40-200944D86029@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:o8ft9ur++HZwyGarrBJnaU9ojqP1BATGPCDMttIaVbokihSoXUs
 qSfeqdU4sBaGXLy3NUpVhCj/pYqsPOBpe1STQMmY47FM8o+aUQ0IQQUaDEGLWR2yL0jBUFI
 DqomYOjo/6e8UVaK4CLtiovx9Yusnlz+9POYLSKaJP4qkoPBDct5wHN34n9lKwOlI2yD0FB
 dvo4GDBrM/Xyk/aMCq+1w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:MMJcrxv0cVA=:mxHX+QiQhwBOOs/3lVRus1
 aSF++VUuXU48UY/VU5n0hzy3X3fXm88DIb10dU3FzqjoDfZNCHFdS1te2G8f+Ein3+v+WGR98
 qw7KHhHrLbQsiTT7VDVb2QmUFCmkCKkmFJq//z7XUZau7mxUkzsW7q4Og5vq21nelTIGflAz4
 PUDe+Cijr0sAuCSgzP1Ha8KPPJUVT8led8I8nLOUCTMKkJZ9Wf7oiigCd3pGXvoZqcPlZyWHl
 Y5/tiUJUYWS+NyTUFco0SWmdR/VXDQzE5ALVFTGwHdxw35iCnuCXjwfI+vYkNJ5oNA3pmiuYJ
 AYWiVJ7h60qJWo67/vMl+FsV+U2sT5nmkZq59vCp0psOVVObWUiEMcvXfyvg7vIzdqZakOLY9
 ZYtcqiK7a9b74bObf8x2cxNOnL3T/Z55WtAtvate/cfPNazcOvf5PZ7IS5oRwqGPU+yvadfWz
 S1QVzBhhPZkg55l4xNrka5nIoJOGMeqzGZdwgDhxlg7BDYaVGiIFt96F4PwzHQSV1afqC13Yc
 +gAyu0/3RVoFsqZaMxK5NfgS5lCrN37y8n8++tfWz+rzep/aPXPBX39FhB+QjAYSFa2+ZpbUv
 gKrZOngr5i70x/SoqMjm+L2yfaqIou7H8f7JR1bHc+iYCTT1fKhH9wT6nKmtU9ylqP/fbIdP4
 11o46E3XvnkhGBQMT46pM3xQdUih9N5y987E7vCkxu3NeZuauDrvtJMSJj43X0d0QOUIC90Lm
 4yWzaxDpht25ru6t1yybSXm6Se5F0c5srd2ncrwH1xbMmzozEgurdIKdBTADB5VTLmskjC/CJ
 t+syV+Vza8aK0riz5YW1h/0jo2a8EWnnmIBeh0adlilAVjnN1vPKY0y46/O3nqNEgkSOlbY6r
 4xrJcHN767kGMI/YZB2hM5LK9vUbPQzGvDttc0JgaJkTO/daubYj1/xP9OeXZ/D7g6NKNHLC2
 Y3kKBgUGczw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2018-01-05 20:00, Lars Schneider wrote:
> 
>> On 01 Jan 2018, at 22:59, tboegi@web.de wrote:
>>
>> From: Torsten Bögershausen <tboegi@web.de>
>>
>> When calling convert_to_git(), the checksafe parameter has been used to
>> check if commit would give a non-roundtrip conversion of EOL.
>>
>> When checksafe was introduced, 3 values had been in use:
>> SAFE_CRLF_FALSE: no warning
>> SAFE_CRLF_FAIL:  reject the commit if EOL do not roundtrip
>> SAFE_CRLF_WARN:  warn the user if EOL do not roundtrip
>>
>> Already today the integer value 0 is passed as the parameter checksafe
>> instead of the correct enum value SAFE_CRLF_FALSE.
>>
>> Turn the whole call chain to use an integer with single bits, which
>> can be extended in the next commits:
>> - The global configuration variable safe_crlf is now conv_flags_eol.
>> - The parameter checksafe is renamed into conv_flags.
>>
>> Helped-By: Lars Schneider <larsxschneider@gmail.com>
>> Signed-off-by: Torsten Bögershausen <tboegi@web.de>
>> ---
>> This is my suggestion.
>> (1) The flag bits had been renamed.
>> (2) The (theoretical ?) mix of WARN/FAIL is still there,
>>    I am not sure if this is a real problem.
>>
>> (3) There are 2 reasons that CONV_EOL_RENORMALIZE is set.
>>    Either in a renormalizing merge, or by running
>>    git add --renormalize .
>>    Therefor HASH_RENORMALIZE is not the same as CONV_EOL_RENORMALIZE.
> 
> Can you elaborate a bit? I am diving into the code but I am still confused.
> 
> I also noticed that the "flags" integer is potentially double booked with
> the following values (see read-cache.c:add_to_index()):
> 
> #define ADD_CACHE_VERBOSE 1
> #define ADD_CACHE_PRETEND 2
> #define ADD_CACHE_IGNORE_ERRORS	4
> 
> #define HASH_WRITE_OBJECT 1
> #define HASH_FORMAT_CHECK 2
> #define HASH_RENORMALIZE  4
> 
> Is this intentional? 

All these flags have a different context,
and the right #define must be used in the right context/function call.
So there is no intention.
You start with 1, then use 2 and so on.

The same way as family Schmidt and family Meier both call
their child "Hans".
There is no connection.


> 
> Thanks,
> Lars
> 
> 
> More context:
>   https://public-inbox.org/git/96B6CD4C-0A0C-47F5-922D-B8BAFB832FD1@gmail.com/
>   (3) We kind of replicate some flags defined in cache.h:
>      #define HASH_WRITE_OBJECT 1
>      #define HASH_RENORMALIZE  4
> 
> 

