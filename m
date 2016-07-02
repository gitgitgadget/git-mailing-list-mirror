Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 82C131FE4E
	for <e@80x24.org>; Sat,  2 Jul 2016 06:35:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750820AbcGBGfA (ORCPT <rfc822;e@80x24.org>);
	Sat, 2 Jul 2016 02:35:00 -0400
Received: from mout.gmx.net ([212.227.15.15]:52539 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750766AbcGBGe7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Jul 2016 02:34:59 -0400
Received: from virtualbox ([37.24.141.253]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0M7YF5-1bUbJp2KyF-00xKbl; Sat, 02 Jul 2016 08:34:30
 +0200
Date:	Sat, 2 Jul 2016 08:34:29 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Junio C Hamano <gitster@pobox.com>
cc:	git@vger.kernel.org
Subject: Re: [PATCH 5/5] Skip blank lines when matching <commit>^{/foo}
In-Reply-To: <xmqqh9cb1ub0.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1607020826530.12947@virtualbox>
References: <cover.1467209576.git.johannes.schindelin@gmx.de> <7cebdcd80a93d1604258e9dc9cb286cd6ba97ba8.1467209576.git.johannes.schindelin@gmx.de> <xmqqh9cb1ub0.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:asFrAT2o8I3WYyefgeXMK8MkkfcBMn71f2T7E7FdhcVStve4NJN
 8DKszYBMFm2yXpLrWnQHil+CR20mcaxcOJO8g3U7A6mVc/wIuHlIJfdAeGjhBOhN8lyCDbD
 Kdxd0P4+J/NOuyvKQm2+ntpTT9QVOF/tiMgvsTNNJ4TDJ43EozrtxSctAZONOShaucm9Uou
 q5cwMulHRlPX0p5H04p6Q==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:XLtoUtJMDO4=:k1Pb5qTkGEZLl7K0Q+3OL+
 NzQG8phIErk5FyzIfkjhUz64BW8vewwoqSM7O1obZwmXIrIEY5+2LWRTKLF+hgWqjV3u+jK9n
 Nggv898DQlrGOdv2Ar6QmP9KBzTZ/I/4X/56uSGVZdX3+Z12dKT/AbnTyLLJdU1J7Ip/8G2T6
 woz+J70WZfIZAXkr3tjfDv9DhZ4ocl/CrB8D52SJyH0ZyB+snj0doyXD4monT+pYjpN3GdPSi
 yqla5nRYXXwZXBaeotkkUmeygJ5uXsTPp2w3oZbz7WsBbBWAUkXI3xthmd4hC5RIuDqEXxi6+
 wHyGlLR8N6F+I9E6kK8LN1MxXmj/B31cuI+E+ZwG5sCWPnv3kayFOXej3dsEY3t3D2s/034qa
 eSN0DOBjMX1A4m+0LOagX4Tb8/bKSqAJxQGhTmYNd5xkgKOzPIfnZVMY0iSLGKmf4T8Wdy5zY
 wtI4YockIMLhqaJbiI6HEYNpAw/can8poEyW4cLQbz0bgRJDXG2W6todeK38SF8Xk1T3dVFAm
 EPQ/R4rSCPeUuQtGZYKfcp5jAdZH8E97SHh3dX8Dj0Y0ANCjaUZ15hh+AL+lEKMliW2wByJeX
 SOAqjJp3KdcZL9cv/F53OAC6vEMGxZ0yj2SuwA6XwprQqVth9ONPvyJW/xb8xlNOc39jlET38
 GboDUnR9jbEANbjqdsUHYrRIWtgTXNOjTZZvkCiNmg+IQZJ4TFAFrL3s0kArCYmV0I33qt44V
 rr2aHlRCDfd5NlcRGOUpnJuI/9wFv7/hTU6B6Qwa4tHKosx9TXZiW19klMGr3/Ll4XYb6hLFk
 WPJR9wN
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Junio,

On Wed, 29 Jun 2016, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > When trying to match a pattern in the commit subject, simply skip leading
> > blank lines in the commit message. This is consistent with the
> > pretty-printing machinery: it silently ignores leading blank lines in the
> > commit object's body.
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> 
> Hmm.
> 
> I just tried
> 
>     $ git commit -s -m '  pull: fast-forward "pull --rebase=true"'
> 
> expecting that ":/^  pull:" would find it ;-)

This patch would try to address a different concern, though:

	git write-object -w --stdin <<-EOF
	tree $(git rev-parse HEAD:)
	parent $(git rev-parse HEAD)
	author B O Gus <bo@gus.com> 1234567890 +0000
	committer F A Ke <fa@ke.org> 1234567890 +0000


	There are two blank lines before the subject
	EOF

It is not about leading whitespace in the commit subject, but about blank
lines before it.

Granted, our current tools do not generate such commit objects, but we
accept them, and already handle them in some places.

> Also 4/5 is another different class of true bugfix, I would suspect,
> so let's take it on a separate topic that can be merged down to
> older maintainance tracks.

Sure!

Thanks,
Dscho
