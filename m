From: Jeff King <peff@peff.net>
Subject: Re: git imap-send converting my patches to CRLF line endings?
Date: Fri, 17 Jun 2011 11:02:15 -0400
Message-ID: <20110617150215.GA11946@sigill.intra.peff.net>
References: <BANLkTimXQQX_Fu0fgtWneF2cCLUZFhTaCg@mail.gmail.com>
 <20110617141450.GA12114@sigill.intra.peff.net>
 <QMrPJrj9ztlKRRk907LM0hozdFOSLjShMt2uDhbAk6DGxE1OSBFMkg@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Mc Donnell <michael@mcdonnell.dk>, git@vger.kernel.org
To: Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Fri Jun 17 17:02:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QXaYz-0001Hv-9j
	for gcvg-git-2@lo.gmane.org; Fri, 17 Jun 2011 17:02:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932073Ab1FQPCT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Jun 2011 11:02:19 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:53134
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752573Ab1FQPCS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jun 2011 11:02:18 -0400
Received: (qmail 26405 invoked by uid 107); 17 Jun 2011 15:02:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 17 Jun 2011 11:02:29 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 17 Jun 2011 11:02:15 -0400
Content-Disposition: inline
In-Reply-To: <QMrPJrj9ztlKRRk907LM0hozdFOSLjShMt2uDhbAk6DGxE1OSBFMkg@cipher.nrlssc.navy.mil>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175951>

On Fri, Jun 17, 2011 at 09:47:17AM -0500, Brandon Casey wrote:

> > The canonical line ending for mail is CRLF. So yes, it will convert your
> > patch to CRLF for storage. But anything pulling it out of the IMAP
> > folder should convert it back to native line endings.
> 
> Not always.  Modern thunderbird (3.1.10, is that modern? I haven't
> checked), saves mail using CRLF.  I don't have access to gmail at the
> moment, but I'm pretty sure gmail does the same thing, i.e. when you
> select "view original", and then use your browser to "save as...".
> 
> mailsplit was modified to strip CRLF when splitting mail here:
> 
>   c2ca1d7 Allow mailsplit (and hence git-am) to handle mails with CRLF line-endings
> 
> which should have first appeared in git v1.6.5.

Ah, I forgot about that. I am used to unix-y tools like mutt. But it is
obviously sensible for git to accept canonical mail via am, given that
some clients produce it.

> > How do you download and apply the patch exactly? If you are speaking
> > imap to gmail, generally the client would strip out the CR's from the
> > mail.
> 
> Michael, how are you applying the "email"?  Are you using 'git am'? or
> possibly are you trying to use 'git apply'?  You need to use 'git am'.

In another reply that crossed paths with yours, he wrote:

  5. Apply patch on a fresh branch with git apply.

So yeah, I think that is the problem.

-Peff
