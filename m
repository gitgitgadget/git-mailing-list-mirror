From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFH] An early draft of v1.5.0 release notes
Date: Wed, 27 Dec 2006 12:54:09 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612271251060.19693@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7vvejx948y.fsf@assigned-by-dhcp.cox.net> <emtgps$f1q$1@sea.gmane.org>
 <7v1wml8wmw.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 27 12:54:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GzXMP-0007NZ-1h
	for gcvg-git@gmane.org; Wed, 27 Dec 2006 12:54:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932425AbWL0LyN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Dec 2006 06:54:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932765AbWL0LyN
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Dec 2006 06:54:13 -0500
Received: from mail.gmx.net ([213.165.64.20]:39108 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932707AbWL0LyL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Dec 2006 06:54:11 -0500
Received: (qmail invoked by alias); 27 Dec 2006 11:54:09 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp051) with SMTP; 27 Dec 2006 12:54:09 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v1wml8wmw.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35463>

Hi,

On Wed, 27 Dec 2006, Junio C Hamano wrote:

> Jakub Narebski <jnareb@gmail.com> writes:
> 
> > I don't quite like it. Why if someone uses different encoding
> > that utf-8 because his terminal is not set to utf-8? Having suddenly
> > what looks like garbage on output, while input was in local encoding
> > (and specified in i18n.commitencoding) is a bit suprising...
> 
> If Luben wants UTF-8 in his project, but somebody he pulled from was 
> mistakenly used latin-1, then the commit pulled record latin-1 while 
> Luben has i18n.commitencoding in his repository set to UTF-8.  Output 
> will be done in UTF-8 for Luben.  For the originator of that latin-1 
> commit, i18n.commitencoding says latin-1 (and that was the only reason 
> he managed to create such a commit) and git show of that commit would 
> not involve recoding.

I think that this is a misunderstanding. Maybe the config variable is 
misnamed. As is clearly visible from the commit messages, this whole stuff 
is meant to reencode to whatever encoding the caller of git-log likes, not 
just UTF-8. And it defaults to UTF-8, overridable by i18n.commitEncoding.

BTW I think that latin-1 is not a valid encoding name (at least in my 
setup it isn't), so we should rather talk about iso-8859-1.

Ciao,
Dscho
