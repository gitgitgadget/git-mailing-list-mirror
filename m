From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC/PATCH 14] autoconf: Added --with/--without for openssl, curl, expat to ./configure
Date: Sat, 1 Jul 2006 19:55:22 +0200
Message-ID: <200607011955.23908.jnareb@gmail.com>
References: <200606290301.51657.jnareb@gmail.com> <e848pr$cca$1@sea.gmane.org> <20060630233004.7xckw444g4g0gcs8@webmail.spamcop.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sat Jul 01 19:55:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fwjgg-00068j-9H
	for gcvg-git@gmane.org; Sat, 01 Jul 2006 19:55:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750734AbWGARzM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 1 Jul 2006 13:55:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750939AbWGARzM
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Jul 2006 13:55:12 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:39672 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750734AbWGARzK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Jul 2006 13:55:10 -0400
Received: by nf-out-0910.google.com with SMTP id k26so129434nfc
        for <git@vger.kernel.org>; Sat, 01 Jul 2006 10:55:09 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=VDm2+ptTucrknUYsZyf2rT+7+evqWD6lYR/lFAQC/Yxdjvlu2RGB2uwvqkcE+IEFocsYLfwaPsNQO8NeQaYwl/M37gqONGnREW55TY3/H1D3bn1oNvOfuxV3ehBl6efuttT4havtgc6oEirGRCXuXa0Gw9m/Rz6k3wOGDgHBw8I=
Received: by 10.49.27.10 with SMTP id e10mr1134072nfj;
        Sat, 01 Jul 2006 10:55:08 -0700 (PDT)
Received: from host-81-190-27-124.torun.mm.pl ( [81.190.27.124])
        by mx.gmail.com with ESMTP id g1sm2329815nfe.2006.07.01.10.55.07;
        Sat, 01 Jul 2006 10:55:08 -0700 (PDT)
To: Pavel Roskin <proski@gnu.org>, git@vger.kernel.org
User-Agent: KMail/1.9.3
In-Reply-To: <20060630233004.7xckw444g4g0gcs8@webmail.spamcop.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23051>

Pavel Roskin wrote:
> Hi Jakub,
> 
> you lost cc: but please feel free to return to the list.

Sending reply to GMane newsgroup tied to mailing list, and via email 
to author, but _not_ via mail to mailing list would do that... 
especially if the author I'm replying to doesn't use newsgroup 
interface.
 
> Quoting Jakub Narebski <jnareb@gmail.com>:

>> I suspect that AS_HELP_WITH does some strange quoting, or stripping. Both
>> [=PATH] and [[=PATH]] produces =PATH in ./configure --help output.
>> When using @<:@=PATH@:>@ I get [=PATH], but the description of option begins
>> line below.
> 
> If you are not following quoting rules, every macro can do strange things!

Well, [=PATH] or [[=PATH]] doesn't work even if GIT_APPEND_LINE is without
double quotes. Besides, that doesn't matter because this is inside of 
AS_HELP_STRING macro. No combination of quoting (I think I tried all)
works... I guess I would just not use AS_HELP_STRING, and format help 
message "by hand".

>> Any ideas for name of MY_APPEND_LINE(LINE)/GIT_APPEND_LINE(LINE) macro,
>> which as a result adds line to output (e.g. LINE = "NO_CURL=YesPlease")?
> 
> GIT_LIB_CURL
> 
> Generally, please try to avoid negations.  They are confising to the end users. 
> Lack of curl may be an anomaly to git developers, but it is not an anomaly for a
> user who has never heard of curl.  If you can, try to use positive logic, like
> CURL=1, and translate it to negative logic only as a temporary solution and far
> away from the user's eyes.

I'm following example set by main Makefile. That, and I tried to make configure.ac
as simple as possible...


By the way, if you know autoconf well, perhaps you could tell me how to write
tests for the following programs: ar, tar, rpmbuild, how to write test for
Python version (or rather for WITH_OWN_SUBPROCESS_PY) and other test autoconf.ac
lacks now (NEEDS_SSL_WITH_CRYPTO, NEEDS_LIBICONV, NEEDS_SOCKET, NO_MMAP,
NO_IPV6, NO_ICONV, NO_ACCURATE_DIFF unless that was removed or changed name).

-- 
Jakub Narebski
ShadeHawk on #git
