From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH] document submdule.$name.update=none option for gitmodules
Date: Thu, 10 May 2012 21:30:12 +0100
Organization: OPDS
Message-ID: <A406C457BFB948FC9843C8F53AD82CDE@PhilipOakley>
References: <20120510185903.GF76400@book.hvoigt.net>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: "Heiko Voigt" <hvoigt@hvoigt.net>,
	"Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 10 22:29:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SSZzg-0003Wi-Fq
	for gcvg-git-2@plane.gmane.org; Thu, 10 May 2012 22:29:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754403Ab2EJU3o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 May 2012 16:29:44 -0400
Received: from out1.ip06ir2.opaltelecom.net ([62.24.128.242]:37258 "EHLO
	out1.ip06ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752081Ab2EJU3m (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 May 2012 16:29:42 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AiIRAO0krE9cHlGK/2dsb2JhbABEiz6nQAEBAYEdgQiCEAUBAQQBCAEBLh4BASEFBgIDBQIBAw4DBAEBCiUUAQQaBgcPCAYBEggCAQIDAYd4CbtUixJZgQFzgm1jBIgwhUqYQ4Jq
X-IronPort-AV: E=Sophos;i="4.75,566,1330905600"; 
   d="scan'208";a="537738835"
Received: from host-92-30-81-138.as13285.net (HELO PhilipOakley) ([92.30.81.138])
  by out1.ip06ir2.opaltelecom.net with SMTP; 10 May 2012 21:29:40 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197629>

From: "Heiko Voigt" <hvoigt@hvoigt.net> Sent: Thursday, May 10, 2012 7:59 PM
Subject: [PATCH] document submdule.$name.update=none option for gitmodules


> This option was not yet described in the gitmodules documentation. We
> only described it in the 'git submodule' command documentation but
> gitmodules is the more natural place to look.

The gitmodules documentation is only more natural if we tell (link) the reader early in the submodule documentation. A link to 
gitmodules should be provided in the third paragraph of Description where the .gitmodules is introduced.

Currently the gitmodules link is the last thing mentioned (i.e. 8 PgDn's for me).

>
> A short reference in the 'git submodule' documentation should be
> sufficient since the details can now be found in the documentation to
> gitmodules.
>
> Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
> ---
> Documentation/git-submodule.txt |    7 ++-----
> Documentation/gitmodules.txt    |    5 ++++-
> 2 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
> index c243ee5..c83a856 100644
> --- a/Documentation/git-submodule.txt
> +++ b/Documentation/git-submodule.txt
> @@ -140,7 +140,8 @@ update::
>  checkout the commit specified in the index of the containing repository.
>  This will make the submodules HEAD be detached unless `--rebase` or
>  `--merge` is specified or the key `submodule.$name.update` is set to
> - `rebase`, `merge` or `none`.
> + `rebase`, `merge` or `none`. `none` can be overriden by specifying
> + `--checkout`.
> +
> If the submodule is not yet initialized, and you just want to use the
> setting as stored in .gitmodules, you can automatically initialize the
> @@ -148,10 +149,6 @@ submodule with the `--init` option.
> +
> If `--recursive` is specified, this command will recurse into the
> registered submodules, and update any nested submodules within.
> -+
> -If the configuration key `submodule.$name.update` is set to `none` the
> -submodule with name `$name` will not be updated by default. This can be
> -overriden by adding `--checkout` to the command.
>
> summary::
>  Show commit summary between the given commit (defaults to HEAD) and
> diff --git a/Documentation/gitmodules.txt b/Documentation/gitmodules.txt
> index 4e1fd52..4effd78 100644
> --- a/Documentation/gitmodules.txt
> +++ b/Documentation/gitmodules.txt
> @@ -41,8 +41,11 @@ submodule.<name>.update::
>  the commit specified in the superproject. If 'merge', the commit
>  specified in the superproject will be merged into the current branch
>  in the submodule.
> + If 'none', the submodule with name `$name` will not be updated
> + by default.
> +
>  This config option is overridden if 'git submodule update' is given
> - the '--merge' or '--rebase' options.
> + the '--merge', '--rebase' or '--checkout' options.
>
> submodule.<name>.fetchRecurseSubmodules::
>  This option can be used to control recursive fetching of this
> -- 
> 1.7.10.rc2.31.gd8c60
>
