From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] cat-file: Remove unused includes
Date: Thu, 08 Jan 2015 11:45:50 -0800
Message-ID: <xmqq1tn5f441.fsf@gitster.dls.corp.google.com>
References: <1420743366-14926-1-git-send-email-kuleshovmail@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Alexander Kuleshov <kuleshovmail@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 08 20:46:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y9J1p-0001Ma-SK
	for gcvg-git-2@plane.gmane.org; Thu, 08 Jan 2015 20:45:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755269AbbAHTpx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Jan 2015 14:45:53 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:60898 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751774AbbAHTpx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jan 2015 14:45:53 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 50AD22E894;
	Thu,  8 Jan 2015 14:45:52 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WsJUG0TQYDy6mBOsmghD7K1esyQ=; b=MlIaI/
	TDolYQfsL8tSKOCghTeFqD1N62+aXVokMXyjVJzI/WrVe+L6lMikG7DCjesgURIB
	7+EENtSkw67a7LP/KSbMPdK8Zbt8ebKFI9VUaYFEomVxtV372ciCDeoOYneCXi72
	hfYGa2h/fh70Q5RcX66LVUvW+ztPFtrXXYqNw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GG0gvcBr2WmEJIiDOWIoqkhcp0xRHHqL
	tr4b2Icjj+Urxujws9W3zKMZVDcgG8DjIlRtMSWD9TwZ7JzhRjrD4fTuUvBeQlcd
	wAvONFLcAecmpkz2WEPaK9w2dtys4VPJYeZWIqrSAbZHGstG+WbHMbteKi2F98rD
	RwagA5kGB64=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 48A602E893;
	Thu,  8 Jan 2015 14:45:52 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8FAB52E891;
	Thu,  8 Jan 2015 14:45:51 -0500 (EST)
In-Reply-To: <1420743366-14926-1-git-send-email-kuleshovmail@gmail.com>
	(Alexander Kuleshov's message of "Fri, 9 Jan 2015 00:56:06 +0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: F388C914-976E-11E4-9159-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262213>

Alexander Kuleshov <kuleshovmail@gmail.com> writes:

> Signed-off-by: Alexander Kuleshov <kuleshovmail@gmail.com>
> ---
>  builtin/cat-file.c | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/builtin/cat-file.c b/builtin/cat-file.c
> index f8d8129..750b5a2 100644
> --- a/builtin/cat-file.c
> +++ b/builtin/cat-file.c
> @@ -4,12 +4,8 @@
>   * Copyright (C) Linus Torvalds, 2005
>   */
>  #include "cache.h"
> -#include "exec_cmd.h"
> -#include "tag.h"
> -#include "tree.h"
>  #include "builtin.h"
>  #include "parse-options.h"
> -#include "diff.h"
>  #include "userdiff.h"
>  #include "streaming.h"

Interesting.

 - "exec_cmd.h" became unnecessary at b931aa5a (Call builtin ls-tree
   in git-cat-file -p, 2006-05-26).

 - "tag.h" and "tree.h" became unnecessary at 21666f1a (convert
   object type handling from a string to a number, 2007-02-26).

 - "diff.h" was added at e5fba602 (textconv: support for cat_file,
   2010-06-15), together with "userdiff.h".  Was it unnecessary from
   the beginning?

I didn't dig further to find out the answer to the last question,
but a patch to remove these include should explain these in its log
message, I would think.

Thanks.
