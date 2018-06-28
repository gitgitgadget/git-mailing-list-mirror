Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A8661F516
	for <e@80x24.org>; Thu, 28 Jun 2018 13:08:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752888AbeF1NIr (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Jun 2018 09:08:47 -0400
Received: from mout.gmx.net ([212.227.15.18]:55109 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965891AbeF1NIq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jun 2018 09:08:46 -0400
Received: from [192.168.0.129] ([37.201.195.74]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Lb5GD-1g1HmZ1Xk9-00khJW; Thu, 28
 Jun 2018 15:08:38 +0200
Date:   Thu, 28 Jun 2018 15:08:22 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Christian Couder <christian.couder@gmail.com>,
        Tiago Botelho <tiagonbotelho@gmail.com>,
        git <git@vger.kernel.org>,
        Harald Nordgren <haraldnordgren@gmail.com>,
        Tiago Botelho <tiagonbotelho@hotmail.com>
Subject: Re: [RFC PATCH v5] Implement --first-parent for git rev-list
 --bisect
In-Reply-To: <xmqqwoukgpr9.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1806281505160.73@tvgsbejvaqbjf.bet>
References: <20180622123945.68852-1-tiagonbotelho@hotmail.com> <xmqq4lhqpy80.fsf@gitster-ct.c.googlers.com> <CAP8UFD3oEjW75qsk4d_wqo2V8PmzMvZLshutw20CD7AU4b4ocg@mail.gmail.com> <nycvar.QRO.7.76.6.1806261540340.21419@tvgsbejvaqbjf.bet>
 <CAP8UFD1TeC4czp_8HCRw5CtjGO78A8gRezw_xspnm4MXuhQswg@mail.gmail.com> <xmqqa7rhi40f.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1806271254210.21419@tvgsbejvaqbjf.bet> <xmqqwoukgpr9.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:wB4gSkiiodZIqgc/4mi9oLUYIE2Q8hRyhU+yg5RHtyCuJJ9o4lC
 JpCeQU9i0hU2rw/t9/Qb/Y8BXXOqq0KyDgGutQzF/Pv2NBFjprgbHJQtk4qbuMTQasKd3hm
 BL+Ljf6vfjPLLGqJdc1lZgPq/ldtEFXN2ZphB4BxhSCVGCmev5Vn/ZJYcD8dDM/E6d1qeeR
 fDiZ5VkcfjN9bksPyHGFg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:qRMNZ/+IqrA=:TZDAl/hJpr7aZMCRSSG3et
 Qo9d00dtOmwe6NQs7Y1iuilOVmXYIOjdQ5l7u+nAWZDHI6A9W0jHjXT9QmaXqTlmFyVg6j+Of
 VoYhG/bT1GkPO6CBf7vSF4unRqBJ9D31ZzRamIsE/jk5QRTo4vu2AHf+JY7TPmZ05BCbu+k4x
 KXZHPpV8Q7Syb+d8Ko79WJmTVvP97sNPokaPku7dNRWbBCuv4t97FQqKiW5c8gWBgFNdG3VDC
 Unes7oM+2++5Tj6ADT8YNxxwiJX7oY1ZPxfMHniN53tgWT/UjawVENeCYssYyvNyYEeu2QxR5
 E4HqzKa2DkoZ5R7WHqxa0KIRLwvwN+YyaKUoe+itZRdCcvkPoDnN3QtzmiVvAnNKk2PhzwawP
 wmJlCQusBAAKSNoF8hM/C/f3NgA6wtjsff191bXwh8TU77XxGhiNGD+JYkOZafK/2S/A2ifv/
 xZRMzaHpjDXT88gyu45k3Icw3PPVWz92h2yqlNPozIp4PdmmRjT1QHOC5+ObvoBY/afeohvy+
 4S5yzxEgO0pSw2v7fpsHIzwn3TXhf+TqpNOVaKyr444AZ3ruYiriuFzqwAC0wgs6VEXT96OzQ
 2onrvmd9CJ5Fi0Ih/EEfpw2d/2kUN83hocl+xDZVy71tBLfyQ5GIHr+ByoZsN+p1Bed8zsYiJ
 RYxjvUp6rOSJ1F6TutMLYMxhcffI5osP81qajNQ2si0LgfdrIbY2SIROJl/xuQpMTaHRzGhcG
 As9qdX7mR1eXgHU9iQjrUkkEcJKD+LgN/1nMQs3grRyd5y3u17aunzO5zXN6LESyIiHU/CFPO
 Q0AlZkA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 27 Jun 2018, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > 	git rev-list --bisect-all --first-parent F..E >revs &&
> > 	# only E, e1..e8 should be listed, nothing else
> > 	test_line_count = 9 revs &&
> > 	for rev in E e1 e2 e3 e4 e5 e6 e7 e8
> > 	do
> > 		grep "^$(git rev-parse $rev) " revs || return
> > 	done
> >
> > I am faster by... a lot. Like, seconds instead of minutes.
> 
> I'm fine either way.  I just thought you would not want 9 separate
> invocations of grep ;-)

I don't.

I like the unnecessary test_commit calls even less ;-)

And yes, we could avoid those `grep` calls, I know. By something as
convoluted as

	revs="$(cat revs)" &&
	for rev in $(git rev-parse E e1 e2 e3 e4 e5 e6 e7 e8)
	do
		case "$LF$revs" in
		*"$LF$rev "*) ;; # okay
		*) echo "Missing: $rev">&2; return 1;;
		esac
	done

Is this really what you would call an easy-to-understand test? Maybe for
you, a Unix oldtimer and shell scripting king.

Ciao,
Dscho
