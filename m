From: Gary Yang <garyyang6@yahoo.com>
Subject: Re: git-p4 submit, Can't clobber writable file
Date: Wed, 3 Dec 2008 11:06:53 -0800 (PST)
Message-ID: <210854.98218.qm@web37908.mail.mud.yahoo.com>
References: <1228302466.23167.1.camel@therock.nsw.bigpond.net.au>
Reply-To: garyyang6@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jing Xue <jingxue@digizenstudio.com>, git@vger.kernel.org
To: Arafangion <thestar@fussycoder.id.au>
X-From: git-owner@vger.kernel.org Wed Dec 03 20:08:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7x55-0008Ik-Mn
	for gcvg-git-2@gmane.org; Wed, 03 Dec 2008 20:08:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752848AbYLCTG4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Dec 2008 14:06:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752799AbYLCTG4
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Dec 2008 14:06:56 -0500
Received: from web37908.mail.mud.yahoo.com ([209.191.91.170]:29878 "HELO
	web37908.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752687AbYLCTGz (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Dec 2008 14:06:55 -0500
Received: (qmail 98277 invoked by uid 60001); 3 Dec 2008 19:06:54 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:X-Mailer:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Message-ID;
  b=bR2j9xZEVBPIIgMX2M/a+o2cdQQIMtD1vu/Ub5t3kNH3jCE90lV5vFq9n0fRRwzk5qn4x9v3qkncmPDx2gh9/BOY+DSouro8mWAFIt8rshKv6JO7oCt2/mFXvAYkkvBqVRXuGcugCrzvV38TZd/l8sCk5D+0bKWJreLRJP6YH4Q=;
X-YMail-OSG: pg.G0ikVM1m0HhEKkMl3_wo8Tsi1WZBsfLQPc_x6cE0SrnjP196nLQToUtpOcCpvGcc_152aq7cfnj48jR2S_8j1CTiOUYtpdlZuydXH5bvxYA_7yDPnNn_QVMjsvTbbbwhViISsempMCozpgIcjpGtl7IVXVjoIPeYGa_.66fJCBE0-
Received: from [76.195.33.70] by web37908.mail.mud.yahoo.com via HTTP; Wed, 03 Dec 2008 11:06:53 PST
X-Mailer: YahooMailWebService/0.7.260.1
In-Reply-To: <1228302466.23167.1.camel@therock.nsw.bigpond.net.au>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102278>

Arafangion,

I got email from Jing and I solved the problem. The doc should clearly state that we need a separated P4 working dir in order to make git p4 submit work. Many thanks to Jing.

Gary


--- On Wed, 12/3/08, Arafangion <thestar@fussycoder.id.au> wrote:

> From: Arafangion <thestar@fussycoder.id.au>
> Subject: Re: git-p4 submit, Can't clobber writable file
> To: garyyang6@yahoo.com
> Cc: "Jing Xue" <jingxue@digizenstudio.com>, git@vger.kernel.org
> Date: Wednesday, December 3, 2008, 3:07 AM
> I would argue that's a bug with git-p4, however that is
> a warning given
> by perforce, thus, you should be able to work around it by
> changing the
> clientspec, change the clientspec so that it will clobber
> such files,
> you will need to refer to the perforce docs for info about
> that.
> 
> On Tue, 2008-12-02 at 22:04 -0800, Gary Yang wrote:
> > So, I have to keep two copies of source tree at my
> home directory. One is for Perforce build_scripts workspace,
> another is for Git build_scripts.git. I normally work at
> build_scripts.git. But, when I need to submit changes to
> Perforce, I have to copy changed code from build_scripts.git
> to build_scripts. Then, p4 submit code into Perforce. Is
> this the only way of using git-p4?
> > Note: I cannot use git-p4 submit at build_scripts. It
> claims "Cannot clobber writable file". Is it a bug
> of git-p4 or the instruction is not correct?
> > 
> > 
> > --- On Tue, 12/2/08, Jing Xue
> <jingxue@digizenstudio.com> wrote:
> > 
> > > From: Jing Xue <jingxue@digizenstudio.com>
> > > Subject: Re: git-p4 submit, Can't clobber
> writable file
> > > To: "Gary Yang"
> <garyyang6@yahoo.com>
> > > Cc: git@vger.kernel.org
> > > Date: Tuesday, December 2, 2008, 7:07 PM
> > > On Tue, Dec 02, 2008 at 02:30:51PM -0800, Gary
> Yang wrote:
> > > > 
> > > > I followed the instructions at
> > >
> http://modular.math.washington.edu/home/mhansen/git-1.5.5.1/contrib/fast-import/git-p4.txt
> > > > 
> > > > But, I am not able to git-p4 submit. Any
> idea?
> > > > 
> > > > git-p4 clone //build/scripts build_scripts
> > > > cd build_scripts
> > > > vi foo.h
> > > > git commit foo.h
> > > > git-p4 rebase
> > > > git-p4 submit
> > > > 
> > > >   from sets import Set;
> > > > Perforce checkout for depot path
> //build/scripts/
> > > located at /home/gyang/workspace/build_scripts/
> > > > Syncronizing p4 checkout...
> > > > //build/scripts/foo.h#1 - added as
> > > /home/gyang/workspace/build_scripts/foo.h
> > > > Can't clobber writable file
> > > /home/gyang/workspace/build_scripts/foo.h
> > > > //build/scripts/foo.c#1 - added as
> > > /home/gyang/workspace/build_scripts/foo.c
> > > > Can't clobber writable file
> > > /user/home/gyang/workspace/build_scripts/foo.c
> > > > ......
> > > > command failed: p4 sync ...
> > > 
> > > You might want to clone to a git working dir
> different than
> > > the p4
> > > working dir.
> > > 
> > > For instance, if your p4 workspace has the
> working dir set
> > > to
> > > build_scripts/, try 'git p4 clone
> //build/scripts
> > > build_scripts.git'.
> > > 
> > > You would then normally work under
> build_scripts.git/.
> > > build_scripts/
> > > would only be used by git-p4 at submission time.
> > > 
> > > Cheers.
> > > -- 
> > > Jing Xue
> > 
> > 
> >       
> > --
> > To unsubscribe from this list: send the line
> "unsubscribe git" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at 
> http://vger.kernel.org/majordomo-info.html
> 
> --
> To unsubscribe from this list: send the line
> "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at 
> http://vger.kernel.org/majordomo-info.html


      
