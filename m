From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Mac OS X 10.5 does not require the OLD_ICONV flag set
Date: Fri, 02 Nov 2007 02:03:52 -0700
Message-ID: <7v4pg55893.fsf@gitster.siamese.dyndns.org>
References: <1193971102-61907-1-git-send-email-blaker@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, git@vger.kernel.org
To: Blake Ramsdell <blaker@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 02 10:04:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1InsRr-0004zh-DZ
	for gcvg-git-2@gmane.org; Fri, 02 Nov 2007 10:04:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752082AbXKBJEB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Nov 2007 05:04:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752080AbXKBJEB
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Nov 2007 05:04:01 -0400
Received: from sceptre.pobox.com ([207.106.133.20]:44652 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750797AbXKBJEA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Nov 2007 05:04:00 -0400
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 3B8D72EF;
	Fri,  2 Nov 2007 05:04:21 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id B769090593;
	Fri,  2 Nov 2007 05:04:16 -0400 (EDT)
In-Reply-To: <1193971102-61907-1-git-send-email-blaker@gmail.com> (Blake
	Ramsdell's message of "Thu, 1 Nov 2007 19:38:21 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63077>

Blake Ramsdell <blaker@gmail.com> writes:

> Signed-off-by: Blake Ramsdell <blaker@gmail.com>
> ---
>  Makefile |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index 71479a2..5d83756 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -401,7 +401,9 @@ endif
>  ifeq ($(uname_S),Darwin)
>  	NEEDS_SSL_WITH_CRYPTO = YesPlease
>  	NEEDS_LIBICONV = YesPlease
> -	OLD_ICONV = UnfortunatelyYes
> +	ifneq ($(uname_R),9.0.0)
> +		OLD_ICONV = UnfortunatelyYes
> +	endif
>  	NO_STRLCPY = YesPlease
>  	NO_MEMMEM = YesPlease
>  endif

I do not have an access to a Darwin box, but do you mean 10.5
gives 9.0.0 as uname_R?
