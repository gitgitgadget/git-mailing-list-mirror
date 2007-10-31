From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [GIT-GUI PATCH 2/3] po2msg: ignore untranslated messages
Date: Wed, 31 Oct 2007 02:23:16 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0710310222110.4362@racer.site>
References: <Pine.LNX.4.64.0710301122300.4362@racer.site>
 <Pine.LNX.4.64.0710301124450.4362@racer.site> <7vabq0l7wn.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: stimming@tuhh.de, spearce@spearce.org, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 31 03:24:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1In3Ff-0000lD-G6
	for gcvg-git-2@gmane.org; Wed, 31 Oct 2007 03:24:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752510AbXJaCYA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2007 22:24:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752287AbXJaCYA
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Oct 2007 22:24:00 -0400
Received: from mail.gmx.net ([213.165.64.20]:35548 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751616AbXJaCX7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2007 22:23:59 -0400
Received: (qmail invoked by alias); 31 Oct 2007 02:23:57 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp044) with SMTP; 31 Oct 2007 03:23:57 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/UuAsqAHLUrCTytqxGrEOQZItu9EuouN0mOy5ckH
	Rwc5QeL/X8fZH7
X-X-Sender: gene099@racer.site
In-Reply-To: <7vabq0l7wn.fsf@gitster.siamese.dyndns.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62783>

Hi,

On Tue, 30 Oct 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > Do not generate translations when the translated message is empty.
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >  po/po2msg.sh |    3 +++
> >  1 files changed, 3 insertions(+), 0 deletions(-)
> >
> > diff --git a/po/po2msg.sh b/po/po2msg.sh
> > index 48a2669..91d420b 100644
> > --- a/po/po2msg.sh
> > +++ b/po/po2msg.sh
> > @@ -62,6 +62,9 @@ proc flush_msg {} {
> >  	if {$msgid == ""} {
> >  		set prefix "set ::msgcat::header"
> >  	} else {
> > +		if {$msgstr == ""} {
> > +			return
> > +		}
> >  		set prefix "::msgcat::mcset $lang \"[u2a $msgid]\""
> >  	}
> 
> Is this change to fix some real issues?

Yes.  I compared the output of po2msg.sh with that of msgfmt, and only 
with this change (and 1/3) they came up identical.

Ciao,
Dscho
