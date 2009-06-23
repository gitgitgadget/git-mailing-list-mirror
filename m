From: =?utf-8?b?Wm9sdMOhbg==?= =?utf-8?b?RsO8emVzaQ==?= 
	<zfuzesi@eaglet.hu>
Subject: Re: most annoying thing in git-push
Date: Tue, 23 Jun 2009 05:21:39 +0000 (UTC)
Message-ID: <loom.20090623T050211-438@post.gmane.org>
References: <20090622192147.GE5743@altlinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 23 07:25:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MIyVr-0006R8-2t
	for gcvg-git-2@gmane.org; Tue, 23 Jun 2009 07:25:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751819AbZFWFZE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Jun 2009 01:25:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750943AbZFWFZD
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Jun 2009 01:25:03 -0400
Received: from main.gmane.org ([80.91.229.2]:36906 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750858AbZFWFZC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jun 2009 01:25:02 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1MIyVC-0006gW-Qw
	for git@vger.kernel.org; Tue, 23 Jun 2009 05:25:02 +0000
Received: from catv-86-101-96-139.catv.broadband.hu ([86.101.96.139])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 23 Jun 2009 05:25:02 +0000
Received: from zfuzesi by catv-86-101-96-139.catv.broadband.hu with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 23 Jun 2009 05:25:02 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 86.101.96.139 (Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US) AppleWebKit/530.5 (KHTML, like Gecko) Chrome/2.0.172.31 Safari/530.5)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122075>


Alexey I. Froloff <raorn <at> altlinux.org> writes:
> 
> From git-fetch(1), -n option description: "By default, tags that
> point at objects that are downloaded from the remote repository
> are fetched and stored locally."
> 
> Is is possible to add such functionality to git-push, so it will
> push tags that point at objects that were uploaded to the remote
> repository?
> 

Hi,

git-fetch -n does the opposite: "This option disables this automatic tag 
following." I guess you wanted to write git-fetch -t.
git-push --tags will help you, but it's a 2 step push: one for the branches and 
one for the tags. I use .git/config to solve this:

[remote "origin"]
	url = ...
	fetch = +refs/heads/*:refs/remotes/origin/*
	push = +refs/heads/*
	push = +refs/tags/*

With these lines added git-push origin will upload all your branches and tags.
If you want to upload only some of them, you can enumerate them.
