From: "Aaron Gray" <aaronngray.lists@googlemail.com>
Subject: Re: git & ssh on F10 server
Date: Fri, 17 Apr 2009 19:00:24 +0100
Message-ID: <637436EA5D5846208F8432D51B63D87D@HPLAPTOP>
References: <489CF11BD65F439998B6CF3FCC610576@HPLAPTOP> <alpine.LNX.2.00.0904171716150.8346@reaper.quantumfyre.co.uk> <FD77671D77E2465097BD60A1E144BB91@HPLAPTOP> <alpine.LNX.2.00.0904171812330.8773@reaper.quantumfyre.co.uk>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=response
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: "Julian Phillips" <julian@quantumfyre.co.uk>
X-From: git-owner@vger.kernel.org Fri Apr 17 20:06:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LusSM-0003hb-Tx
	for gcvg-git-2@gmane.org; Fri, 17 Apr 2009 20:06:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760816AbZDQSEz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Apr 2009 14:04:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759814AbZDQSEy
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Apr 2009 14:04:54 -0400
Received: from mail-ew0-f176.google.com ([209.85.219.176]:45401 "EHLO
	mail-ew0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755922AbZDQSEx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Apr 2009 14:04:53 -0400
Received: by ewy24 with SMTP id 24so340934ewy.37
        for <git@vger.kernel.org>; Fri, 17 Apr 2009 11:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:from:to:cc
         :references:subject:date:mime-version:content-type
         :content-transfer-encoding:x-priority:x-msmail-priority:x-mailer
         :x-mimeole;
        bh=yUN6ERQlLe+m+J60AVtvV8IKoYANqQoiOHur78wvUTs=;
        b=sCZysDDrOcrC44tFiKSTUy5+8mi8LmQNzYzkyHwE1MJNvnBB+Sn1zLEG2BH+hsyCv7
         piaygLtmUz5X+OrpYULikTS609kvO8W/BA/d+9i3Hf+ljpbfJolfz3ptQ6PpHDO1/JRm
         nO/yejz99YSZgey5mdEuzomhRTccXcSxWaUok=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=message-id:from:to:cc:references:subject:date:mime-version
         :content-type:content-transfer-encoding:x-priority:x-msmail-priority
         :x-mailer:x-mimeole;
        b=gy3VtkQW5ioJTGhvrEyLTKCwoylLGWEXTZHh8jSl12/OPIYsk6CiG7Fz/i2A9xjNDa
         tb+1t2v7SIPu5LRWPHj1a1lB3ctXsdyBzrpDXcpBUXHYCK/PfBBXt6u6mnoa6w75lZiP
         o2D707YzLDPChPkEtgn/qIkSPZ+bFfSf6BfWE=
Received: by 10.210.110.5 with SMTP id i5mr930887ebc.34.1239991492007;
        Fri, 17 Apr 2009 11:04:52 -0700 (PDT)
Received: from HPLAPTOP (mwgray.force9.co.uk [212.159.110.144])
        by mx.google.com with ESMTPS id 28sm3937342eye.14.2009.04.17.11.04.51
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 17 Apr 2009 11:04:51 -0700 (PDT)
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5512
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.5579
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116765>

> On Fri, 17 Apr 2009, Aaron Gray wrote:
>
>> Julian,
>>
>> Thanks for the response.
>
> Not a problem, but please keep the mailing list on the CC ...
>
>>>  On Fri, 17 Apr 2009, Aaron Gray wrote:
>>>
>>> >  Hi,
>>> >
>>> >  we have a Fedora 10 server in SELinux enforcing mode setup running 
>>> > git-deamon and gitweb (with home grown SElinux policy).
>>> >
>>> >  Anyway now we find out you cannot do a 'push' over the basic git 
>>> > protocol, back to the server repository.
>>>
>>>  You can push over git://, but you get no authentication mechanism so 
>>> it's
>>>  disabled by default.  It's only really useful if you trust everyone who
>>>  has IP access to the server.
>>
>> How do go about I enabling it ?
>
> You have to enable the receive-pack service.  You can either enable it for 
> all repositories by using the --enable=<service> option to git-daemon, or 
> on a per-repository basis by setting daemon.receivepack to true in the 
> repositories that you want to enable push for.

Thanks, I'll make a note of that.

>>> >  So now am trying to get git to work over ssh. The repositories are 
>>> > located /pub/git/*/.git
>>> >
>>> >  Basic attempts using BerliOS'es instructions for client end failed.
>>> >
>>> >
>>> > 
>>> > http://developer.berlios.de/docman/display_doc.php?docid=1812&group_id=2
>>> >
>>> >  Could someone please help us with this.
>>> >
>>> >  Aaron
>>>
>>>  You haven't said what commands you tried, nor what the errors you 
>>> received
>>>  were, so it's a bit hard to say what went wrong ...
>>>
>>
>> git push ssh://ang@git.site.org/pub/git/llvm/trunk milestone1
>> Pushing to ssh://ang@git.site.org/pub/git/llvm/trunk
>> fatal:  exec ssh failed.
>> fatal:  The remote end hung up unexpectedly
>
> Sounds like git didn't find ssh on your path.
> What version of git is this btw?

Yep. No ssh installed in Cygwin.

Thanks Julian, I am getting lax these days !

Aaron
