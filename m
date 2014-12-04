From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] check-ignore: clarify treatment of tracked files
Date: Thu, 04 Dec 2014 12:15:41 -0800
Message-ID: <xmqqzjb3rx1u.fsf@gitster.dls.corp.google.com>
References: <5480777D.6000205@drmicha.warpmail.net>
	<fbc5799c32357e8bff0c690ba7bc4cd46374684d.1417706481.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Guilherme <guibufolo@gmail.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Dec 04 21:15:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XwcoZ-0000dY-8f
	for gcvg-git-2@plane.gmane.org; Thu, 04 Dec 2014 21:15:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751878AbaLDUPr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Dec 2014 15:15:47 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:59557 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750934AbaLDUPq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Dec 2014 15:15:46 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D625F23CD8;
	Thu,  4 Dec 2014 15:15:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KIZN4He8tegQhbL3oezrEN4Kac8=; b=TI2FTH
	PfiI6U/6dlTLgtuTL8DFJBEa/uY/FkeM221KVbKGVzzj0y87/Qaz4WYOqUJ6s3Vv
	qgmoB3KDlgDeRJC7MhPcJHfPEmzL6h/uSJiZb+wfLAtP7W3eL2WZIZMNQoZ9AoRE
	p4Ot/PAWfbJH5E2ATHPzuqlkKxXEKzIbGl7tQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kCFXN72la7TMqIAWSvTfUYabCuXnVFNY
	3YAnwZlCWDbveUBejDcUTK8SIBqBz8Nt2hUb7UwWK5d/C5rSwT74kcMS35gO0zOJ
	ibqYCZMnlJXAMNUCglZ2rgP4FWDFuoMRVAxA0VzlDdzTpdL6OwMp+YVz4PYWKiMJ
	ZfoUr1y85SU=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id BADE623CCF;
	Thu,  4 Dec 2014 15:15:44 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2AE3F23CCE;
	Thu,  4 Dec 2014 15:15:44 -0500 (EST)
In-Reply-To: <fbc5799c32357e8bff0c690ba7bc4cd46374684d.1417706481.git.git@drmicha.warpmail.net>
	(Michael J. Gruber's message of "Thu, 4 Dec 2014 16:23:05 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 538C19A8-7BF2-11E4-98C9-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260794>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> By default, check-ignore does not list tracked files at all since
> they are not subject to ignore patterns.
>
> Make this clearer in the man page.
>
> Reported-by: Guilherme <guibufolo@gmail.com>
> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
> ---
> That really is a bit confusing. Does this help?

Thanks.

"git check-ignore" is a tool to debug your .gitignore settings when
your expectation does not match the reality, so having this new
sentence here is a good thing to do, but I wonder if there is a more
prominent and central place where people learn about the ignore
mechanism the first place.  If we had this sentence there, too, that
may reduce the need to debug their .gitignore settings in the first
place.

Perhaps Documentation/gitignore.txt?  Documentation/user-manual.txt?


>
>  Documentation/git-check-ignore.txt | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/Documentation/git-check-ignore.txt b/Documentation/git-check-ignore.txt
> index ee2e091..788a011 100644
> --- a/Documentation/git-check-ignore.txt
> +++ b/Documentation/git-check-ignore.txt
> @@ -21,6 +21,9 @@ the exclude mechanism) that decides if the pathname is excluded or
>  included.  Later patterns within a file take precedence over earlier
>  ones.
>  
> +By default, tracked files are not shown at all since they are not
> +subject to exclude rules; but see `--no-index'.
> +
>  OPTIONS
>  -------
>  -q, --quiet::
