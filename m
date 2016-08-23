Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 147581FD99
	for <e@80x24.org>; Tue, 23 Aug 2016 13:39:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754611AbcHWNjx (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Aug 2016 09:39:53 -0400
Received: from mout.gmx.net ([212.227.17.22]:60734 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753429AbcHWNjw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Aug 2016 09:39:52 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0Lu2F0-1bBLhk0OAQ-011VH0; Tue, 23 Aug 2016 15:39:46
 +0200
Date:   Tue, 23 Aug 2016 15:39:45 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: Re: [ANNOUNCE] Git v2.10.0-rc1
In-Reply-To: <xmqq7fbcz76b.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1608231538160.4924@virtualbox>
References: <xmqq7fbcz76b.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:wxz3QdPy6FKE8ZwO3zGe82JpJ5a0XM2ze+v91h83MtUoK5QumAZ
 wDf7cy7C8TfrAdg0sPTYoLpQ+uLS6XdLtfQMcLbxPwdz58DizS7YrEKJihzPtneFUvkEbKw
 UuK9bFBGXFxTIq+71/rpCsjamCXZstH+wZvC4naEo3K/1JlpJtJzSpeWklU1uQzArGw9Y7+
 667zLkR0Z4FcKpweY2Pnw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:avjfnYRSbw0=:cfdS9KaxH0KWx5CvXBNO9q
 E4Wq2x6xD7IZoMJbqhlHDOyhlvhTNJgH1P3PiaC59bNTAcW+EQ41rQ7Tm8OSWoj4ht8XVcwL4
 r1anSPzvWTTHb/GG+aJsOlwAn0G+ovF2M3ZrGBDK6lVbaWaR5FIhUGG6mATwbM3UUvL90RXiR
 UM4f9jK+469kdB5qRjSyCXJYGDzt5XR9KphoJwhFOw8qeCK8p6YLknIOzheY090CwK1jZWQJS
 HCAA39aFUdttEZV/PhK7JgBcw/ycTmP1m0igYCl+Q6yUXMk8es3Re3JXd7OxbLDDVUHnbEckU
 F/XTOPhBGTIYYNx1q9y64b1nw5ayW03QCM32Vs/P9tGXeTbdXTsPeRle+YGBvfjUiZh4IP/0f
 55Y3FdXqnzXjztTsP8Y3Hp4b3Xtu9Av1aXxCTLs8LeGzHzwVFaRbMkS60frbTKt0x4qQmT/27
 phFTAd2DLXUhyjiBMJXghzFJzZOXShEXb5wlG6qyRM9LtaZf5r5EJa5Gq9yCH/0K/wFbSEFGB
 d7BXQsx3fNCQTc7HAzGyQGNyvBReIrV/ytwExayisQa4hIQbpjF+elcUn8qp+Rcxca1hYk+Dl
 FWv7dggNCskPwCGg1xpjTQHypKfjWt4rXB25Fw6SYUGymzYVfLzkelr2FYO1Jn6QfHFqNJADy
 6cuiR/Vhn/oA5aU9ww+LvEygN9KuX2fSZ9rA50sEUZKICVliX6AdMC7LRmXWFqwEnXHFeVgu8
 p9W/hpq43GKHHZALnKoGq0ahZFGQlVn9MLFD5HOmTzQJR7YIP5Y9NMfmlPxD7n+/IBMjxlQg8
 2cbgvWt
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

[dropping LKML]

On Fri, 19 Aug 2016, Junio C Hamano wrote:

> [...]
>  * A new run-command API function pipe_command() is introduced to
>    sanely feed data to the standard input while capturing data from
>    the standard output and the standard error of an external process,
>    which is cumbersome to hand-roll correctly without deadlocking.
> 
>    The codepath to sign data in a prepared buffer with GPG has been
>    updated to use this API to read from the status-fd to check for
>    errors (instead of relying on GPG's exit status).
>    (merge efee955 jk/gpg-interface-cleanup later to maint).

You probably want a '*' in front of this paragraph, too.

>  * Squelch compiler warnings for netmalloc (in compat/) library.

s/netmalloc/nedmalloc/

Thank you so much for these extensive release notes. They do take time to
read, but they really cover everything quite nicely.

Ciao,
Dscho
