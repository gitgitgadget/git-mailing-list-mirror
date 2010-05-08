From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Makefile: Fix 'clean' target to remove all gitweb build files
Date: Sat, 08 May 2010 11:07:45 -0700 (PDT)
Message-ID: <m3fx22e08t.fsf@localhost.localdomain>
References: <4BE5A10F.6040401@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Sat May 08 20:07:55 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OAoRO-00060w-63
	for gcvg-git-2@lo.gmane.org; Sat, 08 May 2010 20:07:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751051Ab0EHSHt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 May 2010 14:07:49 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:37936 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750784Ab0EHSHs (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 May 2010 14:07:48 -0400
Received: by fxm10 with SMTP id 10so1445800fxm.19
        for <git@vger.kernel.org>; Sat, 08 May 2010 11:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=iG/dWoOwxq4xyWYBrIkpATptoDTBaognfnEoZCvZ1aw=;
        b=HJTxln7RZf0DBP8toWjzN5Jm/TW1wTK5J24SunIyhZm1GjPGAPtQGrGI/+3su/8oPt
         wWXh6aYEXe4uU66znSCIx/MIK55YwEk5d5z92nYZ9S83TiEZCa53MMSArRPSyrOfbSS1
         oU4/hVa6C05aihnK9vXgts7oHp7fh0z5uLPzw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=lfpoepPqTFb+bF/WNMmAmVeBSsVkALrBOekJBLYW9oVtM3y/FpB+XTuiivX83ceEAg
         oL6Bv45iTooiTgmCU7ZU7sZiub+7XXTZgwBCgVfYUHReSsiFsguAPiROxWE6prqvNfG3
         srNFEEffEYT+LQgWADM7QFEGn1RpNFX52iUGI=
Received: by 10.102.14.5 with SMTP id 5mr935907mun.33.1273342066578;
        Sat, 08 May 2010 11:07:46 -0700 (PDT)
Received: from localhost.localdomain (abvu105.neoplus.adsl.tpnet.pl [83.8.218.105])
        by mx.google.com with ESMTPS id 25sm13402703mul.26.2010.05.08.11.07.45
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 08 May 2010 11:07:45 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o48I7K5d030933;
	Sat, 8 May 2010 20:07:26 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o48I6xj6030928;
	Sat, 8 May 2010 20:06:59 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <4BE5A10F.6040401@ramsay1.demon.co.uk>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146670>

Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:

> In particular the gitweb/GITWEB-BUILD-OPTIONS file was not being
> removed by the main Makefile. However, the gitweb/Makefile has a
> 'clean' target that correctly removes all the build products.
> In order to fix the problem, rather than duplicate the clean-up
> instructions, we change the main Makefile so that it delegates
> the clean-up actions to the gitweb Makefile.
> 
> Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>

For what it is worth

Acked-by: Jakub Narebski <jnareb@gmail.com>

> ---
>  Makefile |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index 910f471..eb1d162 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -2098,7 +2098,7 @@ clean:
>  	$(RM) $(htmldocs).tar.gz $(manpages).tar.gz
>  	$(MAKE) -C Documentation/ clean
>  ifndef NO_PERL
> -	$(RM) gitweb/gitweb.cgi gitweb/gitweb.min.*
> +	$(MAKE) -C gitweb clean
>  	$(MAKE) -C perl clean
>  endif
>  ifndef NO_PYTHON
> -- 
> 1.7.1

-- 
Jakub Narebski
Poland
ShadeHawk on #git
