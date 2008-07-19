From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: What's cooking in git.git (topics)
Date: Sat, 19 Jul 2008 13:19:46 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0807191311220.3305@eeepc-johanness>
References: <7vr69r8sqk.fsf@gitster.siamese.dyndns.org> <7vlk01hqzz.fsf@gitster.siamese.dyndns.org> <20080718175040.6117@nanako3.lavabit.com> <20080718182010.6117@nanako3.lavabit.com> <7v63r38r4r.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0807181351370.3932@eeepc-johanness>
 <7vabge30dh.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Nanako Shiraishi <nanako3@lavabit.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 19 13:20:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKATr-0000PU-WD
	for gcvg-git-2@gmane.org; Sat, 19 Jul 2008 13:20:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752518AbYGSLTE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Jul 2008 07:19:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752513AbYGSLTD
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Jul 2008 07:19:03 -0400
Received: from mail.gmx.net ([213.165.64.20]:39680 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752305AbYGSLTB (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Jul 2008 07:19:01 -0400
Received: (qmail invoked by alias); 19 Jul 2008 11:18:58 -0000
Received: from 88-107-142-10.dynamic.dsl.as9105.com (EHLO eeepc-johanness.st-andrews.ac.uk) [88.107.142.10]
  by mail.gmx.net (mp042) with SMTP; 19 Jul 2008 13:18:58 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/nQY0TaYPnpTI3NALCPp2xxMY2TFznebO+/06QIo
	s/LXrDl3/ysQRt
X-X-Sender: user@eeepc-johanness
In-Reply-To: <7vabge30dh.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.59
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89106>

Hi,

On Fri, 18 Jul 2008, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > On Fri, 18 Jul 2008, Junio C Hamano wrote:
> >
> >> +The 'recursive' strategy can take the following options:
> >> +
> >> +ours;;
> >
> > You still have not addressed the issue that you can specify multiple 
> > strategies,...
> 
> Even though multiple -s parameters are supported, I know you have been 
> here long enough in git scene to remember how it came about.  I've seen 
> some third-party documents that talk about our ability to "try multiple 
> strategies and pick the best one" as one of the unique features, but 
> anybody who was there knows that it was just a failed experiment that we 
> did not bother removing.

I think that we made it hard for that experiment to succeed, by 
disallowing custom merge strategies.

See

http://git.or.cz/gitwiki/SoC2007Ideas#head-cfde15f16950c2579a89cc109762e911546e6fe3

for an idea that would make complete sense as a _fallback_ strategy.  
Fallback, because it is definitely too slow to be the default.

Yes, I agree, if all strategies fail, it is dubitable that we find a 
metric that will always find the "best" one.  But if one fails and the 
next one does not, it is obvious what is correct.

So I still feel that "-s subtree=<blabla>,recursive=theirs" would be a 
viable way to go.  And more intuitive than "-X".

I'll just ask Miklos what he thinks of the idea, and to write the patch if 
he likes it, once he's back from the saddle. :-)

Ciao,
Dscho
