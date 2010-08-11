From: James Shubin <purpleidea@gmail.com>
Subject: Re: [PATCH v3] Gitweb: Use a default for a bad env config file
 variable
Date: Wed, 11 Aug 2010 09:36:52 -0400
Message-ID: <1281533812.28858.50.camel@ping.CS.McGill.CA>
References: <AANLkTi=42V8=26oEwcNOHubuK+VAf-QaYnvCLAKQ0xtg@mail.gmail.com>
	 <vpq4of2scen.fsf@bauges.imag.fr>
	 <AANLkTi=UCJa9uT5i9TRB9hGsH1D8b9DgB49TPM5k1htQ@mail.gmail.com>
	 <AANLkTikDtK0vyRwJE3Un5uFkK7FzoWtiWpL8gPqLQjH5@mail.gmail.com>
	 <1281458849.28858.18.camel@ping.CS.McGill.CA>
	 <m3tyn22iqd.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 11 15:44:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OjBbu-0002vy-J8
	for gcvg-git-2@lo.gmane.org; Wed, 11 Aug 2010 15:44:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752788Ab0HKNok (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Aug 2010 09:44:40 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:56317 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752389Ab0HKNoj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Aug 2010 09:44:39 -0400
Received: by qwh6 with SMTP id 6so137565qwh.19
        for <git@vger.kernel.org>; Wed, 11 Aug 2010 06:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:cc
         :in-reply-to:references:content-type:date:message-id:mime-version
         :x-mailer:content-transfer-encoding;
        bh=+Mc5vx7O36jjoTz0EG6MeR3PUdb3d/siTD7ljXrhUMA=;
        b=xd0WoV51STk6vfNf2hzjEcZ7YXwxxRoi2DT/3/R5JIWu42kJfT+JoQzzyafm407ytv
         lZSEBizF8RW02Ov0LEbBijJLomsAQVdaNGuy9qxs7vyQ3OSLpY7wBk4LqWC7HnB/yqx0
         R46x1CkklbjglCo15k8TaXSidnAqi/zcdw6bs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:to:cc:in-reply-to:references:content-type:date
         :message-id:mime-version:x-mailer:content-transfer-encoding;
        b=F3vSdr1fKVbeTB+QwOElswc8cyjzVa/xUNAJphverWJ/npMOsy9E1Tg3gjUw7lMWqm
         99HlqX8LRf8Mwnu5MI2rGt9FPDv8llpCeKntGmETncqXUDQLWxp8fiPEAFWUd3Rep6Aq
         VOE3N9juvkq+phqKhQud9yfxYSqwVzp2+h/yQ=
Received: by 10.229.181.82 with SMTP id bx18mr9748266qcb.147.1281534278861;
        Wed, 11 Aug 2010 06:44:38 -0700 (PDT)
Received: from [132.206.2.24] (ping.CS.McGill.CA [132.206.2.24])
        by mx.google.com with ESMTPS id f15sm163484qcr.13.2010.08.11.06.44.38
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 11 Aug 2010 06:44:38 -0700 (PDT)
In-Reply-To: <m3tyn22iqd.fsf@localhost.localdomain>
X-Mailer: Evolution 2.28.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153233>

Thanks for all the "sending patches" input; it's useful, even if my
patch isn't ;)
I suppose I was trying to provide more defaults to work around some
weirdly setup servers that I have inherited. Upon reconsideration, I'll
withdraw the patch.
Thanks for your time, and thanks for your nitpicks.

_James


-----Original Message-----
> First, why it is needed?  Why can't you just have GITWEB_CONFIG_SYSTEM
> (or GITWEB_CONFIG) environment variable visible to gitweb.cgi that
> points to existing file?


Second, is there any history behind providing this fallback only for
$GITWEB_CONFIG_SYSTEM variable, and not for $GITWEB_CONFIG?  Currently
gitweb use environment variable if it exists, falling back to build-time
value (might be default), and using first of $GITWEB_CONFIG and 
$GITWEB_CONFIG_SYSTEM that exists.

> PS: thanks to everyone for their patience with my first patch.
> This applied cleanly with git am, let me know if I should do anything
> else differently.
> 
>  gitweb/gitweb.perl |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
> 
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 4efeebc..43294e1 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -605,6 +605,10 @@ sub evaluate_gitweb_config {
>  	} elsif (-e $GITWEB_CONFIG_SYSTEM) {
>  		do $GITWEB_CONFIG_SYSTEM;
>  		die $@ if $@;
> +	# if config file from env is missing, then try the default anyways

Minor nitpick: Actually that is not default, but build-time value, which
has a default.

> +	} elsif (-e "++GITWEB_CONFIG_SYSTEM++") {
> +		do "++GITWEB_CONFIG_SYSTEM++";
> +		die $@ if $@;
>  	}
>  }
>  
> -- 
> 1.7.0.4
