From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] t1300: document some aesthetic failures of the config
 editor
Date: Fri, 29 Mar 2013 20:21:39 -0400
Message-ID: <20130330002139.GA32353@sigill.intra.peff.net>
References: <CAD7mMPW=jr6PaAc50h-Wpf42-UPrn0A5KmisqXNXqqLv78AEgg@mail.gmail.com>
 <20130329170032.GA3552@sigill.intra.peff.net>
 <87ip4ayvfn.fsf@linux-k42r.v.cablecom.net>
 <20130329172307.GA11099@sigill.intra.peff.net>
 <20130329175058.GA13506@sigill.intra.peff.net>
 <7vobe2nins.fsf@alter.siamese.dyndns.org>
 <20130329195155.GA19994@sigill.intra.peff.net>
 <7vvc8alzat.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Thomas Rast <trast@student.ethz.ch>,
	Phil Haack <haacked@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 30 01:22:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ULjYh-0000Vk-JV
	for gcvg-git-2@plane.gmane.org; Sat, 30 Mar 2013 01:22:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757365Ab3C3AVm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Mar 2013 20:21:42 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:48698 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757352Ab3C3AVm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Mar 2013 20:21:42 -0400
Received: (qmail 11818 invoked by uid 107); 30 Mar 2013 00:23:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 29 Mar 2013 20:23:29 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 29 Mar 2013 20:21:39 -0400
Content-Disposition: inline
In-Reply-To: <7vvc8alzat.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219546>

On Fri, Mar 29, 2013 at 01:35:22PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Here it is with the updated expectation. I don't care _that_ much, so if
> > you feel strongly and want to drop the first test, feel free.
> 
> As long as we are adding expect_failure without an immediate fix,
> let's document the ideal, with this patch on top.
> [...]
>  test_expect_failure 'unsetting the last key in a section removes header' '
>  	cat >.git/config <<-\EOF &&
> +	# some generic comment on the configuration file itself
> +	# a comment specific to this "section" section.
>  	[section]
>  	# some intervening lines
>  	# that should also be dropped
>  
>  	key = value
>  	EOF
>  
> -	>expect &&
> +	cat >expect <<-\EOF &&
> +	# some generic comment on the configuration file itself
> +	EOF

I think we may not attain that ideal without some natural language
processing of the comments. But hey, no reason not to shoot for the
stars. :)

-Peff
