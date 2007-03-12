From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: svnimport problems (abysmal performance and crash) on Cygwin
Date: Mon, 12 Mar 2007 23:39:25 +1300
Message-ID: <46a038f90703120339j674e15cqe0e0fa587736f9bc@mail.gmail.com>
References: <45F4F58D.2010701@dawes.za.net> <45F50023.9030403@dawes.za.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>, normalperson@yhbt.net
To: "Rogan Dawes" <lists@dawes.za.net>
X-From: git-owner@vger.kernel.org Mon Mar 12 11:39:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQhwB-0003E6-Cc
	for gcvg-git@gmane.org; Mon, 12 Mar 2007 11:39:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965514AbXCLKj2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Mar 2007 06:39:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965519AbXCLKj2
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Mar 2007 06:39:28 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:58230 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965514AbXCLKj1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Mar 2007 06:39:27 -0400
Received: by nf-out-0910.google.com with SMTP id o25so1962674nfa
        for <git@vger.kernel.org>; Mon, 12 Mar 2007 03:39:26 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=hwJ7oiWB0L/vgZ9aOHt8q85NufpRNhaDBj26YksgOMlyvCdFh46QWGKDcDKWyXcNtiAiEhvuAxpwOE701F17xpXXODfPN5oiiM5rMKjQ3Q8HxJa+ITiunYS/Om8DWCdYsotV1PmIv7XvRPoHd+sBHPYXbhKiyblF7Wflg4gQdx4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Rv33bmqJWaYbrvWcRlviBX/FKqq2n+Qa12PapXEhpBtY9ioUl/U5IWw6vVTnC3SABIm4WwMZ1mpO/5lKg7b88w6kgfnewqfKjxREomvxOUBOApR3uVXmNSW1etFJND2MzdRXuYosQI8XrmR0/LEdOq32W0hmq4CxrT/8tboBMi4=
Received: by 10.82.163.13 with SMTP id l13mr7783134bue.1173695965298;
        Mon, 12 Mar 2007 03:39:25 -0700 (PDT)
Received: by 10.82.183.14 with HTTP; Mon, 12 Mar 2007 03:39:25 -0700 (PDT)
In-Reply-To: <45F50023.9030403@dawes.za.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42016>

Rogan,

it looks like your connection to the server is dodgy, or maybe the
server is being restarted, or has a throttle for "intense" clients.

After it failes, you should be able to do

   git-checkout -b master

and then rerun git-svnimport $params as many times as needed until it
completes.

cheers,


maritn




On 3/12/07, Rogan Dawes <lists@dawes.za.net> wrote:
> Rogan Dawes wrote:
> > Hi folks,
> >
> > I am trying to use git to track the Spring Rich Client project's SVN
> > repository, along with some local changes. I am using git 1.5.0.3 as
> > packaged by Cygwin, on Windows XP SP2.
> >
> > The repo's URL is:
> >
> > <http://spring-rich-c.svn.sourceforge.net/svnroot/spring-rich-c/trunk/spring-richclient>
> >
> >
> > I start the import using:
> >
> > git svnimport -v $url
> >
> > and then wait (and wait and wait). For some reason, revision 5 takes
> > over an hour to complete, from version 4. The repo is not substantial
> > (when it eventually fails on rev 102, the unpacked repo is only 148kB).
> >
> > In addition, it does not complete the import successfully.
> >
> > Eventually (I left it running while I slept), it crashes on rev 102 with
> > the following message:
> >
> > Tree ID 4b825dc642cb6eb9a060e54bf8d69288fbee4904
> > Committed change 102:/ 2004-08-03 04:53:31)
> > Merge parent branch: ab10f9f06566e0fbdb3ee57d7489b53567f313d3
> > Commit ID 722f84d2578f84a1b64904b0b425e02c0397c40e
> > Writing to refs/heads/origin
> > DONE: 102 origin 722f84d2578f84a1b64904b0b425e02c0397c40e
> > RA layer request failed: REPORT request failed on
> > '/svnroot/spring-rich-c/!svn/bc/1001/trunk/spring-richclient': REPORT of
> > '/svnroot/spring-rich-c/!svn/bc/1001/trunk/spring-richclient': 200 OK
> > (http://spring-rich-c.svn.sourceforge.net) at /usr/bin/git-svnimport
> > line 955
> >
> > Any ideas what might be going on? Or suggestions for debugging this
> > further?
> >
> > Many thanks
> >
> > Rogan
> >
> > P.S. It also looks like Rev 4-5 takes quite a long time under Linux as
> > well, from initial analysis.
>
> Another data point:
>
> I ran it on a Linux server I have access to, and it got further (rev
> 147), but still failed. The error message was different, though:
>
> Tree ID 4b825dc642cb6eb9a060e54bf8d69288fbee4904
> Committed change 147:/ 2004-08-12 18:23:53)
> Merge parent branch: 1f053b959bdee167f328cf98116179358d80fef9
> Commit ID ef57373cfd1ef6ddf797a4b5ea66de6465391789
> Writing to refs/heads/origin
> DONE: 147 origin ef57373cfd1ef6ddf797a4b5ea66de6465391789 at Mon Mar 12
> 06:40:47 2007
> RA layer request failed: REPORT request failed on
> '/svnroot/spring-rich-c/!svn/bc/1001/trunk/spring-richclient': REPORT of
> '/svnroot/spring-rich-c/!svn/bc/1001/trunk/spring-richclient': Could not
> read response body: connection was closed by server.
> (http://spring-rich-c.svn.sourceforge.net) at
> /home/rdawes/bin/git-svnimport line 955
>
> Rogan
>
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
