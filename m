Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DC7152027C
	for <e@80x24.org>; Sun, 16 Jul 2017 15:18:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751245AbdGPPSp (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Jul 2017 11:18:45 -0400
Received: from mout.web.de ([212.227.15.3]:55385 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751219AbdGPPSo (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Jul 2017 11:18:44 -0400
Received: from [192.168.178.36] ([79.237.60.227]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0M2dt7-1dp7Td1jGv-00sNKx; Sun, 16
 Jul 2017 17:18:28 +0200
Subject: Re: [PATCH] dir: support platforms that require aligned reads
To:     Jeff King <peff@peff.net>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Duy Nguyen <pclouds@gmail.com>
References: <d3db2984-f238-7166-affa-f1f7df566404@web.de>
 <20170716140409.3ywepgvo5c6ognsy@sigill.intra.peff.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <84b4d5aa-956f-932b-4e95-f181243215bc@web.de>
Date:   Sun, 16 Jul 2017 17:18:27 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20170716140409.3ywepgvo5c6ognsy@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:gHT7qLBguxtvDsbd6BWA1kMZrsl2NgM2fjR11vOC3vKAxViagks
 UOCSQVu7iNEiqmD7NYR955DJrSO7NfK5fS0XG0b/YecdL7ABo8Fc2Ci2UJKiuvn/B3XGTqx
 10sTEf1ydp/N2Hf/gGqkXBeMUQccQPCxVBlzds5sPQa36+ILYj7xVA5wAx7EsTGrpk0eWgL
 UB8w6VS2KO8V5D64zT6yQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:izp1ptIz/Qw=:3rX+FKsjElHDbyPiQqa9iS
 sTQk1/evfnUt4dLPsuOpaCT3Mt0mrPIAxOtyYm2xgn+zenYF9rMpe2n1a3uHx0ylsylYb7yZh
 5zOXUPpakeGI7ovfiJLv4CzbNFw33l1RC6NBrlkm3USyvNPEOUn8jnd6e0RTJtcHGcFbZXZU4
 nPVGVclqKvZot49062EPTMIYfhSVfdzugWR8Ht1ngXTmIylg/2otJlAkJaV70NPFD/wuxQq5m
 s/3amA+sE5wE/1iTHIeZc07SMxn0VzCzgMA+2muh+olvwaP8+FRTrcje2Do+7XeK6sy2zwI/L
 WbsHTCBDFS91fverd0OxhaPFi9ES3mMiLJitSI6xTftG4STzS6h1/YJY0H+M2SwNrRXbz6VcA
 GY66s6ilU1bZlPeO5pqYlra7KNjO0zDjmlboZB/I+ntMw1KbW59Fyeo8WztWbFT0HR6NI5QBF
 o58WqdnE+9rynGnywAuk3lWw/DyKvxxVwHa+1fu8i6C4jQSa1r/iFLfmDV2faUya7CSTqJCft
 MY7fEi4Um5RreqoE/+tp3QZg9YWicnN+y1n+XVfDqVrAiyXkyVHeft65mujjLRfBY4DTks98J
 TOyb2boGnx8LT73j5qzKTf+sqDU83AlpbFoTDglFCtzONN4JDwqi7tr1V+BjnHB/OFRkDCa7T
 OECVW66bII4GmOdEB7R7X8GTpQh/yuqlOIilmWAUh99NGZou9UDVPWkye68SrjAjMmzJpyLlK
 vQQ07JjIVL+wkkFYbCL2mVVFumj77Rl8Sv2rH6h+vuvQJbvXkKIZ0nXg+uAie+MIYfz2s74Tv
 VJ0LT0zSJ513D6/lTYuaYxGuR4IC6kgHmudjqoACxGzPapy/vI=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 16.07.2017 um 16:04 schrieb Jeff King:
> On Sun, Jul 16, 2017 at 02:17:37PM +0200, René Scharfe wrote:
> 
>> -static void stat_data_from_disk(struct stat_data *to, const struct stat_data *from)
>> +static void stat_data_from_disk(struct stat_data *to, const unsigned char *data)
>>   {
>> -	to->sd_ctime.sec  = get_be32(&from->sd_ctime.sec);
>> -	to->sd_ctime.nsec = get_be32(&from->sd_ctime.nsec);
>> -	to->sd_mtime.sec  = get_be32(&from->sd_mtime.sec);
>> -	to->sd_mtime.nsec = get_be32(&from->sd_mtime.nsec);
>> -	to->sd_dev	  = get_be32(&from->sd_dev);
>> -	to->sd_ino	  = get_be32(&from->sd_ino);
>> -	to->sd_uid	  = get_be32(&from->sd_uid);
>> -	to->sd_gid	  = get_be32(&from->sd_gid);
>> -	to->sd_size	  = get_be32(&from->sd_size);
>> +	memcpy(to, data, sizeof(*to));
>> +	to->sd_ctime.sec  = ntohl(to->sd_ctime.sec);
>> +	to->sd_ctime.nsec = ntohl(to->sd_ctime.nsec);
>> +	to->sd_mtime.sec  = ntohl(to->sd_mtime.sec);
>> +	to->sd_mtime.nsec = ntohl(to->sd_mtime.nsec);
>> +	to->sd_dev	  = ntohl(to->sd_dev);
>> +	to->sd_ino	  = ntohl(to->sd_ino);
>> +	to->sd_uid	  = ntohl(to->sd_uid);
>> +	to->sd_gid	  = ntohl(to->sd_gid);
>> +	to->sd_size	  = ntohl(to->sd_size);
>>   }
> 
> Hmm. I would have written this to pull the bytes directly out of the
> array, like:
> 
>    to->sd_ctime.sec  = get_be32(data); data += 4;
>    to->sd_ctime.nsec = get_be32(data); data += 4;
> 
> etc. Or even a helper to do the advancing like:
> 
>    to->sd_ctime.sec = parse_be32(&data);
> 
> That reduces assumptions about padding in "struct stat_data". But
> looking more at this code, and reading your comment:
> 
>> Side note: The OS name is not enough for determining the layout of
>> struct ondisk_untracked_cache.  Different platforms can have different
>> int sizes and padding.  Adding the machine type could help, but that
>> would be a breaking change.  At that point we would be better off
>> defining a machine-independent format, no?
> 
> it looks like assumptions about struct layout are pervasive and part of
> the on-disk format. Yuck. :(

Assuming that there is no padding probably even works for the platforms
the code currently supports (basically x86), but I don't know about
others.  We'd need to change the writing side as well to match, though.
Which is probably a good idea, but I tried to keep the patch small and
its impact low.  Cross-machine usability is currently explicitly not
supported -- not sure why, though.

René
