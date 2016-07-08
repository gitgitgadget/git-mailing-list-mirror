Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,BODY_URI_ONLY,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D356D2070D
	for <e@80x24.org>; Fri,  8 Jul 2016 17:14:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932185AbcGHROb (ORCPT <rfc822;e@80x24.org>);
	Fri, 8 Jul 2016 13:14:31 -0400
Received: from mout.web.de ([212.227.17.12]:57477 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755307AbcGHROa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jul 2016 13:14:30 -0400
Received: from [192.168.209.22] ([195.252.60.88]) by smtp.web.de (mrweb102)
 with ESMTPSA (Nemesis) id 0Lhvlm-1bgtbY3pfG-00nCFm; Fri, 08 Jul 2016 19:14:15
 +0200
Subject: Re: [PATCH v3 3/3] correct ce_compare_data() in a middle of a merge
To:	Junio C Hamano <gitster@pobox.com>
References: <xmqq37nyb4kp.fsf@gitster.mtv.corp.google.com>
 <1467100876-2803-1-git-send-email-tboegi@web.de>
 <xmqqh9cc55wm.fsf@gitster.mtv.corp.google.com>
 <62eb3d75-126e-427b-8701-d490e80e3501@web.de>
 <xmqq8txlvwip.fsf@gitster.mtv.corp.google.com>
 <574692d1-c8ae-9c2f-6b99-a01545b15051@telia.com>
 <xmqqa8huvmpv.fsf@gitster.mtv.corp.google.com>
 <c36fe487-b8dc-9767-7fae-bee513dac0b2@web.de>
 <xmqqr3b5p9v0.fsf@gitster.mtv.corp.google.com>
 <2cbf12a6-2dca-8180-323b-f79638aa03bd@web.de>
 <xmqqmvlsm6hu.fsf@gitster.mtv.corp.google.com>
Cc:	git@vger.kernel.org, tboegi@web.de
From:	=?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Message-ID: <f78fa94d-abd2-05a2-c411-15e2ffdb7dae@web.de>
Date:	Fri, 8 Jul 2016 19:13:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:45.0) Gecko/20100101
 Icedove/45.1.0
MIME-Version: 1.0
In-Reply-To: <xmqqmvlsm6hu.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:BeAeul/V4r8TGBnPGqd/a+sR43qNJATLd+kIMscnzkpznOuYhvf
 LvmEQaNqrZTvRcANkESOOMZtKPFc+cnnK8WmP7AbQ47itkPD7Pc3+rKmUcND0DGLPHNYav3
 ehKC2LCHWrKNJxJ9gz4+Y/0a5D5JS+gM37uOkeblxWeuwCoKdWzGC18HKHtJqnqGqKPRgkV
 Ii/XD/nKmJ4IDn1P98nGQ==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:V96yYjmk3fA=:0kb/oC16eZAFRsE+p+o/Yw
 3QaJ+dn32iG0SnJcx/LxDte1SbHR0U001nPfb7xnbA/m9N8JNnxT/S9XMkwjlinY+t/xTIKbg
 HlVH784UCJWMDshJ7uP4f8ur3/HrIPAUyP/MtIez0QNrNKTXz49FaB+LXRquC6QQAVPREgtkw
 K2ExEw8kVUJUCX1qMRz7qs84sQNyQUtKM3gV0+p0w77W4T7Ix0R2m03Ig9/LJTcql2rvaUM2C
 0HmVw9K6LhUqlIZG4poqrENU/aX5hCp5s3NGggOAgVGQqStu9sn07x+BTUga3UH3t3ur7ynjV
 oNPP4AXIFE3+xSUghbo7Q2cyRKaud6ZWEG6T743tAb7oCxVIwCxjiLo6fbaUAVWMM02bdyRB6
 Y470C/alD1VQMXtSD1A5g5CzxRqAkDd5fo3d2uoEyRkfm2DqZcIlx9ZliJEe2mN4pf7zg9YDY
 v7+5IC0wkrDvJ3/X/zXD3JFuo2gjoEvFM2BLTpLa8DNj/WwodzyKn2+FoS/F6ePExMtnBP1T3
 ESCmWuUplySNfZqu9rRL0Yr9Louo0EAx2H+Sxi81Nps8ySwxvZZhOoHCVyeAFCx65Bwn0lsri
 Bz5SAnzl/E6prJ/6MAoARswVc0XC1I50UpI6U0TpkdCJ2zZi9AyGBb5hsUh7dZrVS7hBzC5vQ
 5E1Hjff4SRLg2n48ZgKjndVrQuNTmRL8ht3JyCbiRm6zSJH5LJ3zVFzWChLMitUVM4wQjeqW7
 ICuJTEApIh+iIK2RjZO65pUqgXi/ysR2RKNEePsmNk+lCP9DSLzrHy1kQhKEV0wd/VfI1yZSy
 SHsdGQB
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org



On 07/08/2016 06:36 PM, Junio C Hamano wrote:
> Torsten Bögershausen <tboegi@web.de> writes:
>
>>> I dunno.  I really do not like that extra sha1 argument added all
>>> over the callchain by this patch.
>>>
>>> Or did you mean other calls to add_cacheinfo()?
>>
>> I didn't mean too much - the whole call chain touches code where I
>> am not able to comment on details.
>> I'm happy to test other implementations, if someone suggests a
>> path, so to say.
>
> I did a bit of experiment.
>
> When 1/3 alone is applied, and then only changes for t/t6038 from
> 3/3 is picked, (i.e. we do not add the extra "don't look at index,
> check this contents"), your "Merge addition of text=auto eol=CRLF"
> test would fail.
>
> And then with this further on top:
>
> diff --git a/merge-recursive.c b/merge-recursive.c
> index b880ae5..628c8ed 100644
> --- a/merge-recursive.c
> +++ b/merge-recursive.c
> @@ -202,6 +202,9 @@ static int add_cacheinfo(unsigned int mode, const unsigned char *sha1,
>  		const char *path, int stage, int refresh, int options)
>  {
>  	struct cache_entry *ce;
> +
> +	if (!stage)
> +		remove_file_from_cache(path);
>  	ce = make_cache_entry(mode, sha1 ? sha1 : null_sha1, path, stage,
>  			      (refresh ? (CE_MATCH_REFRESH |
>  					  CE_MATCH_IGNORE_MISSING) : 0 ));
>
Thanks :-)
Did that experiment made it to a branch somewhere ?
