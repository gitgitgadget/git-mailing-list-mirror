Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 62F181F62D
	for <e@80x24.org>; Fri,  6 Jul 2018 12:36:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932876AbeGFMge (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Jul 2018 08:36:34 -0400
Received: from mout.gmx.net ([212.227.15.15]:52297 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932648AbeGFMgd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Jul 2018 08:36:33 -0400
Received: from [192.168.0.129] ([37.201.195.74]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LgYuT-1fwATn1O1V-00nyBF; Fri, 06
 Jul 2018 14:36:26 +0200
Date:   Fri, 6 Jul 2018 14:36:10 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Pratik Karki <predatoramigo@gmail.com>
cc:     git@vger.kernel.org, christian.couder@gmail.com,
        sbeller@google.com, alban.gruin@gmail.com, gitster@pobox.com
Subject: Re: [PATCH v3 2/4] rebase: refactor common shell functions into
 their own file
In-Reply-To: <20180706120815.17851-3-predatoramigo@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1807061432100.75@tvgsbejvaqbjf.bet>
References: <20180628074655.5756-1-predatoramigo@gmail.com> <20180706120815.17851-1-predatoramigo@gmail.com> <20180706120815.17851-3-predatoramigo@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:Tb7k7X1J4zDSLV+JUr0h28wg+4/khdXOKPB4Gx0lK2xAkgetKau
 NIKyq5tpNZnM9xUErB4eMmTcuFV5Nad+leWkb5vJNMhsLOZSv/VsE8kc/ab1bElqGDGr2kr
 TuwZm9fGhgUG1VCP5uwYwzqFcTxnVSwZ+1eEOIsGFtn8KY8A1rcHxK+mHUgMPSOcXlMdSlC
 ttauJygGZpW4wHNFlW58Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:dUXK7iVJQzQ=:05jav9cwE6bfSVPuNnBkq+
 ZxXNVBwNFxKKVXEJeyX9mPG9kFhaapWaf+EOcJYgqeFaLS+/F74jUAX+EUaLlJcQ5+tdvrPTg
 MA8/JDCbtLlN8huyKPsoLxa8mXtq/o/KP1gxMMahbZGHGmWSkM6K2jZfrXAo3Pw2j8ScYqORP
 tX8g3xD87DOTnCrilzrMVkfkVgCFic0enHY+Q3rP3y9rV7dKY4KfmrH6pNv5HPTJD6vIbuJVR
 0YijXY853jHBM89JZihvRNhQYMokgOguDCWKhGWX/jlUi3lkjZkKLZD6PJhQoQJwdDrUxTJ8q
 F8JQs0rk6w+dhtAuXoq20ItSfAsNldSnGXH7LJpPdPQyhkS2ONsgKc+IEFNidbx6NWw/DQF4Q
 e1rHXp1uSI4IJDsTvHoVHrm1HXXqXTjfjZ3sePgPDy7CJ1ld+z0I3p0Y+PzZNnxEGibJjoFB3
 RUNkXqoZJB0Z4/HvN0EF9Z34SIilW4orm1YvPLctHcj0/U9Yx9X7jc02W/1Dwf0KoD8vvLFxM
 Rjbnkp8R912tO1ud+fsGS24ysDdRlbtrRNcwkabrlOwgZ9b9mUpjkCQxPVoaxTLJY02JUsi7C
 kCWfZEtG59f0xk/ecefigpu5+Bhzf3T1KE/+S9qVF+u/72kh9w+SmY/IARCNRMIl1VDiRGkB4
 qfLIxfVrfNWbFASsVlf/w5kzJE9MH+tpoVbCPS1cZ+EOXs0EUo9bydIu6eCWJ8//AsYxrzUuO
 a11umtGiOwjGjd40RIsx2lxhCJ1csT/nOfCRJmyjRyH/Mk1vCZEfbJOURT6T8STJsPoLhD+QH
 oZSrSKr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Pratik,

On Fri, 6 Jul 2018, Pratik Karki wrote:

> The functions present in `git-legacy-rebase.sh` are used by the rebase
> backends as they are implemented as shell script functions in the
> `git-rebase--<backend>` files.
> 
> To make the `builtin/rebase.c` work, we have to provide support via
> a Unix shell script snippet that uses these functions and so, we
> want to use the rebase backends *directly* from the builtin rebase
> without going through `git-legacy-rebase.sh`.
> 
> This commit extracts the functions to a separate file,
> `git-rebase--common`, that will be read by `git-legacy-rebase.sh` and
> by the shell script snippets which will be used extensively in the
> following commits.

Good.

While this seems to catch all the functions required by the backends, I am
fairly certain that the `resolvemsg` variable is used exclusively by the
backends, and it should therefore also moved into `git-rebase--common`.
See my comments on your https://github.com/git/git/pull/505 for more
details.

Ciao,
Dscho
