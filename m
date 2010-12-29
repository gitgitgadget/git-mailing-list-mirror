From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 3/3] gitweb: add css class to remote url titles
Date: Wed, 29 Dec 2010 14:44:37 -0800 (PST)
Message-ID: <m3bp44ci8p.fsf@localhost.localdomain>
References: <1293651215-4924-1-git-send-email-sylvain@abstraction.fr>
	<1293651215-4924-4-git-send-email-sylvain@abstraction.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Sylvain Rabot <sylvain@abstraction.fr>
X-From: git-owner@vger.kernel.org Wed Dec 29 23:44:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PY4lB-0000cJ-Gk
	for gcvg-git-2@lo.gmane.org; Wed, 29 Dec 2010 23:44:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753752Ab0L2Wol (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Dec 2010 17:44:41 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:45230 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753314Ab0L2Wok (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Dec 2010 17:44:40 -0500
Received: by bwz15 with SMTP id 15so11331248bwz.19
        for <git@vger.kernel.org>; Wed, 29 Dec 2010 14:44:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=7Vx8Fk6fupBSKzTgmu1jPAEhccB7DOjhEe7mlyEQhko=;
        b=KQ8Wt1r86Mi0Y/KCtWf3RewWu2mu6SSO/7Cxpe4CX4g3jdrDcZ2gpCN/8tkEMpCOPJ
         nodq7EFXXoSiUcg5Q0XBy5CJqgYjODhZasX+pBvQsU/IBW0JnIdPGhd/lDLULW3UGmkP
         HATK0AHQzfqbBflROj4Z2kLIwEh6FQcQsBwnE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=JK52M+HQfL3aKzT7pClu8uP3n/gYPy+2uNYBbB7jfvgdMPc0NC8J4ShjvC6i5qrQn3
         MUvKJrFKUyWL5RETFb9iy+wIDwxqSxMTXFv2ZD2I5lzIdPehlui/Wa9jmcgP/UCmA0e6
         9XnE3AaH4NBc0f2yr/29qTSvubsPJpUswtJEo=
Received: by 10.204.74.74 with SMTP id t10mr5680101bkj.161.1293662679098;
        Wed, 29 Dec 2010 14:44:39 -0800 (PST)
Received: from localhost.localdomain (abvc66.neoplus.adsl.tpnet.pl [83.8.200.66])
        by mx.google.com with ESMTPS id j11sm9014491bka.12.2010.12.29.14.44.36
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 29 Dec 2010 14:44:37 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id oBTMi6Kd027237;
	Wed, 29 Dec 2010 23:44:16 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id oBTMhoCg027233;
	Wed, 29 Dec 2010 23:43:50 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1293651215-4924-4-git-send-email-sylvain@abstraction.fr>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164338>

Sylvain Rabot <sylvain@abstraction.fr> writes:

> Signed-off-by: Sylvain Rabot <sylvain@abstraction.fr>
> ---
>  gitweb/gitweb.perl       |    8 ++++----
>  gitweb/static/gitweb.css |    5 +++++
>  2 files changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index eae75ac..cb169c7 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -5146,13 +5146,13 @@ sub git_remote_block {
>  
>  	if (defined $fetch) {
>  		if ($fetch eq $push) {
> -			$urls_table .= format_repo_url("URL", $fetch);
> +			$urls_table .= format_repo_url("<span class=\"metadata_remote_fetch_url\">URL</span>", $fetch);
>  		} else {
> -			$urls_table .= format_repo_url("Fetch URL", $fetch);
> -			$urls_table .= format_repo_url("Push URL", $push) if defined $push;
> +			$urls_table .= format_repo_url("<span class=\"metadata_remote_fetch_url\">Fetch URL</span>", $fetch);
> +			$urls_table .= format_repo_url("<span class=\"metadata_remote_push_url\">Push URL</span>", $push) if defined $push;
>  		}
>  	} elsif (defined $push) {
> -		$urls_table .= format_repo_url("Push URL", $push);
> +		$urls_table .= format_repo_url("<span class=\"metadata_remote_push_url\">Push URL</span>", $push);
>  	} else {
>  		$urls_table .= format_repo_url("", "No remote URL");
>  	}

I'm not sure if in this situation if it would not be better to extend
format_repo_url subroutine to take additional parameter describing
_type_ of repo URL; it then would do styling internally.  Which means
moving wrapping 'URL', 'Fetch URL' etc. in span element to
format_repo_url from the caller.

> diff --git a/gitweb/static/gitweb.css b/gitweb/static/gitweb.css
> index 79d7eeb..631b20d 100644
> --- a/gitweb/static/gitweb.css
> +++ b/gitweb/static/gitweb.css
> @@ -579,6 +579,11 @@ div.remote {
>  	display: inline-block;
>  }
>  
> +.metadata_remote_fetch_url,
> +.metadata_remote_push_url {
> +	font-weight: bold;
> +}
> +

Good!

-- 
Jakub Narebski
Poland
ShadeHawk on #git
