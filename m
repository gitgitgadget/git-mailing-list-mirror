From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: Patch for NO_R_TO_GCC_LINKER
Date: Wed, 13 Aug 2008 13:32:59 +0200
Message-ID: <vpqtzdpcfpw.fsf@bauges.imag.fr>
References: <c475e2e60808130342r452fae1cm7d08d8d2206d0468@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Giovanni Funchal" <gafunchal@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 13 13:34:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTEcL-0006XC-JT
	for gcvg-git-2@gmane.org; Wed, 13 Aug 2008 13:34:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752778AbYHMLdM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Aug 2008 07:33:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752742AbYHMLdM
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Aug 2008 07:33:12 -0400
Received: from imag.imag.fr ([129.88.30.1]:32895 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752588AbYHMLdL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Aug 2008 07:33:11 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id m7DBWxxm018022
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 13 Aug 2008 13:32:59 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1KTEb5-0007LY-E5; Wed, 13 Aug 2008 13:32:59 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1KTEb5-0001Tq-Ax; Wed, 13 Aug 2008 13:32:59 +0200
In-Reply-To: <c475e2e60808130342r452fae1cm7d08d8d2206d0468@mail.gmail.com> (Giovanni Funchal's message of "Wed\, 13 Aug 2008 12\:42\:30 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Wed, 13 Aug 2008 13:32:59 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92209>

"Giovanni Funchal" <gafunchal@gmail.com> writes:

> Hi,

Hi Giovanni, glad to see you here ;-).

> I'm proposing the patch below

Please, read Documentation/SubmittingPatches.

I advise you to use git send-email to send your patches, this one has
(gmail-related) whitespace damage. Read about Signed-Off-By too.

> @@ -226,7 +226,8 @@ INSTALL = install
>  RPMBUILD = rpmbuild
>  TCL_PATH = tclsh
>  TCLTK_PATH = wish
> -
> +LD_RUNPATH_SWITCH = -Wl,-rpath,
> +

Whitespace damage: the - and the + are equal (I suppose you added a
trailing whitespace, which you shouldn't have, and gmail stripped it).

> -		CURL_LIBCURL = -L$(CURLDIR)/$(lib) $(CC_LD_DYNPATH)$(CURLDIR)/$(lib) -lcurl
> +		CURL_LIBCURL = -L$(CURLDIR)/$(lib)
> $(LD_RUNPATH_SWITCH)$(CURLDIR)/$(lib) -lcurl

Whitespace damage again.

> +      AC_MSG_ERROR([no linker support for runtime path to dynamic libraries])

I don't think you should error out here: Git can still be compiled and
can still run without this support (just use $LD_LIBRARY_PATH if
needed). Keeping -R with a big warning would avoid having a regression
in this case.

Thanks,

-- 
Matthieu
