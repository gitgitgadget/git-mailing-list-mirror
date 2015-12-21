From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Revert "setup: set env $GIT_WORK_TREE when work tree is set, like $GIT_DIR"
Date: Mon, 21 Dec 2015 09:28:01 -0800
Message-ID: <xmqqegefhftq.fsf@gitster.mtv.corp.google.com>
References: <xmqqh9k06all.fsf@gitster.mtv.corp.google.com>
	<1450693372-6863-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 21 18:28:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aB4Fz-00053W-82
	for gcvg-git-2@plane.gmane.org; Mon, 21 Dec 2015 18:28:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751553AbbLUR2J convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 21 Dec 2015 12:28:09 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:53032 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751367AbbLUR2E convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Dec 2015 12:28:04 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C934632675;
	Mon, 21 Dec 2015 12:28:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=DntEaGRKlDXW
	E8CKF1ErRqou588=; b=eU4gjTdqFsbAIW0dFbuIJTxNlMa+ejx4Vdu/NLckzGRg
	cPwQ/RrHpK+jl7wIG5V3+2WwpWrbLkeIOaEEcAM9vgcVjTWiUxPMpDy8bnXxZMxB
	WCO8m6AiVgXhK6ekk9+jmB6XU+5h/Uxsyw6VzJzNe5YZBegLmRxfHa/exgwPuIM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=KldwIQ
	P9Jqbyek2d289KN/l1iuwhcmJcQAlgimXkRnDhYiPLRndv8FRqhjwlLkEWSZ+h1S
	iWRtgOpofBKXfgH30J+n9sIXG12Qv1KIWrxaeCN9nZ8QfWkKRUq5t2tbBZNFu5Dr
	4dbjHuH5cpM+b83bDHZPrqeGCBCMf4sMgPdhk=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C0AB032674;
	Mon, 21 Dec 2015 12:28:03 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 4016232671;
	Mon, 21 Dec 2015 12:28:03 -0500 (EST)
In-Reply-To: <1450693372-6863-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Mon, 21
 Dec 2015 17:22:52 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 30921B26-A808-11E5-B46A-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282802>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> This commit has caused three regression reports so far. All of them a=
re
> about spawning git subprocesses, where the new presence of GIT_WORK_T=
REE
> either changes command behaviour (git-init or git-clone), or how
> repo/worktree is detected (from aliases), with or without $GIT_DIR.
> The original bug will be re-fixed another way.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  On Thu, Dec 3, 2015 at 12:09 AM, Junio C Hamano <gitster@pobox.com> =
wrote:
>  > OK, when/if you decide that our first step should be a revert of
>  > d95138e please send in a patch to do so with a brief write-up of a
>  > follow-up plan.
>
>  Three reports to me are enough. And I obviously could not push the
>  fix out fast enough. So if you want to revert it, here's the patch o=
n
>  maint.

The timing of this is a bit unfortunate, as d95138e is a regression
since v2.5.1 throughout v2.6 series.  I'll push this out on maint
and onwards for now.  I do not think we added new things that rely
on the post-d95138e "broken" behaviour in-tree, but this reversion
might introduce another unexpected regression X-<.  We'll see.

Thanks.

>
>  environment.c      | 2 --
>  t/t0002-gitfile.sh | 2 +-
>  2 files changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/environment.c b/environment.c
> index 23a38e4..f1a2a49 100644
> --- a/environment.c
> +++ b/environment.c
> @@ -238,8 +238,6 @@ void set_git_work_tree(const char *new_work_tree)
>  	}
>  	git_work_tree_initialized =3D 1;
>  	work_tree =3D xstrdup(real_path(new_work_tree));
> -	if (setenv(GIT_WORK_TREE_ENVIRONMENT, work_tree, 1))
> -		die("could not set GIT_WORK_TREE to '%s'", work_tree);
>  }
> =20
>  const char *get_git_work_tree(void)
> diff --git a/t/t0002-gitfile.sh b/t/t0002-gitfile.sh
> index 9670e8c..3afe012 100755
> --- a/t/t0002-gitfile.sh
> +++ b/t/t0002-gitfile.sh
> @@ -99,7 +99,7 @@ test_expect_success 'check rev-list' '
>  	test "$SHA" =3D "$(git rev-list HEAD)"
>  '
> =20
> -test_expect_success 'setup_git_dir twice in subdir' '
> +test_expect_failure 'setup_git_dir twice in subdir' '
>  	git init sgd &&
>  	(
>  		cd sgd &&
