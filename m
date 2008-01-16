From: "Paul Umbers" <paul.umbers@gmail.com>
Subject: Re: Git Cygwin - unable to create any repository - help!
Date: Wed, 16 Jan 2008 11:48:28 -0700
Message-ID: <a5eb9c330801161048x4b5a88dcsebd7cf9754f72ba6@mail.gmail.com>
References: <20080114202932.GA25130@steel.home>
	 <20080115200437.GB3213@steel.home>
	 <a5eb9c330801151212y30cf4f63r9c294ba33da2b8f@mail.gmail.com>
	 <200801160002.51048.robin.rosenberg.lists@dewire.com>
	 <20080116071832.GA2896@steel.home>
	 <a5eb9c330801160742j645ee50p72ee0a93adf8f94f@mail.gmail.com>
	 <20080116183124.GA3181@steel.home>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_4035_11618818.1200509308825"
Cc: "Robin Rosenberg" <robin.rosenberg.lists@dewire.com>,
	git@vger.kernel.org
To: "Alex Riesen" <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 16 19:49:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFDJr-0002oq-Dv
	for gcvg-git-2@gmane.org; Wed, 16 Jan 2008 19:48:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752057AbYAPSsb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2008 13:48:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751487AbYAPSsa
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jan 2008 13:48:30 -0500
Received: from wa-out-1112.google.com ([209.85.146.181]:64607 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751470AbYAPSsa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2008 13:48:30 -0500
Received: by wa-out-1112.google.com with SMTP id v27so578960wah.23
        for <git@vger.kernel.org>; Wed, 16 Jan 2008 10:48:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:references;
        bh=kXToyKyCGV2czLrLBRxBW0MSKN4mbTTVaPSg8Xii6xY=;
        b=qXsGWJVhPdFaDuuqAA+lB5GwKJ4tS1IYvDtdGOh39KksED7CuBkVOGtXNH/0XrzRzrEOv17My3b9wXEYs19yAejq1+RzNn0DoqV1zn8mD1UIXf2S9ZMHtjTIAxk3Ze5UkUoDS3Ac1+m0frDoiyBWX1UlyzOEk+bBS6D0sIXBRP0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=EN3JbjR9CqDRD8D1pByQg8hBjENHY7WSEGtMVKp76kmAyteEQLD7V08zRo8MVM+2kg8PIcC74Tvfxxkfix/GqMsMEefVPK308OniVcVKEBeB8gVg20mWzsREmKq2iV9BugxD632U6Idfz28K0K4zdAneW/WzSsCYrzhJGsWHPUw=
Received: by 10.114.67.2 with SMTP id p2mr1323077waa.1.1200509308914;
        Wed, 16 Jan 2008 10:48:28 -0800 (PST)
Received: by 10.114.137.1 with HTTP; Wed, 16 Jan 2008 10:48:28 -0800 (PST)
In-Reply-To: <20080116183124.GA3181@steel.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70718>

------=_Part_4035_11618818.1200509308825
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Latest output, log file attached:

paulumbers@Devteam29 ~/workspace/git/git-1.5.3
$ uname -a > somefile

paulumbers@Devteam29 ~/workspace/git/git-1.5.3
$ git init
Initialized empty Git repository in .git/

paulumbers@Devteam29 ~/workspace/git/git-1.5.3
$ strace -o log -f -m syscall ./git --exec-path=$(pwd) add somefile

paulumbers@Devteam29 ~/workspace/git/git-1.5.3
$ git ls-files -s somefile
100644 2ed63d326ffdb2fd4b703780f4d61f1893cac63b 0       somefile

Checking .git/objects/2e ... there is no sha1 file

>
> Ok, since you managed to compile it, could you please try to strace
> git-add? Cygwins strace is a bit unusual, but strace --help can
> provide enough information to configure it to trace filesystem
> operations.
>
> In the top-level of Git source directory:
>
>     $ uname -a > somefile
>     $ strace -o log -f -m syscall ./git --exec-path=$(pwd) add somefile
>     $ git ls-files -s somefile
>
> or
>
>     $ strace -o log -f -m syscall ./git --exec-path=$(pwd) hash-object somefile
>
> Than check if the sha1file is missing and send in the log.
>
>



-- 
Computer Science is no more about computers than astronomy is about telescopes.
--- Edsger W. Dijkstra

Paul Umbers MSc MBCS MIAP
paul.umbers@gmail.com

------=_Part_4035_11618818.1200509308825
Content-Type: application/x-gzip; name=log.tar.gz
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fbi85akd0
Content-Disposition: attachment; filename=log.tar.gz

H4sIAIBwb0UAA+3OMQ6CQBSE4TU2NnoDI502JAss7AmsPQNGQyEEAm5P7w2suIoexBtY2/pCYaMt
2Pxf85KZV0xeZmpoWtg4lhtFoU7khsYkQZ/3pAu0NZGJpZE8CBMbKE8Pvky45pzWnqeq1OWu2B/r
5vdfccrq0lV+7h/GmDWW1WWm2qrcqunzNplLcO9eu2Jhu89Ha6fXx3KtNn/bCAAAAAAAAAAAAAAA
AAD49gZE3OwEACgAAA==
------=_Part_4035_11618818.1200509308825--
