From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Makefile: Use libc strlcpy on OSX
Date: Sat, 24 Jan 2009 10:39:05 -0800
Message-ID: <7vfxj8o8fq.fsf@gitster.siamese.dyndns.org>
References: <7f978c810901240741k201f954dx1c0470186094ae24@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Benjamin Kramer <benny.kra@googlemail.com>
X-From: git-owner@vger.kernel.org Sat Jan 24 19:40:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQnQq-0002lJ-Go
	for gcvg-git-2@gmane.org; Sat, 24 Jan 2009 19:40:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754846AbZAXSjM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Jan 2009 13:39:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754680AbZAXSjL
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Jan 2009 13:39:11 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:61656 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754728AbZAXSjL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Jan 2009 13:39:11 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 9AFB793FF3;
	Sat, 24 Jan 2009 13:39:10 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 30F8993FF2; Sat,
 24 Jan 2009 13:39:06 -0500 (EST)
In-Reply-To: <7f978c810901240741k201f954dx1c0470186094ae24@mail.gmail.com>
 (Benjamin Kramer's message of "Sat, 24 Jan 2009 16:41:30 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 4A4E1E0C-EA46-11DD-B13E-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106985>

Benjamin Kramer <benny.kra@googlemail.com> writes:

> OSX supports strlcpy(3) since 10.2 so we don't need
> to use our own.

How does your patch to Makefile refrain from kicking in for people with
OSX older than 10.2, so that their builds are not broken?

>
> Signed-off-by: Benjamin Kramer <benny.kra@gmail.com>
> ---
>  Makefile |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index b4d9cb4..4c9aab5 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -643,7 +643,6 @@ ifeq ($(uname_S),Darwin)
>  	ifneq ($(shell expr "$(uname_R)" : '9\.'),2)
>  		OLD_ICONV = UnfortunatelyYes
>  	endif
> -	NO_STRLCPY = YesPlease
>  	NO_MEMMEM = YesPlease
>  	THREADED_DELTA_SEARCH = YesPlease
>  endif
