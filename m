Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D21C1F597
	for <e@80x24.org>; Thu,  2 Aug 2018 12:39:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732222AbeHBO36 (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Aug 2018 10:29:58 -0400
Received: from mout.gmx.net ([212.227.17.20]:51597 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732169AbeHBO36 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Aug 2018 10:29:58 -0400
Received: from [192.168.0.129] ([37.201.193.26]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M7UUd-1g7oAw0goJ-00xIpj; Thu, 02
 Aug 2018 14:38:57 +0200
Date:   Thu, 2 Aug 2018 14:38:56 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Eric Sunshine <sunshine@sunshineco.com>
cc:     git@vger.kernel.org
Subject: Re: [PATCH] color: protect against out-of-bounds array
 access/assignment
In-Reply-To: <20180802093208.27420-1-sunshine@sunshineco.com>
Message-ID: <nycvar.QRO.7.76.6.1808021438460.71@tvgsbejvaqbjf.bet>
References: <20180802093208.27420-1-sunshine@sunshineco.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:Huu0/cUJ+5qGIrAWnEixiEPzYPqS8m48yMqxB+pViuuU/60KUXE
 e7mI7mstNuwCsxpBTR59UBaizZ1h2txQ/4rXpXvWBMyjH+H//mrItmmd+NO7/aM8h6aDrqC
 s7FZ6TXyNEcrfe97zKj2NOJpln9/++y53CYB7qKiaKFqwKrPZg23bPfELo5XGDPem6iXrxb
 TlgMzXkbO89Lo+Z3sv70g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:wQ0CJ+0kClU=:Y3HrMWPzqZxCB72myl7Ktc
 1vNBpm9ZLDyd7e1nzKnYN0RTVm8gj4T1LdAvWwd2ipm7NZOuGqwnBgDN51ehTP1y3YWycutrD
 pnIzpfUSXG6zgNhvQzjypI/OgUvfmA5omODTv806D/O5hteDPbxzcCB3/yI4En6PWwNJB2zod
 YYJFno/PlwW5FuXZYV6v5GuAwOwloDIiFJR09p7A+J5FV78ddkxehXdjd3fbCMsApuFqK277L
 C6QH5/z5sied7WUfBBh29zKtyNZlJXUEjidahbbRIUWV8F0Dyu8lEEf8jJSlK5HRrA2C4h5J+
 PCxKBQ4AGpO2CWJZ+uoALPuRqDWLnup6I9cc3/h5Ksxb8CoTYzTYoNwTeMy31cYIu9IxaGT4I
 qkHmBcEu82krazT1NhO0XF/Qo+EEqEKjc9HhZtgw/vwsb9lG2VOdbFpkl5p9miIQXt0iF8bRw
 RrE7JEZpTF+fplUrC+TDfzz9DdtS/wik2+V/IPXl7jUmutUSmP3ASBX7c8/ilAAF2BYgGKcFe
 ZZOxjv6cCrTdcKeIChawKF5R03gttesYq71Z3iSJ/RfwSL3OTrTr4rgJ2LE+Q/l6SitcDzFyo
 aQrK0kjSmflvsV99IUSswsC6SJN+7geB0licuUk9c65Ar5dyZYk7RUCcuLdSC6DPfzacJUJY4
 NJqukaIgz9ZbuiW4a3KSs4/VTrWIY/g3lzMiMvh//N3tnugSzXiYIfxYgdgq1dWT2NpHVT6x+
 CbuMX/qXUT8UYBWp1uNQEbVE9OLudxXPmID+/lF22mbMy16/gcg4sDdr0BWc7KFfgZyBZYLFL
 sLlylaK
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric,

On Thu, 2 Aug 2018, Eric Sunshine wrote:

> want_color_fd() is designed to work only with standard input, output,
> and error file descriptors, and stores information about each descriptor
> in an array. However, it doesn't verify that the passed-in descriptor
> lives within that set, which, with a buggy caller, could lead to
> access/assignment outside the array bounds.

ACK!

Thanks,
Dscho

> 
> Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
> ---
> 
> Just something I noticed while studying this code in relation to a patch
> review.
> 
>  color.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/color.c b/color.c
> index b1c24c69de..b0be9ce505 100644
> --- a/color.c
> +++ b/color.c
> @@ -343,6 +343,9 @@ int want_color_fd(int fd, int var)
>  
>  	static int want_auto[3] = { -1, -1, -1 };
>  
> +	if (fd < 0 || fd >= ARRAY_SIZE(want_auto))
> +	    BUG("file descriptor out of range: %d", fd);
> +
>  	if (var < 0)
>  		var = git_use_color_default;
>  
> -- 
> 2.18.0.599.g4ce2a8faa4.dirty
> 
> 
