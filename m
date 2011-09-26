From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: git svn clone issues with buddypress subversion repository
Date: Mon, 26 Sep 2011 10:13:07 +0200
Message-ID: <4E803413.3080709@drmicha.warpmail.net>
References: <CAM1C4G=YbK5PF21UujxNRR0PX9xqQBSEvcB45Zxy1hwZuyuL8Q@mail.gmail.com> <CAM1C4G=o_Q5scdv=Jk3ou-3OjnZiukZV3nz0NJR7CTaKLbB2jw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Anand Kumria <akumria@acm.org>
X-From: git-owner@vger.kernel.org Mon Sep 26 10:13:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R86JQ-0002w7-PL
	for gcvg-git-2@lo.gmane.org; Mon, 26 Sep 2011 10:13:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751220Ab1IZINL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Sep 2011 04:13:11 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:39098 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750855Ab1IZINK (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Sep 2011 04:13:10 -0400
Received: from compute6.internal (compute6.nyi.mail.srv.osa [10.202.2.46])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 22DEC240D8;
	Mon, 26 Sep 2011 04:13:10 -0400 (EDT)
Received: from frontend2.nyi.mail.srv.osa ([10.202.2.161])
  by compute6.internal (MEProxy); Mon, 26 Sep 2011 04:13:10 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=7j6zO7IF8v2Y6WDXS/9len
	hccr4=; b=ox2xPe+7XM0nZrLsogB+3bLxNtKugEZCgaFHdvO0EEx3PblV04xKip
	d0n1kOVTbkB68nKyCSDinUs6ylucnO0oSWH8mPrMLwvls39KnfcKoLHCFDklLGpa
	nFCrd0HodUSoJ5VS69vZhZVvm+kBBQYUBfJgZWfz17TOINnpfqIRE=
X-Sasl-enc: ttrZCdAUuxozo2YbG3FF3GNwlkqorVlwdMEMlsh8AQ7U 1317024789
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id A0A63A0050E;
	Mon, 26 Sep 2011 04:13:09 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:6.0.2) Gecko/20110906 Thunderbird/6.0.2
In-Reply-To: <CAM1C4G=o_Q5scdv=Jk3ou-3OjnZiukZV3nz0NJR7CTaKLbB2jw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182093>

Anand Kumria venit, vidit, dixit 24.09.2011 18:50:
> Hi,
> 
> I'm trying:
> 
> % git svn clone -s http://svn.buddypress.org/trunk/ buddypress

Please try

git svn clone -s http://svn.buddypress.org/ buddypress

By saying "-s", you make git-svn look in trunk, branches and tags
subdirs of the URL that you specify, i.e. trunk/trunk etc. with your
command line.

Or, omit "-s" if you want the trunk branch only.

> Initialized empty Git repository in
> /home/anand/Projects/wordpress/buddypress/.git/
> Using higher level of URL: http://svn.buddypress.org/trunk =>
> http://svn.buddypress.org
> 
> % git --version
> git version 1.7.0.4
> 
> And at the end, git svn appears to successfull complete but nothing
> has occurred. I'm successfully using 'git svn' against other
> repositories with no problem, just wondering if anyone else has come
> across this.
> 
> % find buddypress
> buddypress
> buddypress/.git
> [omitted]
> buddypress/.git/svn
> buddypress/.git/svn/refs
> buddypress/.git/svn/refs/remotes
> buddypress/.git/svn/refs/remotes/git-svn
> buddypress/.git/svn/refs/remotes/trunk
> buddypress/.git/svn/refs/remotes/trunk/.rev_map.cdf35c40-ae34-48e0-9cc9-0c9da1808c22
> buddypress/.git/svn/.metadata
> 
> % cat buddypress/.git/svn/.metadata
> ; This file is used internally by git-svn
> ; You should not have to edit it
> [svn-remote "svn"]
>     reposRoot = http://svn.buddypress.org
>     uuid = cdf35c40-ae34-48e0-9cc9-0c9da1808c22
>     branches-maxRev = 5188
>     tags-maxRev = 5188

Contents of .git/config would be more helpful in general. We don't need
it in this case, but looking at it might have given you the clue
(trunk/trunk).

Michael
