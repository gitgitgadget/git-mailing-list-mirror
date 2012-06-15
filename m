From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] git-cherry-pick.txt: make clearer when revision
 walking gets activated
Date: Fri, 15 Jun 2012 10:52:44 -0700
Message-ID: <7vehpgbgyb.fsf@alter.siamese.dyndns.org>
References: <1339765943.4625.57.camel@beez.lab.cmartin.tk>
 <1339770796-542-1-git-send-email-cmn@elego.de>
 <1339770796-542-2-git-send-email-cmn@elego.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Yann Dirson <dirson@bertin.fr>
To: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>
X-From: git-owner@vger.kernel.org Fri Jun 15 19:52:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SfahX-0002T7-Pc
	for gcvg-git-2@plane.gmane.org; Fri, 15 Jun 2012 19:52:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756394Ab2FORwr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 Jun 2012 13:52:47 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47134 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752876Ab2FORwq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 Jun 2012 13:52:46 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 45DC4882B;
	Fri, 15 Jun 2012 13:52:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=sJ/horZLjvHP
	0mGE0YVMhGR8pOw=; b=LOwKHrHTcDMFp0DTR+7xF1yW7d5KtBLBX2dlxVPAkSis
	yBqJR5NKsbRC/A2nw2IIaT8l24q1jyEa479xxuqSsB8rWXNaKRKC/pXFoamUuy6U
	vf6zsdQvWQnen0X8utpNRVIZTOzoQC5u69Gg0YlmRmGloPEMpyVNL+6+4yVxJ7c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=dVfJG5
	WN9xnoka4FLWjaAdBfw5cxVyLYuLrhJhLfmtdakLkKFNNmzGddt7lL6bR35jw8c6
	TXz1GkZ1cpqROPMm87SkJEkfxcfDxxzBQPZb9asDQmfF25X+cZNmfT4Y3pcRBDcA
	XKu8p+QpnbwkYR4yuPEr6wok+AOc0/R6AKH70=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3D1DD8828;
	Fri, 15 Jun 2012 13:52:46 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C1A308827; Fri, 15 Jun 2012
 13:52:45 -0400 (EDT)
In-Reply-To: <1339770796-542-2-git-send-email-cmn@elego.de> ("Carlos
 =?utf-8?Q?Mart=C3=ADn?= Nieto"'s message of "Fri, 15 Jun 2012 16:33:16
 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E9D2EB50-B712-11E1-B86B-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200070>

Carlos Mart=C3=ADn Nieto <cmn@elego.de> writes:

> When given a set of commits, cherry-pick will apply the changes for
> all of them. Specifying a simple range will also work as
> expected. This can cause the user to think that
>
>     git cherry-pick A B..C
>
> will apply A and then B..C. This is not what happens. Instead the rev=
s
> are given to rev-list which will consider A and C as positive revs an=
d
> B as a negative one. Add a note about this and add an example with
> this particular syntax, which has shown up on the list a few times.
>
> Signed-off-by: Carlos Mart=C3=ADn Nieto <cmn@elego.de>
> ---
>  Documentation/git-cherry-pick.txt | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/Documentation/git-cherry-pick.txt b/Documentation/git-ch=
erry-pick.txt
> index 06a0bfd..10abfbf 100644
> --- a/Documentation/git-cherry-pick.txt
> +++ b/Documentation/git-cherry-pick.txt
> @@ -48,6 +48,7 @@ OPTIONS
>  	Sets of commits can be passed but no traversal is done by
>  	default, as if the '--no-walk' option was specified, see
>  	linkgit:git-rev-list[1].
> +	Note that specifying a range will activate revision walking.

That is not wrong per-se, but I do not think it would have helped
Yann.  How about phrasing it this way?

	Note that specifying a range will feed all
	<commit>... arguments to a single revision walk (see a later
	example that uses 'maint master..next').

> @@ -130,6 +131,15 @@ EXAMPLES
>  	Apply the changes introduced by all commits that are ancestors
>  	of master but not of HEAD to produce new commits.
> =20
> +`git cherry-pick master next ^maint`::
> +`git cherry-pick master maint..next`::
> +
> +	Apply the changes introduced by all commits that are ancestors
> +	of master or next, but not maint or any of its ancestors. The
> +	second spelling is often a misunderstanding of revision
> +	walking works when trying to apply a range plus a particular
> +	commit and included for completeness.

If you are using these three branches because you expect familiarity
with the convention of maint < master < next on the reader's side, I
think it should be rewritten like this.

`git cherry-pick maint next ^master`::
`git cherry-pick maint master..next`::

	Apply the changes introduced by all commits that are
	ancestors of maint or next, but not master or any of its
	ancestors.  Note that the latter does not mean `maint` and
	everything between `master` and `next`; specifically,
	`maint` will not be used if it is included in `master`.
