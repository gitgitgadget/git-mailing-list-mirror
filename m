From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Be nice with compilers that do not support runtime paths
 at all.
Date: Mon, 22 Oct 2007 11:52:56 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710221149530.25221@racer.site>
References: <7vsl4rdgf4.fsf@gitster.siamese.dyndns.org>
 <1191450052-23619-1-git-send-email-tsuna@lrde.epita.fr>
 <7vejgbdbyn.fsf@gitster.siamese.dyndns.org> <34DAC3CA-E226-4488-8B03-FC45A6A95F78@lrde.epita.fr>
 <09169ECD-19E1-44D1-8539-71EBBA3826A8@lrde.epita.fr> <20071022064454.GV14735@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Benoit SIGOURE <tsuna@lrde.epita.fr>,
	git list <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Oct 22 12:53:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ijuub-0004g6-DM
	for gcvg-git-2@gmane.org; Mon, 22 Oct 2007 12:53:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752411AbXJVKxU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Oct 2007 06:53:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752276AbXJVKxU
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Oct 2007 06:53:20 -0400
Received: from mail.gmx.net ([213.165.64.20]:41956 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752066AbXJVKxT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Oct 2007 06:53:19 -0400
Received: (qmail invoked by alias); 22 Oct 2007 10:53:17 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp036) with SMTP; 22 Oct 2007 12:53:17 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18lSHp+YL0laB3N1BaWbSFqwJZ/5KMkECnNkE5QMm
	FSFq1Xmz4jhJOX
X-X-Sender: gene099@racer.site
In-Reply-To: <20071022064454.GV14735@spearce.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61985>

Hi,

On Mon, 22 Oct 2007, Shawn O. Pearce wrote:

> Benoit SIGOURE <tsuna@lrde.epita.fr> wrote:
> > >On Oct 4, 2007, at 1:18 AM, Junio C Hamano wrote:
> > >>Benoit Sigoure <tsuna@lrde.epita.fr> writes:
> > >>
> > >>If we do not care about supporting too old GNU make, we can do
> > >>this by first adding this near the top:
> > >>
> > >>        ifndef NO_RPATH
> > >>        LINKER_PATH = -L$(1) $(CC_LD_DYNPATH)$(1)
> > >>        else
> > >>        LINKER_PATH = -L$(1)
> > >>        endif
> > >>
> > >>and then doing something like:
> > >>
> > >>	CURL_LIBCURL = $(call LINKER_PATH,$(CURLDIR)/$(lib))
> > >>	OPENSSL_LINK = $(call LINKER_PATH,$(OPENSSLDIR)/$(lib))
> > >>
> > >>to make it easier to read and less error prone.
> > >
> > >Yes.  I can rework the patch, but the question is: do you care  
> > >about old GNU make?  Can I rewrite the patch with this feature?
> > 
> > I know Junio is still offline but maybe someone else has an objection 
> > against this?
> 
> How old of a GNU make are talking about here?  The above is certainly a 
> lot nicer to read, but I'd hate to suddenly ship a new Git that someone 
> cannot compile because their GNU make is too old.

I seem to remember remember that we had some shell quoting in the 
Makefile, and it was "call"ed.  That broke some setups, so we got rid of 
it.

*starting "git log -Scall Makefile"*: yep.  It even was me fixing it, in 
39c015c556f285106931e0500f301de462b0e46e.

Ciao,
Dscho
