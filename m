From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/7] gitk: support -G option from the command line
Date: Tue, 29 Oct 2013 17:52:49 -0700
Message-ID: <xmqqzjprd1ge.fsf@gitster.dls.corp.google.com>
References: <21f40508f83a9407986d29f002adf5ad366c8b88.1382287779.git.trast@inf.ethz.ch>
	<72ba9e0cd862a2fb014d0633802f9afbb0bea27d.1383031141.git.tr@thomasrast.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Paul Mackerras <paulus@samba.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Thomas Rast <trast@inf.ethz.ch>
To: Thomas Rast <tr@thomasrast.ch>
X-From: git-owner@vger.kernel.org Wed Oct 30 01:53:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VbK26-0001wZ-11
	for gcvg-git-2@plane.gmane.org; Wed, 30 Oct 2013 01:53:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752290Ab3J3AxJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Oct 2013 20:53:09 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35081 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751292Ab3J3AxI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Oct 2013 20:53:08 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 10C1044D3D;
	Wed, 30 Oct 2013 00:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=YwUyoLM+BMKpRR6hqvFvJtr9J4Y=; b=pM59yi
	7ayhjH0j4UOBCHwgUECvOc5E+4Upmj0k/tlHvSDjn9HvjwJ1nmGZ9ZCgddZq51tC
	L296FERuzj1YaJ52N0gcLRNlSU6sin8780hhc/UeIYQQmoOoWXOl+fjg9PzF957P
	4Ap1y96c5uOTNooox5gnK5FZxwyjaZCOM75Zg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZU3bwD5jQhqTitWNrodVkHbR3E7BKCwE
	xuEz5flim2m//4WeGMmgvVn4o7ytySBkvEZHAlT+/gtdrg71RPvYWlBUHsv1K+29
	IvhrsUDL0rvS1zIcDoLlGgoMS42TNO19tt9DgTQbuuWRPRs211oIwd66F1LZ7OCm
	pLZYVQhwpqI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EA76544D37;
	Wed, 30 Oct 2013 00:53:06 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4007144D35;
	Wed, 30 Oct 2013 00:52:51 +0000 (UTC)
In-Reply-To: <72ba9e0cd862a2fb014d0633802f9afbb0bea27d.1383031141.git.tr@thomasrast.ch>
	(Thomas Rast's message of "Tue, 29 Oct 2013 08:20:34 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 9A69A9AC-40FD-11E3-ADBF-8F264F2CC097-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236954>

Thomas Rast <tr@thomasrast.ch> writes:

> From: Thomas Rast <trast@inf.ethz.ch>
>
> The -G option's usage is exactly analogous to that of -S, so
> supporting it is easy.
>
> Signed-off-by: Thomas Rast <trast@inf.ethz.ch>
> ---
>  gitk-git/gitk | 2 +-

You CC'ed Paul, which is absolutely the right thing to do, but
please make patches against his tree, which does not have gitk-git/
directory at the top-level.

I think the patch itself makes sense.

Thanks.

>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/gitk-git/gitk b/gitk-git/gitk
> index 5cd00d8..0e95814 100755
> --- a/gitk-git/gitk
> +++ b/gitk-git/gitk
> @@ -227,7 +227,7 @@ proc parseviewargs {n arglist} {
>  	    "--until=*" - "--before=*" - "--max-age=*" - "--min-age=*" -
>  	    "--author=*" - "--committer=*" - "--grep=*" - "-[iE]" -
>  	    "--remove-empty" - "--first-parent" - "--cherry-pick" -
> -	    "-S*" - "--pickaxe-all" - "--pickaxe-regex" -
> +	    "-S*" - "-G*" - "--pickaxe-all" - "--pickaxe-regex" -
>  	    "--simplify-by-decoration" {
>  		# These mean that we get a subset of the commits
>  		set filtered 1
