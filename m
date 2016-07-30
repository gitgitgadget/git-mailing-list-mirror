Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 191C51F858
	for <e@80x24.org>; Sat, 30 Jul 2016 09:32:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750833AbcG3JcZ (ORCPT <rfc822;e@80x24.org>);
	Sat, 30 Jul 2016 05:32:25 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35276 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750744AbcG3JcX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jul 2016 05:32:23 -0400
Received: by mail-wm0-f66.google.com with SMTP id i5so18861199wmg.2
        for <git@vger.kernel.org>; Sat, 30 Jul 2016 02:32:22 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=IZ7jymKwvzhe1IAH/U6ktuV154+tDpVlAu8pVMeI0n0=;
        b=sN3R+RMTkxdprwR/GYz852JDtKLvGafMrgUwhgUEFAtZVW9VwADtD2tLfNzk6hOEA9
         26dGXkVYScypdnZuW9tq1fXoypPaJkEXUdWK2CJWa51lzarh835cKDaRUrNRhw9FQXvP
         XkaKiobsdEZyBluuTssZth31D+HWkQUsklWL9xd4hhY4QpolZNuBhVAmBquGQksTdDjw
         +3F0P1/Ns6EkHi76Y0NMXW+dUCiiHzzatTW9lF/wgXuCFPVg/diEhQH6AN4h/yftTHN1
         xJSeGOo4infxMT8X1mmiauU3vb2URzqwwDPCnO1wn9IqjFVHDHiogpsZOQ5nqp+8YATR
         +FsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=IZ7jymKwvzhe1IAH/U6ktuV154+tDpVlAu8pVMeI0n0=;
        b=YZFjzcs41oihpo8AwSraisbr/ITJNDBuSVG6l1AD8n7Yi+jezzA0S1RKk+0MAtIJhC
         orFp6K9e9vLKJ7k6YWFyI63JSVAJ/0KcS/oza0XPHjMvbOrWk1MGOReJ/2tP7CfT1T+C
         XzO73rfVd2EyMguNSPK+ECCBLoBlvIrY1jJRjZXWHmYp/GF0WIaxpJjHizwN9Cb4g71B
         4HOrNcCTzYnfFD3zi1h6ik75KTOjyUiP+uNNrERIBEhkkYjjnH3nuUGntQbBC3d0S+bn
         lnoSZtC3KEKYyHUseGmGxSo+uBqjGa8hJKp1fnE2AuqtZ9RHDLUh8S246+pGuNe9EcZh
         SkSg==
X-Gm-Message-State: AEkoouskE7+E+mBhW+gEh/SOetJaJD1daDpmCyulkQaGdC3HgBOxSQoin/mNqGkVIc8GIA==
X-Received: by 10.194.240.4 with SMTP id vw4mr46703399wjc.22.1469871141563;
        Sat, 30 Jul 2016 02:32:21 -0700 (PDT)
Received: from [192.168.1.26] (ddi132.neoplus.adsl.tpnet.pl. [83.23.86.132])
        by smtp.googlemail.com with ESMTPSA id u125sm6901425wmg.22.2016.07.30.02.32.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Jul 2016 02:32:20 -0700 (PDT)
Subject: Re: [PATCH v2 5/5] convert: add filter.<driver>.process option
To:	Lars Schneider <larsxschneider@gmail.com>
References: <20160722154900.19477-1-larsxschneider@gmail.com>
 <20160727000605.49982-1-larsxschneider@gmail.com>
 <20160727000605.49982-6-larsxschneider@gmail.com>
 <57994436.4080308@gmail.com> <7F1F1A0E-8FC3-4FBD-81AA-37786DE0EF50@gmail.com>
 <xmqqshusny86.fsf@gitster.mtv.corp.google.com>
 <1a009e19-8830-7dea-2811-d475cf482ea3@gmail.com>
 <2435ACEE-19BE-4995-B929-BCEF658F278E@gmail.com>
Cc:	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	=?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>,
	mlbright@gmail.com,
	Remi Galan Alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Eric Wong <e@80x24.org>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Jeff King <peff@peff.net>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
From:	=?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <8f40f520-2fa5-449a-57b8-e0fed6b92061@gmail.com>
Date:	Sat, 30 Jul 2016 11:32:00 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <2435ACEE-19BE-4995-B929-BCEF658F278E@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

W dniu 2016-07-30 o 01:44, Lars Schneider pisze:
> On 30 Jul 2016, at 01:11, Jakub Narębski <jnareb@gmail.com> wrote:

>> I think the protocol should be either: <size> + <contents>, or
>> <size unknown> + <contents> + <flush>, that is do not use flush
>> packet if size is known upfront -- it would be a second point
>> of truth (SPOT principle).
>
> As I mentioned elsewhere a <flush> packet is always send right now.
> I have no strong opinion if this is good or bad. The implementation
> was a little bit simpler and that's why I did it. I will implement 
> whatever option the majority prefers :-)

Well, if we treat it as a size hint, then it is all right; as you
say it makes for a simpler implementation: read till flush.  Git
should not error out if there is mismatch between specified and
actual size of return from the filter; filter can do whatever
it wants.

I see there is v3 series sent, so I'll move the discussion there.
One thing: we probably would want for the size / size-hint
packet to be extensible, either

  size=<size> [(SPC <key>=<value>)...] "\n"

or

  <size> [(SPC <sth>)...] "\n"

that is, space separated list starting with size / size hint.

Upfront error could be signalled by putting for example "error"
in place of size, e.g.

  error <error description> "\n"

-- 
Jakub Narębski
