From: Gary Yang <garyyang6@yahoo.com>
Subject: Re: git-p4 submit, Can't clobber writable file
Date: Tue, 2 Dec 2008 22:04:20 -0800 (PST)
Message-ID: <410584.87710.qm@web37905.mail.mud.yahoo.com>
References: <20081203030729.GB5624@jabba.hq.digizenstudio.com>
Reply-To: garyyang6@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jing Xue <jingxue@digizenstudio.com>
X-From: git-owner@vger.kernel.org Wed Dec 03 07:07:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7ks0-0005FG-3x
	for gcvg-git-2@gmane.org; Wed, 03 Dec 2008 07:05:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752101AbYLCGEV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Dec 2008 01:04:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751977AbYLCGEV
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Dec 2008 01:04:21 -0500
Received: from web37905.mail.mud.yahoo.com ([209.191.91.167]:41408 "HELO
	web37905.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751319AbYLCGEU (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Dec 2008 01:04:20 -0500
Received: (qmail 89297 invoked by uid 60001); 3 Dec 2008 06:04:20 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:X-Mailer:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Message-ID;
  b=k/QDleoY2CTXlXW0+ww3C7V8aggyv0D5nDBYCxtlj1HJc6+qO0jbBmLpnK+ZBowjEln7N3ptL4Go+VCeG10EMwn60C05blnTVJe71176Pzxoim9RIKW7dxxNQHUEe4ex+f+DCK7m6rX6nA17VL4CdfnPBn0j1T4AUaFgDFJ4KhQ=;
X-YMail-OSG: So_DYdMVM1l3lCf1GP3NL2GcJlFZODmBXXz.BlqN.8QzoSyKIXgOHcCCyPB2_QXc6sJ9wBzNBYl5D6pZD13sok.kg8tExdaHYyBH5gTKVS6qhmvy0cT50k__byGS7hsEUOyvPX5LzXIUvQtxH2sJxchTcC2Wt4TbRPqKvbxUUfmZF1W5v6CElu2oNSK4
Received: from [69.236.84.58] by web37905.mail.mud.yahoo.com via HTTP; Tue, 02 Dec 2008 22:04:20 PST
X-Mailer: YahooMailWebService/0.7.260.1
In-Reply-To: <20081203030729.GB5624@jabba.hq.digizenstudio.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102216>

So, I have to keep two copies of source tree at my home directory. One is for Perforce build_scripts workspace, another is for Git build_scripts.git. I normally work at build_scripts.git. But, when I need to submit changes to Perforce, I have to copy changed code from build_scripts.git to build_scripts. Then, p4 submit code into Perforce. Is this the only way of using git-p4?
Note: I cannot use git-p4 submit at build_scripts. It claims "Cannot clobber writable file". Is it a bug of git-p4 or the instruction is not correct?


--- On Tue, 12/2/08, Jing Xue <jingxue@digizenstudio.com> wrote:

> From: Jing Xue <jingxue@digizenstudio.com>
> Subject: Re: git-p4 submit, Can't clobber writable file
> To: "Gary Yang" <garyyang6@yahoo.com>
> Cc: git@vger.kernel.org
> Date: Tuesday, December 2, 2008, 7:07 PM
> On Tue, Dec 02, 2008 at 02:30:51PM -0800, Gary Yang wrote:
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
> >   from sets import Set;
> > Perforce checkout for depot path //build/scripts/
> located at /home/gyang/workspace/build_scripts/
> > Syncronizing p4 checkout...
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
> You might want to clone to a git working dir different than
> the p4
> working dir.
> 
> For instance, if your p4 workspace has the working dir set
> to
> build_scripts/, try 'git p4 clone //build/scripts
> build_scripts.git'.
> 
> You would then normally work under build_scripts.git/.
> build_scripts/
> would only be used by git-p4 at submission time.
> 
> Cheers.
> -- 
> Jing Xue


      
