Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 83DF6202A5
	for <e@80x24.org>; Thu, 21 Sep 2017 18:50:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751765AbdIUSuF (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Sep 2017 14:50:05 -0400
Received: from mout.web.de ([217.72.192.78]:49785 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751739AbdIUSuE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Sep 2017 14:50:04 -0400
Received: from macce.local ([195.198.252.176]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MBkLb-1e3fVk3l6F-00AkHO; Thu, 21
 Sep 2017 20:49:31 +0200
Subject: Re: [PATCH 1/4] git-compat-util.h: xsize_t() - avoid -Wsign-compare
 warnings
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, GIT Mailing-list <git@vger.kernel.org>
References: <15367a04-754c-f6b8-a89b-2c1ff65dedf5@ramsayjones.plus.com>
From:   =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Message-ID: <75416139-74c5-8a60-22e8-79c53dd062c1@web.de>
Date:   Thu, 21 Sep 2017 20:49:31 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:52.0)
 Gecko/20100101 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <15367a04-754c-f6b8-a89b-2c1ff65dedf5@ramsayjones.plus.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:FBgXjksED/H0UYXq2AGMug71oXcGjV+qfOYbtmFKFCwn5MhuCPj
 lI5pHmQwcfgr0Xi/soFd27JUPza+NmOdWwvlzs5Jt7rfmowbnI1CG2X0A9N/9Y5VNMmydBT
 0B6W8TZK5vaFJG2Oxd1S8xtMrRqHGEfY3ZPIcnUX+5GVc7+Lc9vc23F3+ZYs9air+X9Otyf
 dk+WBvmkIs641/qmimNtA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:+SWhFUOd7ug=:96d77/LVaVgfJfU4v0BGn2
 H2jdsZAFeYiBYZpj905/uaWt02ZZq1icakWBf3jZo2zQGTJdWG1+iyrvFSuzsHIRCLxD3C7x8
 rXmjFPsXcKsBE3TBqYwDo+sxGMuWNCw/tjvwTmmLl0D5Xcjt328IggKHZ4egZHMw7j/mIk5h6
 zQYq1bH4Y/Zm5pob00xu39eVI4ig3nttz0/3JCbjgBYAtCZpd3b8IoEH8p1A0jEyqQ5BRsWD4
 10MDGufdYHfQZUt5T0V8ltZVdBPDrCllfoM3xe0Zat5lTO1FIfMF684N0S4Jev8IOzmV9+ZBJ
 qSawang7wg1bysCD2vxV4Yuu1kM7kDr1To4zbyX2qOhyNEAjCpv9OFeOV5rFCcUrSlxxBgz46
 E3195jbiZ1kimf5jt0wfAQcsgWMlTdCUBLd+FwXRRkB9ak3SwX+1YFyrsPIrIewEEOiDA23q7
 ZkAsYUKIiDGs9en/xYuYjjWCEDfiOWtr/n7cgsKECXjX4RV1TkahDblcKEydT7O/HizWyKfHI
 GxqyPYnN7YLzllfPlwjn5cmVEHFciOk3m3USyU40jOgkuRPbq4S2AjGe7YsWhc1G7i2S9m8co
 czVYla572z3rMXCsXaD9CXa4jcQEFzkwvrXs63QTHOcfHuF93gcEwbliI1WKscM3wLyepqEYb
 V2dp8Rz2RjEgzbil+YMq++wyqhEYfAtp01cPyoh3OAkwdrDFw7pTplNGu4qL0ipE3/8oRyFPT
 +ww6GGWQMM+K0FdUFz9mVKWCeTFsgGoPl+SevXqVFPqnWtzeqpckZsHJavyK9OkF6Ka4b0XhJ
 fgFbv8w1I4/IjxO+hHJQpXqiTCMDdFlYgVTb0I3fC4b7uqAmZs=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2017-09-21 18:46, Ramsay Jones wrote:
> 
> Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
> ---
>  git-compat-util.h | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/git-compat-util.h b/git-compat-util.h
> index 9bc15b036..cedad4d58 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -898,9 +898,11 @@ static inline char *xstrdup_or_null(const char *str)
>  
>  static inline size_t xsize_t(off_t len)
>  {
> -	if (len > (size_t) len)
> +	size_t size = (size_t) len;
> +
> +	if (len != (off_t) size)
>  		die("Cannot handle files this big");
> -	return (size_t)len;
> +	return size;

Hm, can someone help me out ?
Why is the cast not needed ?

>  }
>  
>  __attribute__((format (printf, 3, 4)))
> 

