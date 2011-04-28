From: =?iso-8859-1?Q?Peter_J=F6nsson_P?= <peter.p.jonsson@ericsson.com>
Subject: RE: Git and Binary Files
Date: Thu, 28 Apr 2011 17:26:29 +0200
Message-ID: <41F80411E3CC644A844E6BED6E472FD91AE7A83A2B@ESESSCMS0363.eemea.ericsson.se>
References: <1304003476678-6313601.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: ryanzec <basire@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Apr 28 17:26:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFT78-0000rx-Lj
	for gcvg-git-2@lo.gmane.org; Thu, 28 Apr 2011 17:26:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933156Ab1D1P0i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Apr 2011 11:26:38 -0400
Received: from mailgw10.se.ericsson.net ([193.180.251.61]:55411 "EHLO
	mailgw10.se.ericsson.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933021Ab1D1P0d convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Apr 2011 11:26:33 -0400
X-AuditID: c1b4fb3d-b7bd5ae000002ba3-9d-4db9872613d3
Received: from esessmw0256.eemea.ericsson.se (Unknown_Domain [153.88.253.125])
	by mailgw10.se.ericsson.net (Symantec Mail Security) with SMTP id 99.1C.11171.62789BD4; Thu, 28 Apr 2011 17:26:31 +0200 (CEST)
Received: from ESESSCMS0363.eemea.ericsson.se ([169.254.1.191]) by
 esessmw0256.eemea.ericsson.se ([10.2.3.125]) with mapi; Thu, 28 Apr 2011
 17:26:30 +0200
Thread-Topic: Git and Binary Files
Thread-Index: AcwFtoodQWppQM4RSSKKwR6gVhHmpwAAQ2KA
In-Reply-To: <1304003476678-6313601.post@n2.nabble.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US
X-Brightmail-Tracker: AAAAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172367>

Hi!

I don't work with game development but I work with embedded systems where one usually have at least some types of binary files. This can range from entire cross compiler suites to FPGA binaries which should be included in the resulting product. Anyway, the "solution" to your problem is to separate the source code from the binary data by using several different repos. This can be achieved using either the Google "repo" tool (used for Android platform development) or "plain" git sub modules [2]. There have been some dicussions on this list regarding some other approaches but I think these two are the most common ones. 

// Peter

[1] http://google-opensource.blogspot.com/2008/11/gerrit-and-repo-android-source.html
[2] http://www.kernel.org/pub/software/scm/git/docs/git-submodule.html


-----Original Message-----
From: git-owner@vger.kernel.org [mailto:git-owner@vger.kernel.org] On Behalf Of ryanzec
Sent: den 28 april 2011 17:11
To: git@vger.kernel.org
Subject: Git and Binary Files

I am a long time user of SVN and while it has worked for me in the past, I always felt like there were features I wasn't using properly. Branching is one of those features. Most of the time when I created branches, I was really creating tags because when I created branches, I never really used them for merging, just more to take a snapshot of the current code. When I did have to make changes to code in one branch and merge them to another, I always just manually merged the files because it was usually 1 or two files and merge with SVN from what I hear is not a straight forward process. I have recently starting using merging at work with SVN and I now really understanding why people try to avoid it in SVN. Another thing I do in SVN that I fell is counter productive is I only commit when I a
 m 100% complete with a feature. It would be great to commit things in chunks instead of one great big change. I have had multiple times where I was like "I wish I could go back just a little bit in time" but of course I have to go back to the initial version which may be a week old or modify the file manually to get back to the state I want it at (which it was I usually do).

Thankfully I have been introduced to the world of DVCS, specifically git. My work is in the process of porting over to it and as I have been learning it, I am wondering why I am still using SVN. Git fixes the above issues as well as also having a number of cool little features.

Now while it fixes a lot of things there is one feature that concerns me with trying to using it for game development projects and that is how it handles binary files. In my day job, that is not a huge concern as I do web development and I don't deal with many binary files that need to be versioned. Images are the only ones and they rarely change and are not usually that big. Game development is a different story. Game development in general has many binary files (images, 3d assets, sound files, etc...).
Since git generally has a copy of the entire binary file for each change that happens to it and since these assets can change quite often and sometimes be large in size, I have a feeling that it can make the repository of project become huge even with the compression that git does with git pack/git gc.

Does anyone use git with game development? What is the workflow for binary assets? Do you just store them in git (if so, are they in the main repository or a separate repository using submodules)? If you don't include binaries in the git repository, what tool do you use to manage binary assets and does it work well with git?

--
View this message in context: http://git.661346.n2.nabble.com/Git-and-Binary-Files-tp6313601p6313601.html
Sent from the git mailing list archive at Nabble.com.
--
To unsubscribe from this list: send the line "unsubscribe git" in the body of a message to majordomo@vger.kernel.org More majordomo info at  http://vger.kernel.org/majordomo-info.html
