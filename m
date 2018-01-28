Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,STOX_REPLY_TYPE,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0669B1F404
	for <e@80x24.org>; Sun, 28 Jan 2018 12:14:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751769AbeA1MOv (ORCPT <rfc822;e@80x24.org>);
        Sun, 28 Jan 2018 07:14:51 -0500
Received: from smtp-out-1.talktalk.net ([62.24.135.65]:45468 "EHLO
        smtp-out-1.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751750AbeA1MOu (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Jan 2018 07:14:50 -0500
Received: from PhilipOakley ([92.29.14.162])
        by smtp.talktalk.net with SMTP
        id flrDeslohmITaflrDeBRfD; Sun, 28 Jan 2018 12:14:48 +0000
X-Originating-IP: [92.29.14.162]
X-Spam: 0
X-OAuthority: v=2.2 cv=W/RIbVek c=1 sm=1 tr=0 a=NXc+vVEgz70gitWznrz3ig==:117
 a=NXc+vVEgz70gitWznrz3ig==:17 a=8nJEP1OIZ-IA:10 a=pGLkceISAAAA:8
 a=dIu3SnmMAAAA:8 a=iSf4igj6XQ7CtIJzaM0A:9 a=wPNLvfGTeEIA:10
 a=Ua9G7VpiFza3u12uuhVB:22
Message-ID: <752336D49C8F4FBE9D77E73330CF4C44@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "Christian Couder" <christian.couder@gmail.com>,
        <git@vger.kernel.org>
Cc:     "Junio C Hamano" <gitster@pobox.com>, "Jeff King" <peff@peff.net>,
        "Thomas Rast" <tr@thomasrast.ch>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
        "Christian Couder" <chriscool@tuxfamily.org>,
        "Eric Sunshine" <sunshine@sunshineco.com>
References: <20180128111843.2690-1-chriscool@tuxfamily.org> <20180128111843.2690-3-chriscool@tuxfamily.org>
Subject: Re: [PATCH 3/3] perf/aggregate: sort JSON fields in output
Date:   Sun, 28 Jan 2018 12:14:46 -0000
Organization: OPDS
MIME-Version: 1.0
Content-Type: text/plain;
        format=flowed;
        charset="iso-8859-1";
        reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-Antivirus: AVG (VPS 180127-0, 27/01/2018), Outbound message
X-Antivirus-Status: Clean
X-CMAE-Envelope: MS4wfDv9f4GY8eRr7MoIB/J+8BxoF+PSXJ/jfOpQpD7ccGow6vL4E9Yi2v6O9HqTp4m3nPSpddISbQ5snjZG+oGRrC8RchNShfxNukgNdP1mEwee5L9OHYEa
 aXQlcqZ3VtztnAriodVpz2V+vCfpzw432cCAlja/q1urIOgTvgNAzq2E68jIOGRwTop+KWadn8UrFCzkRhkvBwYJmHYZJqaCsGiHZRfx+ZMz2ApPZos8jba7
 VFlTtjjI6VfYGuAKN12JrTOAflQaZOJ48zbBaJFBML5PKEN8LpdzLyAmHtFu+kF5I2AtYKuMZXjbtrfzoXZGMs7AeO6kz9m7cwKfkxUtdhgMSEnh2X1uK4Gw
 8lR21FQ2i42pyDuQue4gHSN+Z78JIQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Christian Couder" <christian.couder@gmail.com>
> It is much easier to diff the output against a preivous

s/preivous/previous/

> one when the fields are sorted.
> 
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
> t/perf/aggregate.perl | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/t/perf/aggregate.perl b/t/perf/aggregate.perl
> index d616d31ca8..fcc0313e65 100755
> --- a/t/perf/aggregate.perl
> +++ b/t/perf/aggregate.perl
> @@ -253,7 +253,7 @@ sub print_codespeed_results {
>  }
>  }
> 
> - print to_json(\@data, {utf8 => 1, pretty => 1}), "\n";
> + print to_json(\@data, {utf8 => 1, pretty => 1, canonical => 1}), "\n";
> }
> 
> binmode STDOUT, ":utf8" or die "PANIC on binmode: $!";
> -- 
> 2.16.0.rc2.45.g09a1bbd803
>
