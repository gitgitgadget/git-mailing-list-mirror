Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E530C20986
	for <e@80x24.org>; Thu,  6 Oct 2016 09:36:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965211AbcJFJgA (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Oct 2016 05:36:00 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35448 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965140AbcJFJf7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Oct 2016 05:35:59 -0400
Received: by mail-wm0-f66.google.com with SMTP id f193so2569470wmg.2
        for <git@vger.kernel.org>; Thu, 06 Oct 2016 02:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=BKnMP/QGhl+sgRitcKmx7Reb6SsFsCpFubLUXdbZfWE=;
        b=p6Y+J0jEp3P5bfT0k91NxKU+74aGasn5IuIA1eVkAmfjN+byiv/xUMvEDKBWlx2rpH
         AX5ZvYycNJq5jyAAM1X2azxLOSxWV30hYauYjVxuTROTDMB1PiQ6LEsm2yhLuLT8y8P/
         iOkeBeNUJMOxgDt+k+Cv7/yIRabJr0r0yVfCwTI0XPihfaKdI55/0fjOtnFPwIWXsBf/
         kzZpnZLoEb+s/R26D2iFkl9+nRav+ivvSVDK8epzkPuyPBJW3ZF0wk1Km6IAn2HpaYir
         f9Nz0UOD6MD5kIZ9SaR4LS6/BW5rLXhO6IybaRxbmSnX3UGuSzljmzy2iHLk2hREDket
         y11g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=BKnMP/QGhl+sgRitcKmx7Reb6SsFsCpFubLUXdbZfWE=;
        b=FB2sjdMjtjvBqv3U+jMzU9saZh8+Mvga7w0DFDtGEvct/mtj/g+cYPWa0mIONbZYmx
         tO+uNzOGuBGvwaM4Y18Gce3CVUhn5kZHxscmADLjVnFQraYV8i/h8HvIK49ZfjsZ9Fry
         1ScDapydjQNPHh/FOoRnWG2ZE99F4+j+QpJvmJKZLd16+hu+byW0bhlhbAiuqvj7Abq/
         BADh4YymQ+UYrmNRH8EIc04o0r6RIEYepdWMUzj8IXfesPqJj6JeW6YBJO6a7LLFkniF
         BvphxXIg7nWjh401uC1os5ZTIPINLcpA65Zs2IOnXT77Rio5k5p9ZWeQ5UWHPYVW7SRQ
         L+zg==
X-Gm-Message-State: AA6/9Rk1Cssxn8bwMKq20hWEpXepvDy3NBn0t5RyClkLuUZoO90x4DArE57zfDjU1D8LEQ==
X-Received: by 10.28.189.197 with SMTP id n188mr18934759wmf.80.1475746557639;
        Thu, 06 Oct 2016 02:35:57 -0700 (PDT)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id 4sm34161212wmu.2.2016.10.06.02.35.56
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 06 Oct 2016 02:35:57 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v9 04/14] run-command: add wait_on_exit
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <alpine.DEB.2.20.1610061129430.35196@virtualbox>
Date:   Thu, 6 Oct 2016 11:35:56 +0200
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <6FEA8850-1031-4FCA-8DF2-765B752973DF@gmail.com>
References: <20161004125947.67104-1-larsxschneider@gmail.com> <20161004125947.67104-5-larsxschneider@gmail.com> <xmqqh98rud20.fsf@gitster.mtv.corp.google.com> <1FD7FB64-0F40-47F0-A047-25B91B170E66@gmail.com> <xmqqeg3uo5yt.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1610061129430.35196@virtualbox>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        =?utf-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 06 Oct 2016, at 11:32, Johannes Schindelin =
<johannes.schindelin@gmx.de> wrote:
>=20
> Hi Junio & Lars,
>=20
> On Wed, 5 Oct 2016, Junio C Hamano wrote:
>=20
>> Lars Schneider <larsxschneider@gmail.com> writes:
>>=20
>>> OK. Something like the patch below would work nicely.
>>=20
>> Yeah, something along that line; it would eliminate the need to
>> worry about a field named "stdin" ;-)
>=20
> Not only a need to worry. Git for Windows' SDK's headers define
>=20
> 	#define stdin (&__iob_func()[0])
>=20
> leading to the compile error
>=20
> 	In file included from git-compat-util.h:159:0,
>                 from cache.h:4,
>                 from run-command.c:1:
> 	run-command.c:25:6: error: expected identifier or '(' before '&' =
token
> 	  int stdin;
> 	      ^
>=20
> I meant to investigate this build failure of `pu` earlier but only got
> around to do it today.
>=20
> Ciao,
> Dscho

Sorry for the trouble. The "stdin" will go away in the next round
as we agreed on a more generic solution:
=
http://public-inbox.org/git/1FD7FB64-0F40-47F0-A047-25B91B170E66@gmail.com=
/

- Lars

