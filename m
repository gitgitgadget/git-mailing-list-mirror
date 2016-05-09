From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v7 1/3] tests: Adjust the configuration for Apache 2.2
Date: Mon, 9 May 2016 16:03:48 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1605091557050.4092@virtualbox>
References: <cover.1462342213.git.johannes.schindelin@gmx.de> <cover.1462774709.git.johannes.schindelin@gmx.de> <4a15c4e6c35cfb425da568d87e8b20b984e5325c.1462774709.git.johannes.schindelin@gmx.de> <20160509080315.GA14383@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Lars Schneider <larsxschneider@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon May 09 16:25:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1azlnA-0000aR-Tw
	for gcvg-git-2@plane.gmane.org; Mon, 09 May 2016 16:04:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751279AbcEIOEE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 May 2016 10:04:04 -0400
Received: from mout.gmx.net ([212.227.17.21]:50680 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751260AbcEIOED (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 May 2016 10:04:03 -0400
Received: from virtualbox ([37.24.143.84]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0MP1PX-1axHkY3fZH-006LlC; Mon, 09 May 2016 16:03:49
 +0200
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <20160509080315.GA14383@sigill.intra.peff.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:4hfKmy/LDzAewXDK1Pdyu1Rj9eyyDl7ipS4+OJjdaj0xrEAlZTn
 7LyLLP7xQ/LsoNKpYM134o0h9l2nT9ql85Fk3TBy0R5TgMPTKIDqwcDPoiBQN/0MTi0Zef3
 Rsm9go8/gNWUagNgzL6LAyKWcmDeKNaz7qdRB0/vHH+awlhX++pwoezqHq1WArNbG8Fu5Pp
 0/XCA6l2KSnlE8B9Ds+kA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:YPYesMsC75k=:phozi7sFXBZUyNk9zc7sxZ
 gL32WD5Adwe3MiVoYoM3KOHr2zBK5cmpijgkcG5LPHSSQguWJocUsu09cYTHKwCEyRUFE1WNw
 Btv7QMYHyWKSm9CTOcAXd1CZ9YAejOOQBMAV7V6vpmXi/XqmVZUzVVSFoY0MAxczXPCdxjUn1
 2jhTSqwPmhdErsZaPq6x3AJ0BbNszDGDpTDreJgNOkjIHUrr+pnlMCQhREFVNZ6G8oHGFWSzH
 UrhbnO6me+ztGwnWyDjKqCGEiUo7qGUe0ScbauWBOwNWDh5iYdbDRmyWM7kldBnJL4U+t15Wz
 veEVD/GD75Izeo2V8rgMFgz5G/XKgFOjcCG0cEhnQ2K+OQUtbJ/6oeWW/HLs1sH7tMK6s37h6
 XdH5+rTVw5ndnzFun8Pi1rwoLR4YzwIhCN20qLeN41EetRz75XvOpKpiMZuZMt+P4s1+QGABv
 6sddBGhd7DsJGAgHOssj7hbN8Z04Nml7F7vHJXS+RJseqHv6jVqcaMWU5vLXvFzy4qRhVxNjp
 PHd+Xi1+3s3tbVq33GyatgpcT/tKdovcyz9zKNo54TNQ42fYn8evsxSdOxTpq50Is8acDP90T
 S0WLWFcsQG2YnOxmoTliORIUiyNnZk2K7H9y99AqaC6Y9FiB+taJi1tHMY8Y4ikguoKkupTDg
 xK8+z7NSQFvV87vafu3a3e1ldpCOEYsUIojEUbr6cTyKFSJoQJmwDJdKAqy02g7JJj8Iw2ARp
 lZPqfoZTVHZ+rhJt3Vo+wXEA5uEM8a9TvnfHZaRaH2x4l3nVjZIwwCF8Y3l9C13uyNZmawLr 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293995>

Hi Peff,

On Mon, 9 May 2016, Jeff King wrote:

> On Mon, May 09, 2016 at 08:18:52AM +0200, Johannes Schindelin wrote:
> 
> > +# Apache 2.2 does not understand <RequireAll>, so we use RewriteCond.
> > +# And as RewriteCond unfortunately lacks "not equal" matching, we use this
> > +# ugly trick to fail *unless* the two headers are present.
> > +RewriteCond %{HTTP:x-magic-one} =abra
> > +RewriteCond %{HTTP:x-magic-two} =cadabra
> > +RewriteRule ^/smart_headers/.* - [L]
> > +RewriteRule ^/smart_headers/.* - [F]
> > +
> 
> Thanks, this is the magic that eluded me earlier. I had to look up the
> flags, so for any observers in the same boat, this works because:
> 
>   - the '[L]' flag says "stop doing any more rewrite rules"; it triggers
>     only when the RewriteConds above match
> 
>   - the '[F]' flag says "return 403 Forbidden"; it triggers always,
>     because after a RewriteRule, all RewriteConds are reset
> 
> I'm sure that is all apparent to somebody who is familiar with Apache
> config, but I think that does not include most people on this project. I
> dunno if it is worth a comment here or in the commit message.

Oh, you're absolutely correct, I should have described this better. It
took me quite a couple of iterations to get it right, after all.

How about this:

	As RewriteCond does not allow testing for *non*-matches, we simply
	match the desired case first and let it pass by marking the
	RewriteRule as '[L]' ("last rule, do not process any other
	matching RewriteRules after this"), and then have another
	RewriteRule that matches all other cases and lets them fail via
	'[F]' ("fail").

Good enough?

Ciao,
Dscho
