X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: multi-project repos (was Re: Cleaning up git user-interface
 warts)
Date: Thu, 16 Nov 2006 14:49:45 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0611161436230.3349@woody.osdl.org>
References: <87k61yt1x2.wl%cworth@cworth.org> <455A1137.8030301@shadowen.org>
 <87hcx1u934.wl%cworth@cworth.org> <Pine.LNX.4.64.0611141518590.2591@xanadu.home>
 <87bqn9u43s.wl%cworth@cworth.org> <ejdcg5$4fl$1@sea.gmane.org>
 <Pine.LNX.4.64.0611141633430.2591@xanadu.home> <7vbqn9y6w6.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0611142007010.2591@xanadu.home> <7v3b8ltq7r.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0611142306090.2591@xanadu.home> <Pine.LNX.4.64.0611150950170.3349@woody.osdl.org>
 <455BBCE9.4050503@xs4all.nl> <Pine.LNX.4.64.0611151908130.3349@woody.osdl.org>
 <455C412D.1030408@xs4all.nl> <Pine.LNX.4.64.0611160814560.3349@woody.osdl.org>
 <455C94FA.3050903@xs4all.nl> <Pine.LNX.4.64.0611160904010.3349@woody.osdl.org>
 <455CA2A8.5010700@xs4all.nl> <Pine.LNX.4.64.0611160958170.3349@woody.osdl.org>
 <Pine.LNX.4.63.0611162315110.13772@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Thu, 16 Nov 2006 22:50:10 +0000 (UTC)
Cc: Han-Wen Nienhuys <hanwen@xs4all.nl>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <Pine.LNX.4.63.0611162315110.13772@wbgn013.biozentrum.uni-wuerzburg.de>
X-MIMEDefang-Filter: osdl$Revision: 1.159 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31630>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gkq3U-00024Q-0Q for gcvg-git@gmane.org; Thu, 16 Nov
 2006 23:50:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1755485AbWKPWty (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 16 Nov 2006
 17:49:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755489AbWKPWtx
 (ORCPT <rfc822;git-outgoing>); Thu, 16 Nov 2006 17:49:53 -0500
Received: from smtp.osdl.org ([65.172.181.4]:2275 "EHLO smtp.osdl.org") by
 vger.kernel.org with ESMTP id S1755485AbWKPWtw (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 16 Nov 2006 17:49:52 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kAGMnkoZ009339
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Thu, 16
 Nov 2006 14:49:47 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kAGMnjwg010095; Thu, 16 Nov
 2006 14:49:46 -0800
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Sender: git-owner@vger.kernel.org



On Thu, 16 Nov 2006, Johannes Schindelin wrote:
>
> - a terrible UI.

Why? We _do_ have the temporary branch. It's called FETCH_HEAD.

> _Also_, git-pull not storing the fetched branches at least temporarily 
> often annoyed me: the pull did not work, and the SHA1 was so far away I 
> could not even scroll to it.

Again, why didn't you use FETCH_HEAD?

If the user doesn't give us a head to write to, we clearly MUST NOT write 
to any long-term branch. That would be a _horrible_ mistake. 

So all your complaints seem totally misplaced. The UI is both usable and 
practical, and your complaint that git pull doesn't store the fetched 
branches is just NOT TRUE.

And your "solution" is obviously totally unusable. git ABSOLUTELY MUST NOT 
overwrite any existing branches unless explicitly told to do so by the 
user.

So I really don't see your point. 

A lot of the complaints seem to not be about the interfaces, but about 
people not _understanding_ and knowing what the interfaces do. If you were 
confused about something (like not realizing that FETCH_HEAD is there and 
very much usable), how about sending in a patch to make FETCH_HEAD use 
clearer in whatever docs you looked at and didn't find it mentioned in.

Now, there is no question that some of the interfaces can get a bit 
"interesting" to use. For example, if you really don't want to re-fetch 
for some reason, FETCH_HEAD actually does contain enough information that 
you should be able to just re-do a failed merge, for example, including 
the message generation. But at that point it really _does_ get a bit 
complicated, and you end up doing something like

	git merge "$(git fmt-merge-msg < .git/FETCH_HEAD)" HEAD FETCH_HEAD

which should _work_, but I'm not going to claim that it's all that easy to 
understand.

(That said, read that one-liner a few times, and suddenly it doesn't seem 
_that_ complicated any more, now does it? You can probably even guess what 
it's really going to do, even if you don't know git all that well. It's 
not unreadable line noise, is it?)

Of course, if I had a merge that failed (the most common reason being that 
I had some uncommitted patch in a file that wanted to be updated by the 
merge), I'd never actually do the above one-liner. I'd just re-do the 
pull. But if networking was _really_ slow, and I _really_ cared, maybe I'd 
do the above.

(And no, I didn't actually test the above one-liner. Maybe it doesn't work 
for some reason. Somebody should check, just for fun).

