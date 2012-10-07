From: Thomas Ackermann <th.acker66@arcor.de>
Subject: Aw: Re: [Patch 1/5] Fix some asciidoc layout problems
Date: Sun, 7 Oct 2012 10:01:00 +0200 (CEST)
Message-ID: <1013292233.101229.1349596860911.JavaMail.ngmail@webmail23.arcor-online.net>
References: <20121006191009.GB3644@sigill.intra.peff.net> <505841759.269631.1349538675925.JavaMail.ngmail@webmail08.arcor-online.net>
 <244418682.269701.1349538839518.JavaMail.ngmail@webmail08.arcor-online.net>
 <7vfw5rqwby.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: th.acker66@arcor.de, git@vger.kernel.org
To: peff@peff.net, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Oct 07 10:01:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TKlnc-0007L8-M2
	for gcvg-git-2@plane.gmane.org; Sun, 07 Oct 2012 10:01:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752086Ab2JGIBH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Oct 2012 04:01:07 -0400
Received: from mail-in-10.arcor-online.net ([151.189.21.50]:36123 "EHLO
	mail-in-10.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752008Ab2JGIBF (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 7 Oct 2012 04:01:05 -0400
Received: from mail-in-10-z2.arcor-online.net (mail-in-10-z2.arcor-online.net [151.189.8.27])
	by mx.arcor.de (Postfix) with ESMTP id 0B56C2D6935;
	Sun,  7 Oct 2012 10:01:01 +0200 (CEST)
Received: from mail-in-07.arcor-online.net (mail-in-07.arcor-online.net [151.189.21.47])
	by mail-in-10-z2.arcor-online.net (Postfix) with ESMTP id E1F7328A40E;
	Sun,  7 Oct 2012 10:01:00 +0200 (CEST)
Received: from webmail23.arcor-online.net (webmail23.arcor-online.net [151.189.8.121])
	by mail-in-07.arcor-online.net (Postfix) with ESMTP id DE448107B10;
	Sun,  7 Oct 2012 10:01:00 +0200 (CEST)
X-DKIM: Sendmail DKIM Filter v2.8.2 mail-in-07.arcor-online.net DE448107B10
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arcor.de; s=mail-in;
	t=1349596860; bh=ucOSGC3FVElRe5Q/WtJrDeqfgVrynn9zUYgXaJg/rnA=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	b=O6a/Mr9alGmKKK3Nnsq0MB37nioN/bZeprS2G1OMzKrWVZopNnOCCuRs6+wTQV0vH
	 AghaEiwRLn1Uh+2F3dIgLp+YHdDVw6/Sq42pPIqdTGvyMf22pwjHSbsw+ZlCXkakyE
	 p7ePyf0MOSiQ5wgEMgg9VcnfN8bnJ0fjMQCm8kE8=
Received: from [188.98.225.100] by webmail23.arcor-online.net (151.189.8.121) with HTTP (Arcor Webmail); Sun, 7 Oct 2012 10:01:00 +0200 (CEST)
In-Reply-To: <20121006191009.GB3644@sigill.intra.peff.net>
X-ngMessageSubType: MessageSubType_MAIL
X-WebmailclientIP: 188.98.225.100
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207177>

 
Making the dashed lines longer was unnecessary and I will remove this.

There were in general the following "layout problems" I encountered while trying to create git-doc.pdf:

- Wrong sectioning syntax (e.g. "===" instead of "---")
- Left-over shell scripting commands (in some release notes files)
- Over-long lines which caused very wide right margins in the resulting pdf

The later is the case here and I tried to fix this by either splitting the offending line in several lines
or removing as much spaces as possible.

I will be more specific about these things in my commit messages.


----- Original Nachricht ----
Von:     Jeff King <peff@peff.net>
An:      Junio C Hamano <gitster@pobox.com>
Datum:   06.10.2012 21:10
Betreff: Re: [Patch 1/5] Fix some asciidoc layout problems

> On Sat, Oct 06, 2012 at 11:39:13AM -0700, Junio C Hamano wrote:
> 
> > Thomas Ackermann <th.acker66@arcor.de> writes:
> > 
> > > Signed-off-by: Thomas Ackermann <th.acker@arcor.de>
> > > ---
> > >  Documentation/git-bisect-lk2009.txt | 12 ++++++------
> > >  Documentation/git-fetch-pack.txt    |  5 ++++-
> > >  2 files changed, 10 insertions(+), 7 deletions(-)
> > 
> > You didn't say what "layout problem" you are fixing, or what the
> > approach you took to "fix" it.  From the patch, I can guess that the
> > latter is to lengthen the lines that surround the displayed examples,
> > but as far as I know and can tell, the existing ones are long enough
> > so I cannot tell why you needed such a change to the source in the
> > first place.
> > 
> > A better explanation, please?
> 
> I had the same question. Also, some of the lines convert tabs in literal
> output into spaces, which is actively wrong (or maybe they were
> converted already to spaces in the current code, but they should at
> least align with 8-space tabstops):
> 
> > > -:100644 100644 5cf8258195331a4dbdddff08b8d68642638eea57
> 4492984efc09ab72ff6219a7bc21fb6a957c4cd5 M      Makefile
> > > +:100644 100644 5cf8258195331a4dbdddff08b8d68642638eea57
> 4492984efc09ab72ff6219a7bc21fb6a957c4cd5 M  Makefile
> 
> -Peff
> 

---
Thomas
