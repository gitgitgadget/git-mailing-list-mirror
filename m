From: Tim Mazid <timmazid@hotmail.com>
Subject: RE: Handling non-git config files
Date: Wed, 24 Feb 2010 12:46:41 +1100
Message-ID: <SNT124-W237D02A0994F2AEEBDB460C4410@phx.gbl>
References: <8440EA2C12E50645A68C4AA9887166513FC19C@SERVER.webdezign.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Feb 24 02:46:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nk6Kx-0000tT-33
	for gcvg-git-2@lo.gmane.org; Wed, 24 Feb 2010 02:46:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754022Ab0BXBqo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Feb 2010 20:46:44 -0500
Received: from snt0-omc3-s24.snt0.hotmail.com ([65.55.90.163]:29073 "EHLO
	snt0-omc3-s24.snt0.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753983Ab0BXBqm convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2010 20:46:42 -0500
Received: from SNT124-W23 ([65.55.90.137]) by snt0-omc3-s24.snt0.hotmail.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 23 Feb 2010 17:46:41 -0800
X-Originating-IP: [211.30.173.126]
Importance: Normal
In-Reply-To: <8440EA2C12E50645A68C4AA9887166513FC19C@SERVER.webdezign.local>
X-OriginalArrivalTime: 24 Feb 2010 01:46:41.0837 (UTC) FILETIME=[36874DD0:01CAB4F3]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140888>


Hey Richard,
 
I am by no means an expert, or the sharpest knife in the drawer, for that matter, but let me see if I can understand what you're trying to do.


> I understand that git is for source code mangement. However in certains
> applications like web applications in a live environment, it ends up
> storing data related to the state of the application as well.

Do you mean that your app creates a file like 'users.dat' or similar that you do not wish to track with git? If so, you can simply not add it the repo, and add it to your .gitignore file.
 
 
> I myself am a web developer and for me git ends up storing data like the
> root path of the web app. I would like to work on a test rig, commit and
> push the changes to a central repo. Then pull the changes on to the live
> server. Having different config files on the test and live deployments
> make this workflow difficult as I don't know how to tell git to handle
> the different config files. I have managed to do this with patches, but
> I do not thing it is good in the long run.

Once again, do you need to track the file that stores this data with git?
One (probably not very elegant) solution might be to store all location independant data in one config file, to be tracked by git, and a script generated "local" config file ignored by git.
 
 
> I would put the config data in it's own location, but unfortunately I
> have been given a product to work with and I cannot do that. This means
> that config data that I do wish to commit is in the same file as data
> that would vary from deployment to deployment.

Well, that just killed my previous idea. But is there no possibility at all of editing the code to achieve that?
Unfortunately, I do not believe git can ignore half a file.
 
 
> Currently I only work on the live server with git. Firstly this is not
> ideal to experiment on a live site. Secondly my colleagues now want to
> learn git and you can't have several people performing git operations on
> the same working directory.

Well, you COULD have multiple people working in the same working directory, but that will present all the usual problems of multiple access to a single file (not very fun at all.)
Why not just have them clone their own copy of the repo?
 

> So my quesstion is that is there any way to have several checked out
> copies of a git repo each with their own slightly different config
> files, yet still being able to perform git operations with respect to a
> centralised repository as if they were identical?

By checked out do you mean a 'git clone'? If so, yes, you can have as many as you want. That is (I think) one of the major points of git.
 
 
> I've thought about using a migration script for each target deployment
> and then ignoring any changes related to the deployment. I've also
> considered having each deployment as a seperate branch and then rebasing
> changes back and forth. However this seems uneccesarily complicated and
> I teaching git beginners about rebasing doesn't seem like a good idea.

The branches for deployments could work. I see no need for rebasing, though. You merely add deployment-specific changes to those branches, and all other changes to your main branch, which you then merge into the deployment-specific branches.
Unless I've missed something, which is likely, that should work just fine.
 
 
> The first solution give a me a corrolary question. I use tig for staging
> changes. In the config file, the lines specific to the deployment can
> end up in the same hunk as lines specific to the application that I do
> want to keep. Can I stage partial hunks in tig? Or do I have to use git
> add --interative?

Unfortunately, I do not know tig and cannot comment on that. I do know, however, that git gui allows you to stage content by hunks, and even line by line, which I often find useful. Is there any reason you are unable/unwilling to use git gui?
 
 
All in all, quite a useless reply, but hopefully you will elaborate further as to the data file situation (which is your major concern, unless I'm mistaken, but requires a little more explanation as to why structural changes cannot be made), which can assist someone knowledgable work this out.
 
 
Regards,
Tim. 		 	   		  
_________________________________________________________________
Find a great deal on your next car. Get straight to the Point.
http://clk.atdmt.com/NMN/go/157637060/direct/01/