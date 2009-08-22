From: "Nicholas A. Bellinger" <nab@linux-iscsi.org>
Subject: Re: Issue with gitweb + tag + branch of the same name from master
	branch commit
Date: Sat, 22 Aug 2009 13:12:51 -0700
Message-ID: <1250971971.26147.122.camel@haakon2.linux-iscsi.org>
References: <1250811031.26147.42.camel@haakon2.linux-iscsi.org>
	 <m3fxbkn5ot.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "J.H." <warthog9@kernel.org>,
	"H. Peter Anvin" <hpa@zytor.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 22 22:18:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mex2k-0008Bl-Cq
	for gcvg-git-2@lo.gmane.org; Sat, 22 Aug 2009 22:18:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933345AbZHVUSV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Aug 2009 16:18:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933329AbZHVUSV
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Aug 2009 16:18:21 -0400
Received: from n11.bullet.mail.mud.yahoo.com ([209.191.125.210]:48041 "HELO
	n11.bullet.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S933300AbZHVUSU (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 22 Aug 2009 16:18:20 -0400
X-Greylist: delayed 329 seconds by postgrey-1.27 at vger.kernel.org; Sat, 22 Aug 2009 16:18:20 EDT
Received: from [68.142.200.226] by n11.bullet.mail.mud.yahoo.com with NNFMP; 22 Aug 2009 20:12:53 -0000
Received: from [68.142.201.72] by t7.bullet.mud.yahoo.com with NNFMP; 22 Aug 2009 20:12:53 -0000
Received: from [127.0.0.1] by omp424.mail.mud.yahoo.com with NNFMP; 22 Aug 2009 20:12:53 -0000
X-Yahoo-Newman-Id: 553380.71338.bm@omp424.mail.mud.yahoo.com
Received: (qmail 49998 invoked from network); 22 Aug 2009 20:12:53 -0000
Received: from unknown (HELO ?192.168.0.119?) (nab@70.231.234.42 with plain)
  by smtp108.sbc.mail.sp1.yahoo.com with SMTP; 22 Aug 2009 20:12:52 -0000
X-YMail-OSG: Zm0l0ocVM1nygnWMrNv4sqGPe50kZ.yVvfeeCVnvPiY4TWes..btLVTuJx07JDC.AnEi2bFPf1hzMG87XTSMVSI1QwpQlBFG3XxOB_TB8Jk.YRk0YUXCagiYhAOULxwLeqNGk_dhNyht7FtG8iIDqSmItIuVO4e4haflX3NIrmnKwFe7diflvoLKnBQ7x56NB.Uyw4ty81GES69qnSZKDrNVSuHMjZEwSy538eKaZ3t2N7bHUKN6knltYMAJnTdU4tPPwjLper6kvPH1M5mbI2x_oA1HzPo-
X-Yahoo-Newman-Property: ymail-3
In-Reply-To: <m3fxbkn5ot.fsf@localhost.localdomain>
X-Mailer: Evolution 2.22.3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126818>

Greetings Jakub,

On Fri, 2009-08-21 at 15:49 -0700, Jakub Narebski wrote:
> "Nicholas A. Bellinger" <nab@linux-iscsi.org> writes:
> 
> > I have recently been trying to make a tag and branch of the same name
> 
> But why?  Why do you want to confuse git and yourself?
> 

I stumbled the strangeness in k.o gitweb due to my inexperience with git
tagging+branch..  I absoulutely agree that it makes more sense to use
different names for these, and that is what I am doing from now on.. :-)

> > from a previous <COMMIT> on a master branch on a kernel.org tree using
> > the following commands:
> > 
> > 	# Create the tag:
> > 	git tag -a lio-x.y <COMMIT>
> > 	# Push the tags:
> > 	git push --tags origin
> > 	# Fetch to be sure
> > 	git fetch origin
> > 	# Make tagged branch:
> > 	git checkout -b lio-x.y <COMMIT>
> > 	# Make <NEW_COMMIT> to lio-x.y and commit
> >         git commit frob
> > 	# Switch back to master branch
> > 	git checkout master
> > 	# Push local branch to origin
> > 	git push origin refs/heads/lio-x.y
> > 
> > At this point after pushing to origin, I can do a fresh clone of the
> > tree, and do a 'git checkout origin/lio-x.y and I see '<NEW_COMMIT>',
> > and the logs and blobs look as expected..
> > 
> > However, after checking gitweb log for branch lio-x.y on kernel.org, I
> > only see <COMMIT>, and not <NEW_COMMIT>, and all of the blobs in branch
> > lio-x.y still reference the original <COMMIT>, et al.
> 
> I guess that you meant here gitweb's 'log' / 'shortlog' view linked
> from 'heads' view, don't you?

That is correct..

>  
> > John Hawley has been helping to resolve the issue (I am just going to
> > use different tag/branch names instead), and hpa asked me to report this
> > as it is easy to reproduce with the gitweb version on kernel.org..
> 
> > 22:42 < warthog9> I would got show this to the git people, it *could*
> >                   just be an old bug in gitweb (ours is not particularly
> >                   up to date) but if I can replicate it here easily enough
> >                   I'm guessing there's still a bug elsewhere
> 
> This is an old and long fixed (or rather worked around) issue in
> gitweb, fixed in bf901f8 (gitweb: disambiguate heads and tags withs
> the same name, 2007-12-15)... well if by fixed you can consider
> passing around "fully qualified" refnames, i.e. the 'shortlog' link in
> 'heads' view now uses 'refs/heads/frob', and not only 'frob'.
>

Cool, I am hear it has already been fixed.

--nab
