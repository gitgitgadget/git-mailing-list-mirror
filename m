From: Ian Jackson <ijackson@chiark.greenend.org.uk>
Subject: Re: [PATCH v2] ident: check /etc/mailname if email is unknown
Date: Mon, 3 Oct 2011 12:32:17 +0100
Message-ID: <20105.40257.351258.425389@chiark.greenend.org.uk>
References: <20111003045745.GA17604@elie>
	<7v8vp2iqvc.fsf@alter.siamese.dyndns.org>
	<20111003061633.GB17289@elie>
	<4E895FBD.8020904@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Matt Kraai <kraai@ftbfs.org>, Gerrit Pape <pape@smarden.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Oct 03 13:52:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RAh4c-000261-HJ
	for gcvg-git-2@lo.gmane.org; Mon, 03 Oct 2011 13:52:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754170Ab1JCLwi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Oct 2011 07:52:38 -0400
Received: from chiark.greenend.org.uk ([212.13.197.229]:56926 "EHLO
	chiark.greenend.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753378Ab1JCLwh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Oct 2011 07:52:37 -0400
X-Greylist: delayed 1213 seconds by postgrey-1.27 at vger.kernel.org; Mon, 03 Oct 2011 07:52:37 EDT
Received: by chiark.greenend.org.uk (Debian Exim 4.69 #1) with local
	(return-path ijackson@chiark.greenend.org.uk)
	id 1RAgkr-0002rQ-G0; Mon, 03 Oct 2011 12:32:17 +0100
In-Reply-To: <4E895FBD.8020904@viscovery.net>
X-Mailer: VM 8.0.9 under Emacs 22.2.1 (i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182656>

Johannes Sixt writes ("Re: [PATCH v2] ident: check /etc/mailname if email is unknown"):
> Am 10/3/2011 8:16, schrieb Jonathan Nieder:
> > +static int add_mailname_host(char *buf, size_t len)
> > +{
> > +	FILE *mailname;
> > +
> > +	mailname = fopen("/etc/mailname", "r");
> > +	if (!mailname) {
> > +		if (errno != ENOENT)
> > +			warning("cannot open /etc/mailname: %s",
> > +				strerror(errno));
> 
> This warns on EACCES. Is that OK? (Just asking, I have no opinion.)

I think that's correct.  Personally I'm a bit of an error handling
fascist and I would have it crash on EACCES but that's probably a bit
harsh.

Certainly this file ought to be generally readable, if it exists.

Ian.
