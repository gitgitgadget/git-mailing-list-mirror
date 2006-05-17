From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [PATCH 1/2] Handle branch names with slashes
Date: Wed, 17 May 2006 16:18:49 +0100
Message-ID: <b0943d9e0605170818j380a6daaif42f2acbf627104f@mail.gmail.com>
References: <20060515105810.GA27077@diana.vm.bytemark.co.uk>
	 <20060516063541.GA11218@backpacker.hemma.treskal.com>
	 <7v64k6ea8r.fsf@assigned-by-dhcp.cox.net>
	 <20060516074504.GA27234@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Junio C Hamano" <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 17 17:19:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FgNnb-00013T-RH
	for gcvg-git@gmane.org; Wed, 17 May 2006 17:18:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750934AbWEQPSx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 17 May 2006 11:18:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751300AbWEQPSx
	(ORCPT <rfc822;git-outgoing>); Wed, 17 May 2006 11:18:53 -0400
Received: from wx-out-0102.google.com ([66.249.82.193]:9558 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1750934AbWEQPSt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 May 2006 11:18:49 -0400
Received: by wx-out-0102.google.com with SMTP id s6so180009wxc
        for <git@vger.kernel.org>; Wed, 17 May 2006 08:18:49 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ppJavHwkD8malfmARs5HTnLWGXn7Kpp5xarkxg2eHtpBsMPoBRImOJ/oPNAL7zI5xWXtJz//pRPmMCnnblV/HsSrjU//ufJwrZWz1baW5+GWoyjhENidDDfZ8BsL1tVw8tnWPb3UZfpfyOJXSf3UCH5gFSY38AV+4/7dmeekiBc=
Received: by 10.70.59.2 with SMTP id h2mr696269wxa;
        Wed, 17 May 2006 08:18:49 -0700 (PDT)
Received: by 10.70.31.2 with HTTP; Wed, 17 May 2006 08:18:49 -0700 (PDT)
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
In-Reply-To: <20060516074504.GA27234@diana.vm.bytemark.co.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20207>

On 16/05/06, Karl Hasselstr=F6m <kha@treskal.com> wrote:
> On 2006-05-15 23:48:04 -0700, Junio C Hamano wrote:
>
> > Karl Hasselstr=F6m <kha@treskal.com> writes:
> >
> > > I had to change the patch@branch/top command-line syntax to
> > > patch@branch%top, in order to get sane parsing. The /top variant
> > > is still available for repositories that have no slashy branches;
> > > it is disabled as soon as there exists at least one subdirectory
> > > of refs/heads. Preferably, this compatibility hack can be killed
> > > some time in the future.
> >
> > I wonder if using double-slashes is an easier alternative to type
> > than '%', like "patch@branch//top". That way, you do not have to
> > forbid per-cent sign in branch names.
>
> Good argument. And // does look slightly better than %, too. But I'll
> wait a few days this time, or else someone will surely come along wit=
h
> an even better idea. :-)

I also thing // is a better solution than %.

There is another option, a bit more complicated, "patch@branch:top".
This would imply replacing : with .. in the current handling of the -r
option in diff/mail/export but it would make the commit or patch
ranges look more like GIT's arguments.

--=20
Catalin
