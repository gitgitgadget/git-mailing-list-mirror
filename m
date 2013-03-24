From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] status, branch: fix the misleading "bisecting" message
Date: Sat, 23 Mar 2013 22:30:30 -0700
Message-ID: <7v4ng14b61.fsf@alter.siamese.dyndns.org>
References: <7vfvzqgms9.fsf@alter.siamese.dyndns.org>
 <1364010764-972-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jonathan Niedier <jrnieder@gmail.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 24 06:31:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UJdWU-000195-W6
	for gcvg-git-2@plane.gmane.org; Sun, 24 Mar 2013 06:31:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752666Ab3CXFan convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 24 Mar 2013 01:30:43 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59746 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752595Ab3CXFan convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 24 Mar 2013 01:30:43 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C377D8FB0;
	Sun, 24 Mar 2013 01:30:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=PS2MeZry7A2p
	tXPkYZAoFoANWVs=; b=CvaoshgCHYcsY6U5a9OwNO2iFMR+65d5TtY/QE8bmGbn
	3UtyKGbWRMuM0gREIFDd2WI245NdGoiLVwcvGZsT2oVC/vlgkykX7bN9jFjz/UQr
	BCBq7vIz5yMYH9lLRFGWHbEu+qJSpTCamibsdy8eeaEuilaWuaRr1OMi2qN0jjQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=IF6/hm
	/IeJ+6wqQPldE726+nVKbueXNZNXy++KdudA4LDR7TD+On6fY8MurYAzVQ4vkscU
	v4g7HmS/ZhpB1DG3wjNZm+0mQXH384LLvQaT9LIpPHhGuQm57x5yTrZpjPQlVJyV
	GN4FRT4I85ZMXE0KIHEWjltODi8oE1CzZdG7s=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AE18B8FAF;
	Sun, 24 Mar 2013 01:30:32 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DAA698FAE; Sun, 24 Mar 2013
 01:30:31 -0400 (EDT)
In-Reply-To: <1364010764-972-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuIFRow6FpCU5n4buNYw==?= Duy"'s message of "Sat, 23 Mar
 2013 10:52:44 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F20AB8B6-9443-11E2-BF68-EA7A2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218937>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:

> The current message is "bisecting %s" (or "bisecting branch %s").
> "%s" is the current branch when we started bisecting. Clarify that to
> avoid confusion with good and bad refs passed to "bisect" command.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---

Sounds sensible.  Is this something we should squash in to
nd/branch-show-rebase-bisect-state topic, or just apply it to the
top (the latter is easier for me, but you may want to keep the
history free of "oops, that was a bad idea" changes).

Will queue on top, at least for now, as the topic is not in 'next'.

Thanks.

>  builtin/branch.c            | 2 +-
>  t/t6030-bisect-porcelain.sh | 2 +-
>  t/t7512-status-help.sh      | 2 +-
>  wt-status.c                 | 2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/builtin/branch.c b/builtin/branch.c
> index 99105f8..8f00203 100644
> --- a/builtin/branch.c
> +++ b/builtin/branch.c
> @@ -562,7 +562,7 @@ static char *get_head_description(void)
>  		strbuf_addf(&desc, _("(no branch, rebasing %s)"),
>  			    state.branch);
>  	else if (state.bisect_in_progress)
> -		strbuf_addf(&desc, _("(no branch, bisecting %s)"),
> +		strbuf_addf(&desc, _("(no branch, bisect started on %s)"),
>  			    state.branch);
>  	else if (state.detached_from)
>  		strbuf_addf(&desc, _("(detached from %s)"),
> diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.s=
h
> index 9b6f0d0..2fce99a 100755
> --- a/t/t6030-bisect-porcelain.sh
> +++ b/t/t6030-bisect-porcelain.sh
> @@ -164,7 +164,7 @@ test_expect_success 'bisect start: existing ".git=
/BISECT_START" not modified if
>  	cp .git/BISECT_START saved &&
>  	test_must_fail git bisect start $HASH4 foo -- &&
>  	git branch > branch.output &&
> -	test_i18ngrep "* (no branch, bisecting other)" branch.output > /dev=
/null &&
> +	test_i18ngrep "* (no branch, bisect started on other)" branch.outpu=
t > /dev/null &&
>  	test_cmp saved .git/BISECT_START
>  '
>  test_expect_success 'bisect start: no ".git/BISECT_START" if mistake=
n rev' '
> diff --git a/t/t7512-status-help.sh b/t/t7512-status-help.sh
> index 5adba4f..c35d01d 100755
> --- a/t/t7512-status-help.sh
> +++ b/t/t7512-status-help.sh
> @@ -578,7 +578,7 @@ test_expect_success 'status when bisecting' '
>  	TGT=3D$(git rev-parse --short two_bisect) &&
>  	cat >expected <<-EOF &&
>  	# HEAD detached at $TGT
> -	# You are currently bisecting branch '\''bisect'\''.
> +	# You are currently bisecting, started from branch '\''bisect'\''.
>  	#   (use "git bisect reset" to get back to the original branch)
>  	#
>  	nothing to commit (use -u to show untracked files)
> diff --git a/wt-status.c b/wt-status.c
> index 32a51e1..cf3d81a 100644
> --- a/wt-status.c
> +++ b/wt-status.c
> @@ -953,7 +953,7 @@ static void show_bisect_in_progress(struct wt_sta=
tus *s,
>  {
>  	if (state->branch)
>  		status_printf_ln(s, color,
> -				 _("You are currently bisecting branch '%s'."),
> +				 _("You are currently bisecting, started from branch '%s'."),
>  				 state->branch);
>  	else
>  		status_printf_ln(s, color,
