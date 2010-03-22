From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH v5] Improve remote-helpers documentation
Date: Mon, 22 Mar 2010 12:57:56 -0400 (EDT)
Message-ID: <alpine.LNX.2.00.1003221257330.14365@iabervon.org>
References: <f3271551003220954s38ed80f2vde1a287d05ef4ad5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 22 17:58:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ntkx1-0003QO-5j
	for gcvg-git-2@lo.gmane.org; Mon, 22 Mar 2010 17:58:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755346Ab0CVQ56 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Mar 2010 12:57:58 -0400
Received: from iabervon.org ([66.92.72.58]:42992 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755341Ab0CVQ55 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Mar 2010 12:57:57 -0400
Received: (qmail 8976 invoked by uid 1000); 22 Mar 2010 16:57:56 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 22 Mar 2010 16:57:56 -0000
In-Reply-To: <f3271551003220954s38ed80f2vde1a287d05ef4ad5@mail.gmail.com>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142949>

Looks good to me.

Acked-by: Daniel Barkalow <barkalow@iabervon.org>

On Mon, 22 Mar 2010, Ramkumar Ramachandra wrote:

> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> ---
> Cosmetic change since v4: The capabilities fetch, option, push,
> connect, and import are presented in a more elegant manner.
> 
>  Documentation/git-remote-helpers.txt |   35 +++++++++++++++++++--------------
>  1 files changed, 20 insertions(+), 15 deletions(-)
> 
> diff --git a/Documentation/git-remote-helpers.txt
> b/Documentation/git-remote-helpers.txt
> index 1b5f61a..990d302 100644
> --- a/Documentation/git-remote-helpers.txt
> +++ b/Documentation/git-remote-helpers.txt
> @@ -3,7 +3,7 @@ git-remote-helpers(1)
> 
>  NAME
>  ----
> -git-remote-helpers - Helper programs for interoperation with remote git
> +git-remote-helpers - Helper programs for interacting with remote repositories
> 
>  SYNOPSIS
>  --------
> @@ -13,10 +13,23 @@ DESCRIPTION
>  -----------
> 
>  These programs are normally not used directly by end users, but are
> -invoked by various git programs that interact with remote repositories
> -when the repository they would operate on will be accessed using
> -transport code not linked into the main git binary. Various particular
> -helper programs will behave as documented here.
> +invoked by various git programs that interact with remote
> +repositories.  For a program to qualify as a remote helper, it must
> +implement a subset of the capabilities documented here, and conform to
> +the remote helper protocol. Remote helpers are spawned as binaries by
> +the main git programs and interact using text streams, without
> +linking.
> +
> +The curl helper is one such program. It is invoked via
> +'git-remote-http', 'git-remote-https', 'git-remote-ftp', or
> +'git-remote-ftps', and implments the capabilities 'fetch', 'option',
> +and 'push'. The curl helper essentially helps in transporting native
> +git objects.
> +
> +As opposed to native git objects, remote helpers can also provide a
> +fast-import stream through the 'import' capability. This makes them
> +especially useful when native interoperability with a foreign
> +versioning system is desired.
> 
>  COMMANDS
>  --------
> @@ -119,16 +132,11 @@ CAPABILITIES
>  ------------
> 
>  'fetch'::
> -	This helper supports the 'fetch' command.
> -
>  'option'::
> -	This helper supports the option command.
> -
>  'push'::
> -	This helper supports the 'push' command.
> -
> +'connect'::
>  'import'::
> -	This helper supports the 'import' command.
> +	This helper supports the corresponding command with the same name.
> 
>  'refspec' 'spec'::
>  	When using the import command, expect the source ref to have
> @@ -140,9 +148,6 @@ CAPABILITIES
>  	all, it must cover all refs reported by the list command; if
>  	it is not used, it is effectively "*:*"
> 
> -'connect'::
> -	This helper supports the 'connect' command.
> -
>  REF LIST ATTRIBUTES
>  -------------------
> 
> -- 
> 1.7.0.2
> 
