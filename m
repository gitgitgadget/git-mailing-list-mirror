From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Force new line at end of commit message
Date: Sun, 30 Dec 2007 11:26:49 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0712301124510.14355@wbgn129.biozentrum.uni-wuerzburg.de>
References: <87ve6ub3u7.fsf@gollum.intra.norang.ca> <8763yof9lg.fsf@gollum.intra.norang.ca>
 <Pine.LNX.4.64.0712241835210.14355@wbgn129.biozentrum.uni-wuerzburg.de>
 <20071225044202.GO14735@spearce.org> <7v4pe5nt8m.fsf@gitster.siamese.dyndns.org>
 <Pine.LNX.4.64.0712291426500.14355@wbgn129.biozentrum.uni-wuerzburg.de>
 <7vodc99gpy.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Bernt Hansen <bernt@alumni.uwaterloo.ca>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Dec 30 11:27:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J8vO2-00088Q-VP
	for gcvg-git-2@gmane.org; Sun, 30 Dec 2007 11:27:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751331AbXL3K0x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Dec 2007 05:26:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751292AbXL3K0x
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Dec 2007 05:26:53 -0500
Received: from mail.gmx.net ([213.165.64.20]:56791 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751246AbXL3K0w (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Dec 2007 05:26:52 -0500
Received: (qmail invoked by alias); 30 Dec 2007 10:26:50 -0000
Received: from wbgn128.biozentrum.uni-wuerzburg.de (EHLO wrzx67.rz.uni-wuerzburg.de) [132.187.25.128]
  by mail.gmx.net (mp028) with SMTP; 30 Dec 2007 11:26:50 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18/BEcr0eQ/xIZcH1G63pr5XgjhVQJ9+rXRwW3+DI
	q/9U9dRe5gksKF
X-X-Sender: gene099@wbgn129.biozentrum.uni-wuerzburg.de
In-Reply-To: <7vodc99gpy.fsf@gitster.siamese.dyndns.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69342>

Hi,

On Sat, 29 Dec 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> >>  		echo "# This is a combination of $COUNT commits."
> >> -		sed -n "2,\$p" < "$SQUASH_MSG"
> >> +		sed -e 1d -e '2,/^./{
> >> +			/^$/d
> >> +		}' <"$SQUASH_MSG"
> >
> > If I read this correctly (haven't tested), then _all_ empty lines are 
> > removed from the SQUASH_MSG, right?  This is not what I want.
> 
> That is no what I wanted either.
> 
> "1d" removes the "# This is a combination of <$n> commits." from
> the previous round, "2,/^./{ ... }" says apply what's in {} to
> lines from second line to the first non-empty line, and what's
> in {} is to remove empty ones.

Okay, so it removes only the empty lines between the first line and the 
next non-empty line.

But if I understood the OP correctly, the problem was a missing newline at 
the end of the commit message, no?

Thanks,
Dscho
