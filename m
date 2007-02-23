From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH for "next"] pretty-formats: add 'format:<string>'
Date: Fri, 23 Feb 2007 12:48:07 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702231237500.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <87k61yt1x2.wl%cworth@cworth.org> <455A1137.8030301@shadowen.org>
 <87hcx1u934.wl%cworth@cworth.org> <Pine.LNX.4.64.0611141518590.2591@xanadu.home>
 <87bqn9u43s.wl%cworth@cworth.org> <ejdcg5$4fl$1@sea.gmane.org>
 <Pine.LNX.4.64.0611141633430.2591@xanadu.home> <7vbqn9y6w6.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0611142007010.2591@xanadu.home> <7v3b8ltq7r.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0611142306090.2591@xanadu.home> <Pine.LNX.4.64.0611150950170.3349@woody.osdl.org>
 <455BBCE9.4050503@xs4all.nl> <Pine.LNX.4.64.0611151908130.3349@woody.osdl.org>
 <455C412D.1030408@xs4all.nl> <7v7ixvbq80.fsf@assigned-by-dhcp.cox.net>
 <455C618A.7080309@xs4all.nl> <ejkd6g$vog$1@sea.gmane.org> <4566E512.4010405@xs4all.nl>
 <Pine.LNX.4.63.0702230125270.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vslcx9ywx.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Han-Wen Nienhuys <hanwen@xs4all.nl>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Feb 23 12:48:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HKYuc-0002Fz-Rv
	for gcvg-git@gmane.org; Fri, 23 Feb 2007 12:48:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932178AbXBWLsL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Feb 2007 06:48:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932206AbXBWLsL
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Feb 2007 06:48:11 -0500
Received: from mail.gmx.net ([213.165.64.20]:38043 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932178AbXBWLsJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Feb 2007 06:48:09 -0500
Received: (qmail invoked by alias); 23 Feb 2007 11:48:07 -0000
X-Provags-ID: V01U2FsdGVkX1+ye2V6AsSy7yx0g8OR9wPt6YWtrPZtydecjremuz
	RzgA==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <7vslcx9ywx.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40442>

Hi,

On Thu, 22 Feb 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > With this patch,
> >
> > $ git show -s \
> > 	--pretty=format:'  Ze komit %h woss%n  dunn buy ze great %an'
> >
> > shows something like
> >
> >   Ze komit 04c5c88 woss
> >   dunn buy ze great Junio C Hamano
> 
> Does it say "This commit is by a fool whose name is blah"?

Vy, it iss korrekt Churmen Inklish [Translation: Why, it is correct 
German "English"]... ;-)

> > The supported placeholders are:
> >
> > 	'%H': commit hash
> >...
> > 	'%b': body
> 
> Hmmm.  Would we want to make them somehow interoperable with
> git-for-each-ref format atoms?

But those placeholders are so long! Not even GNU date supports such long 
placeholders... And I could not reuse interpolate.[ch] as is for that.

> Also, it _might_ be worthwhile to do something like "%+4b" which means 
> "indent each line of this field with 4 spaces", for a multi-line field 
> like "%b".

Same goes here: interpolate.[ch] does not (yet) allow for that.

> > 	'%Cred': switch color to red
> > 	'%Cgreen': switch color to green
> > 	'%Cblue': switch color to blue
> > 	'%Creset': reset color
> 
> Hmmm.  I strongly suspect that we would want to reuse code to grok 
> colors and attributes in color.c.

And again...

> > 	>   --format 'committer %c\nauthor %a\n'
> > 	>   
> > 	> this catches all combinations, and is easier for scripting.
> 
> I do not have strong preference between "\n" and "%n".

This would be easy, methink, to teach to interpolate().

Maybe I can overcome my laziness, and extend interpolate() so that it can 
actually call callbacks with callback data...

Alternatively, I could imitate for-each-ref, and roll my own 
interpolate()? :-)

Ciao,
Dscho
