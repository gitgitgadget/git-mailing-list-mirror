From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add abbreviated commit hash to rebase conflict message
Date: Sat, 05 Nov 2011 17:31:06 -0700
Message-ID: <7v39e2852t.fsf@alter.siamese.dyndns.org>
References: <1320501759-27236-1-git-send-email-srabbelier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Jonas =?utf-8?Q?Flod=C3=A9n?= <jonas@floden.nu>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Herman <eric@freesa.org>, Fernando Vezzosi <fv@repnz.net>,
	"Git List" <git@vger.kernel.org>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 06 01:31:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RMqdq-0000C0-Q1
	for gcvg-git-2@lo.gmane.org; Sun, 06 Nov 2011 01:31:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753031Ab1KFAbL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 5 Nov 2011 20:31:11 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44965 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751794Ab1KFAbJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 5 Nov 2011 20:31:09 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 09D0A5754;
	Sat,  5 Nov 2011 20:31:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=1HjMKdaNMDH+
	dSFqQNW2aZoUqgE=; b=Qz4cq95sBjxz1Vklre7J9EJO/ma/85uueTEPGSQ+G9xc
	ZxPvQt99Jij8rd4MrbyFaXTG26yITzs8TMaP9j1kiEtF7dQUIlYZXUx/iAjnmhlQ
	s/n1JwdgtCIEJoYIre4PWkPrkOXPpglRR3cy8aD95TOdIwJLxnCeXFGAdy8p2bc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=BD6JUC
	YJamnpqnJsVW68555IW50Hquy+Sn4GBEj20GsR8Ce/UPN5Izo0Fub8RTQhoyrxAn
	oPrQxyte3+9wUqvNd6RotiJjq3IfkiMDBswGl1LHR7tVXc1+n6W3+dDRNGV0OmzP
	d7lLlSEKZ5Sv3m7EdTsjf00qT5R43rfyNfGXM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EF9305753;
	Sat,  5 Nov 2011 20:31:08 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E3EA75752; Sat,  5 Nov 2011
 20:31:07 -0400 (EDT)
In-Reply-To: <1320501759-27236-1-git-send-email-srabbelier@gmail.com> (Sverre
 Rabbelier's message of "Sat, 5 Nov 2011 15:02:39 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9E89E242-080E-11E1-B5D1-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184887>

Sverre Rabbelier <srabbelier@gmail.com> writes:

> Also move the $msgnum to a more sensible location.
>
> Before:
> 	Patch failed at 0001 msg
> After:
> 	Patch 0001 failed at [da65151] msg

We can guess that 7-hexdigit is an abbreviated commit object name but t=
he
above description and the title do not tell the most important thing. W=
hat
commit are you trying to describe, and why is it a good idea to show it=
?

> Reviewed-by: Eric Herman <eric@freesa.org>
> Reviewed-by: Fernando Vezzosi <buccia@repnz.net>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.c=
om>
> Signed-off-by: Sverre Rabbelier <srabbelier@gmail.com>

I wouldn't have issues if these were Helped-by or Asked-by or something=
,
but a patch with Reviewed-by for which I do not see any trace of
discussion on this list triggers some WTF at least for me.

Where did these reviews take place? What were their inputs and how was =
the
patch improved based on them? Why I should trust the judgements of thes=
e
people?

What happens when threeway is not enabled, and especially when "git am"=
 is
used for applying patches, not within rebase?

> ---
>  git-am.sh |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
>
> diff --git a/git-am.sh b/git-am.sh
> index 9042432..9d70588 100755
> --- a/git-am.sh
> +++ b/git-am.sh
> @@ -837,7 +837,8 @@ did you forget to use 'git add'?"
>  	fi
>  	if test $apply_status !=3D 0
>  	then
> -		eval_gettextln 'Patch failed at $msgnum $FIRSTLINE'
> +		abbrev_commit=3D$(git log -1 --pretty=3D%h $commit)
> +		eval_gettextln 'Patch $msgnum failed at [$abbrev_commit] $FIRSTLIN=
E'
