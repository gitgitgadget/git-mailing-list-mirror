Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MALFORMED_FREEMAIL,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E74CB1F71B
	for <e@80x24.org>; Mon,  1 Aug 2016 09:01:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752088AbcHAJBV (ORCPT <rfc822;e@80x24.org>);
	Mon, 1 Aug 2016 05:01:21 -0400
Received: from mout.gmx.net ([212.227.15.18]:52543 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752047AbcHAJBT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Aug 2016 05:01:19 -0400
Received: from virtualbox ([37.24.142.100]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0Lxgt9-1bEAQ11Uy3-017CeB; Mon, 01 Aug 2016 11:01:02
 +0200
Date:	Mon, 1 Aug 2016 11:01:01 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Junio C Hamano <gitster@pobox.com>
cc:	Kevin Willford <kcwillford@gmail.com>, git@vger.kernel.org
Subject: Re: [[PATCH v2] 0/4] Use header data patch ids for rebase to avoid
 loading file content
In-Reply-To: <xmqqshusmby9.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1608011059040.149069@virtualbox>
References: <20160729161920.3792-1-kcwillford@gmail.com> <xmqqshusmby9.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:OOfky4GvOq/3bEPL8U3uY/DTTjGZW6QBkQxNoJ4fzjEIJY3wC70
 HoJWhDONKoVzQkBMkaCt/CxRHW8TZi8ACpJAcpDeK//YGGlMoI5cd/anYM1VfyeS4hj0HSJ
 n73ikMm3A482d9XHgS463UvI/xwszT+IZTVkDz5SGmRfEZZddvmaWEie4ZSJFrtFYDUrFOZ
 Aoh4mKuh1AcD+ubGn4kDg==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:X+H/KTow7ew=:70J7SnYnVQ3hAYlkeG5Zm5
 8yiQ51d64KNXwokwzbbJjweUimbh3+FBXGqhGMvHZ7WR+J8uv4eKEFTFgka656xEs4r4u/xjC
 qrHInFwyaBuxK3dhUsd1uYx9lx/HzJoVm2eBJlEfsMgV5oyeKqwG8lbk8lwuIaCjzif+2oLbT
 4vqpJBkzK1b2mnPU/WwD8pHInnrHu82ZAnL+NN+oEylu7Iyk8TFrp2aMqyOkHm7hNWN8Ik3UF
 dQKOWJhDt8H0jeeiFZw+s/fPXzgaVh5dkxxT9eiOhS1T52zTKdzz5iZlwUkdkCmCcM0WqQwyQ
 yUOi+ywLjCl9Z6IwLkf3+jkKUm8iK41Wm3IkALtVuFae2OlUxssHk7sEvSmCViCP5x99iEc65
 vKdWByIwT7ZSwciVoxbOfIU19UdTzMN9yMP2+Hvri0iUIPLN5JlkPTLdySjGX9hVTMifAoadH
 AvlYIRYLeco8S7BCufQNDZYR1kGR9YB1AAbrS0mFXhI1Bc1s+psBndk5SK3hP8yykJpwi/+Os
 nbgX9QHlDvIXzykjcSl6bseDBFpjgkqU/puj8gUVnP3D0ri3vn6uYoxJ5tAVyvYXIZu3ki83E
 sgshQ/H5bvMg0LF9uriS0BRcDquhLR7+3WoYS5swe4XgDSjQcvpE5mhw3X4SYSXashYRANvHO
 LHk8S2QfzfH1Bvr6CX1OeGiPXA8zYpBgiHFGOqmJz+b7A5CA63hWwIpeXJXJ6e9885QhOzQPG
 bhVfe/WRzUbBSz0OLEbIJJuJy1WIYH4z8JU/ur0NtY3v9hECbXFFkvd5/T44OfBEHbzgzqXNO
 uK37BCx
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Junio,

On Fri, 29 Jul 2016, Junio C Hamano wrote:

> Kevin Willford <kcwillford@gmail.com> writes:
> 
> > This patch series is to remove the hand rolled hashmap in the patch_ids
> > and use the hashmap.h implementation.  It also introduces the idea of having
> > a header only patch id so that the contents of the files do not have to be
> > loaded in order to determine if two commits are different.
> 
> > Subject: Re: [[PATCH v2] 0/4] Use header data patch ids for rebase to avoid loading file content
> 
> Did you do "format-patch --subject-prefix='[PATCH v2]'" or something
> like that?

This is my fault, sorry, I suggested this usage (misremembering the
semantics because I only use my mail-patch-series.sh helper and never use
format-patch manually anymore).

>     git format-patch --subject-prefix='PATCH v2'
> 
> or even better
> 
>     git format-patch -v2
> 
> would have been more appropriate.

Oooh, I did not know about the latter form. Nice.

Thanks,
Dscho
