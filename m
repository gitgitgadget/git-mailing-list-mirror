From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] Makefile: Windows lacks /dev/tty
Date: Mon, 12 Dec 2011 16:18:02 -0500
Message-ID: <20111212211801.GA9754@sigill.intra.peff.net>
References: <20111210103943.GA16478@sigill.intra.peff.net>
 <20111210104130.GI16648@sigill.intra.peff.net>
 <4EE66DAB.5070407@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Mon Dec 12 22:18:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RaDGF-0005bm-1V
	for gcvg-git-2@lo.gmane.org; Mon, 12 Dec 2011 22:18:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754138Ab1LLVSH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Dec 2011 16:18:07 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:48324
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754028Ab1LLVSF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Dec 2011 16:18:05 -0500
Received: (qmail 5515 invoked by uid 107); 12 Dec 2011 21:24:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 12 Dec 2011 16:24:44 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 12 Dec 2011 16:18:02 -0500
Content-Disposition: inline
In-Reply-To: <4EE66DAB.5070407@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186954>

On Mon, Dec 12, 2011 at 10:10:03PM +0100, Johannes Sixt wrote:

> diff --git a/Makefile b/Makefile
> index 2c506b3..5b7f6a8 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1139,6 +1139,7 @@ ifeq ($(uname_S),Windows)
>  	NO_CURL = YesPlease
>  	NO_PYTHON = YesPlease
>  	BLK_SHA1 = YesPlease
> +	NO_DEV_TTY = YesPlease
>  	NO_POSIX_GOODIES = UnfortunatelyYes
>  	NATIVE_CRLF = YesPlease
>  
> @@ -1232,6 +1233,7 @@ ifneq (,$(findstring MINGW,$(uname_S)))
>  	ETAGS_TARGET = ETAGS
>  	NO_INET_PTON = YesPlease
>  	NO_INET_NTOP = YesPlease
> +	NO_DEV_TTY = YesPlease
>  	NO_POSIX_GOODIES = UnfortunatelyYes
>  	COMPAT_CFLAGS += -D__USE_MINGW_ACCESS -DNOGDI -Icompat -Icompat/win32
>  	COMPAT_CFLAGS += -DSTRIP_EXTENSION=\".exe\"

Unless I've bungled something, these should be no-ops, shouldn't they?
The most recent version of the prompt series has platforms opting into
the replacement with HAVE_DEV_TTY.

-Peff
