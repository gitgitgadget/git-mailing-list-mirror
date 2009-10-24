From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] tar: on extract, -o is --no-same-owner
Date: Sat, 24 Oct 2009 02:56:33 -0700 (PDT)
Message-ID: <m38wf1dsjf.fsf@localhost.localdomain>
References: <1256328943-22136-1-git-send-email-rep.dot.nop@gmail.com>
	<20091023202524.GE4615@mx.loc> <20091023210648.GA23122@mx.loc>
	<7vocnxajj6.fsf@alter.siamese.dyndns.org>
	<20091024091758.GF4615@mx.loc> <m28wf1unop.fsf@whitebox.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Bernhard Reutner-Fischer <rep.dot.nop@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, vda.linux@googlemail.com,
	busybox@busybox.net, git@vger.kernel.org
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Sat Oct 24 11:56:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N1dMl-0008IH-Sa
	for gcvg-git-2@lo.gmane.org; Sat, 24 Oct 2009 11:56:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751876AbZJXJ4a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Oct 2009 05:56:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751563AbZJXJ4a
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Oct 2009 05:56:30 -0400
Received: from mail-fx0-f218.google.com ([209.85.220.218]:57577 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751666AbZJXJ4a (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Oct 2009 05:56:30 -0400
Received: by fxm18 with SMTP id 18so10920713fxm.37
        for <git@vger.kernel.org>; Sat, 24 Oct 2009 02:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=o6/MeQlUYHCh8mymn3EiLObngYnB9gm7zZxQEOMkYgo=;
        b=gQLYmix+tw4UXkg3n7Lq9ABZHtloFvyAAO4fKkhqzkQrqBy7tuPXBTtpskM1iinWfL
         TI7KXNPrkHA3CXhu93Of5kET7PaBuwq9Prs8rtNlBKSRAOWTJkI04kxl2UMjZDUe1fUp
         RI6QjaoDRxF00dA9ZW4tWkO8Bu0n64HFqfiws=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=tv9yBy7KNhckYUnTSurxa8PsFtn7xRYk404FZDNyZ5Z9WZ0XTXUUDvrG71VWB+bVYL
         Dg3rgdK+E/gDWc+TmwRfu0Zv2B7ZvkD12OH99cF3clIjMXw2jA+sAZpD8AM9sw52E7XN
         dXoEi2oD9PFTHi9t9Z3dOeBf9gRNMYBLnzaDk=
Received: by 10.204.25.66 with SMTP id y2mr3512174bkb.59.1256378193863;
        Sat, 24 Oct 2009 02:56:33 -0700 (PDT)
Received: from localhost.localdomain (abwd230.neoplus.adsl.tpnet.pl [83.8.227.230])
        by mx.google.com with ESMTPS id 14sm135630bwz.9.2009.10.24.02.56.32
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 24 Oct 2009 02:56:33 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n9O9uP2Y017795;
	Sat, 24 Oct 2009 11:56:25 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n9O9uL2o017791;
	Sat, 24 Oct 2009 11:56:21 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <m28wf1unop.fsf@whitebox.home>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131155>

Andreas Schwab <schwab@linux-m68k.org> writes:
> Bernhard Reutner-Fischer <rep.dot.nop@gmail.com> writes:
>> On Fri, Oct 23, 2009 at 02:26:53PM -0700, Junio C Hamano wrote:
>>>Bernhard Reutner-Fischer <rep.dot.nop@gmail.com> writes:
>>>> On Fri, Oct 23, 2009 at 10:25:24PM +0200, Bernhard Reutner-Fischer wrote:
>>>>> On Fri, Oct 23, 2009 at 10:15:43PM +0200, Bernhard Reutner-Fischer wrote:
>>>>>>
>>>>>> GNU tar-1.22 handles 'o' as no-same-owner only on extract,
>>>>>> on create, 'o' would be --old-archive.

>>>>>  	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(template_instdir_SQ)'
>>>>>  	(cd blt && $(TAR) cf - .) | \
>>>>> -	(cd '$(DESTDIR_SQ)$(template_instdir_SQ)' && umask 022 && $(TAR) xfo -)
>>>>> +	(cd '$(DESTDIR_SQ)$(template_instdir_SQ)' && umask 022 && $(TAR) x --no-numeric-owner -f -)
>>>>
>>>> argh, sorry! --no-same-owner of course.
>>>
>>> Either way, your change would break non-GNU tar implementations that are
>>> properly POSIX.1, isn't it?
>>
>> I suppose xf - -o would work?
> 
> Isn't that the same as 'xfo -'?
> 
> (tar isn't specified by POSIX, btw.)

I don't quite understand why 'o' has to be spelled using long name
--no-same-owner, instead of just correcting the ordering of "old style"
short options to have 'f' last, i.e.

  $(TAR) xof -

and not (current)

  $(TAR) xfo -

-- 
Jakub Narebski
Poland
ShadeHawk on #git
