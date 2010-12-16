From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 1/3] gitweb: add extensions to highlight feature
Date: Thu, 16 Dec 2010 14:22:37 -0800 (PST)
Message-ID: <m3y68slxj9.fsf@localhost.localdomain>
References: <1292535801-7421-1-git-send-email-sylvain@abstraction.fr>
	<1292535801-7421-2-git-send-email-sylvain@abstraction.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
To: Sylvain Rabot <sylvain@abstraction.fr>
X-From: git-owner@vger.kernel.org Thu Dec 16 23:22:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PTMDk-0003z7-MT
	for gcvg-git-2@lo.gmane.org; Thu, 16 Dec 2010 23:22:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752301Ab0LPWWk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Dec 2010 17:22:40 -0500
Received: from mail-fx0-f43.google.com ([209.85.161.43]:58704 "EHLO
	mail-fx0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751081Ab0LPWWj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Dec 2010 17:22:39 -0500
Received: by fxm18 with SMTP id 18so57825fxm.2
        for <git@vger.kernel.org>; Thu, 16 Dec 2010 14:22:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=pghbIp5pyM7pg3e/p+eD8yYnYrd+Hv0C/edwANKpHpc=;
        b=o8jGED0gZ3lW0U/R4emRgG3/hxbt9PDJaunMSqc/s2VBc0uKmSO4jYUUyXphqozD8P
         yTF7rz2MiuHdK4PyqPhD55/OovEovbniJ6LOC1Wopka/EaYm4VksesZWBrkEeUKfFWG3
         7tlipXGPFDfxa+JdeCrksHa0fKdgWTZXnlBAU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=VLVd5tWxQF1Bgf7t7b3jO0aCGrdOfn83hz0GpHZ7Rdowyu2ndcS4/S5pFTf3gLf3aJ
         aX/RpyvDKfIzslzIv/WNCh0D2dmVLsysb0B0h5cOsIsVmOHK9jb15L44XIMKSS4NNtfB
         st6sWXVMRHYg/8xE6uVsO+TgSmX5VY1BlAh8A=
Received: by 10.223.79.13 with SMTP id n13mr31148fak.139.1292538158066;
        Thu, 16 Dec 2010 14:22:38 -0800 (PST)
Received: from localhost.localdomain (abvg92.neoplus.adsl.tpnet.pl [83.8.204.92])
        by mx.google.com with ESMTPS id o17sm215988fal.25.2010.12.16.14.22.36
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 16 Dec 2010 14:22:37 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id oAGMLuwi015790;
	Tue, 16 Nov 2010 23:22:07 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id oAGMLk56015786;
	Tue, 16 Nov 2010 23:21:46 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1292535801-7421-2-git-send-email-sylvain@abstraction.fr>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163823>

Sylvain Rabot <sylvain@abstraction.fr> writes:

> added: sql, php5, phps, bash, zsh, mk
> 

There is one issue with this patch (see below), but otherwise I like
it.

> Signed-off-by: Sylvain Rabot <sylvain@abstraction.fr>
> ---
>  gitweb/gitweb.perl |    7 ++++---
>  1 files changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index d521c93..db18d06 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -250,13 +250,14 @@ our %highlight_ext = (
>  	# main extensions, defining name of syntax;
>  	# see files in /usr/share/highlight/langDefs/ directory
>  	map { $_ => $_ }
> -		qw(py c cpp rb java css php sh pl js tex bib xml awk bat ini spec tcl),
> +		qw(py c cpp rb java css php pl js tex bib xml awk bat ini spec tcl sql),

Why did you remove 'sh' => 'sh' mapping?  Shouldn't it be

  -		qw(py c cpp rb java css php sh pl js tex bib xml awk bat ini spec tcl),
  +		qw(py c cpp rb java css php sh pl js tex bib xml awk bat ini spec tcl sql),

>  	# alternate extensions, see /etc/highlight/filetypes.conf
>  	'h' => 'c',
> +	map { $_ => 'sh'  } qw(bash zsh),

Good idea.

>  	map { $_ => 'cpp' } qw(cxx c++ cc),
> -	map { $_ => 'php' } qw(php3 php4),
> +	map { $_ => 'php' } qw(php3 php4 php5 phps),

Good idea.

>  	map { $_ => 'pl'  } qw(perl pm), # perhaps also 'cgi'
> -	'mak' => 'make',
> +	map { $_ => 'make'} qw(mak mk),

Good idea.

Sidenote: git itself uses *.mak extension.  Is *.mk popular?

>  	map { $_ => 'xml' } qw(xhtml html htm),
>  );
>  
> -- 
> 1.7.3.2
> 

-- 
Jakub Narebski
Poland
ShadeHawk on #git
