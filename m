From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] user-manual: Rewrite git-gc section for automatic
 packing
Date: Fri, 08 Feb 2013 09:36:53 -0800
Message-ID: <7vd2wa3dxm.fsf@alter.siamese.dyndns.org>
References: <7ac63ea832711ad4bee636163e277a408cbddda4.1360341577.git.wking@tremily.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git <git@vger.kernel.org>
To: "W. Trevor King" <wking@tremily.us>
X-From: git-owner@vger.kernel.org Fri Feb 08 18:37:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3rt1-0007y0-K2
	for gcvg-git-2@plane.gmane.org; Fri, 08 Feb 2013 18:37:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946842Ab3BHRg5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2013 12:36:57 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36692 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1946839Ab3BHRg4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2013 12:36:56 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 96CFEC1A0;
	Fri,  8 Feb 2013 12:36:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3PrhB6KlmFGnQPJY30OG5foxyhg=; b=BFL5hX
	JwyhSV2IRzDtx3w4Zm6RACpBpMALCVF7o0c6sD9bWV9g6AcuPSE+AbLd18xhJu25
	axmHDGJgg5N8R3V9AojWTsIi+A4ug3yJ4ufxbLndGirWDxkdbFiabtGm8IFsE8TB
	Ch3Uv6ynTg40GlYghwvZBCSiBS0OOOKVo4IPk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NWOxtG8gA40gLRCSWi5MKShSGo8oplyF
	XFWHg7UUwxjRLjUrqJcG5nk0phgbjOvK+IFSWtAWfAatvVuOQLv4YoQK4ujZZcNK
	bhdOR/haF68KVOqFSVrNmXt828XYvYqDOVb9uu+d0idRrSTITRKr+B3cW3J1SYYQ
	+Ze53N1YoZk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8C25EC19E;
	Fri,  8 Feb 2013 12:36:55 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0DE92C199; Fri,  8 Feb 2013
 12:36:54 -0500 (EST)
In-Reply-To: <7ac63ea832711ad4bee636163e277a408cbddda4.1360341577.git.wking@tremily.us>
 (W. Trevor King's message of "Fri, 08 Feb 2013 11:43:02 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 217446BC-7216-11E2-AE77-BCD12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215789>

"W. Trevor King" <wking@tremily.us> writes:

> From: "W. Trevor King" <wking@tremily.us>
>
> This should have happened back in 2007, when `git gc` learned about
> auto:
>
>   commit e9831e83e063844b90cf9e525d0003715dd8b395
>   Author: Junio C Hamano <gitster@pobox.com>
>   Date:   Mon Sep 17 00:39:52 2007 -0700
>
>     git-gc --auto: add documentation.
>
> Signed-off-by: W. Trevor King <wking@tremily.us>
> ---
> I'd also be happy just dropping the whole git-gc section ;).
>
>  Documentation/user-manual.txt | 16 ++++++----------
>  1 file changed, 6 insertions(+), 10 deletions(-)
>
> diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
> index 5077e7c..d14e3c7 100644
> --- a/Documentation/user-manual.txt
> +++ b/Documentation/user-manual.txt
> @@ -1562,17 +1562,13 @@ Ensuring good performance
>  -------------------------
>  
>  On large repositories, Git depends on compression to keep the history
> -information from taking up too much space on disk or in memory.
> +information from taking up too much space on disk or in memory.  Some
> +git commands may automatically run linkgit:git-gc[1], so you don't
> +have to worry about running it manually.  However, compressing large
> +repositories may take some time, so you might want to disable
> +automatic comression and run it explicitly when you are not doing
> +other work.

I'd rather phrase it like "... may take long, so you would want to
run it explicitly from time to time to avoid automatic gc kicking in
when it is not convenient for you".

> -This compression is not performed automatically.  Therefore you
> -should occasionally run linkgit:git-gc[1]:
> -
> --------------------------------------------------
> -$ git gc
> --------------------------------------------------
> -
> -to recompress the archive.  This can be very time-consuming, so
> -you may prefer to run `git gc` when you are not doing other work.

Removal of this is a good change, though.
