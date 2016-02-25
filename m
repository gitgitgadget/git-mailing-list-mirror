From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2.1] Documentation/diff-config: fix description of diff.renames
Date: Thu, 25 Feb 2016 10:18:39 -0800
Message-ID: <xmqqoab4odq8.fsf@gitster.mtv.corp.google.com>
References: <1456390761-27015-2-git-send-email-Matthieu.Moy@imag.fr>
	<1456421878-443-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Thu Feb 25 19:18:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZ0V1-0007me-HK
	for gcvg-git-2@plane.gmane.org; Thu, 25 Feb 2016 19:18:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933380AbcBYSSp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2016 13:18:45 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:56168 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933114AbcBYSSo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Feb 2016 13:18:44 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E96494659D;
	Thu, 25 Feb 2016 13:18:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mQ0VMLiSZF1/eTFbrcqhuWfMVeU=; b=K1GyZp
	t0MkiWfyIUXhG86zMfvH4gDczA6Or/k4AlfuMzxIEke8QQbcpYqD0bXplelDM4Qd
	dU8KLJ6k8PYrMVuYRGKAnIlZ57WyqJ85ucMGFsAUCj7loH4PzAFF/grJbIYUK5Rm
	Ikj2LX81Hwd5D/a4g+rLodV22pjGS2auanBQ0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=amnGqqm5oyKz7CPrJG6AeNd+NxacHPgL
	6zIqgPJ38ShXgWa/2/udkWgnnxv9QP/CD19JoqobKzSUlhxYzBvA2DuG5ui3ZIlp
	Rme34CHULdFq5xwNH0klgo61mJuR8uepM5CUmDsi90jqXlxRYHLEhUXmF9KqJ4b3
	h98zOt4vDso=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E05514659C;
	Thu, 25 Feb 2016 13:18:41 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 4578C4659A;
	Thu, 25 Feb 2016 13:18:41 -0500 (EST)
In-Reply-To: <1456421878-443-1-git-send-email-Matthieu.Moy@imag.fr> (Matthieu
	Moy's message of "Thu, 25 Feb 2016 18:37:58 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 32A31D44-DBEC-11E5-AC3F-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287412>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> The description was misleading, since "set to any boolean value" include
> "set to false", and diff.renames=false does not enable basic detection,
> but actually disables it. Also, document that diff.renames only affects
> Porcelain.
>
> Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
> ---
> Oops, trivial fix for typo noticed by Felipe. I'm resending just this
> one in case Junio wants to pick the latest version but I can obviously
> resend the whole if needed.

Heh, I guess people independently spotted the same typo nearly
simultaneously ;-)

I think I got this fixed locally (and adjusted the last one to
match).  Thanks.


>
>  Documentation/diff-config.txt | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/diff-config.txt b/Documentation/diff-config.txt
> index 6eaa452..b5e9bda 100644
> --- a/Documentation/diff-config.txt
> +++ b/Documentation/diff-config.txt
> @@ -108,9 +108,13 @@ diff.renameLimit::
>  	detection; equivalent to the 'git diff' option '-l'.
>  
>  diff.renames::
> -	Tells Git to detect renames.  If set to any boolean value, it
> -	will enable basic rename detection.  If set to "copies" or
> -	"copy", it will detect copies, as well.
> +	Whether and how Git detects renames.  If set to "false",
> +	rename detection is disabled.  If set to "true", basic rename
> +	detection is enabled.  If set to "copies" or "copy", Git will
> +	detect copies, as well.  Defaults to false.  Note that this
> +	affects only 'git diff' Porcelain like linkgit:git-diff[1] and
> +	linkgit:git-log[1], and not lower level commands such as
> +	linkgit:git-diff-files[1].
>  
>  diff.suppressBlankEmpty::
>  	A boolean to inhibit the standard behavior of printing a space
