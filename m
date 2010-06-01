From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Makefile: Use $(sharedir)/gitweb for target 'install-gitweb'
Date: Tue, 1 Jun 2010 21:50:02 +0200
Message-ID: <201006012150.02970.jnareb@gmail.com>
References: <1275405080-17326-1-git-send-email-pavan.sss1991@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
	Petr Baudis <pasky@ucw.cz>
To: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 01 21:48:05 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJXRR-0003uA-EV
	for gcvg-git-2@lo.gmane.org; Tue, 01 Jun 2010 21:48:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752416Ab0FATrz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jun 2010 15:47:55 -0400
Received: from fg-out-1718.google.com ([72.14.220.156]:28775 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751364Ab0FATrz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jun 2010 15:47:55 -0400
Received: by fg-out-1718.google.com with SMTP id d23so1932697fga.1
        for <git@vger.kernel.org>; Tue, 01 Jun 2010 12:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=R7ULThEozAol9N9Az8fMpFGYPv1XwxGbGGAXscX/Xb8=;
        b=sTqVNU9I7PT0Up/rGyvrGL8+tyeICqvGnfyv7An+WuSCSMwPIsPt9fFHvIJ7xoGngY
         F8G0lMObAOc1T4Yj1DrGioXK1DWQExR2RQUxuyPTfLrvulY9sDGYOL8BlgLSX7PC4c81
         hyRll7Z4hRNaVp4UEmj0qb3nEWXYv7gma/J0w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=wiBs/7h2lB8Lf3KYIJaelWQuUq9A/LY+Qqv5ologb50FOq3sBbQRl1afnAQDzSFumM
         i2lF7mUNSS9Td4H7aMEn5CV/4WIfaWzi3bV5xugRGI0XWzQ6XqL0XGxPT6Hi2McELHa8
         yJ8Fb6kK59t1EGP0e78ccRmuspupt/90c+jLQ=
Received: by 10.223.64.205 with SMTP id f13mr7550225fai.98.1275421673161;
        Tue, 01 Jun 2010 12:47:53 -0700 (PDT)
Received: from [192.168.1.15] (abvg224.neoplus.adsl.tpnet.pl [83.8.204.224])
        by mx.google.com with ESMTPS id j23sm48559836faa.2.2010.06.01.12.47.50
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 01 Jun 2010 12:47:51 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <1275405080-17326-1-git-send-email-pavan.sss1991@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148154>

On Tue, 1 June 2010, Pavan Kumar Sunkara wrote:

> Export gitwebdir variable so that when user types the command
> 'make install-gitweb', gitweb is installed in $(sharedir)/gitweb
> rather than /var/www/cgi-bin. Now, $(sharedir)/gitweb is default
> for both 'install' and 'install-gitweb' targets.
> 
> Remove 'gitwebdir=$(gitwebdir_SQ)' from gitweb part of 'install'
> target which is unneccessary now.
> 
> Signed-off-by: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>

For what it is worth:

Acked-by: Jakub Narebski <jnareb@gmail.com>

(But I have not tested it!)

> ---
>  Makefile |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index 8f011a5..32e3146 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -294,7 +294,7 @@ lib = lib
>  # DESTDIR=
>  pathsep = :
>  
> -export prefix bindir sharedir sysconfdir
> +export prefix bindir sharedir gitwebdir sysconfdir

Nitpick: why not

  +export prefix bindir sharedir sysconfdir gitwebdir

i.e. have 'gitwebdir' last?  Not that it matters, though....

>  
>  CC = gcc
>  AR = ar
> @@ -2049,7 +2049,7 @@ install: all
>  	$(MAKE) -C templates DESTDIR='$(DESTDIR_SQ)' install
>  ifndef NO_PERL
>  	$(MAKE) -C perl prefix='$(prefix_SQ)' DESTDIR='$(DESTDIR_SQ)' install
> -	$(MAKE) -C gitweb gitwebdir=$(gitwebdir_SQ) install
> +	$(MAKE) -C gitweb install

Nice.

>  endif
>  ifndef NO_PYTHON
>  	$(MAKE) -C git_remote_helpers prefix='$(prefix_SQ)' DESTDIR='$(DESTDIR_SQ)' install
> -- 
> 1.7.1.447.g40f7.dirty
> 
> 

-- 
Jakub Narebski
Poland
