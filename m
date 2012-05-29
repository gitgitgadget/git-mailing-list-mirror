From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: "docs: stop using asciidoc no-inline-literal" breaks asciidoc 8.2.5
Date: Wed, 30 May 2012 00:42:32 +0200
Message-ID: <CACBZZX6a2BQVhe8-X5o+WnfbsrqPKa_Cn93GZ1bbq1TLezB97Q@mail.gmail.com>
References: <CACBZZX7Y-NTzRP1KYy=eEHTsLHTrzxGms61anXSHVbyCSPgurw@mail.gmail.com>
 <87ehq3mbxg.fsf@thomas.inf.ethz.ch> <CACBZZX5iOB5PCZUCX5ksR4hpw+DTLTaP4jOnyHAJ8hZVe9xo5w@mail.gmail.com>
 <20120529215613.GB17598@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Thomas Rast <trast@inf.ethz.ch>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>,
	=?UTF-8?Q?Carlos_Mart=C3=ADn_Nieto?= <cmn@elego.de>,
	Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed May 30 00:43:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SZV7y-00087Q-Ao
	for gcvg-git-2@plane.gmane.org; Wed, 30 May 2012 00:42:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753321Ab2E2Wmy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 May 2012 18:42:54 -0400
Received: from mail-gg0-f174.google.com ([209.85.161.174]:61640 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752668Ab2E2Wmx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 May 2012 18:42:53 -0400
Received: by gglu4 with SMTP id u4so3026802ggl.19
        for <git@vger.kernel.org>; Tue, 29 May 2012 15:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=c/lFBPmtygU4im4KWSTTCjc/bjLgD3r7FBFMGeVOhdQ=;
        b=m8c6qlt4drM/beUB5+W1y6RAXAde8L9a/WAv+ta58SgKv/tId8BEnpyFvQ/4DIyHnp
         RutovtSNbLrsEGV/nf4mpJ1muvUNHlmBz8jwlmmbUnMx9qYlX5o9WHw6PHqOqnOY7rnv
         ltrII/LnKCgR0AtKsGkFJOGQtBGzxVfWktZSTtotSKoAbOEfxD4VxVon6e0XDYjoc++T
         4ylwzKZIg0qqWMpJkpLDX7xuoWD7Izy6Rs199224lhACcraz0Z15M3G1Tx6Qfftv7181
         f61Gw75mZctmjUH3qTrO9Qmu3KEDSyXJt/frAQnIxmrObEDiaNYN4FQjXvGcodCZnLhW
         UPyg==
Received: by 10.60.14.169 with SMTP id q9mr13271595oec.19.1338331372810; Tue,
 29 May 2012 15:42:52 -0700 (PDT)
Received: by 10.182.167.65 with HTTP; Tue, 29 May 2012 15:42:32 -0700 (PDT)
In-Reply-To: <20120529215613.GB17598@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198771>

On Tue, May 29, 2012 at 11:56 PM, Jeff King <peff@peff.net> wrote:

> I'm very sympathetic to having platform support dropped. It's annoying
> for the user. But given that it's a 3rd-party install anyway (and you
> can install a newer 3rd-party RPM), and that you can additionally use
> "make quick-install-man" to avoid needing asciidoc entirely, and given
> the sheer number of bugs this patch fixes (and prevents), to me the
> balance still argues for keeping the patch.

To be clear I like the patch, I was just suggesting that we might want
to hold it off for a bit.

Anyway, I've tested dropping asciidoc.py from the source distribution
into compat/asciidoc.py and doing "make doc
ASCIIDOC=../compat/asciidoc.py", it seems to work.

I wonder if the easiest solution is to change the default asciidoc
invocation from "asciidoc" to a small Documentation/asciidoc.sh script
that we supply, it would check if there's an asciidoc present on the
system, whether it's sufficiently new, and if not fall back on a copy
we have in compat/.
