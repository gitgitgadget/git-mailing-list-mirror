From: Bernhard Reutner-Fischer <rep.dot.nop@gmail.com>
Subject: Re: [PATCH] tar: on extract, -o is --no-same-owner
Date: Sat, 24 Oct 2009 12:06:21 +0200
Message-ID: <20091024100621.GH4615@mx.loc>
References: <1256328943-22136-1-git-send-email-rep.dot.nop@gmail.com>
 <20091023202524.GE4615@mx.loc>
 <20091023210648.GA23122@mx.loc>
 <7vocnxajj6.fsf@alter.siamese.dyndns.org>
 <20091024091758.GF4615@mx.loc>
 <m28wf1unop.fsf@whitebox.home>
 <m38wf1dsjf.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andreas Schwab <schwab@linux-m68k.org>,
	Junio C Hamano <gitster@pobox.com>, vda.linux@googlemail.com,
	busybox@busybox.net, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 24 12:05:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N1dVW-0002gd-Qc
	for gcvg-git-2@lo.gmane.org; Sat, 24 Oct 2009 12:05:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752106AbZJXKFt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Oct 2009 06:05:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752034AbZJXKFt
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Oct 2009 06:05:49 -0400
Received: from mail-fx0-f218.google.com ([209.85.220.218]:58765 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751563AbZJXKFs (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Oct 2009 06:05:48 -0400
Received: by fxm18 with SMTP id 18so10923816fxm.37
        for <git@vger.kernel.org>; Sat, 24 Oct 2009 03:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:from:to:cc
         :subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=w+Y+kXfeppN5ci92U0t8Mj1PB8K23/D8WQE2aTrbOzY=;
        b=SKCz50Qp67ORuNUgvZ31AVWnbsXbUnLFDadBlZtk3ZDipCmBeia/Q3R1i7vAQXEZXq
         Uan7e/svwY3IbfmwiPv8ZiKsKvyxPI1462iyejHHfksb9fX+fw4snjmhgJlinEDyFao4
         6U2290dXvzZ7eDCVnckN6somNTf5EHDOuUKeA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=ap1q0oWYfPRQyPm5bPAtTxG6YnZMyx5cMnlvej7TR4jUHa+7J+/0fFWo0uel+gNbC+
         Rg56oWfCPcvVAGw+TyaD1XzLDTGYX5ET/F1PeTRs5tJWfP9OUgaJyN+1G6A+HpDkx83T
         yaFWkwnIH3woqR7qjMBiES/SZJ/cQCbW392Yc=
Received: by 10.204.36.210 with SMTP id u18mr3523362bkd.19.1256378752152;
        Sat, 24 Oct 2009 03:05:52 -0700 (PDT)
Received: from s42.loc (85-127-251-67.dynamic.xdsl-line.inode.at [85.127.251.67])
        by mx.google.com with ESMTPS id 15sm497634bwz.4.2009.10.24.03.05.50
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 24 Oct 2009 03:05:51 -0700 (PDT)
Received: from cow by s42.loc with local (Exim 4.69)
	(envelope-from <rep.dot.nop@gmail.com>)
	id 1N1dVt-00015S-Lv; Sat, 24 Oct 2009 12:06:21 +0200
Content-Disposition: inline
In-Reply-To: <m38wf1dsjf.fsf@localhost.localdomain>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131157>

On Sat, Oct 24, 2009 at 02:56:33AM -0700, Jakub Narebski wrote:
>Andreas Schwab <schwab@linux-m68k.org> writes:
>> Bernhard Reutner-Fischer <rep.dot.nop@gmail.com> writes:
>>> On Fri, Oct 23, 2009 at 02:26:53PM -0700, Junio C Hamano wrote:
>>>>Bernhard Reutner-Fischer <rep.dot.nop@gmail.com> writes:
>>>>> On Fri, Oct 23, 2009 at 10:25:24PM +0200, Bernhard Reutner-Fischer wrote:
>>>>>> On Fri, Oct 23, 2009 at 10:15:43PM +0200, Bernhard Reutner-Fischer wrote:
>>>>>>>
>>>>>>> GNU tar-1.22 handles 'o' as no-same-owner only on extract,
>>>>>>> on create, 'o' would be --old-archive.
>
>>>>>>  	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(template_instdir_SQ)'
>>>>>>  	(cd blt && $(TAR) cf - .) | \
>>>>>> -	(cd '$(DESTDIR_SQ)$(template_instdir_SQ)' && umask 022 && $(TAR) xfo -)
>>>>>> +	(cd '$(DESTDIR_SQ)$(template_instdir_SQ)' && umask 022 && $(TAR) x --no-numeric-owner -f -)
>>>>>
>>>>> argh, sorry! --no-same-owner of course.
>>>>
>>>> Either way, your change would break non-GNU tar implementations that are
>>>> properly POSIX.1, isn't it?
>>>
>>> I suppose xf - -o would work?
>> 
>> Isn't that the same as 'xfo -'?
>> 
>> (tar isn't specified by POSIX, btw.)
>
>I don't quite understand why 'o' has to be spelled using long name
>--no-same-owner, instead of just correcting the ordering of "old style"

It doesn't have to be, right.

>short options to have 'f' last, i.e.
>
>  $(TAR) xof -
>
>and not (current)
>
>  $(TAR) xfo -

any of "xf - -o" or "xof -" would work for me.
