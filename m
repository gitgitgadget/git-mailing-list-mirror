From: Thomas Ackermann <th.acker66@arcor.de>
Subject: Aw: Re: [Patch 0/5] Create single PDF for all HTML files
Date: Sun, 7 Oct 2012 10:14:28 +0200 (CEST)
Message-ID: <1770841099.101310.1349597668191.JavaMail.ngmail@webmail23.arcor-online.net>
References: <20121006193205.GD3644@sigill.intra.peff.net> <505841759.269631.1349538675925.JavaMail.ngmail@webmail08.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: peff@peff.net, th.acker66@arcor.de
X-From: git-owner@vger.kernel.org Sun Oct 07 10:16:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TKm2L-0003Xs-Uf
	for gcvg-git-2@plane.gmane.org; Sun, 07 Oct 2012 10:16:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752094Ab2JGIOd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Oct 2012 04:14:33 -0400
Received: from mail-in-13.arcor-online.net ([151.189.21.53]:49625 "EHLO
	mail-in-13.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751975Ab2JGIO3 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 7 Oct 2012 04:14:29 -0400
Received: from mail-in-16-z2.arcor-online.net (mail-in-16-z2.arcor-online.net [151.189.8.33])
	by mx.arcor.de (Postfix) with ESMTP id 35F7821246D;
	Sun,  7 Oct 2012 10:14:28 +0200 (CEST)
Received: from mail-in-08.arcor-online.net (mail-in-08.arcor-online.net [151.189.21.48])
	by mail-in-16-z2.arcor-online.net (Postfix) with ESMTP id 30ED63FEEF4;
	Sun,  7 Oct 2012 10:14:28 +0200 (CEST)
Received: from webmail23.arcor-online.net (webmail23.arcor-online.net [151.189.8.121])
	by mail-in-08.arcor-online.net (Postfix) with ESMTP id 2F1113AED37;
	Sun,  7 Oct 2012 10:14:28 +0200 (CEST)
X-DKIM: Sendmail DKIM Filter v2.8.2 mail-in-08.arcor-online.net 2F1113AED37
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arcor.de; s=mail-in;
	t=1349597668; bh=msDQe8oGela3zBVTbk3paN3wQk9Xi+aOMsf4fd6LlTo=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	b=rEeiHEckBsGpa8F0i5dEVd4mxfYjBu9x4btFAzgnl9LFcN1Ijgf4sPc4rHUW2yZop
	 iHu6Z7ziGImmrHHCfzbaEsEW2dTttVAfACQfNLjBEsDHejk+YNctqtDiU1UQrPaqOB
	 Ju6vXNQ2yZS7dUh539VCr32oxJAv6llURMxqNNhU=
Received: from [188.98.225.100] by webmail23.arcor-online.net (151.189.8.121) with HTTP (Arcor Webmail); Sun, 7 Oct 2012 10:14:27 +0200 (CEST)
In-Reply-To: <20121006193205.GD3644@sigill.intra.peff.net>
X-ngMessageSubType: MessageSubType_MAIL
X-WebmailclientIP: 188.98.225.100
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207178>


There are "patched QT" and "unpatched QT" versions of wkhtmltopdf
(see http://code.google.com/p/wkhtmltopdf/). I am using V0.9.9 for Windows
which is "patched QT".

There is one drawback with wkhtmltopdf: At least on my Netbook (Win7 64bit,
Pentium 1.5GHz) it is very slow. It takes more than 3 hrs to create git-doc.pdf.

If you want to have a quick look on the resulting pdf just clone 
https://github.com/tacker66/git-docpdf.git. This repo contains
a current version of user.manual.pdf and git-doc.pdf 


----- Original Nachricht ----
Von:     Jeff King <peff@peff.net>
An:      Thomas Ackermann <th.acker66@arcor.de>
Datum:   06.10.2012 21:32
Betreff: Re: [Patch 0/5] Create single PDF for all HTML files

> On Sat, Oct 06, 2012 at 05:51:15PM +0200, Thomas Ackermann wrote:
> 
> > I wanted to have a single PDF file which contains the complete Git
> documentation 
> > (except user-manual) for easier reading on my tablet. The simplest way to
> do 
> > this was by using wkhtmltopdf which can combine a set of HTML files into a
> sinlge 
> > PDF file and also apply some reformatting. To this end HTML files for all
> the missing 
> > files in Documentation/technical and Documentation/howto and also for all
> the 
> > release notes in Documentation/RelNotes were created. 
> 
> It seems like a reasonable goal. I do not have a strong opinion on the
> approach or how the final output looks, but I wasn't able to actually
> get output at all after applying your patches. Running "make fullpdf"
> (after installing dblatex) got me:
> 
>   The switch --book, is not support using unpatched qt, and will be
>   ignored.The switch --footer-html, is not support using unpatched qt,
>   and will be ignored.The switch --disable-external-links, is not
>   support using unpatched qt, and will be ignored.
> 
> after which wkhtmltopdf began pegging my CPU. I let it run for 10
> minutes before giving up.
> 
> Another way of doing this would be to format the individual troff
> manpages into dvi or postscript, convert that into pdf, and then
> concatenate that. Something like:
> 
>   for i in *.[157]; do
>     man -Tdvi -l "$i" >"$i.dvi"
>     dvipdfm "$i"
>   done
>   pdftk *.[157].pdf cat output full.pdf
> 
> works for me, though obviously that does not handle some of the non-man
> items you included. No idea on how the output compares to yours, but
> it's something you may want to look at.
> 
> -Peff
> 

---
Thomas
