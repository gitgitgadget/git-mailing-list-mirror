From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH v3] Replace hard-coded path with one from <paths.h>
Date: Thu, 15 Apr 2010 05:25:14 -0700 (PDT)
Message-ID: <m3hbncgaxu.fsf@localhost.localdomain>
References: <20100404222801.GB31315@arachsys.com>
	<20100406163525.GF15306@arachsys.com>
	<20100406163643.GG15306@arachsys.com>
	<n2u40aa078e1004070357m143cfaccvdc754a3bc5fe1ae1@mail.gmail.com>
	<20100408105850.GD2146@arachsys.com>
	<m2x40aa078e1004080426u98fbe6b2zfa9a2726172f725@mail.gmail.com>
	<20100408115706.GE2077@arachsys.com>
	<z2o40aa078e1004080508z17c5e71by371bbe6e1cdb8c50@mail.gmail.com>
	<20100409054536.GB2151@arachsys.com>
	<20100413090604.GB770@arachsys.com>
	<20100413090713.GC770@arachsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, kusmabite@gmail.com,
	git@vger.kernel.org
To: Chris Webb <chris@arachsys.com>
X-From: git-owner@vger.kernel.org Thu Apr 15 14:25:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O2O8L-0003Zq-80
	for gcvg-git-2@lo.gmane.org; Thu, 15 Apr 2010 14:25:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753279Ab0DOMZS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Apr 2010 08:25:18 -0400
Received: from mail-bw0-f225.google.com ([209.85.218.225]:52849 "EHLO
	mail-bw0-f225.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752268Ab0DOMZR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Apr 2010 08:25:17 -0400
Received: by bwz25 with SMTP id 25so1501931bwz.28
        for <git@vger.kernel.org>; Thu, 15 Apr 2010 05:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=PlSOmIMAeFBCP1BWwEcBXhe3FDRBks8b7Jb1yfEaNtc=;
        b=t6fQomf6HAjNp1lAEI9pfxGSfyra/hR28SomrUmftaPqfHbcw4pcjdz4l9B7R35qrF
         BbJ1cwx9JsDjAaCkpfu44hpp0DHLjnXfnumfVrOz/voT29OC3Gm+GcwcyM+mSG0y63yq
         YDhsVQyMybisDkYjXMeK7/FyzutDx9wJibX10=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=WnQA3Jp/aYbnE5gvsZdqttzeNJdqep7yDjMIDkWKado+9Gh72BwQNb82AlesC3A1Au
         lyk+jPNbqoMWv5j7d7KRXA2B74Hgd074PQB5SVAGyRAKUmAkxHFSN1XqjJ5cZqea6Ksr
         zB6LYTyh0lNVooi9vknM3icMzWEZIa0yCoKyE=
Received: by 10.103.69.2 with SMTP id w2mr66289muk.18.1271334315621;
        Thu, 15 Apr 2010 05:25:15 -0700 (PDT)
Received: from localhost.localdomain (abvo40.neoplus.adsl.tpnet.pl [83.8.212.40])
        by mx.google.com with ESMTPS id 7sm7724183mup.3.2010.04.15.05.25.14
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 15 Apr 2010 05:25:14 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o3FCPInc025080;
	Thu, 15 Apr 2010 14:25:29 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o3FCP2jW025073;
	Thu, 15 Apr 2010 14:25:02 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20100413090713.GC770@arachsys.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144974>

Chris Webb <chris@arachsys.com> writes:

> In exec_cmd.c, git hard-codes a default path of /usr/local/bin:/usr/bin:/bin.
> Get an appropriate value for the system from <paths.h> if possible instead. We
> only try to include <paths.h> on Linux, FreeBSD, NetBSD, OpenBSD and GNU where
> it is known to exist.
> 
> Signed-off-by: Chris Webb <chris@arachsys.com>
> ---
>  Makefile          |   10 ++++++++++
>  exec_cmd.c        |    2 +-
>  git-compat-util.h |    6 ++++++
>  3 files changed, 17 insertions(+), 1 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index 910f471..f4fe941 100644
> --- a/Makefile
> +++ b/Makefile

All other such variables are described at the top of main Makefile,
for example:

  #
  # Define NO_LIBGEN_H if you don't have libgen.h.

I think that HAVE_PATHS_H should also have such one-line description.
By the way it the very first variable with HAVE_* rather than NEEDS_*
or NO_* name.

[...]
> diff --git a/git-compat-util.h b/git-compat-util.h
> index 7e62b55..ed1accc 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -164,6 +164,12 @@ extern char *gitbasename(char *);
>  #define PATH_SEP ':'
>  #endif
>  
> +#ifdef HAVE_PATHS_H
> +#include <paths.h>
> +#else
> +#define _PATH_DEFPATH "/usr/local/bin:/usr/bin:/bin"
> +#endif
> +
>  #ifndef STRIP_EXTENSION
>  #define STRIP_EXTENSION ""
>  #endif

Why not

  +#ifdef HAVE_PATHS_H
  +#include <paths.h>
  +#endif
  +#ifndef _PATH_DEFPATH
  +#define _PATH_DEFPATH "/usr/local/bin:/usr/bin:/bin"
  +#endif

This way you are covered if some other header provides _PATH_DEFPATH.
Or is your way better?

-- 
Jakub Narebski
Poland
ShadeHawk on #git
