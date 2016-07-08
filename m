Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C0B722070D
	for <e@80x24.org>; Fri,  8 Jul 2016 18:44:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755694AbcGHSon (ORCPT <rfc822;e@80x24.org>);
	Fri, 8 Jul 2016 14:44:43 -0400
Received: from mout.web.de ([217.72.192.78]:60827 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752461AbcGHSom (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jul 2016 14:44:42 -0400
Received: from [192.168.178.36] ([79.213.115.114]) by smtp.web.de (mrweb103)
 with ESMTPSA (Nemesis) id 0MIvXZ-1bJ7v40ogL-002UC6; Fri, 08 Jul 2016 20:44:31
 +0200
Subject: Re: [PATCH] am: ignore return value of write_file()
To:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <577EB546.1090007@web.de>
 <alpine.DEB.2.20.1607080830430.6426@virtualbox>
Cc:	Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
From:	=?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <577FF48C.4030008@web.de>
Date:	Fri, 8 Jul 2016 20:44:28 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.2
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1607080830430.6426@virtualbox>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:r8o87yTYOElDRGCJPVjESEY/8Pbjz+qZo7PX9RwBuDSk/Xx5F+N
 t5PwXe6EjLs4mh4P7d11iO9F0RRxqWmhr6nnxqXmGQz9wtYzpAL28Qg9IRBOgWZbeZa/hYk
 RCwbf9OhPjXK/3tek2ix1rmB9LRGbLFQO8wmyGP14klxeI4q2GnDD7r6lJ3I4GEEU33yBUA
 DdbmVn2dKwYm1FtVsl8nQ==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:9VM6IJ7QM4c=:EafPipD65uSFGXOp8O1Uq9
 Mf+P3+JUb1KlfTS7cX111W0GUnBEui8w1D64ML8XzauH08fmpz25Y4dLvcdE7YpdYaN5bJ2Ir
 S2FLeGnV9EhU/SOZTVkWTL8EIRL2BOToxewrvLOmzUrC6cVOJSXUa6vlqO33kJ4Pnsj5xDpeb
 AJ+QAbdZjIwzGsTM++sKp74/QvTFMs/qM+4bbcKOyCG54mRnFTY0yVQeqpnmvA5cMx2UT3+L3
 ntrwE9Zvxkw9ZaHPENd43XUdPv045+RKJ0zMzEwHVlWO54barrzvBPYMSA+la6XdUVrjE1M3X
 4OfDujSL31oL+Fx1bbB/TCcVrMhai8Z/dZ9miHet88BEwmAN3avcIj0jz+EzoCzkPwaOoCe+W
 CNe1KByQ9kHjpMMo46O5njWrWveCratVJCGJ3c6hQ8sKakzIekTwSvg3E5jy6tVk89ZviihXF
 8Oiga3HxATCmHB3rV4nWgJUj22UManCxb/8wYar7BQIuiImwyrQAeJwB8oMDFXvJkL/2Fwull
 5UKlQE518dNt3QlmqH57su1lU458Y/1wA1txQKMdk3agdhelQMVF7YKfUJZ3Ljy3EBL+OyemA
 ZeY/b1MSRiwuL88MwU7+/hOYEnwaDTtmKWTwwwQtN1sUn9EKUxe0bvkV+aNOhVBmRmizxZJSz
 MNnnYhpriKEXbWgO2xQauKgOLtXUQB8YcoRZmEsdKr6aYd5rnS14AP2pPEwTvXDeitR6ykD3x
 YettGjYwsVIlew1jinnAvXz9/ngSr4qtWVJIuMv8zNw4bysf9EFxxctgzN8rX/Np7m8rHftjY
 7b6EMSs
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Dscho,

Am 08.07.2016 um 08:33 schrieb Johannes Schindelin:
> On Thu, 7 Jul 2016, René Scharfe wrote:
>> write_file() either returns 0 or dies, so there is no point in checking
>> its return value.
>
> The question is whether it makes sense for write_file() to die(). It is a
> library function and not every caller can be happy with that function to
> exit the program when some file could not be written, without a chance to
> tell the user what to do about the situation.
>
> If write_file() was defined in builtin/am.c, as a static function, I would
> grudgingly acquiesce, but it is not.
>
> IMO it would be better to fix write_file() to *not* die() but return
> error() instead.

there is write_file_gently() for that purpose, but it's used only by a 
single caller that exits on failure after all, and in fact Peff's series 
drops it.

So I think write_file() is fine, and it's rather a question of whether 
am should use write_file_gently() instead.  I don't see why, but perhaps 
that's because it's Friday..

René
