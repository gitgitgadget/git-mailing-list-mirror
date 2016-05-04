From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] submodule: stop sanitizing config options
Date: Wed, 4 May 2016 13:25:20 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1605041324030.9313@virtualbox>
References: <cover.1461837783.git.johannes.schindelin@gmx.de> <cover.1462342213.git.johannes.schindelin@gmx.de> <20160504062618.GA9849@sigill.intra.peff.net> <20160504074559.GA3077@sigill.intra.peff.net> <20160504080047.GA2436@sigill.intra.peff.net>
 <xmqqwpnai6em.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Jeff King <peff@peff.net>, Stefan Beller <sbeller@google.com>,
	Jacob Keller <jacob.keller@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 04 13:25:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axuw7-0004MV-Hz
	for gcvg-git-2@plane.gmane.org; Wed, 04 May 2016 13:25:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752300AbcEDLZm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 May 2016 07:25:42 -0400
Received: from mout.gmx.net ([212.227.17.21]:55621 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752175AbcEDLZm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2016 07:25:42 -0400
Received: from virtualbox ([37.24.143.84]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0MPHrQ-1b2IeQ1m1Q-004OoH; Wed, 04 May 2016 13:25:22
 +0200
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <xmqqwpnai6em.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:e9ZTHOo+LKFYCzRtLVapD69uICxCKQia2gR7PCZsgTHr+kv6u+U
 6x75Rt4VTt5BUv1PWXl20M5y3uyyVTl7+PxCCn3ovwlfKTKW6OxUE0uvwazAT8g2PPLYOST
 EB87Z6mwK0vAfd/gzCvFe58NRwTJx7d5SHgmz/RAmNy1b6X7XCv1iOAu42iemijIVi+q1qc
 QhbugVGooTCtsS58IJ5QA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:mmV7i6C3/2U=:vSVe2vglcndSOJyEIVSioD
 +gSb5D+k9k7Zl/srPlMxQGWyq+z4sLHSqcH6K8yYtSdhTDT54dv4JMxTO3Km9zLmkJBdslGz/
 WSFs8hQA7DumXwp2Orgq+ZUDvpj3PZqwmG0nscR0rCo4xk/tdj6ZUz2/HowmF6JF9jM4lwzdw
 H7kfd0EBlY8YUedyRV4GS5AjVUwPiMtbWI0nkOXdFSLGF/zSBRiL/KOwx1uYI7Sac6NEHSlQX
 EdxTwHSle6HPLR9ExlTOy/aBa4o8hmeyY8ffvkiw+G9hQZiLTGGmwV1+2S2XvBw+cqSGdjOVG
 OWbrDyW/34lXgVUdDCJ4Xuc5VDk8/32O04Or2fqUG+gYjsdXlNGvq7yGw75MlEGDs+XQ2kwqN
 8K/GQLgqpZFxXLUnOdqEWGhJT2VRZKz7DjDMAB1vZmZ7LBJufGBNqbgMdNQLWQ9FvEfJUsgAf
 d7YI5yb48qXN+A7wd9bGe+pa5XetaWDlO6bJPBhO5R1f1y30P5CqhxvsxjLZ4KicdRqlpEse0
 BjYMigAVzo+arpFQVZoqfXkOVP2aqHt5w3IzGlfHRcx+s/QYroaJF+s0wqYi46VG0FKOTNK9K
 2h24ngsbAmaQJdNgpiYjrX2uAPJqpU/YV1stiaAJUGCNg6LJiBiGQuyr+WpxCF7qfgiZYtjgv
 /FCmMf+yp5Neb9L319tJFZUUpxL0bOZH8Ws0X35llgBYK/F3X5gR23/+8ZuR05RKNAlPzXm4n
 JdCJ2DhUl+Bb7StzlQaQIbEY9Ym1dOf10gGLVWqjt7STpDTzQRKGaAdGraLR3KLp7zAz+A58 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293535>

Hi,

On Wed, 4 May 2016, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > [+cc Stefan and Jacob since this is really resuming that earlier thread]
> > ...
> >> 
> >> So I think we'd actually want my series as a preliminary fix, followed
> >> by dropping the whitelist entirely on top of that, and then probably
> >> simplifying the shell sanitize_submodule_env() on top of that (it would
> >> be correct without the whitelist, but you can also trivially implement
> >> it without having to call submodule--helper at all).
> >
> > I think we'd actually do it all in one, and that patch looks something
> > like the one below (on top of jk/submodule-config-sanitize-fix).
> >
> > I don't feel that strongly about going either direction with this, but I
> > figure it doesn't hurt to make the patch so we know what the actual
> > option looks like.
> 
> I do not feel strongly either, but I suspect "we do not filter"
> would be a lot easier to explain than "we pass these selected
> things, each with such and such justification why it has to be
> passed down".

I really like the simplicity of the rationale.

> Nice code reduction is very attractive, too, but that is secondary.

Me, too. It just makes things simpler.

Ciao,
Dscho
