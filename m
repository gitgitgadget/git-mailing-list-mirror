From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: Possible bug in 'git status' exit code is 1 instead of 0
Date: Tue, 9 Jan 2007 19:33:39 +0100
Message-ID: <e5bfff550701091033x51496b38x6c6f798e8a7ae795@mail.gmail.com>
References: <e5bfff550701090945u5a240fe9xf46cc40b030e1ba7@mail.gmail.com>
	 <7vhcv0m5md.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "GIT list" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jan 09 19:33:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4Ln5-0006XZ-Bn
	for gcvg-git@gmane.org; Tue, 09 Jan 2007 19:33:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932330AbXAISdk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 Jan 2007 13:33:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932332AbXAISdk
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jan 2007 13:33:40 -0500
Received: from py-out-1112.google.com ([64.233.166.183]:63902 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932330AbXAISdk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jan 2007 13:33:40 -0500
Received: by py-out-1112.google.com with SMTP id a29so4272000pyi
        for <git@vger.kernel.org>; Tue, 09 Jan 2007 10:33:39 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=EAOVadSM8Qb+79OpVxcF0mGEBlmbexY9Gpm9nmmVAsxFqxahGe9xMDkRltaWVD9DO90SWFFwATuEOs5JlyVtmNKgg0Ya96kkeivs6gznSdUDe6CyRlZKXCCBw3tAoAxw+Z4Pp+Wrao8DqZvAK2C9F76Q/618pzQ9ay5/lCperRw=
Received: by 10.35.121.2 with SMTP id y2mr51406062pym.1168367619649;
        Tue, 09 Jan 2007 10:33:39 -0800 (PST)
Received: by 10.35.42.4 with HTTP; Tue, 9 Jan 2007 10:33:39 -0800 (PST)
To: "Junio C Hamano" <junkio@cox.net>
In-Reply-To: <7vhcv0m5md.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36383>

On 1/9/07, Junio C Hamano <junkio@cox.net> wrote:
> "Marco Costalba" <mcostalba@gmail.com> writes:
>
> > bash-3.1$ pwd
> > /home/marco/programmi/git
> > bash-3.1$ git status; echo $?
> > # On branch refs/heads/origin
> > nothing to commit (use "git add file1 file2" to include for commit)
> > 1
> > bash-3.1$ git --version
> > git version 1.5.0.rc0.g244a7
>
> I think that's normal and has been the way for git-commit to
> detect if there is anything to commit.
>
>

Ok, I was changing the error detection to check exit status, but it's
definitely better to still check for something written to stdErr
instead.

Thanks
Marco
