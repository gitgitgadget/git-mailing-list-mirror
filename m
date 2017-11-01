Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 29512202A0
	for <e@80x24.org>; Wed,  1 Nov 2017 12:27:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754615AbdKAM1I (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Nov 2017 08:27:08 -0400
Received: from mout.gmx.net ([212.227.15.15]:62189 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754614AbdKAM1H (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Nov 2017 08:27:07 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M7HGA-1dGEkP1Jlm-00x6Gh; Wed, 01
 Nov 2017 13:26:59 +0100
Date:   Wed, 1 Nov 2017 13:26:57 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
        jacob.keller@gmail.com, me@ikke.info
Subject: Re: [PATCHv2 2/7] revision.h: introduce blob/tree walking in order
 of the commits
In-Reply-To: <xmqqr2tiveqp.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.21.1.1711011316590.6482@virtualbox>
References: <20171031003351.22341-1-sbeller@google.com> <20171031211852.13001-1-sbeller@google.com> <20171031211852.13001-3-sbeller@google.com> <xmqqr2tiveqp.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:Dorp+aDWeaQSLfMp05qfLqAxiqNalFHYUvvhDDoR8m4mldCu/wa
 dfY76y4ekscy+gKtKDo2QbQVGzPujZCMAsZQY87I+/CNkjQiG3gpztTr+EsKvOMcCJ/xC4f
 xhi8E9xGwizZ1fnNaGeNXREu0G3MqPLDlgCtewgtPYr83x6k+Mv4QIYNUm5stv6ReoYAYbj
 8ybpnToCKoZhQ12BLQPQw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:r2F9vfgBisU=:7W+gtZFi5Ywg+fpfa0tzLu
 UpRkCu4oWwA2QiuI+clHc2c/qpeOjQ5UoOd9mTvGVmD9umdbtv1VKeswT/Y7qCLow4Wx8wDOU
 zmBoCBBeD0NluDnxjtVQEhHgNQCaWBib+s+TEksjQ3jMd5/lwJJINf1rVFeJt4l6spx7PugNX
 ZDVemh6pbuV7TISY7hp2bLVEwRt1GuY7wASKkz84wWjTWQy5DZsPdFiYj0uYaUjssrPmkDANN
 MMzK6NvjkLAixrBxBW4MGVDUkG+stAvZNMdvDNdSorQp9AU06jisRoHx+NsdDD6WVXqo5UXcd
 cWLMSgjDrvh0yZzyrHW52f9pGHGLvNTTBMdnMaN9k9Vm91pgQT7KeGCV5SXKPPX4dXN+zf4X6
 aJEW0yjj32shW5ZAAGsdIc3CDRUT5oXvmAQNxiKpKRLQ1gwQ5otnFAR8JtwNO35DsXMPdRPYQ
 HtTnmiJLV4SjuRuuQu8PdfNDV7nHN7L6XpWn8t9ztYruDhQq2egrK6+AK3CdelRqfpv7l1M1Y
 eiAH4vgFdr66lV3VgfVV47/ROQ5/YlBp9G5KbRMLcPs/pdLXkyDxUu+aHf+ApPgLqWZsZ4PGR
 MfDxMV6eWxrDI5gLVkWW5rV1bCI0GmpKHXE1FVBKeKukJ8r4SyhJXPcOK98CVg38ituAIQLJ6
 0KKqXW1St+l360lf6AAMYqaF0nvF0DJI8X2XdT7B/puK0u4ez8rm6W7BDvhKTdraTmSN2tunC
 l3/3EUD2FGNRPpYhmxryvhN9X1kiYh2VgZKj1iVagwI2d0sCmTP2QSkxBX8DnkAwua+fB25zr
 8qI+u3LYmha+p1dbPg8fu/pRn53bDj8VBBbfthqKocWajIJ/WEVuTsYIuK0l6nSoFUdVh+Y
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Wed, 1 Nov 2017, Junio C Hamano wrote:

> Stefan Beller <sbeller@google.com> writes:
> 
> > diff --git a/t/t6100-rev-list-in-order.sh b/t/t6100-rev-list-in-order.sh
> > new file mode 100755
> > index 0000000000..651666979b
> > --- /dev/null
> > +++ b/t/t6100-rev-list-in-order.sh
> > @@ -0,0 +1,46 @@
> > +#!/bin/sh
> > +
> > +test_description='miscellaneous rev-list tests'
> > +
> > +. ./test-lib.sh
> > +
> > +
> > +test_expect_success 'setup' '
> > +	for x in one two three four
> > +	do
> > +		echo $x >$x &&
> > +		git add $x &&
> > +		git commit -m "add file $x"
> > +	done &&
> > +	for x in four three
> > +	do
> > +		git rm $x &&
> > +		git commit -m "remove $x"
> > +	done &&
> 
> When "git commit -m 'remove four'" fails, this loop would still
> continue, so the &&-chain in "done &&" would still be rendered
> ineffetive.

... so the proper fix is to append an "|| break", as in:

	...
	for x in four three
	do
		git rm $x &&
		git commit -m "remote $x" ||
		break
	done &&
	...

But that is still incorrect, as the "break" statement will succeed,
breaking (pun intended) the && chain in a different way. The canonical way
to do it is to wrap the loop in a subshell, *and also* test $? (because
`(exit 1) && echo something` still prints `something`):

	...
	(
		for x in four three
		do
			git rm $x &&
			git commit -m "remote $x" ||
			exit
		done
	) &&
	test 0 -eq $? &&
	...

Ugly? Yes. Correct? Also yes.

Ciao,
Dscho
