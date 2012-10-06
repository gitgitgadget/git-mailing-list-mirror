From: Jeff King <peff@peff.net>
Subject: Re: [Patch 5/5] Create pdf from all html files
Date: Sat, 6 Oct 2012 15:11:52 -0400
Message-ID: <20121006191152.GC3644@sigill.intra.peff.net>
References: <505841759.269631.1349538675925.JavaMail.ngmail@webmail08.arcor-online.net>
 <1206625172.269796.1349539081024.JavaMail.ngmail@webmail08.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Thomas Ackermann <th.acker66@arcor.de>
X-From: git-owner@vger.kernel.org Sat Oct 06 21:12:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TKZnC-0001l0-JL
	for gcvg-git-2@plane.gmane.org; Sat, 06 Oct 2012 21:12:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756228Ab2JFTL5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Oct 2012 15:11:57 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:43164 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755463Ab2JFTL4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Oct 2012 15:11:56 -0400
Received: (qmail 10073 invoked by uid 107); 6 Oct 2012 19:12:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 06 Oct 2012 15:12:28 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 06 Oct 2012 15:11:52 -0400
Content-Disposition: inline
In-Reply-To: <1206625172.269796.1349539081024.JavaMail.ngmail@webmail08.arcor-online.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207169>

On Sat, Oct 06, 2012 at 05:58:01PM +0200, Thomas Ackermann wrote:

> - use wkhtmltopdf to combine all html files into a single pdf file "git-doc.pdf"
> - provide make target "fullpdf" to create "git-doc.pdf"
> 
> Signed-off-by: Thomas Ackermann <th.acker@arcor.de>
> ---
>  Documentation/.gitignore      |  1 +
>  Documentation/Makefile        |  9 +++++++++
>  Documentation/footerend.txt   |  4 ++++
>  Documentation/footerstart.txt |  7 +++++++
>  Documentation/makedocpdf.sh   | 25 +++++++++++++++++++++++++
>  Makefile                      |  6 ++++++
>  6 files changed, 52 insertions(+)
>  create mode 100644 Documentation/footerend.txt
>  create mode 100644 Documentation/footerstart.txt
>  create mode 100644 Documentation/makedocpdf.sh

The makedocpdf script has no execute bit, but...

> diff --git a/Documentation/Makefile b/Documentation/Makefile
> index abd27b5..c4c2a30 100644
> --- a/Documentation/Makefile
> +++ b/Documentation/Makefile
> @@ -189,6 +189,9 @@ info: git.info gitman.info
>  
>  pdf: user-manual.pdf
>  
> +fullpdf: pdf all
> +	./makedocpdf.sh

Here we try to run it.

-Peff
