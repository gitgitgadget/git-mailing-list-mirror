From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-prompt: Document GIT_PS1_DESCRIBE_STYLE
Date: Tue, 11 Dec 2012 15:36:24 -0800
Message-ID: <7v38zc6u13.fsf@alter.siamese.dyndns.org>
References: <alpine.DEB.2.00.1212111815580.1093@dr-wily.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Anders Kaseorg <andersk@MIT.EDU>
X-From: git-owner@vger.kernel.org Wed Dec 12 00:36:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TiZNf-00083V-3T
	for gcvg-git-2@plane.gmane.org; Wed, 12 Dec 2012 00:36:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754117Ab2LKXgi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Dec 2012 18:36:38 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:32839 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753781Ab2LKXgh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Dec 2012 18:36:37 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9E44688C2;
	Tue, 11 Dec 2012 18:36:36 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1Iirw5ZtBeAPZiLGPc7nQ6FlMX8=; b=dPwZ3b
	zcmvUOt2tUvu0iLeuHDidPbcAP6hvDIGofJWYKVu1BkMsudodX92Msz5z8rjDdf1
	ySqPFx9i1jCjrBfXmbw8IaaXxKt23GX2OIXYTqXfkHieaXzwxXBzJm2LGJkJVH55
	ZP4m9QJaPqJPcETRbtQ1Gk5VDMHoGyOarR2RQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iZI+cJGHSARO/vCgzT4qBbYOh0UItbeJ
	bA4BzOpTZvgO8UGVEFMLJ30gwya/vUBB1uCukh+K2Q2EXGRxHvJICvsKT63fBAYL
	xhkqIQc51JleDlCppxjqwOusoz7E9ZTO3lMMtNC+n2AvnNTVTZicZPqyfY/7bY+6
	GXiux4eXWx8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8C13F88C0;
	Tue, 11 Dec 2012 18:36:36 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C095588BF; Tue, 11 Dec 2012
 18:36:35 -0500 (EST)
In-Reply-To: <alpine.DEB.2.00.1212111815580.1093@dr-wily.mit.edu> (Anders
 Kaseorg's message of "Tue, 11 Dec 2012 18:20:24 -0500 (EST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9A333E40-43EB-11E2-9345-995F2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211317>

Anders Kaseorg <andersk@MIT.EDU> writes:

> GIT_PS1_DESCRIBE_STYLE was introduced in v1.6.3.2~35.  Document it in the 
> header comments.
>
> Signed-off-by: Anders Kaseorg <andersk@mit.edu>
> ---

Thanks.

>  contrib/completion/git-prompt.sh | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
> index bf20491..5ab488c 100644
> --- a/contrib/completion/git-prompt.sh
> +++ b/contrib/completion/git-prompt.sh
> @@ -49,6 +49,15 @@
>  # find one, or @{upstream} otherwise.  Once you have set
>  # GIT_PS1_SHOWUPSTREAM, you can override it on a per-repository basis by
>  # setting the bash.showUpstream config variable.
> +#
> +# If you would like to see more information about the identity of
> +# commits checked out as a detached HEAD, set GIT_PS1_DESCRIBE_STYLE
> +# to one of these values:
> +#
> +#     contains      relative to newer annotated tag (v1.6.3.2~35)
> +#     branch        relative to newer tag or branch (master~4)
> +#     describe      relative to older annotated tag (v1.6.3.1-13-gdd42c2f)
> +#     default       exactly matching tag
>  
>  # __gitdir accepts 0 or 1 arguments (i.e., location)
>  # returns location of .git repo
