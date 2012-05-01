From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] completion: simplify __git_complete_revlist_file
Date: Tue, 01 May 2012 16:39:46 -0700
Message-ID: <7vfwbj79od.fsf@alter.siamese.dyndns.org>
References: <1335897776-3726-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>,
	git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 02 01:40:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPMfq-0007vb-Iu
	for gcvg-git-2@plane.gmane.org; Wed, 02 May 2012 01:40:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755482Ab2EAXjt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 May 2012 19:39:49 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42009 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755297Ab2EAXjs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 May 2012 19:39:48 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0CC967024;
	Tue,  1 May 2012 19:39:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=R04r1UnnZp9zkfnDfC10I/Jk3iE=; b=wBAAI8
	GSYoJ1/HkZl4raeU6ONwEEZqDNg14CsMVFUhlzYXrgV34sruQzBSeDl+05q48OZw
	jthk2c68Sr9ozykszByvHtgZmnD3/jS16XoBtoxJ9Cd6nKp3T05DNdtzUI8UzRJP
	dMmeeGtFVE6iPI7q9HTAkBTV/OQ+aRpJlyLbg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=h76qeZgHUPWHWviCmnIlJLPtvSJEfj4T
	PxeitPpPa9hijKb9sKcz720yn1vaqU1yk2C0HgMHJugVviCekD7r5szJ7OtQjtfV
	R4mTyZgu83HKmvkNQrlrJOtb7IDDNBAT1FaxPI0qPyMaja2Tvts2ytbFKvsdG3JY
	BYo1NC5kDqg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F1FA87023;
	Tue,  1 May 2012 19:39:47 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8BA367022; Tue,  1 May 2012
 19:39:47 -0400 (EDT)
In-Reply-To: <1335897776-3726-1-git-send-email-felipe.contreras@gmail.com>
 (Felipe Contreras's message of "Tue, 1 May 2012 20:42:56 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EFFBB556-93E6-11E1-8ECC-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196769>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Use new __gitcomp_nl; this is the last place that uses COMPREPLY and
> compgen directly.
>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  contrib/completion/git-completion.bash |    6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index 31f714d..d877a23 100755

This seems to be based on 'maint', which has 31f714d, but I see two hits
with "git grep 'COMPREPLY.*compgen' contrib/completion" there, so I am not
sure if that is where you wanted it to apply.

I see this was not addressed to me (neither was the other zsh one), so I
take it that the patch is still for discussion, at least for the purpose
of today's integration round.  Ping me when it is ready for either 'pu' or
'next'.

Thanks.
