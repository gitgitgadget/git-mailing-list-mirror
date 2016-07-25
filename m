Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 72E69203C1
	for <e@80x24.org>; Mon, 25 Jul 2016 07:33:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752360AbcGYHdu (ORCPT <rfc822;e@80x24.org>);
	Mon, 25 Jul 2016 03:33:50 -0400
Received: from mout.gmx.net ([212.227.17.22]:64198 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751418AbcGYHds (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jul 2016 03:33:48 -0400
Received: from virtualbox ([37.24.142.100]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0LoJDJ-1apnnM09tZ-00gJwH; Mon, 25 Jul 2016 09:33:45
 +0200
Date:	Mon, 25 Jul 2016 09:33:00 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Ilya Tumaykin <itumaykin@gmail.com>
cc:	git@vger.kernel.org
Subject: Re: Bug: "git log --format='format:%+s%+b'" doesn't insert newline
 before body
In-Reply-To: <8915446.47C9zkNvuX@photon>
Message-ID: <alpine.DEB.2.20.1607250926320.14111@virtualbox>
References: <8915446.47C9zkNvuX@photon>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:pPmSHmHcSP8XW8vTsAJE5NRgEwVVJtXbHok0DN0qb9MubCbvCm0
 PyT9Cm0cLI/fuhMKt4N7DoMamENjYxz4yyJG93dlzBoSM5tfta2MxUW4VSFvdTpmneNUjgm
 SaxUF2csX9CfkVLXrRPafN1ly3Us3lvXx7NfqtGcObxm0XuNxTQh5VuoydD1ZLc1HFueDHi
 VBoZC1LYM7i1rjfSxfyXw==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:Y9Qio0xtX/U=:s/xgGfANpqmJ5HyMPYG1Ie
 zdQEcWd02wRlNspcHO0+asYZJF/y9XKRoxA7YSRxc9ta32/wuiXhJWT9VH7HdaUUR3Fu5jfQ3
 r2fXt+ztYAFHRuJ9q2eU8vChD2tRcB9eSMyV/IabDaFqRtd72AOwsdYg2nd9RgVCXUcObFYOJ
 mdyOMUKFlUF3sCb9CQ2M2n3eg0gN/x4Ef8epHJReSUIOihwtjdJjhnMDFZYA9v95irvdJk/zg
 8sxI3t9ctnCPvhbpRKjmaWwef/S7iUPeasIlOkPPWqssmUl4pBQKsvNpX7ipNVny0jPNjXfBK
 6YLjnQgzHACsvhokNxUrviUEBwFLRQ3awk0exexhn0pzxEJadoHBW2Q/BekMWiuQOTVxjvSRV
 fCiUOYKultAb8MscBqmR9XaruTNl9brrPGfoSPoEeLVzaFNPkliMhjCPTWe3qhm0Lx2bNIBZE
 tIoTyBEJUTfHXhocrhQmexrteeGr20OL/0YexYYTAIY7/t4fsBM/kz2whBTJj9LzaPcprx0nA
 PhdoymvaBY8V4nlOgHgqoaTp0ExFuq+5cab5BAOqs3MTxksEeFC/Ox7AExdgyE5nDCyGZR18u
 OMyIG/nHU7O2MgIE2kwx+mYSb+jU4VixqIu1O0Mwc4Xbe4scuTtZSNgFJg9aFh0kY3UDduU/j
 NpeaK7Bv8fR/TAOVuHj4tGC1+Y5IJPjeE925XFC7IreFt66PJe/H5AayCEB2EYLzPxbE/dR/3
 8cC4M8T5gW308ns45YBrTgA60T3g5ljCdnVda0YdiIpnauZh6MrBfJ6HPGKkG6Feqwra9SYSd
 9Hg3PVr
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Ilya,

On Sun, 24 Jul 2016, Ilya Tumaykin wrote:

> Steps to reproduce:
> $ git init
> $ >123
> $ git add 123
> $ git commit -v -m 'This is subject' -m 'And this is body'
> $ git --no-pager log -1 --format='format:%+s%+b'
> 
> Actual results:
> ```
> 
> This is subject
> And this is body
> ```
> 
> Expected results:
> ```
> 
> This is subject
> 
> And this is body
> ```

The empty line between commit subject and body is neither part of the
subject nor of the body. That means that the above-mentioned expectation
was incorrect.

Unless you somehow allow empty commit messages (Git does not, unless you
play games with low-level commands), the second '+' is unnecessarily
conditional. Therefore "%s%n%+b" *might* do what you intended (I would not
know, because that information was missing from the report).

Ciao,
Johannes
