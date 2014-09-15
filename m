From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] compat-util: add _DEFAULT_SOURCE define
Date: Mon, 15 Sep 2014 12:02:33 -0700
Message-ID: <xmqq61go7lme.fsf@gitster.dls.corp.google.com>
References: <1410672815-2555-1-git-send-email-sergey.senozhatsky@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 15 21:02:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XTbXt-00074m-2E
	for gcvg-git-2@plane.gmane.org; Mon, 15 Sep 2014 21:02:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754204AbaIOTCh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Sep 2014 15:02:37 -0400
Received: from smtp.pobox.com ([208.72.237.35]:54268 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754108AbaIOTCg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Sep 2014 15:02:36 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id F25FE39EB7;
	Mon, 15 Sep 2014 15:02:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=JJvNosvpBNqUQc6VWEr2ObR4xto=; b=HR8M62
	yokUCznTYY2Hr9VLArolOykqttVLyMsdVDWV62Ty2FfRncbH53tJKSGawxx8IGUA
	35XYtbTu+wMdv8Q3Rhc8WHmVfTPHnQkUGmG+Qu05yzxvGTnVrh0+5n+rq/ZUHtdK
	EOufY3Gha2j6ogKBtsKn26rhi6u4PB09ZjTU8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qfoNk0vrJEvS/6rJ1dHUI3foFv8Zdg0C
	oyDGeGDMjyrM9fJGEQw+FujRatgzSiZITnkmkaMEB/P53A00+54Ht6E6JKXE+6Wm
	eBKUWEbple0oE2TqwETJXjNZgQt8cbQ6SFNUvt3foIv1HWKU0Yyyiug/SpcpQ6Bp
	rQl4DGgSW54=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E91A339EB5;
	Mon, 15 Sep 2014 15:02:35 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 54BDA39EB2;
	Mon, 15 Sep 2014 15:02:35 -0400 (EDT)
In-Reply-To: <1410672815-2555-1-git-send-email-sergey.senozhatsky@gmail.com>
	(Sergey Senozhatsky's message of "Sun, 14 Sep 2014 14:33:35 +0900")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: DA8C6BA0-3D0A-11E4-9F8B-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257068>

Sergey Senozhatsky <sergey.senozhatsky@gmail.com> writes:

> glibc has deprecated the use of _BSD_SOURCE define
>
>   warning "_BSD_SOURCE and _SVID_SOURCE are deprecated, use _DEFAULT_SOURCE"
>
> To make it easier to maintain a cross platform source code, that
> warning can be suppressed by _DEFAULT_SOURCE.
>
> Define both _BSD_SOURCE, _DEFAULT_SOURCE and cleanup the build.

I can see you defined DEFAULT_SOURCE, but where did you do "cleanup
the build"?  Or did you mean "define both (in order) to clean up"?

Just making sure we are not only seeing a patch half eaten by mail
transport somewhere.

>
> Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
> ---
>  git-compat-util.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/git-compat-util.h b/git-compat-util.h
> index 4e7e3f8..08a9ee2 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -82,6 +82,7 @@
>  #define _ALL_SOURCE 1
>  #define _GNU_SOURCE 1
>  #define _BSD_SOURCE 1
> +#define _DEFAULT_SOURCE 1
>  #define _NETBSD_SOURCE 1
>  #define _SGI_SOURCE 1
