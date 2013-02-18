From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 9/9] user-manual: Use -o latest.tar.gz to create a
 gzipped tarball
Date: Sun, 17 Feb 2013 18:58:58 -0800
Message-ID: <7vbobicop9.fsf@alter.siamese.dyndns.org>
References: <20130217170606.GA3432@odin.tremily.us>
 <cover.1361146398.git.wking@tremily.us>
 <27dea793fc101f8bd148385b753997867b987658.1361146398.git.wking@tremily.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git <git@vger.kernel.org>, Jonathan Nieder <jrnieder@gmail.com>
To: "W. Trevor King" <wking@tremily.us>
X-From: git-owner@vger.kernel.org Mon Feb 18 03:59:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7Gwx-0006f3-2U
	for gcvg-git-2@plane.gmane.org; Mon, 18 Feb 2013 03:59:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754445Ab3BRC7B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Feb 2013 21:59:01 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59606 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753774Ab3BRC7A (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Feb 2013 21:59:00 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 60B22B081;
	Sun, 17 Feb 2013 21:59:00 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RCG7wFbucUQ1v1vf7/9dbeEFBs8=; b=Z3JVHt
	xQhLtA8mrS1Z8mntQEt2bW3ICaRcjV9r3BAfMQ42K2QAMDoEHd+lEQtp415KfFCB
	L0Ja4vjrpGGteRC5Qiqc3Kh26l27nAuppLHF+s+Uf1BnwNGc3GOuxmzlA5VfPI5A
	FRjf/4FuoDug+eu2dDV4X9YZZEfQh2vseop4w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Vg0k6HlFGoahsWcLrKl9MngVXear2wer
	ELCMTJnHkm9L7UXTEuU3eEUDrWn6k3pZYIod6MzkqpQe8/f7pfCOBQ7DEBnIkTs4
	rGmyPruwd6YvbpQS5QgFeyyEM/ch9VAHQkC/4B6yEOKQ6JS8qbK5V0BBniFZDPZs
	4Je6NS56jCk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 54B46B080;
	Sun, 17 Feb 2013 21:59:00 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BE600B07F; Sun, 17 Feb 2013
 21:58:59 -0500 (EST)
In-Reply-To: <27dea793fc101f8bd148385b753997867b987658.1361146398.git.wking@tremily.us>
 (W. Trevor King's message of "Sun, 17 Feb 2013 19:16:01 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 24AC2CA6-7977-11E2-806E-ACA62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216436>

"W. Trevor King" <wking@tremily.us> writes:

> From: "W. Trevor King" <wking@tremily.us>
>
> This functionality was introduced by 0e804e09 (archive: provide
> builtin .tar.gz filter, 2011-07-21) for v1.7.7.
>
> Signed-off-by: W. Trevor King <wking@tremily.us>
> ---

This looks like a good 'maint' material that can be applied straight
away there if the patch did not depend on 5/9 to cause needless
conflicts.

It is easy for me to deal with conflicts in this particular case,
but in general it would have been more straightforward to manage if
these more localized phrasing fixes came earlier and a larger
file-wide cosmetic change was done after all the others have
settled.

> diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
> index 3381c22..af6c09d 100644
> --- a/Documentation/user-manual.txt
> +++ b/Documentation/user-manual.txt
> @@ -931,11 +931,20 @@ The linkgit:git-archive[1] command can create a tar or zip archive from
>  any version of a project; for example:
>  
>  -------------------------------------------------
> -$ git archive --format=tar --prefix=project/ HEAD | gzip >latest.tar.gz
> +$ git archive -o latest.tar.gz --prefix=project/ HEAD
>  -------------------------------------------------
>  
> -will use HEAD to produce a tar archive in which each filename is
> -preceded by `project/`.
> +will use HEAD to produce a gzipped tar archive in which each filename
> +is preceded by `project/`.  The output file format is inferred from
> +the output file extension if possible, see linkgit:git-archive[1] for
> +details.
> +
> +Versions of Git older than 1.7.7 don't know about the 'tar.gz' format,
> +you'll need to use gzip explicitly:
> +
> +-------------------------------------------------
> +$ git archive --format=tar --prefix=project/ HEAD | gzip >latest.tar.gz
> +-------------------------------------------------
>  
>  If you're releasing a new version of a software project, you may want
>  to simultaneously make a changelog to include in the release
