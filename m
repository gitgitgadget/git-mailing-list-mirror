From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] Documentation/Makefile: move infodir to be with other '*dir's
Date: Mon, 17 Jun 2013 13:14:51 -0700
Message-ID: <7vppvkbikk.fsf@alter.siamese.dyndns.org>
References: <4857ab4f4097c582063f064f657a8e5dfbfee232.1371402684.git.john@keeping.me.uk>
	<ffea107da7b3b7d5e390d27397d3a72155e942b4.1371402684.git.john@keeping.me.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Mon Jun 17 22:15:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UofpW-0001gB-Mn
	for gcvg-git-2@plane.gmane.org; Mon, 17 Jun 2013 22:15:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752453Ab3FQUPE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Jun 2013 16:15:04 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35079 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752397Ab3FQUPD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Jun 2013 16:15:03 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9B2E528376;
	Mon, 17 Jun 2013 20:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=TG6RaZQwKT4yCzhvt6PnwdMEH0k=; b=aOF1Av
	LvFEagXUnAog4NKUtSW1IlSFTmECS9qcuBq6AtB6oHxarucDk8ZssMD/1dkuFWZ9
	b9tUeLOWuMEild+yil2NvSceonjN9+aVEASEDWhrnlEYCpi+9Hvs67GsOh+pThJ9
	FRFXG8UY/aOHi8VOojn2OYexaNKWRA+OekK1o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LVHJrf91+eJS8tawguQz2EKtQwIu46jV
	qxEDUJNeEhNNVYoF9DNuwhGOHsdqgnxZZOfhkV9rZCulWMzoiWrUYkguzhZL8W3Q
	GCupiuBEyfgl0Bi3VoypcUtKya09T2viNISfvI8+Q0UMzU5rgdHRoGG1F3KxN1Ly
	oWV4GvaJM1E=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 902DB28372;
	Mon, 17 Jun 2013 20:15:02 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E3FE82836E;
	Mon, 17 Jun 2013 20:15:01 +0000 (UTC)
In-Reply-To: <ffea107da7b3b7d5e390d27397d3a72155e942b4.1371402684.git.john@keeping.me.uk>
	(John Keeping's message of "Sun, 16 Jun 2013 18:13:01 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 975CBAC4-D78A-11E2-A8EF-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228110>

John Keeping <john@keeping.me.uk> writes:

> Signed-off-by: John Keeping <john@keeping.me.uk>
> ---

Thanks; will directly apply 1/2 on maint.  I am not absolutely sure
about this one, where variables related to an optional "info"
support used to be in one place but with the patch only "infodir" is
separated away.  Maybe it is not a big deal, though.

>  Documentation/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/Makefile b/Documentation/Makefile
> index af3d8a4..0cfdc36 100644
> --- a/Documentation/Makefile
> +++ b/Documentation/Makefile
> @@ -81,6 +81,7 @@ DOC_MAN7 = $(patsubst %.txt,%.7,$(MAN7_TXT))
>  prefix ?= $(HOME)
>  bindir ?= $(prefix)/bin
>  htmldir ?= $(prefix)/share/doc/git-doc
> +infodir ?= $(prefix)/share/info
>  pdfdir ?= $(prefix)/share/doc/git-doc
>  mandir ?= $(prefix)/share/man
>  man1dir = $(mandir)/man1
> @@ -98,7 +99,6 @@ RM ?= rm -f
>  MAN_REPO = ../../git-manpages
>  HTML_REPO = ../../git-htmldocs
>  
> -infodir ?= $(prefix)/share/info
>  MAKEINFO = makeinfo
>  INSTALL_INFO = install-info
>  DOCBOOK2X_TEXI = docbook2x-texi
