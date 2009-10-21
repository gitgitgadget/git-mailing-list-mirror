From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [Foundation-l] Wikipedia meets git
Date: Wed, 21 Oct 2009 17:05:48 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0910211656350.21460@xanadu.home>
References: <ee9cc730910151155w307a87f0w7bba5c4039bb1ef9@mail.gmail.com>
 <e692861c0910170118n6cabcc0bt3a4028cbbb54da86@mail.gmail.com>
 <ee9cc730910170140m5a7f2949h80afce7398d9e503@mail.gmail.com>
 <71cd4dd90910170705o7c61e06fuacba41f447571b45@mail.gmail.com>
 <deea21830910170804s61786d8ewae0bc9390baaed71@mail.gmail.com>
 <71cd4dd90910170823o3f58b8c2x1d39040e7582634@mail.gmail.com>
 <ee9cc730910170939m6e83ad2fy5f22a541c3679638@mail.gmail.com>
 <deea21830910170953o33823dd3rd7a9305f9ea794d@mail.gmail.com>
 <ee9cc730910171011l1b68a1a0q7096a93c36362959@mail.gmail.com>
 <e405c96a0910190830y51009225lc72942a703575042@mail.gmail.com>
 <5396c0d10910210543i4c0a3350je5bee4c6389a2292@mail.gmail.com>
 <1256154567.1477.87.camel@giskard>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_wLfL8aQf3CaOY8p7H2OW6w)"
Cc: Samuel Klein <meta.sj@gmail.com>,
	Wikimedia Foundation Mailing List 
	<foundation-l@lists.wikimedia.org>, git <git@vger.kernel.org>
To: Bernie Innocenti <bernie@codewiz.org>
X-From: git-owner@vger.kernel.org Wed Oct 21 23:23:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0iel-0001qZ-2h
	for gcvg-git-2@lo.gmane.org; Wed, 21 Oct 2009 23:23:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755203AbZJUVXd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Oct 2009 17:23:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754805AbZJUVXd
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Oct 2009 17:23:33 -0400
Received: from relais.videotron.ca ([24.201.245.36]:33612 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754734AbZJUVXc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Oct 2009 17:23:32 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MR-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0KRV002JRULOIXS0@VL-MR-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 21 Oct 2009 17:05:48 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <1256154567.1477.87.camel@giskard>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130966>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_wLfL8aQf3CaOY8p7H2OW6w)
Content-type: TEXT/PLAIN; charset=ISO-8859-15
Content-transfer-encoding: 8BIT

On Wed, 21 Oct 2009, Bernie Innocenti wrote:

> And here's the the catch: the history of individual files is not
> directly represented in a git repository. It is typically scattered
> across thousands of commit objects, with no direct links to help find
> them. If you want to retrieve the log of a file that was changed only 6
> times in the entire history of the Linux kernel, you'd have to dig
> through *all* of the 170K revisions in the "master" branch.
> 
> And it takes some time even if git is blazingly fast:
> 
>  bernie@giskard:~/src/kernel/linux-2.6$ time git log  --pretty=oneline REPORTING-BUGS  | wc -l 
>  6
> 
>  real	0m1.668s
>  user	0m1.416s
>  sys	0m0.210s
> 
> (my laptop has a low-power CPU. A fast server would be 8-10x faster).
> 
> 
> Now, the English Wikipedia seems to have slightly more than 3M articles,
> with--how many? tenths of millions of revisions for sure. Going through
> them *every time* one needs to consult the history of a file would be
> 100x slower. Tens of seconds. Not acceptable, uh?
> 
> It seems to me that the typical usage pattern of an encyclopedia is to
> change each article individually. Perhaps I'm underestimating the role
> of bots here. Anyway, there's no consistency *requirement* for mass
> changes to be applied atomically throughout all the encyclopedia, right?

You certainly don't need to put all files in the same tree then.  
Having the whole thing split according to some sections that are 
unlikely to overlap would be the way to go.  Therefore you could arrange 
subsections to have their own branches with no other files in them, or 
even rely on Git submodules.  The partitioning doesn't necessarily have 
to be one of the two extremes such as one branch per file à la CVS or 
all files in the same branch/tree as Git does by default.


Nicolas

--Boundary_(ID_wLfL8aQf3CaOY8p7H2OW6w)--
