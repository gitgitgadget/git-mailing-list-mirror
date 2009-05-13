From: "Matthias Andree" <matthias.andree@gmx.de>
Subject: Re: [PATCH v3] To make GIT-VERSION-FILE, search for git more widely
Date: Wed, 13 May 2009 14:17:09 +0200
Message-ID: <op.utva2vxh1e62zd@balu>
References: <1241688129-31613-1-git-send-email-matthias.andree@gmx.de>
 <7v7i0scvcf.fsf@alter.siamese.dyndns.org>
 <op.utlq3vgx1e62zd@merlin.emma.line.org>
 <7vprek0ywq.fsf@alter.siamese.dyndns.org> <op.utlylkb61e62zd@balu>
 <7vskje6wsy.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; delsp=yes; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 13 14:17:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4DOi-0008Fv-Qg
	for gcvg-git-2@gmane.org; Wed, 13 May 2009 14:17:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757650AbZEMMRN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 May 2009 08:17:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755788AbZEMMRM
	(ORCPT <rfc822;git-outgoing>); Wed, 13 May 2009 08:17:12 -0400
Received: from mail.gmx.net ([213.165.64.20]:60659 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755070AbZEMMRL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 May 2009 08:17:11 -0400
Received: (qmail invoked by alias); 13 May 2009 12:17:11 -0000
Received: from balu.cs.uni-paderborn.de (EHLO balu.cs.uni-paderborn.de) [131.234.21.37]
  by mail.gmx.net (mp065) with SMTP; 13 May 2009 14:17:11 +0200
X-Authenticated: #428038
X-Provags-ID: V01U2FsdGVkX18R/tRTEgARViMf2UEf4nSBJ6VvUWAUqQuGFCQu6m
	hKk+ooesVlEFtE
Received: from [127.0.0.1] (helo=balu)
	by balu.cs.uni-paderborn.de with esmtp (Exim 4.69)
	(envelope-from <matthias.andree@gmx.de>)
	id KJL0SM-0003VG-AP; Wed, 13 May 2009 14:17:10 +0200
In-Reply-To: <7vskje6wsy.fsf@alter.siamese.dyndns.org>
User-Agent: Opera Mail/9.64 (Win32)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.54
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119043>

Am 09.05.2009, 18:55 Uhr, schrieb Junio C Hamano <gitster@pobox.com>:

> "Matthias Andree" <matthias.andree@gmx.de> writes:
>
>>> Fine then.  Or you could just append "." to the $PATH ;-)
>>
>> "." in the super user's PATH? Cool stuff, and so innovative.
>
> I didn't mean to suggest PATH=$PATH:. *in the user's environment* ;-).
> You do that inside GIT-VERSION-FILE, which is essentially the same thing
> as running ./git$X from there.

No, it is not -- the scope of the GIT variable is much narrower than doing  
PATH=$PATH:. in the script.

BTW, in the earlier version, I used type(1) to take $PATH search into  
account in case GIT=git; test -x does not do path search, unlike type.

> What's innovative is whoever is running build as root.

Yes, and that is why I found the PATH-dependent behaviour so irritating  
and wanted to fix it. I have another approach cooking that entails  
factoring out common code from ./git-gui/GIT-VERSION-GEN and  
./GIT-VERSION-GEN into ./git-gui/GIT-VERSION-SUBR.

For any approach taken, we'll have to touch both the shell and the  
Makefile, unless we want to manually redo things in the GIT-VERSION-GEN  
script that were already done automatically or programmatically in  
Makefile.

Please let me know if you're willing to accept a patch that touches both  
Makefile and the GIT-VERSION-* shell scripts. If you don't, I can quit  
here and not waste further time on submissions that are inacceptable  
anyhow, but just keep rebasing my local patch instead.

Best regards

-- 
Matthias Andree
