From: Fredrik Noring <noring@nocrew.org>
Subject: Re: [PATCH] Calculate lines changed for cvs log command
Date: Mon, 14 Apr 2008 21:56:30 +0200
Message-ID: <FFB8FCA9-AD9C-4F7F-9238-0CB0CA3204AF@nocrew.org>
References: <3F0821AA-C11D-4C42-A415-D346A7CD89F8@nocrew.org> <m3zlrxsnbt.fsf@localhost.localdomain> <20AD7252-19A2-443F-88CF-F871AE7A392E@nocrew.org> <200804132243.40909.jnareb@gmail.com>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 14 22:01:33 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JlUoK-0006KF-6x
	for gcvg-git-2@gmane.org; Mon, 14 Apr 2008 21:57:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756161AbYDNT4k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Apr 2008 15:56:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755951AbYDNT4j
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Apr 2008 15:56:39 -0400
Received: from smtpserver.stunet.se ([85.194.0.110]:51876 "EHLO mail.visit.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755546AbYDNT4h (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Apr 2008 15:56:37 -0400
Received: by mail.visit.se (Postfix, from userid 503)
	id 785EC36E0241; Mon, 14 Apr 2008 21:56:57 +0200 (CEST)
Received: from [10.0.1.2] (cust.dsl-fiber-lan.snet.lk.85.194.37.51.visit.se [85.194.37.51])
	by mail.visit.se (Postfix) with ESMTP id A7A9E36E01D3;
	Mon, 14 Apr 2008 21:56:55 +0200 (CEST)
In-Reply-To: <200804132243.40909.jnareb@gmail.com>
X-Mailer: Apple Mail (2.919.2)
X-Spam-Checker-Version: SpamAssassin 3.0.6 (2005-12-07) on mail.visit.se
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00 
	autolearn=ham version=3.0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79530>

Hi Jakub,

13 apr 2008 kl. 22.43 skrev Jakub Narebski:
> First, having patch as attachement, moreover as _binary_ and _encoded_
> attachement makes it hard to comment on it.  And if you make it hard  
> to
> comment on patch, people woundn't do it.

Again, my sincere apologies. I have a feeling my current mailer never  
will meet the patch submission requirements for this mailing list.  
However, I will replace it at the next opportunity in order to comply.

The goal with these patches is to make cvsserver commands such as "cvs  
log" identical to the real thing, so that cvs users would feel at home  
after a cvs import to git. I'm getting closer with these tweaks/fixes  
to the cvsserver. So far mainly handling of whitespace and calculating  
proper "shortstats". Decent performance would be nice as well. I'm  
playing around with this but I'm in no hurry, so feel free to ignore. :)

> Second, your approach with "--pretty=format:%s%n%b" might be a good
> idea, but you don't get all the information as you get from
> git-cat-file: no tree info, no true (recorded) parents info, no
> committer info, no author info.  I don't know if git-cvsserver makes
> use of that info or not; from the patch it looks as if it discards
> all but commit message (message body).

Yeah -- it's all discarded. A small issue is that "--pretty=format:%s%n 
%b" only outputs the same commit message as git-cat-file in ~95 % of  
my test cases. I've seen differences regarding newlines after the  
subject line (git-cat-file seems to output this correctly, but not %s%n 
%b). Something to investigate further, perhaps.

> BTW. I'm not Perl expert, but if you want to discard two last
> elements in arrays, wouldn't using splice (or just decreasing
> $#lines by 2) be simpler solution?

I went for clarity and felt pop() made the job. ;)

> About git-log vs git-cat-file: take a look how gitweb does it, with
> parse_commits and parse_commit_text, and commit 756bbf548dbef5b738c
> by Robert Fitzsimons introducing it.  Note that IIRC this commit
> predates --pretty=format:<fmt> option to git-log / git-rev-list.

Sure, thanks!

> BTW. cannot you turn off "format=flowed" in Apple Mail?

Well, it appears easier to replace it altogether in order to follow  
the patch submission rules. I like Gnome Evolution and it'll hopefully  
work nicely in this case.

> Could you please do not toppost?  It is against natural reading order.

>

Heh. Very funny you wrote that as a toppost yourself. ;)

Thanks,
Fredrik
