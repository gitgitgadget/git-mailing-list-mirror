From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 15/15] user-manual: Use --format=tar.gz to create a
 gzipped tarball
Date: Sun, 10 Feb 2013 14:27:08 -0800
Message-ID: <7va9rbst37.fsf@alter.siamese.dyndns.org>
References: <7vzjzexv8l.fsf@alter.siamese.dyndns.org>
 <cover.1360508415.git.wking@tremily.us>
 <92a02e35df3dab70928e56e6790417243beea2af.1360508415.git.wking@tremily.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git <git@vger.kernel.org>
To: "W. Trevor King" <wking@tremily.us>
X-From: git-owner@vger.kernel.org Sun Feb 10 23:27:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U4fN1-0005ja-9j
	for gcvg-git-2@plane.gmane.org; Sun, 10 Feb 2013 23:27:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756912Ab3BJW1M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Feb 2013 17:27:12 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64469 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756854Ab3BJW1L (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Feb 2013 17:27:11 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A6704BF72;
	Sun, 10 Feb 2013 17:27:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=axlJnsNAuKLGMZexx/8yrRFf3cQ=; b=c29Vdv
	fpfeNxkB7jZZTxvGTS1N6B8UmBQr9S3zaJWTxBba+SiBtRm3Ep8WFcJEta4vl+qg
	WwwJmf1SPyXFLjy3PUfi75xiETH97MJcAb7eKWFbCcrS2TyFfMFeoyY2k1j7oay3
	PsmBt0gBsh0ZKmtPSjJc5i816nez4gJv4G5D0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=F0SSAAs/TckQBwJUvuvbV/RB+YBNXnDW
	JLcaNl4TsZJB16ewNfiPQ1ri6azWZOKAuKbLhk4B/vs+4jGDhojJhzHV6AZqrcuB
	8aupQLWMPSlOuVjs1XSdfFGy7Oru3dahvrB2zoj0oYuEf1g9q+awAf80bhClAksa
	PeJMJragTZs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 793C3BF70;
	Sun, 10 Feb 2013 17:27:10 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BA839BF65; Sun, 10 Feb 2013
 17:27:09 -0500 (EST)
In-Reply-To: <92a02e35df3dab70928e56e6790417243beea2af.1360508415.git.wking@tremily.us>
 (W. Trevor King's message of "Sun, 10 Feb 2013 10:10:41 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0252A938-73D1-11E2-AF61-BCD12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215954>

"W. Trevor King" <wking@tremily.us> writes:

> From: "W. Trevor King" <wking@tremily.us>
>
> This functionality was introduced by 0e804e09 (archive: provide
> builtin .tar.gz filter, 2011-07-21) for v1.7.7.
>
> Signed-off-by: W. Trevor King <wking@tremily.us>
> ---

This is a "meh" at least to me.  Unless it uses something like

	git archive -o latest.tar.gz --prefix=project/ HEAD
        
it is not all that interesting.

>  Documentation/user-manual.txt | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
> index 8024758..c04ea51 100644
> --- a/Documentation/user-manual.txt
> +++ b/Documentation/user-manual.txt
> @@ -931,12 +931,19 @@ The linkgit:git-archive[1] command can create a tar or zip archive from
>  any version of a project; for example:
>  
>  -------------------------------------------------
> -$ git archive --format=tar --prefix=project/ HEAD | gzip >latest.tar.gz
> +$ git archive --format=tar.gz --prefix=project/ HEAD >latest.tar.gz
>  -------------------------------------------------
>  
>  will use HEAD to produce a tar archive in which each filename is
>  preceded by `project/`.
>  
> +Versions of Git older than 1.7.7 don't know about the 'tar.gz' format,
> +you'll need to use gzip explicitly:
> +
> +-------------------------------------------------
> +$ git archive --format=tar --prefix=project/ HEAD | gzip >latest.tar.gz
> +-------------------------------------------------
> +
>  If you're releasing a new version of a software project, you may want
>  to simultaneously make a changelog to include in the release
>  announcement.
