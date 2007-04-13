From: Rogan Dawes <lists@dawes.za.net>
Subject: Re: [PATCH 5/6] Teach "fsck" not to follow subproject links
Date: Fri, 13 Apr 2007 11:00:37 +0200
Message-ID: <461F46B5.2020007@dawes.za.net>
References: <Pine.LNX.4.64.0704092100110.6730@woody.linux-foundation.org>  <Pine.LNX.4.64.0704111545040.6730@woody.linux-foundation.org>  <Pine.LNX.4.64.0704111605210.6730@woody.linux-foundation.org>  <Pine.LNX.4.64.0704111646000.6730@woody.linux-foundation.org>  <Pine.LNX.4.63.0704111628240.28394@qynat.qvtvafvgr.pbz>  <Pine.LNX.4.64.0704111903060.4061@woody.linux-foundation.org> <56b7f5510704121132g3961060amb394978bb49093e6@mail.gmail.com> <Pine.LNX.4.64.0704121203290.4061@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Dana How <danahow@gmail.com>,
	David Lang <david.lang@digitalinsight.com>,
	Sam Vilain <sam@vilain.net>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Apr 13 11:01:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HcHeI-0005io-CO
	for gcvg-git@gmane.org; Fri, 13 Apr 2007 11:00:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752930AbXDMJAm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 Apr 2007 05:00:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752915AbXDMJAm
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Apr 2007 05:00:42 -0400
Received: from sd-green-bigip-74.dreamhost.com ([208.97.132.74]:52751 "EHLO
	spunkymail-a16.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752097AbXDMJAl (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 Apr 2007 05:00:41 -0400
Received: from [192.168.201.103] (dsl-146-24-118.telkomadsl.co.za [165.146.24.118])
	by spunkymail-a16.dreamhost.com (Postfix) with ESMTP id 5E37A7CC3E;
	Fri, 13 Apr 2007 02:00:38 -0700 (PDT)
User-Agent: Thunderbird 1.5.0.10 (Windows/20070221)
In-Reply-To: <Pine.LNX.4.64.0704121203290.4061@woody.linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44395>

Linus Torvalds wrote:
> 
> Yes.
> 
> The issues for hosting sites are very different from the issues of 
> individual developers having their own git repositories, and I agree 100% 
> that both alternates and shared object directories make tons of sense for 
> hosting.
> 
>> Below I talk about a possible way we could use git
>> without changing it (since I recognize this would be a minority usage
>> pattern).
> 
> I hope it wouldn't even be a minority usage pattern. I am a firm believer 
> that distributed SCM's and git in particular makes a lot more sense for 
> source control hosting than CVS or SVN do. I'm really disappointed with 
> things like sourceforge, and part of the problem is literally that a 
> centralized SCM is really *fundamentally* wrong for a hosting entity. 
> 
> Using a distributed SCM just makes _so_ much more sense for hosting 
> projects, and I've actually very much wanted to try to make sure that git 
> can help people who host things. 


> And btw, I think the shared object model really works very well, but I 
> think it has to be paired with some stricter rules than people who use 
> their own repos tend to have. For example, end-point developers have 
> become very used to rebasing and generally rewriting history (or just 
> resetting to an older state), and that's something that works find in a 
> "local repository" setup, but it's also the kinds of patterns that can 
> really screw you in a hosted and shared-object environment.
> 

Would it not make sense for a hosting environment to say, if you are 
using alternates, or shared object directories, then you need to include 
*all* the refs in *all* the projects if you ever do an fsck?

I'm not sure how well git will scale in this case, although it just 
should be a matter of how well git scales to dealing with a single 
project with tens of thousands of refs/tags/etc. The only problem might 
be in passing all those refs/tags to fsck in one go. STDIN, I guess?

Rogan
