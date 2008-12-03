From: Gary Yang <garyyang6@yahoo.com>
Subject: Re: git-p4 submit, Can't clobber writable file
Date: Tue, 2 Dec 2008 16:14:05 -0800 (PST)
Message-ID: <94261.93438.qm@web37908.mail.mud.yahoo.com>
References: <3f4fd2640812021551t5451e6e3i91e6d2694c89e085@mail.gmail.com>
Reply-To: garyyang6@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Reece Dunn <msclrhd@googlemail.com>
X-From: git-owner@vger.kernel.org Wed Dec 03 01:15:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7fOv-0001Us-ST
	for gcvg-git-2@gmane.org; Wed, 03 Dec 2008 01:15:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754733AbYLCAOL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Dec 2008 19:14:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754676AbYLCAOK
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Dec 2008 19:14:10 -0500
Received: from web37908.mail.mud.yahoo.com ([209.191.91.170]:20756 "HELO
	web37908.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754230AbYLCAOH (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 Dec 2008 19:14:07 -0500
Received: (qmail 93999 invoked by uid 60001); 3 Dec 2008 00:14:05 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:X-Mailer:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Message-ID;
  b=0gVdM11px6D3ex7Kz4Sb3fM30keRQxo42B3wB+lAWiX/gU1UfIILX05yDW+proMqccFOgq8PgvjoB9udo3x1nVIRhYfpSGUS5K5ZJtSJRChsEyzbPQNLKl0pR4rZ+qoyzuowanBT/gLq9l9msFAAOMkOnmp5vFsSNQYLnWZfUoY=;
X-YMail-OSG: wMb7EzwVM1lQQYyLSbuKjOQU3a8qx9X58jSCLNVZOf3wQkW1L8RcRCr5k9lQgBPS22lprDfdX9ugL3jwinURPuvtzIWgKwZvRio_Xzz7xH3NQ1FuFBagCN_6k.NkhLffZnFirTn4iAv1gfsiMxFa2RgGMnjVOp.eqEx4WGM6MW4qeMHw0CpCIx4ZzClJ
Received: from [76.195.33.70] by web37908.mail.mud.yahoo.com via HTTP; Tue, 02 Dec 2008 16:14:05 PST
X-Mailer: YahooMailWebService/0.7.260.1
In-Reply-To: <3f4fd2640812021551t5451e6e3i91e6d2694c89e085@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102192>

Reece,

I understand your explanation. But, git-p4 submit does not work for me. Are you able to re-produce the problem?

Thanks,

Gary


--- On Tue, 12/2/08, Reece Dunn <msclrhd@googlemail.com> wrote:

> From: Reece Dunn <msclrhd@googlemail.com>
> Subject: Re: git-p4 submit, Can't clobber writable file
> To: garyyang6@yahoo.com
> Cc: git@vger.kernel.org
> Date: Tuesday, December 2, 2008, 3:51 PM
> 2008/12/2 Gary Yang <garyyang6@yahoo.com>:
> >
> > I followed the instructions at
> http://modular.math.washington.edu/home/mhansen/git-1.5.5.1/contrib/fast-import/git-p4.txt
> >
> > But, I am not able to git-p4 submit. Any idea?
> >
> > git-p4 clone //build/scripts build_scripts
> > cd build_scripts
> > vi foo.h
> > git commit foo.h
> > git-p4 rebase
> > git-p4 submit
> >
> >  from sets import Set;
> > Perforce checkout for depot path //build/scripts/
> located at /home/gyang/workspace/build_scripts/
> > Syncronizing p4 checkout...
> 
> This will be running a `p4 sync ...` command to ensure that
> the files
> are up-to-date.
> 
> > //build/scripts/foo.h#1 - added as
> /home/gyang/workspace/build_scripts/foo.h
> > Can't clobber writable file
> /home/gyang/workspace/build_scripts/foo.h
> > //build/scripts/foo.c#1 - added as
> /home/gyang/workspace/build_scripts/foo.c
> > Can't clobber writable file
> /user/home/gyang/workspace/build_scripts/foo.c
> > ......
> > command failed: p4 sync ...
> 
> Perforce will mark files as readonly when it does a
> checkout. When you
> use `p4 edit` to say you have made changes to the file,
> Perforce
> removes the readonly bit.
> 
> What is happening here is that the sync (checkout) command
> is trying
> to write foo.h/c to your build_scripts directory, but
> because they
> already exist there *and* are not readonly, Perforce is
> producing that
> error as it does not want to overwrite any files that have
> changed
> locally.
> 
> Not sure what is happening on the git-p4 side, though.
> 
> - Reece


      
