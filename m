From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] bash completion: allow git stash store options completion
Date: Tue, 13 Jan 2015 10:40:40 -0800
Message-ID: <xmqq7fwqed7b.fsf@gitster.dls.corp.google.com>
References: <1421171612-12058-1-git-send-email-kuleshovmail@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Alexander Kuleshov <kuleshovmail@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 13 19:41:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YB6Oj-0001Gq-6H
	for gcvg-git-2@plane.gmane.org; Tue, 13 Jan 2015 19:41:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753380AbbAMSkv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Jan 2015 13:40:51 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:64093 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753257AbbAMSkt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jan 2015 13:40:49 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 90A432CB74;
	Tue, 13 Jan 2015 13:40:43 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fGsdgugxcMNVi2GnXzE8HhaYLfA=; b=KOACl4
	pxhlH0GrRD2JVOthhOFTYmlFgqawhHREugdzxkOpruIN55HJCDy/arwE3Wj2z86q
	pCsORuJTGUKtF89VC3D3AZOriI6hNk2e9k1HsB3iORyNPt9C9HtPR1m2XTHO2kfU
	t1Df2Q7c8iGdxtIiQKBLVgbDp4SVPe4CZqRkE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BRCFUiV9GoG9LgkNHrtIpuFcYqbKOJ2O
	7fV70AjwPQuLVU6BbZZMWDomSrUmr46eJZY1pOYE24QbFJNxpjzo49MdrLA22EtD
	/2HPyxeWOdt6bJkgHoDKYDtXIlPFr+yQAJESyXtOptp4PMZaKlNm7g8YI6aNwJ1O
	Cr9l7/VJX3Y=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 724C62CB73;
	Tue, 13 Jan 2015 13:40:43 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id EA3832CB72;
	Tue, 13 Jan 2015 13:40:41 -0500 (EST)
In-Reply-To: <1421171612-12058-1-git-send-email-kuleshovmail@gmail.com>
	(Alexander Kuleshov's message of "Tue, 13 Jan 2015 23:53:32 +0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: AD478330-9B53-11E4-9DB0-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262345>

Alexander Kuleshov <kuleshovmail@gmail.com> writes:

> This patch adds bash completion for git stash 'store' subcommand
> which apperead at bd514cad (stash: introduce 'git stash store', 18 Jun 2013)
>
> Signed-off-by: Alexander Kuleshov <kuleshovmail@gmail.com>
> ---

Hmph.  The "create" and "store" subcommands are not end-user facing;
they are meant to be used in scripts.  I am not sure if we want to
complete them in the first place.  I know "create" already is in the
list of completion candidates, but I wonder if adding "store" is
making things worse.

I dunno.

>  contrib/completion/git-completion.bash | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index c21190d..7578266 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -2375,7 +2375,7 @@ _git_show_branch ()
>  _git_stash ()
>  {
>  	local save_opts='--keep-index --no-keep-index --quiet --patch'
> -	local subcommands='save list show apply clear drop pop create branch'
> +	local subcommands='save list show apply clear drop pop create branch store'
>  	local subcommand="$(__git_find_on_cmdline "$subcommands")"
>  	if [ -z "$subcommand" ]; then
>  		case "$cur" in
> @@ -2402,6 +2402,9 @@ _git_stash ()
>  			__gitcomp_nl "$(git --git-dir="$(__gitdir)" stash list \
>  					| sed -n -e 's/:.*//p')"
>  			;;
> +		store,--*)
> +			__gitcomp "--message --quiet"
> +			;;
>  		*)
>  			;;
>  		esac
