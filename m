From: Steven Grimm <koreth@midwinter.com>
Subject: Re: GIT vs Other: Need argument
Date: Wed, 18 Apr 2007 10:08:55 -0700
Message-ID: <462650A7.5030404@midwinter.com>
References: <aa69c80b0704170202r3f35acc7ydb81708e747c69ff@mail.gmail.com> <200704171818.28256.andyparkins@gmail.com> <8b65902a0704180540l721b9b1dj6f6e068f0d7e5119@mail.gmail.com> <200704181426.29969.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	Guilhem Bonnefille <guilhem.bonnefille@gmail.com>,
	Tomash Brechko <tomash.brechko@gmail.com>,
	Pietro Mascagni <pietromas@gmail.com>
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 18 19:08:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HeDeJ-00060U-C5
	for gcvg-git@gmane.org; Wed, 18 Apr 2007 19:08:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753820AbXDRRIu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Apr 2007 13:08:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754139AbXDRRIu
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Apr 2007 13:08:50 -0400
Received: from tater.midwinter.com ([216.32.86.90]:48613 "HELO midwinter.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753820AbXDRRIt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Apr 2007 13:08:49 -0400
Received: (qmail 2128 invoked from network); 18 Apr 2007 17:08:48 -0000
Received: from c-76-21-17-123.hsd1.ca.comcast.net (HELO ?192.168.0.133?) (koreth@76.21.17.123)
  by tater.midwinter.com with SMTP; 18 Apr 2007 17:08:48 -0000
User-Agent: Thunderbird 1.5.0.10 (Macintosh/20070221)
In-Reply-To: <200704181426.29969.andyparkins@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44915>

Andy Parkins wrote:
> svn update = git pull
>   

That's not quite equivalent, and it's one of the biggest annoyances svn 
users seem to have when starting up with git in my observation (having 
gone through it myself and watched a few other people at my company do 
so.) svn update will merge upstream changes into your locally edited but 
not yet committed files. git pull will just complain if you have 
uncommitted local edits to files that changed upstream.

To avoid that problem, my workflow often looks like

git commit -a -m "dummy revision"
git fetch
git rebase origin/master
git reset --soft HEAD^

which IMO is something the tool should be doing for me. Cogito's 
cg-update would do this for me, but Cogito hasn't kept up with recent 
git changes so aside from cg-admin-rewritehist I never use it. Please 
tell me if the above is doable in fewer commands, by the way.

-Steve
