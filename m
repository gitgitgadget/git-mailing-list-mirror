From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCHv2 1/2] shell setup: clear_local_git_env() function
Date: Tue, 23 Feb 2010 21:25:24 +0100
Message-ID: <4B8439B4.9030605@web.de>
References: <cb7bb73a1002222355s38fda032g99623f44d6200fbc@mail.gmail.com> <1266913829-14533-2-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	msysGit Mailinglist <msysgit@googlegroups.com>,
	Johannes Sixt <j.sixt@viscovery.net>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 23 21:25:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nk1K7-0002Oz-IV
	for gcvg-git-2@lo.gmane.org; Tue, 23 Feb 2010 21:25:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753426Ab0BWUZe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Feb 2010 15:25:34 -0500
Received: from fmmailgate01.web.de ([217.72.192.221]:44484 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751411Ab0BWUZd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2010 15:25:33 -0500
Received: from smtp08.web.de (fmsmtp08.dlan.cinetic.de [172.20.5.216])
	by fmmailgate01.web.de (Postfix) with ESMTP id 4FB04148C5DC8;
	Tue, 23 Feb 2010 21:25:32 +0100 (CET)
Received: from [80.128.55.61] (helo=[192.168.178.26])
	by smtp08.web.de with asmtp (WEB.DE 4.110 #314)
	id 1Nk1Jz-0007ux-00; Tue, 23 Feb 2010 21:25:31 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.1.7) Gecko/20100111 Thunderbird/3.0.1
In-Reply-To: <1266913829-14533-2-git-send-email-giuseppe.bilotta@gmail.com>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX1/HBKEj3UcsmS01Wkgs4M68Xk4pd9g1vn/CunGv
	twx9CFNT45IvcUNQlZriq5F+ZoHOteIrlHeorEP0roAzvdfYSt
	TMfSPkBTgC3pjJ9VTCWQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140830>

Am 23.02.2010 09:30, schrieb Giuseppe Bilotta:
> diff --git a/git-sh-setup.sh b/git-sh-setup.sh
> index 7a09566..f1be832 100644
> --- a/git-sh-setup.sh
> +++ b/git-sh-setup.sh
> @@ -172,6 +172,21 @@ get_author_ident_from_commit () {
>  	LANG=C LC_ALL=C sed -ne "$pick_author_script"
>  }
>  
> +# Clear repo-local GIT_* environment variables. Useful when switching to
> +# another repository (e.g. when entering a submodule). See also the env
> +# list in git_connect()
> +clear_local_git_env() {
> +	unset	GIT_ALTERNATE_OBJECT_DIRECTORIES \
> +		GIT_CONFIG \
> +		GIT_DIR \
> +		GIT_GRAFT_FILE \
> +		GIT_INDEX_FILE \
> +		GIT_NO_REPLACE_OBJECTS \
> +		GIT_OBJECT_DIRECTORY \
> +		GIT_WORKTREE

Shouldn't that last one be GIT_WORK_TREE?


> +
> +}
> +
>  # Make sure we are in a valid repository of a vintage we understand,
>  # if we require to be in a git repository.
>  if test -z "$NONGIT_OK"
