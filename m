Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7EAE5202F8
	for <e@80x24.org>; Thu,  9 Mar 2017 16:34:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932275AbdCIQdv (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Mar 2017 11:33:51 -0500
Received: from mout.web.de ([212.227.15.3]:64316 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932164AbdCIQdu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Mar 2017 11:33:50 -0500
Received: from [192.168.178.36] ([79.213.126.222]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MWRoI-1ckUYU2JHW-00XaV3; Thu, 09
 Mar 2017 17:33:28 +0100
Subject: Re: [PATCH 2/2] Fix callsites of real_pathdup() that wanted it to die
 on error
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
References: <cover.1488987786.git.johannes.schindelin@gmx.de>
 <0c0abc667d9b8dff299aa61aeb29a7e9e7316b66.1488987786.git.johannes.schindelin@gmx.de>
 <81f1e30b-e0e1-d587-4a4b-4848beffd38c@web.de>
 <20170308183840.GA130604@google.com>
 <xmqq4lz331wb.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1703091221440.3767@virtualbox>
Cc:     Brandon Williams <bmwill@google.com>, git@vger.kernel.org,
        Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <40b64644-f01c-d748-1cc3-8b3046be8a83@web.de>
Date:   Thu, 9 Mar 2017 17:33:15 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1703091221440.3767@virtualbox>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:+qGMrYfISBp9ft1b/XlLxlJNhUXt8H59k8fjTro7aw7cND9GpwX
 37Us1NggO0kMU7L7iG2sKxRGTvRy4Ocjg5v59LytbDw6gSA4Osc6Gtfk1CaTBNNEuRDHnmb
 iIYzz1CyY4z+2ktaZ9vJX6P0VyciTFix05Og8i2lIwYwhS+9wQazAMcF9wh7TrwSaBQtdS2
 xcVT+7gomOStrgy0V4nOA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:KGc2S4GSJtQ=:+gzkMXEv9fHdcVZ+hRf7vg
 ut5NZnhEakMDc70bvTd5ye67mxu27JpG8I27suknD39tN3ItiB2QcaOiruqtuiVMzX7IL2J4N
 Tp8HA0Bde+wN2DpRcrArkTJsIau3AaNM0pDYblinuDAJvqzAX9sMAU7dNNBNHgZcHBiQ7HjU3
 1R87NkbmonKi+0BE+LFYMtPayuGXITHGNnZ8sisVNgWpt55U8cIqPsRAvbVKC8qFFclnj5+BQ
 cDqVWfnXs6lYAOYw5E2922AhH0V8t6IRTR/ddL8YKTpjVoAlSg0kVqeb8I+HllKKh7XpZSqi+
 QLo0iIM7YKNcgU1Eca8HzSHbcY/7cI0Hb+dL2husjzcrQuot6XawVQ1VIolff5aWA+5jhpT02
 wDjg19UIVmFmvWntZs3EadRgUNBQXVBVo2Yr8ySs63644SJGNJmO/ciN37eyaxnVWUAQEyWpi
 CtH2xGkQ4AHsMamVTAZuH/6yyhn74ABy3r5PeSUgefmz/8trUUbFbg2h0CLw3oKlmLh/g2JpU
 Qc0aAtovqXliAdmDfKjEOhAOmQmeB3ZcLIKJBkl9g9K/55HYJ/SZBxxVHGS9WXDkSd18F14bL
 e/tHCvIFtXGDZqrq6K6vT4pXVg8XT/5y6ztN3n4IZzs0eNM+qZ1M4PVpX5cxxYsIoIcygWJ3x
 bO/DstpRX1X9iXXCsIEAY3zkkoHfz4WYtoLsvML4LJE7B5QBpvY41K6i/iw4IDonOMTCTrQgJ
 wZVONDzNIDvFd+dIFPoYodeNXQSqsA5S837MwXEDDXYmuxp0PPU8MEXWh8r1zjg3uW9GMSIZb
 mQcHxDB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 09.03.2017 um 12:24 schrieb Johannes Schindelin:
> While I would have agreed earlier that René's patch looks less intrusive,
> I have to point out that there would not have been any possible regression
> if the original patch had introduced the die_on_error parameter. It would
> have made the contract *obvious*.
>
> The nicer API made the contract unobvious, and that was the reason that
> the bug could hide.

You mean nicer in the sense of more forgiving, right?

The meaning of calls of a function with a die_on_error parameter are 
only obvious if at least the name of that parameter is known.  A 
declaration without it would not suffice:

	char *real_pathdup(const char *, int);

There are two possibilities that can't be distinguished by looking at 
callers alone:

	char *real_pathdup(const char *path, int die_on_error);
	char *real_pathdup(const char *path, int gentle);

An enum can help, so that calls look something like this:

	copy_or_death = real_pathdup(path, DIE_ON_ERROR);
	copy = real_pathdup(path, IGNORE_ERRORS); if (copy) ...

For binary flags we can easily encode that information into the function 
names and thus simplify the API:

	copy_or_death = real_pathdup_or_die(path);
	copy = real_pathdup_gently(path); if (copy) ...

And we can drop the suffix of the variant used overwhelmingly often, but 
as you pointed out that relies on readers knowing that convention.

I'm sure Brandon will balance these concerns nicely in follow-up patches. ;)

René
