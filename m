From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: [PATCH v2 1/4] config: factor out config file stack management
Date: Thu, 14 Mar 2013 07:36:30 +0100
Message-ID: <20130314063629.GA4062@sandbox-ub.fritz.box>
References: <20130310165642.GA1136@sandbox-ub.fritz.box>
 <20130310165752.GB1136@sandbox-ub.fritz.box>
 <20130312105200.GC11340@sigill.intra.peff.net>
 <20130312154434.GB3021@sandbox-ub.fritz.box>
 <20130312190456.GC17099@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jens Lehmann <jens.lehmann@web.de>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 14 07:37:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UG1mj-0003YV-LP
	for gcvg-git-2@plane.gmane.org; Thu, 14 Mar 2013 07:37:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754275Ab3CNGgi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Mar 2013 02:36:38 -0400
Received: from smtprelay01.ispgateway.de ([80.67.31.24]:39945 "EHLO
	smtprelay01.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753781Ab3CNGgh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Mar 2013 02:36:37 -0400
Received: from [77.21.76.82] (helo=localhost)
	by smtprelay01.ispgateway.de with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1UG1mA-00074i-SN; Thu, 14 Mar 2013 07:36:31 +0100
Content-Disposition: inline
In-Reply-To: <20130312190456.GC17099@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218117>

On Tue, Mar 12, 2013 at 03:04:56PM -0400, Jeff King wrote:
> On Tue, Mar 12, 2013 at 04:44:35PM +0100, Heiko Voigt wrote:
> 
> > > Can we throw in a comment at the top here with the expected usage? In
> > > particular, do_config_from is expecting the caller to have filled in
> > > certain fields (at this point, top->f and top->name), but there is
> > > nothing to make that clear.
> > 
> > Of course. Will do that in the next iteration. How about I squash this in:
> > [...]
> > +/* The fields data, name and the source specific callbacks of top need
> > + * to be initialized before calling this function.
> > + */
> >  static int do_config_from_source(struct config_source *top, config_fn_t fn, voi
> 
> I think that is OK, but it may be even better to list the fields by
> name. Also, our multi-line comment style is:
> 
>   /*
>    * Multi-line comment.
>    */

Ok will do both.

> > I would add that to the third patch:
> > 
> > 	config: make parsing stack struct independent from actual data source
> > 
> > because that contains the final modification to config_file/config_source.
> 
> It does not matter to the end result, but I find it helps with reviewing
> when the comment is added along with the function, and then expanded as
> the function is changed. It helps to understand the effects of later
> patches if they need to tweak comments.

To make the series more clear to others who read it later, I will add
the comment from the beginning.

Cheers Heiko
