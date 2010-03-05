From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 1/1] gitignore: do not ignore include/linux/
Date: Fri, 05 Mar 2010 02:43:29 -0800 (PST)
Message-ID: <m3pr3jkq26.fsf@localhost.localdomain>
References: <4B90CBE5.9090102@viscovery.net>
	<1267780845-10547-1-git-send-email-jslaby@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andrew Morton <akpm@linux-foundation.org>, git@vger.kernel.org,
	linux-kernel@vger.kernel.org, jirislaby@gmail.com,
	Johannes Sixt <j.sixt@viscovery.net>
To: Jiri Slaby <jslaby@suse.cz>
X-From: git-owner@vger.kernel.org Fri Mar 05 11:44:03 2010
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NnV0h-0006fZ-6J
	for gcvg-git-2@lo.gmane.org; Fri, 05 Mar 2010 11:43:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755166Ab0CEKne (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Mar 2010 05:43:34 -0500
Received: from mail-fx0-f219.google.com ([209.85.220.219]:40135 "EHLO
	mail-fx0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755028Ab0CEKnd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Mar 2010 05:43:33 -0500
Received: by fxm19 with SMTP id 19so3936685fxm.21
        for <multiple recipients>; Fri, 05 Mar 2010 02:43:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=yLwwg1y8APJ4IvjGwAo8Xzj1BsWQKOwZW6HWLOHl7OE=;
        b=eGoc9luXJhOS9itaRfMl2yhZbln2p7CCdhImMSgwsQdYiSJC1L5o2MctNu3D90C3gt
         ja+BgZPpq/lB4SnYAnyJpVgK5PdW81wExiR6jtW+gZTSq1PCGwnKeHvS0XLx5NCuE6jK
         1D4Bdsf3xW7zykB5NU4JevrqRySQ6faTBW4lc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=U3dFkgj+woje3CuV8lTRBabF8GwH9UXVuQyiVFONCJzU9vyMzx+WgP+wiQQS2g1yCK
         FQafg3AYMsN3WAq5R4/QW912L9l+oYfO+P/N7TBsTODxyAb6NIuimigFzDrY+OuPqJwA
         eeJBNqr/54kQAS49sw2jmzvWiGTzxSaSmK1Ys=
Received: by 10.223.77.136 with SMTP id g8mr870816fak.10.1267785810633;
        Fri, 05 Mar 2010 02:43:30 -0800 (PST)
Received: from localhost.localdomain (abws10.neoplus.adsl.tpnet.pl [83.8.242.10])
        by mx.google.com with ESMTPS id 13sm1063123fxm.6.2010.03.05.02.43.28
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 05 Mar 2010 02:43:29 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o25AgoWu029865;
	Fri, 5 Mar 2010 11:42:56 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o25AgPv7029849;
	Fri, 5 Mar 2010 11:42:25 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1267780845-10547-1-git-send-email-jslaby@suse.cz>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141573>

Jiri Slaby <jslaby@suse.cz> writes:

> linux entry in .gitignore means that everything in include/linux/
> gets ignored with git 1.7.
> 
> Prepend a slash to entries which are toplevel to avoid that
> 
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> Cc: Johannes Sixt <j.sixt@viscovery.net>
> ---
>  .gitignore |   20 ++++++++++----------
>  1 files changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/.gitignore b/.gitignore
> index efab0eb..fe6ebb9 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -34,16 +34,16 @@ modules.builtin
>  #
>  # Top-level generic files
>  #
> -tags
> -TAGS
> -linux
> -vmlinux
> -vmlinuz
> -System.map
> -Module.markers
> -Module.symvers
> -!.gitignore
> -!.mailmap
> +/tags
> +/TAGS
> +/linux
> +/vmlinux
> +/vmlinuz
> +/System.map
> +/Module.markers
> +/Module.symvers
> +!/.gitignore
> +!/.mailmap
>  
>  #
>  # Generated include files

Actually you want to *not ignore* .gitignore and .mailmap (and
.gitattributes which is missing here) anywhere, not only as top-level
file.  So .gitignore and .mailmap should not be prepended with slash.

   #
   # Top-level generic files
   #
  -tags
  -TAGS
  -linux
  -vmlinux
  -vmlinuz
  -System.map
  -Module.markers
  -Module.symvers
  +/tags
  +/TAGS
  +/linux
  +/vmlinux
  +/vmlinuz
  +/System.map
  +/Module.markers
  +/Module.symvers
   !.gitignore
   !.mailmap


-- 
Jakub Narebski
Poland
ShadeHawk on #git
