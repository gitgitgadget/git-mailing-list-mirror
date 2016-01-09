From: Stephen & Linda Smith <ischis2@cox.net>
Subject: Re: [PATCH v2 2/2] object name: introduce '^{/!-<negativepattern>}' notation
Date: Fri, 08 Jan 2016 18:55:21 -0700
Message-ID: <17299684.zSfrSa31Pt@thunderbird>
References: <1433550295-15098-1-git-send-email-wmpalmer@gmail.com> <loom.20160108T065547-969@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 09 02:54:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aHiju-0000lG-76
	for gcvg-git-2@plane.gmane.org; Sat, 09 Jan 2016 02:54:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754834AbcAIBym (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Jan 2016 20:54:42 -0500
Received: from fed1rmfepo203.cox.net ([68.230.241.148]:45783 "EHLO
	fed1rmfepo203.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751673AbcAIByl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jan 2016 20:54:41 -0500
Received: from fed1rmimpo306 ([68.230.241.174]) by fed1rmfepo203.cox.net
          (InterMail vM.8.01.05.15 201-2260-151-145-20131218) with ESMTP
          id <20160109015440.KEVI26406.fed1rmfepo203.cox.net@fed1rmimpo306>
          for <git@vger.kernel.org>; Fri, 8 Jan 2016 20:54:40 -0500
Received: from thunderbird ([68.231.74.134])
	by fed1rmimpo306 with cox
	id 3dug1s0062tqoqC01dugDD; Fri, 08 Jan 2016 20:54:40 -0500
X-CT-Class: Clean
X-CT-Score: 0.00
X-CT-RefID: str=0001.0A020201.56906860.00C4,ss=1,re=0.000,fgs=0
X-CT-Spam: 0
X-Authority-Analysis: v=2.0 cv=LKq4tuq9 c=1 sm=1
 a=/Rt4pg3TtX3KzfzhvVoEow==:17 a=kviXuzpPAAAA:8 a=7aQ_Q-yQQ-AA:10
 a=ybZZDoGAAAAA:8 a=TSbVqHtbAAAA:8 a=_J5RUaTPfq_1pH9etOsA:9 a=CjuIK1q_8ugA:10
 a=/Rt4pg3TtX3KzfzhvVoEow==:117
X-CM-Score: 0.00
Authentication-Results: cox.net; none
Received: from thunderbird.localnet (thunderbird [127.0.0.1])
	by thunderbird (Postfix) with ESMTP id C710013F7BB;
	Fri,  8 Jan 2016 18:55:22 -0700 (MST)
User-Agent: KMail/5.0.2 (Linux/4.3.0-5-generic; KDE/5.15.0; x86_64; ; )
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283596>


On Friday, January 08, 2016 10:21:48 AM Junio C Hamano wrote:
> Stephen Smith <ischis2@cox.net> writes:
> 
> > Junio C Hamano <gitster <at> pobox.com> writes:
> >> >  	echo modified >>a-blob &&
> >> >  	git add -u &&
> >> >  	git commit -m Modified &&
> >> > +	git branch modref &&
> >> 
> >> This probably belongs to the previous step, no?
> >> 
> > What did you mean by this comment?  I looked at the original patch and at 
> > Will's response to your comment and am not quite sure what was meant.
> 
> Notice that the title is [2/2], so there is [1/2], which turns out
> to be http://article.gmane.org/gmane.comp.version-control.git/270898
> 
I had that patch but didn't connect it to your comment.   

> That patch updates the preparatory steps of the test script so that
> [2/2] have more commits and refs to work with to perform more tests.
> 
> Marking the result of that "Modified" commit so that it can be
> referenced later with a short name 'modref' is something that should
> have done in [1/2], which added that new invocation of "git commit"
> to record that "Modified" commit, not in [2/2] as an afterthought
> "Oh I created Modified commit in 1/2 so that I can use it in the
> test in 2/2, but I forgot to give it a name, so I am adding a new
> invocation of 'git branch' in this step".
Yep makes sense.

> 
> >
> >> > +test_expect_success 'ref^{/!-}' '
> >> > +	test_must_fail git rev-parse master^{/!-}
> >> > +'
> >> 
> > I plan on leaving this in.
> >
> >> > +test_expect_success 'ref^{/!-.}' '
> >> > +	test_must_fail git rev-parse master^{/!-.}
> >> > +'
> >> 
> > I plan on leaving this in.
