From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Use "--no-" prefix to switch off some of checkout
 dwimmery
Date: Sun, 18 Oct 2009 15:49:44 -0700
Message-ID: <7vzl7omi5z.fsf@alter.siamese.dyndns.org>
References: <1254775583-49452-1-git-send-email-jaysoffian@gmail.com>
 <alpine.DEB.1.00.0910052314580.4985@pacific.mpi-cbg.de>
 <7vzl7pyvzl.fsf@alter.siamese.dyndns.org>
 <7v63adxh9a.fsf_-_@alter.siamese.dyndns.org>
 <81b0412b0910180540u7030c22br7efcaf7f51df771d@mail.gmail.com>
 <7v7huspjg0.fsf@alter.siamese.dyndns.org>
 <20091018210222.GA5371@blimp.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jay Soffian <jaysoffian@gmail.com>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 19 00:50:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MzeZr-00008t-Fm
	for gcvg-git-2@lo.gmane.org; Mon, 19 Oct 2009 00:50:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755444AbZJRWtw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Oct 2009 18:49:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755440AbZJRWtw
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Oct 2009 18:49:52 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:55245 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755417AbZJRWtv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Oct 2009 18:49:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E15FD5EA07;
	Sun, 18 Oct 2009 18:49:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=LtcRQqpZ+QuZxMQ4HLKMSWnQGWg=; b=VJxC8G
	d1gh4pquFFg375akLDc9JnR6C8re64IzQVG9lymeG2a8EcmBy8mxnmaLNh/bMsQS
	lJkya+FzDZdW3yOUAOLtGHgo3DAVtxATNUGyp22WyK09DTCwcHgJKAwQZtVdCQJO
	mcf+AzOxI48btD+UVJEKj2IYCvMHY6l+wEIw8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LvSz/vQ4IR4xgtRITyNcbNa/aijs17VJ
	JWJtEIBcJsZfn3jIeHdNczPSMbTrhv8+37wP47LJSr1eJxF+Fb1QEI2oMkvG+D79
	tTngIXtNS84KMx389xQnZ5llc9JL3RKN2l9QgCi4bsdx4dyXJuLzc32O7sJjQ5j1
	QYQmccG9M+o=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id AB85A5EA06;
	Sun, 18 Oct 2009 18:49:51 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CC5E25EA05; Sun, 18 Oct
 2009 18:49:45 -0400 (EDT)
In-Reply-To: <20091018210222.GA5371@blimp.localdomain> (Alex Riesen's message
 of "Sun\, 18 Oct 2009 23\:02\:22 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 8BC3D1C8-BC38-11DE-9E10-1B12EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130618>

Alex Riesen <raa.lkml@gmail.com> writes:

> The one which guesses local branch name from a remote reference.
>
> Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
> ---
>
> Maybe like this?
>
> BTW, can parse-options take care of the " (default)" addition?
>
>  builtin-checkout.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/builtin-checkout.c b/builtin-checkout.c
> index 6ec9b83..22b023b 100644
> --- a/builtin-checkout.c
> +++ b/builtin-checkout.c
> @@ -632,8 +632,8 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
>  		OPT_STRING(0, "conflict", &conflict_style, "style",
>  			   "conflict style (merge or diff3)"),
>  		OPT_BOOLEAN('p', "patch", &patch_mode, "select hunks interactively"),
> -		OPT_SET_INT(0, "nodwim", &dwim_new_local_branch,
> -			    "do not dwim local branch creation", 0),
> +		OPT_SET_INT(0, "dwim", &dwim_new_local_branch,
> +			    "Guess local branch from remote reference (default)", 0),

Humph, how does SET_INT know to set it to 1 with --dwim and set it to 0
with --no-dwim?

>  		OPT_END(),
>  	};
>  	int has_dash_dash;
> -- 
> 1.6.5.1.50.g84e6e
