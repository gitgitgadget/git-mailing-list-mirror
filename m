Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9CE331F461
	for <e@80x24.org>; Thu,  4 Jul 2019 10:38:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727555AbfGDKiT (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Jul 2019 06:38:19 -0400
Received: from mout.gmx.net ([212.227.15.15]:37605 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727385AbfGDKiT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Jul 2019 06:38:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1562236695;
        bh=3g5vOULZJVB86PG1ttTqRDbqmGcIWYZ9qUJhdKN5oBQ=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=AxSerTvgHFRhKYAaOGJE6prLQr+ugS4WGW7BtEzdbQwyalCsygg8ZnhMd7fSdUxWn
         ftTsLPOzKKm/T95/rj0/yVd0K61bQAgTo9ieYRgzdeHAbjgZqgGz09IJJO2+k8T8Gc
         1HjwbwR8u8mmYdWauAgk2yYlUV3swMi7qhRBwkzI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.51]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MFMIO-1hmIWB1mAG-00EJsS; Thu, 04
 Jul 2019 12:38:15 +0200
Date:   Thu, 4 Jul 2019 12:38:44 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Heiko Voigt <hvoigt@hvoigt.net>
cc:     paulus@samba.org, max@max630.net, git@vger.kernel.org
Subject: Re: [PATCH] gitk: fix --all behavior combined with --not
In-Reply-To: <20190704080907.GA45656@book.hvoigt.net>
Message-ID: <nycvar.QRO.7.76.6.1907041236200.44@tvgsbejvaqbjf.bet>
References: <20190704080907.GA45656@book.hvoigt.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:LVN6L/WEarDZkEB+E9B5eow//Mdj19ItD6Uax8+VPl7CuwBQFSw
 PVZihLLzpQEYHoDuyYPY4rySeU0ei6I3RaIznZC0nXZJesB+qqpADBfJX8vOW1b4jLCOvY9
 htzC27OO/MOC9x/nzEkUgNIGo8X7ekM5ik/QTOJXTYBT6+ulBBjPLPbLt95se6FItYXFhul
 813oBTHMLrFP53Gk4f9RQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:4OXi6FkzEP8=:V7QY4BCIOIg9ksKo7iOks1
 V07EgkGrcUOG0tUdQEgDhyPK2QMJUzGF+yYEsIJGOgpatjo8uDtbSFOTQSIeTBdoqcAVtvkh1
 78w8zWHWJFOPcktDOZPlWw02mgB8JAlbqsWu2XGaneMK0idvyXZx0hT5MPPSvRanmTinnc4OJ
 OEBtHbNNQw9dT5r+/B2h1IzFKRa8l7HBT1w3LfDR7rSGajhi2eTu5Z6QEStLCDnaRWHsZYOgU
 QdFD89Z3aySAdnpfeJBjK92C8y0KUvG4iPr0X2QUC1XOebrDuCWCajPSDhWx4Vi9CbV4tVA6l
 +q8UwE78qqAI4Lqia3keCm6V/70Eka5mDjJeudcj/REXf+5ersOCDFD8NZxfmCnO1nsdndnhv
 XtEsP3aDRF4y2qZrsHZ4xsX/KPY4ABoQ7Pb/+9zNCI+FIOsn213CNsvrvO/g/Md263J5qstkp
 I6YV7SExKKdE9pkD4pULUlMcpBOjvBJSpUuUI2O41rPuND7Fb7Yoxlb6nssXgy5JNsT/+Y3e+
 IwYGvU4d3guCrqqAuD2eu18kYkBJTAHhMIzMXKHnGAlFkDJOX8iMjoaI9NbouaEBTRJBWuALH
 F+UMfrRR52BXiOEKIQTVcUU0nQHKUue0zNeFWJoIVXzrmvsF8wS6YHXrotqHXiDgxFwOl2UhW
 4O0xYIZ+6FTrRvymesgk2Qxac88qWGomjNXqlgmcuPPFjl2nH5/o0eTKbZiIkZrpjVFvsVqvM
 HRLVm4SyLoit0pe1dPoy1oxB5qVNOYgi0/iycuG1PhbxvIs4ArFhqddaTNX45qF8HEjbVs7hC
 3h7BTOmXgzVezs9gKFb2jwP1CWvRuF1saVUaXOQnX1LtMTYMvvgQiBWWhtJne4SjKbeHbE7Bo
 1tJgeNKpEAAeRikLMMVtqASV24DKdXEI83f8Jyc86CrraFzdTvMEqAekg9r9SuhFHfVaCra+q
 OoH2QrmW8hoj3TWIHEbB+d6unwyYwyJuE2iOi5Jvv44CBsNFYkwlSt5eQhmYLf1mhm0OnA0To
 moogGKAs0JYHR1GpvQlf3HQ1480f/wCcJGb+Pvf0aoFpNT8KEPD1vWAiA4ARBP8WWxPPm3YPw
 AtXlFr8PXd/kIf5giLjqQCH6qsgJWdzf5Yl
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Heiko,

On Thu, 4 Jul 2019, Heiko Voigt wrote:

> In commit 4d5e1b1319 ("gitk: Show detached HEAD if --all is specified",
> 2014-09-09) the intention was to have detached HEAD shown when the --all
> argument is given.
>
> This was solved by appending HEAD to the revs list. By doing that the
> behavior using the --not argument is now broken, since that inverts the
> meaning of all following arguments passed to git rev-parse.
>
> Lets fix this by prepending HEAD instead of appending, this way there
> can not be any '--not' in front.
>
> This was discovered because
>
> 	gitk --all --not origin/master
>
> does not display the same revs as
>
> 	gitk --all ^origin/master
>
> which it should.
>
> Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>

Good description.

> ---
>  gitk | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/gitk b/gitk
> index a14d7a1..19d95cd 100755
> --- a/gitk
> +++ b/gitk
> @@ -295,7 +295,7 @@ proc parseviewrevs {view revs} {
>      if {$revs eq {}} {
>  	set revs HEAD
>      } elseif {[lsearch -exact $revs --all] >=3D 0} {
> -	lappend revs HEAD
> +	linsert revs 0 HEAD

For a moment, I wondered whether there is any case where `HEAD` might not
be appropriate as first argument, but you're right, the revision parsing
machinery allows mixing options and rev arguments.

In short: this patch looks good to me.

Thanks,
Dscho

>      }
>      if {[catch {set ids [eval exec git rev-parse $revs]} err]} {
>  	# we get stdout followed by stderr in $err
> --
> 2.21.0
>
>
