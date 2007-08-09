From: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
Subject: Re: [GUILT PATCH 2/5] guilt-guard: Assign guards to patches in
	series
Date: Thu, 9 Aug 2007 09:47:15 -0400
Message-ID: <20070809134715.GA22563@filer.fsl.cs.sunysb.edu>
References: <1185851481190-git-send-email-eclesh@ucla.edu> <1185851481271-git-send-email-eclesh@ucla.edu> <20070731040510.GD12918@filer.fsl.cs.sunysb.edu> <87bqdhnotj.fsf@hubert.paunchy.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Eric Lesh <eclesh@ucla.edu>
X-From: git-owner@vger.kernel.org Thu Aug 09 15:47:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJ8MN-0006Se-UW
	for gcvg-git@gmane.org; Thu, 09 Aug 2007 15:47:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765303AbXHINrZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Aug 2007 09:47:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933079AbXHINrZ
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Aug 2007 09:47:25 -0400
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:53124 "EHLO
	filer.fsl.cs.sunysb.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1765071AbXHINrY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Aug 2007 09:47:24 -0400
Received: from filer.fsl.cs.sunysb.edu (localhost.localdomain [127.0.0.1])
	by filer.fsl.cs.sunysb.edu (8.12.11.20060308/8.13.1) with ESMTP id l79DlFnV023036;
	Thu, 9 Aug 2007 09:47:15 -0400
Received: (from jsipek@localhost)
	by filer.fsl.cs.sunysb.edu (8.12.11.20060308/8.13.1/Submit) id l79DlFY1023034;
	Thu, 9 Aug 2007 09:47:15 -0400
X-Authentication-Warning: filer.fsl.cs.sunysb.edu: jsipek set sender to jsipek@fsl.cs.sunysb.edu using -f
Content-Disposition: inline
In-Reply-To: <87bqdhnotj.fsf@hubert.paunchy.net>
User-Agent: Mutt/1.5.16 (2007-07-16)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55451>

On Thu, Aug 09, 2007 at 12:34:48AM -0700, Eric Lesh wrote:
> [ I'm finally back to this.  Thanks for your comments. ]

Good. I was starting to get worried :)

> Josef Sipek <jsipek@fsl.cs.sunysb.edu> writes:
> 
> [...]
> 
> >> +}
> >> +
> >> +# usage: set_guards <patch> <guards...>
> >> +set_guards()
> >> +{
> >> +	p="$1"
> >
> > Again, be careful about namespace polution.
> >
> 
> Can I use "local", or is it a bashism?  If not, use parentheses around
> the function body?

Right, "local" is a bashism therefore you must use a subshell (paretheses).

> >> +	shift
> >> +	for x in "$@"; do
> >> +		if [ -z $(printf %s "$x" | grep -e "^[+-]") ]; then
> >
> > Out of curiosity, why printf and not echo?
> >
> 
> For guards named '-e' or other funky things echo doesn't like and can't
> process with echo --.

Good enough reason :)

...
> I'm trying to clean the rest and get it ready again. This whole series
> will definitely need to incubate for a while once there's a
> reasonable-looking version, to make sure nothing goes crazy.  Hopefully
> it ends up being useful somewhere!

I'd use it at times. For certain scenarios (2 series that are mostly
identical) using guards makes more sense than different branches.

Thanks,

Josef 'Jeff' Sipek.

-- 
Humans were created by water to transport it upward.
