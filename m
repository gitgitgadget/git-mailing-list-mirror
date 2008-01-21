From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] http-push: making HTTP push more robust and more
 user-friendly
Date: Mon, 21 Jan 2008 12:17:10 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0801211212010.5731@racer.site>
References: <1200250979-19604-1-git-send-email-gb@gbarbier.org> <7vbq7ppbyh.fsf@gitster.siamese.dyndns.org> <47946F67.5060601@gbarbier.org> <7vmyqzzdhf.fsf@gitster.siamese.dyndns.org> <47947399.3000507@gbarbier.org>
 <7vabmzzbcc.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463811741-517187996-1200917831=:5731"
Cc: =?ISO-8859-15?Q?Gr=E9goire_Barbier?= <devel@gbarbier.org>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 21 13:18:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JGvbB-00031V-76
	for gcvg-git-2@gmane.org; Mon, 21 Jan 2008 13:17:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759230AbYAUMR1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2008 07:17:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759226AbYAUMR1
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jan 2008 07:17:27 -0500
Received: from mail.gmx.net ([213.165.64.20]:52286 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1759206AbYAUMR0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jan 2008 07:17:26 -0500
Received: (qmail invoked by alias); 21 Jan 2008 12:17:24 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp058) with SMTP; 21 Jan 2008 13:17:24 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/Z2H8EQ8TZXKLsQLKmzqae4G33BG3p4VhaHtAR9b
	Twu0isO6GRYnio
X-X-Sender: gene099@racer.site
In-Reply-To: <7vabmzzbcc.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71276>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463811741-517187996-1200917831=:5731
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT

Hi,

On Mon, 21 Jan 2008, Junio C Hamano wrote:

> Grégoire Barbier <devel@gbarbier.org> writes:
> 
> > Junio C Hamano a écrit :
> >> Thanks for correction.  I need to update Release Notes...
> >
> > Curl 7.16 has been released in october 2006 
> > (http://curl.haxx.se/changes.html), rather than 2003 like for 7.10.
> >
> > The consequences is that a lot of not so old distributions may be 
> > concerned. I only checked Fedora, which does not provide curl > 7.15 
> > before Fedora 7 (issued late may 2007).
> >
> > (BTW you may guess well that I'm using a Fedora Core 6 for my git 
> > patches...)
> 
> Now, that means the patch is not quite good for 1.5.4, and if we want to 
> keep http-push alive (I do not very much care about it myself, though), 
> and make it usable, we would need to fix it for non MULTI case.

IMHO it is safer to disable it for curl < 7.0xa -- even if it affects a 
number of distros -- than to give the illusion that it works, when it does 
not.

As for fixing it in the non-MULTI case, I have a hunch that Mike's 
cleanups will help that, but that this is a 1.5.5 feature.

So, I would like to read in the ReleaseNotes something like this:

-- snip --
Support for pushing via HTTP was broken with curl versions prior to 7.16, 
so we disabled it for now.  However, it is likely that a major cleanup of 
the http transport code -- scheduled after the release of git 1.5.4 -- 
will be supported with more curl versions.
-- snap --

Ciao,
Dscho

---1463811741-517187996-1200917831=:5731--
