From: Arafangion <thestar@fussycoder.id.au>
Subject: Re: git-p4 submit, Can't clobber writable file
Date: Wed, 03 Dec 2008 22:07:46 +1100
Message-ID: <1228302466.23167.1.camel@therock.nsw.bigpond.net.au>
References: <410584.87710.qm@web37905.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Jing Xue <jingxue@digizenstudio.com>, git@vger.kernel.org
To: garyyang6@yahoo.com
X-From: git-owner@vger.kernel.org Wed Dec 03 15:20:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7sa0-0003jp-1K
	for gcvg-git-2@gmane.org; Wed, 03 Dec 2008 15:19:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751078AbYLCOSf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Dec 2008 09:18:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751161AbYLCOSf
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Dec 2008 09:18:35 -0500
Received: from nskntqsrv03p.mx.bigpond.com ([61.9.168.237]:35461 "EHLO
	nskntqsrv03p.mx.bigpond.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750918AbYLCOSe (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Dec 2008 09:18:34 -0500
Received: from nskntotgx02p.mx.bigpond.com ([58.173.132.215])
          by nskntmtas01p.mx.bigpond.com with ESMTP
          id <20081203105651.MQRY18010.nskntmtas01p.mx.bigpond.com@nskntotgx02p.mx.bigpond.com>;
          Wed, 3 Dec 2008 10:56:51 +0000
Received: from therock.local ([58.173.132.215])
          by nskntotgx02p.mx.bigpond.com with ESMTP
          id <20081203105646.IYDF1284.nskntotgx02p.mx.bigpond.com@therock.local>;
          Wed, 3 Dec 2008 10:56:46 +0000
In-Reply-To: <410584.87710.qm@web37905.mail.mud.yahoo.com>
X-Mailer: Evolution 2.6.3 
X-RPD-ScanID: Class unknown; VirusThreatLevel unknown, RefID str=0001.0A150204.493665EF.000F,ss=1,fgs=0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102262>

I would argue that's a bug with git-p4, however that is a warning given
by perforce, thus, you should be able to work around it by changing the
clientspec, change the clientspec so that it will clobber such files,
you will need to refer to the perforce docs for info about that.

On Tue, 2008-12-02 at 22:04 -0800, Gary Yang wrote:
> So, I have to keep two copies of source tree at my home directory. One is for Perforce build_scripts workspace, another is for Git build_scripts.git. I normally work at build_scripts.git. But, when I need to submit changes to Perforce, I have to copy changed code from build_scripts.git to build_scripts. Then, p4 submit code into Perforce. Is this the only way of using git-p4?
> Note: I cannot use git-p4 submit at build_scripts. It claims "Cannot clobber writable file". Is it a bug of git-p4 or the instruction is not correct?
> 
> 
> --- On Tue, 12/2/08, Jing Xue <jingxue@digizenstudio.com> wrote:
> 
> > From: Jing Xue <jingxue@digizenstudio.com>
> > Subject: Re: git-p4 submit, Can't clobber writable file
> > To: "Gary Yang" <garyyang6@yahoo.com>
> > Cc: git@vger.kernel.org
> > Date: Tuesday, December 2, 2008, 7:07 PM
> > On Tue, Dec 02, 2008 at 02:30:51PM -0800, Gary Yang wrote:
> > > 
> > > I followed the instructions at
> > http://modular.math.washington.edu/home/mhansen/git-1.5.5.1/contrib/fast-import/git-p4.txt
> > > 
> > > But, I am not able to git-p4 submit. Any idea?
> > > 
> > > git-p4 clone //build/scripts build_scripts
> > > cd build_scripts
> > > vi foo.h
> > > git commit foo.h
> > > git-p4 rebase
> > > git-p4 submit
> > > 
> > >   from sets import Set;
> > > Perforce checkout for depot path //build/scripts/
> > located at /home/gyang/workspace/build_scripts/
> > > Syncronizing p4 checkout...
> > > //build/scripts/foo.h#1 - added as
> > /home/gyang/workspace/build_scripts/foo.h
> > > Can't clobber writable file
> > /home/gyang/workspace/build_scripts/foo.h
> > > //build/scripts/foo.c#1 - added as
> > /home/gyang/workspace/build_scripts/foo.c
> > > Can't clobber writable file
> > /user/home/gyang/workspace/build_scripts/foo.c
> > > ......
> > > command failed: p4 sync ...
> > 
> > You might want to clone to a git working dir different than
> > the p4
> > working dir.
> > 
> > For instance, if your p4 workspace has the working dir set
> > to
> > build_scripts/, try 'git p4 clone //build/scripts
> > build_scripts.git'.
> > 
> > You would then normally work under build_scripts.git/.
> > build_scripts/
> > would only be used by git-p4 at submission time.
> > 
> > Cheers.
> > -- 
> > Jing Xue
> 
> 
>       
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
