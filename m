From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH v3] Replace hard-coded path with one from <paths.h>
Date: Thu, 15 Apr 2010 14:57:59 +0200
Message-ID: <201004151458.02156.jnareb@gmail.com>
References: <20100406163643.GG15306@arachsys.com> <m3hbncgaxu.fsf@localhost.localdomain> <20100415124043.GH12365@arachsys.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, kusmabite@gmail.com,
	git@vger.kernel.org
To: Chris Webb <chris@arachsys.com>
X-From: git-owner@vger.kernel.org Thu Apr 15 14:57:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O2OdW-000536-RK
	for gcvg-git-2@lo.gmane.org; Thu, 15 Apr 2010 14:57:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753262Ab0DOM5d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Apr 2010 08:57:33 -0400
Received: from mail-bw0-f225.google.com ([209.85.218.225]:64651 "EHLO
	mail-bw0-f225.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752297Ab0DOM5c (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Apr 2010 08:57:32 -0400
Received: by bwz25 with SMTP id 25so1546460bwz.28
        for <git@vger.kernel.org>; Thu, 15 Apr 2010 05:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=ZaFwOQ8+vhC6/XEEWQ45lY/o2PK99jw9KPTH4m5fGWI=;
        b=tF9v2Sr+H08VQIldT5UsolV65CR/+wXfYVPZ4WkztdL0wooFxvjzM9duEn7H2EnBH7
         3zngqm7ArzHe8dhFdUStgemEjg1S+gO2wLc1UmiLRHdKlu/uCl+bTI54Ognxrzl4hoPZ
         UsftVzdHBXSw3mbF7UfR50wk9ytF4cujeOSHY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=SIPRRF3Nh9mbI8LHURroLXpBqnG5xeyus1qHwMkQ4KAy+N7cP9qnvDSNDNI5brUuk3
         UbGQCMWSJcjuVn0YMQXxzH3rEy76FoA7dBA+uY//ftlRChJGo0lqHCTzhs9P8P2JQrQE
         FwkdFf6AHsbbEqI7Ych1wAFBaNR90CrX6Q6ZE=
Received: by 10.204.9.23 with SMTP id j23mr5070bkj.132.1271336249489;
        Thu, 15 Apr 2010 05:57:29 -0700 (PDT)
Received: from [192.168.1.13] (abvo40.neoplus.adsl.tpnet.pl [83.8.212.40])
        by mx.google.com with ESMTPS id 14sm1169316bwz.14.2010.04.15.05.57.28
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 15 Apr 2010 05:57:28 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20100415124043.GH12365@arachsys.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144979>

On Thu, 15 April 2010, Chris Webb wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> 
> > All other such variables are described at the top of main Makefile,
> > for example:
> > 
> >   #
> >   # Define NO_LIBGEN_H if you don't have libgen.h.
> > 
> > I think that HAVE_PATHS_H should also have such one-line description.
> > By the way it the very first variable with HAVE_* rather than NEEDS_*
> > or NO_* name.
> 
> To be honest, I used the name suggested to me earlier in the thread without
> a great deal of checking to see how consistent it was with existing naming
> convention.

Actually HAVE_STH_H is the convention used in autoconf documentation.
It is Git convention of NO_STH_H (well, the single example of NO_LIBGEN_H)
that is non-standard... but this convention predates [optional] autoconf
support in Git.

> 
> Blacklisting OSes with a NO_PATHS_H #define feels like a mistake, as unknown
> OSes will fail rather than assuming a safe (if slightly untidy) default. I
> got caught out assuming that Windows was sane in this regard, for instance.

Well, there is only one example of checking for _headers_, namely
NO_LIBGEN_H, so it is not that you are against some majority.

In short: if there is no voice against HAVE_PATHS_H, lets have it this
way.

> 
> To me, NEEDS_PATH_H hints that a system with paths.h would break if it
> weren't included, rather than that this is an extra feature available on
> this OS. But if NEEDS_* is used elsewhere to enable optional extras on
> systems which support them, I agree we should change to NEEDS_PATH_H to be
> consistent.

Well, things like NEEDS_LIBGEN or NEEDS_SSL_WITH_CRYPTO are about a few
systems that needs *extra* work.  I don't think NEEDS_PATH_H is a good
variable name.


-- 
Jakub Narebski
Poland
