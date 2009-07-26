From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] Trivial path quoting fixes in git-instaweb
Date: Sun, 26 Jul 2009 03:10:14 -0700
Message-ID: <20090726101014.GA27702@dcvr.yhbt.net>
References: <4A61E563.7000401@superdigi.de> <BLU0-SMTP74459FFFD6FF936D27AD4FAE1F0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Bodo Schlecht <schlecht@superdigi.de>, git@vger.kernel.org,
	Sean Estabrooks <seanlkml@sympatico.ca>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jul 26 12:12:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MV0gU-0001II-JQ
	for gcvg-git-2@gmane.org; Sun, 26 Jul 2009 12:10:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753350AbZGZKKT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Jul 2009 06:10:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753343AbZGZKKT
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Jul 2009 06:10:19 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:39835 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753341AbZGZKKS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Jul 2009 06:10:18 -0400
Received: from localhost (user-118bg0q.cable.mindspring.com [66.133.192.26])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by dcvr.yhbt.net (Postfix) with ESMTPSA id 3D4131F5F3;
	Sun, 26 Jul 2009 10:10:16 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <BLU0-SMTP74459FFFD6FF936D27AD4FAE1F0@phx.gbl>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124116>

Sean Estabrooks <seanlkml@sympatico.ca> wrote:
> 
> Bodo Schlecht noticed that Instaweb didn't propely quote all
> path instances in the Apache config file it generated.

Works for me here, thank you.

Acked-by: Eric Wong <normalperson@yhbt.net>

> ---
>  git-instaweb.sh |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/git-instaweb.sh b/git-instaweb.sh
> index 5f4419b..32f6496 100755
> --- a/git-instaweb.sh
> +++ b/git-instaweb.sh
> @@ -256,7 +256,7 @@ apache2_conf () {
>  	mkdir -p "$GIT_DIR/gitweb/logs"
>  	bind=
>  	test x"$local" = xtrue && bind='127.0.0.1:'
> -	echo 'text/css css' > $fqgitdir/mime.types
> +	echo 'text/css css' > "$fqgitdir/mime.types"
>  	cat > "$conf" <<EOF
>  ServerName "git-instaweb"
>  ServerRoot "$fqgitdir/gitweb"
> @@ -272,7 +272,7 @@ EOF
>  		fi
>  	done
>  	cat >> "$conf" <<EOF
> -TypesConfig $fqgitdir/mime.types
> +TypesConfig "$fqgitdir/mime.types"
>  DirectoryIndex gitweb.cgi
>  EOF
>  
> -- 
