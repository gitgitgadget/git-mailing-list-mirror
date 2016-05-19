From: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Subject: Re: [PATCH] upload-pack.c: use of parse-options API
Date: Thu, 19 May 2016 16:36:39 +0200 (CEST)
Message-ID: <800962099.10901198.1463668599601.JavaMail.zimbra@imag.fr>
References: <20160518164019.26443-1-Antoine.Queru@ensimag.grenoble-inp.fr> <20160518180800.GC5796@sigill.intra.peff.net> <721240639.4127450.1463652631815.JavaMail.zimbra@ensimag.grenoble-inp.fr> <20160519115725.GB3050@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Antoine Queru <antoine.queru@ensimag.grenoble-inp.fr>,
	git@vger.kernel.org,
	william duclot <william.duclot@ensimag.grenoble-inp.fr>,
	simon rabourg <simon.rabourg@ensimag.grenoble-inp.fr>,
	francois beutin <francois.beutin@ensimag.grenoble-inp.fr>,
	Antoine Queru <antoine.queru@grenoble-inp.fr>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu May 19 16:36:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b3P4J-000187-Oy
	for gcvg-git-2@plane.gmane.org; Thu, 19 May 2016 16:36:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754323AbcESOgt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 May 2016 10:36:49 -0400
Received: from mx2.imag.fr ([129.88.30.17]:50632 "EHLO mx2.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753995AbcESOgs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 May 2016 10:36:48 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by mx2.imag.fr (8.13.8/8.13.8) with ESMTP id u4JEacEm026878
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Thu, 19 May 2016 16:36:38 +0200
Received: from z8-mb-verimag.imag.fr (z8-mb-verimag.imag.fr [129.88.4.38])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u4JEadYr032238;
	Thu, 19 May 2016 16:36:40 +0200
In-Reply-To: <20160519115725.GB3050@sigill.intra.peff.net>
X-Originating-IP: [129.88.6.115]
X-Mailer: Zimbra 8.0.9_GA_6191 (ZimbraWebClient - FF45 (Linux)/8.0.9_GA_6191)
Thread-Topic: upload-pack.c: use of parse-options API
Thread-Index: XkQA+7bmcKl/V81T4wBVKv9+5+GuNA==
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (mx2.imag.fr [129.88.30.17]); Thu, 19 May 2016 16:36:38 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u4JEacEm026878
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@imag.fr
MailScanner-NULL-Check: 1464273402.57373@RtOTCZvg4j/chSCCoEpNyA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295064>

Jeff King wrote:
> On Thu, May 19, 2016 at 12:10:31PM +0200, Antoine Queru wrote:
> 
> > > I'm not sure whether it is worth hiding the first two options. We
> > > typically hide "internal" options like this for user-facing programs, so
> > > as not to clutter the "-h" output. But upload-pack isn't a user-facing
> > > program. Anybody who is calling it directly with "-h" may be interested
> > > in even its more esoteric options.
> > 
> > In fact, to do this, I looked at builtin/receive-pack.c, where the parser
> > API
> > was already implemented, and these first two options were hidden. There
> > were
> > also no description for any options, so I thought it was not needed. Maybe
> > we
> > could update this file too ?
> 
> Yeah, I don't think it's that bad to hide them, and perhaps consistency
> with receive-pack is better.

IIRC, part of the reason receive-pack has hidden options is that it was a
GSoC microproject, and writing an accurate description is much harder than
what we expect from a microproject.

IOW, I'm all for un-hiding these options, but that shouldn't be a requirement
for a beginner's project.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
