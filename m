Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5DE931FD4F
	for <e@80x24.org>; Thu, 31 May 2018 12:07:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754226AbeEaMHo (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 May 2018 08:07:44 -0400
Received: from mout.gmx.net ([212.227.17.22]:43437 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751955AbeEaMHn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 May 2018 08:07:43 -0400
Received: from [192.168.0.129] ([37.201.195.106]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M9bYB-1fT0PC2ZJP-00Cw9i; Thu, 31
 May 2018 14:07:41 +0200
Date:   Thu, 31 May 2018 14:07:42 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Stefan Beller <sbeller@google.com>
cc:     git@vger.kernel.org
Subject: Re: [PATCH 3/3] submodule--helper: plug mem leak in
 print_default_remote
In-Reply-To: <20180530170302.191176-3-sbeller@google.com>
Message-ID: <nycvar.QRO.7.76.6.1805311407140.82@tvgsbejvaqbjf.bet>
References: <20180530170302.191176-1-sbeller@google.com> <20180530170302.191176-3-sbeller@google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:2YAGW258e3jdSgkIQx3QP9hhM2C310uv+olYyMNll9UDnXaFBF3
 p7hKSJcGOz/IBfNINuTZ+OAtmYoJ9+xdPPUGL9GRyh7RxgFbqPFI3nkcJfB0MOlD7p+xvOf
 dH6Omyza2KlX0NmB3HC+mE7vvqrisl8JQvCC3MGrXiyvd0q63XSono+H7Ayt5IUhPe91+fq
 HKcZQDhkzEna9lV6mH4uQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:MS0I9r73Mkc=:gEWv4wUJ2GwzcxFOXj2CIg
 1LJEyMqkCJ/IEjt0ssBkGnNSRf4QQ6RPraBka8XPwi28LfQGpwzUKN4BV9Q/oxa1vjr2C6ay7
 MiqlLiYs0VhBL7XB/PrCE/JZLBz7oi3H1RnjZ27eNWY8E4VjVnbVKNb9J8CmM2/ntkjGvDDgp
 csGmJ4UlMyhUtG+hwknK8kAWzl4FhggUxlf98Kebl1BWbE2vnRKDQb6nZqUkJf5rShwtLv5LG
 0LfJjLwr4ctaTpGH4h/n1JzgB97uBRONOeg5R2+UreRBaRp2mu9u4YlK+x5ihAbtYlGfj0buP
 BJjC51Y0QpcXpymmhB13tl+KP//8ceVw8mFVGwDseD7uMs0J4E4CdjB3xbhG3B76BvwjP6dfF
 W5lzA78WUhsMb2Lt05QmL5oXlXYFsPvSu9W1/OVB5A8YBl+OGbENgevU3uvR/mcSOPF14u6an
 Sg+chjG779BKlMw4VY8NP5Pne+ZDtrMuA9EkjZRML9vSrSDbGyA+tCoOawEyRRcX51GjtEBm3
 qN4XCbBvYfXL26/IAlNUyWNhWsmS1BUEOecN9X8WvU982R6tNxlzNrqvRUEsiWJr04eDIyoJq
 9qSTS810eaZ83x4brCRjqXQhssI+cdVbLh07X1IirgOn1BjCeVjNJRt428H3n+IRa6nmnPPYD
 U+haKgJiwlV7Fn+VPl8opPbjI7qfPwOSNttDzhIhzk9EZ0Ri3rAb96dcuAMzJ0CgXlRMNPLAQ
 KVYP2/xXpj+O7mjNsZL8zdRAFBTiFxl/qTV/LEawqhrCttWL6RfCEtgrv/Dq6qYO4ivXZ9QSn
 BP91QDI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stefan,

On Wed, 30 May 2018, Stefan Beller wrote:

> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  builtin/submodule--helper.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index 7c3cd9dbeba..96024fee1b1 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -63,6 +63,7 @@ static int print_default_remote(int argc, const char **argv, const char *prefix)
>  	if (remote)
>  		printf("%s\n", remote);
>  
> +	free(remote);

Makes sense.

Out of curiosity (and because a cover letter is missing): how did you
stumble over these? Coverity?

Ciao,
Dscho

>  	return 0;
>  }
>  
> -- 
> 2.17.1.1185.g55be947832-goog
> 
> 
