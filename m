From: "Aaron Gray" <aaronngray.lists@googlemail.com>
Subject: Re: git & ssh on F10 server
Date: Sat, 18 Apr 2009 16:58:33 +0100
Message-ID: <56F224865B074F398A67811CD80984C0@HPLAPTOP>
References: <489CF11BD65F439998B6CF3FCC610576@HPLAPTOP> <alpine.LNX.2.00.0904171716150.8346@reaper.quantumfyre.co.uk> <FD77671D77E2465097BD60A1E144BB91@HPLAPTOP> <alpine.LNX.2.00.0904171812330.8773@reaper.quantumfyre.co.uk> <DD909F216D254CDAB2A0C0847AEB75C0@HPLAPTOP> <alpine.LNX.2.00.0904181632150.20139@reaper.quantumfyre.co.uk>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=response
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: "Julian Phillips" <julian@quantumfyre.co.uk>
X-From: git-owner@vger.kernel.org Sat Apr 18 18:00:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LvCxj-0002aW-La
	for gcvg-git-2@gmane.org; Sat, 18 Apr 2009 18:00:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755951AbZDRP6l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Apr 2009 11:58:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753672AbZDRP6l
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Apr 2009 11:58:41 -0400
Received: from mail-ew0-f176.google.com ([209.85.219.176]:32807 "EHLO
	mail-ew0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755553AbZDRP6k (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Apr 2009 11:58:40 -0400
Received: by ewy24 with SMTP id 24so595849ewy.37
        for <git@vger.kernel.org>; Sat, 18 Apr 2009 08:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:from:to:cc
         :references:subject:date:mime-version:content-type
         :content-transfer-encoding:x-priority:x-msmail-priority:x-mailer
         :x-mimeole;
        bh=7BE3KIswplaC8ZeAxJi51U2LVWyrzVe86if8Ax0rHhQ=;
        b=lhSYVOhjzkeByGb+4kni7r7MUSyWuggGGT9p2yh2y9f2VIxkxnk6vqKeutQfE9eArU
         hpuo5JEAyAQAPfXM8vsBp474P3/opgRJbmrWgS8tJAliuKG9rF4KjdNFayVhobM+346F
         Y0FXJ0Ezy/dYP+PdUf+kKbSjzhVtXHMyMuCW0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=message-id:from:to:cc:references:subject:date:mime-version
         :content-type:content-transfer-encoding:x-priority:x-msmail-priority
         :x-mailer:x-mimeole;
        b=VRJZP2mU9/CzKEMyVH3OAoQtTLc2MAd7h8S5xT9vdPNnks7Xxdf0nBDmcg2Cjs7xCC
         SKm3yByJASsXz7X24KuVAtgxmLilfV5PJA0ychaPrqEJMKf9fsP1K+SzXBTkheFLKBtf
         I/9R74wa65A6dkLtYhWQ1EQroloJUl9dmtYtI=
Received: by 10.210.51.18 with SMTP id y18mr2947331eby.97.1240070318848;
        Sat, 18 Apr 2009 08:58:38 -0700 (PDT)
Received: from HPLAPTOP (mwgray.force9.co.uk [212.159.110.144])
        by mx.google.com with ESMTPS id 7sm85826eyg.44.2009.04.18.08.58.36
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 18 Apr 2009 08:58:38 -0700 (PDT)
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5512
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.5579
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116832>

> On Sat, 18 Apr 2009, Aaron Gray wrote:
>
>>>  On Fri, 17 Apr 2009, Aaron Gray wrote:
>>> > >   On Fri, 17 Apr 2009, Aaron Gray wrote:
>>> > >
>>> > > >   Hi,
>>> > > >
>>> > > >  we have a Fedora 10 server in SELinux enforcing mode setup 
>>> > > > running git-deamon and gitweb (with home grown SElinux policy).
>>> > > >
>>> > > >  Anyway now we find out you cannot do a 'push' over the basic git 
>>> > > > protocol, back to the server repository.
>>> > >
>>> > >  You can push over git://, but you get no authentication mechanism 
>>> > > so it's
>>> > >   disabled by default.  It's only really useful if you trust 
>>> > > everyone who
>>> > >   has IP access to the server.
>>> >
>>> >  How do go about I enabling it ?
>>>
>>>  You have to enable the receive-pack service.  You can either enable it 
>>> for
>>>  all repositories by using the --enable=<service> option to git-daemon, 
>>> or
>>>  on a per-repository basis by setting daemon.receivepack to true in the
>>>  repositories that you want to enable push for.
>>
>> Okay I have added the following to 'config' :-
>>
>> [daemon]
>>        receivepack = true
>>
>> and done an 'service xinetd restart' just in case, probably not needed.
>>
>> I have tried a 'git push git://.../repo' but it is hanging, btw I am 
>> using Cygwin on the client, and F10 on the server.
>
> What output do you get?

None.

>  What version of git are you using (client and server)?

Server: F10
        git is version 1.6.0.6
        git-daemon 1.6.0.6-3.fc10.i386

Client: Cygwin
        git is version 1.6.1.2

> Do you get any output logged by the git daemon?

I dont seem to have logging on at all. How do I enable it ?
I am running git-daemon via xinetd

Aaron

>> Trying to clone an empty repository also hangs. btw I have sucessfully 
>> cloned big repositories.
>>
>> Aaron
>
> -- 
> Julian
>
>  ---
> Yes, but every time I try to see things your way, I get a headache. 
