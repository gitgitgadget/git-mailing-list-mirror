From: Ed Avis <eda@waniasset.com>
Subject: Re: Feature: git stash pop --always-drop
Date: Mon, 10 Aug 2015 15:16:42 +0000 (UTC)
Message-ID: <loom.20150810T171010-455@post.gmane.org>
References: <loom.20150810T124037-407@post.gmane.org> <20150810124125.GC32371@sigill.intra.peff.net> <loom.20150810T144849-152@post.gmane.org> <20150810133220.GA3559@sigill.intra.peff.net> <loom.20150810T153939-856@post.gmane.org> <20150810134957.GC6763@sigill.intra.peff.net> <loom.20150810T155117-978@post.gmane.org> <xmqqzj1zuqod.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 10 17:16:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZOooq-0002j8-3p
	for gcvg-git-2@plane.gmane.org; Mon, 10 Aug 2015 17:16:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753150AbbHJPQw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Aug 2015 11:16:52 -0400
Received: from plane.gmane.org ([80.91.229.3]:41459 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752957AbbHJPQv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Aug 2015 11:16:51 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1ZOooj-0002go-Rc
	for git@vger.kernel.org; Mon, 10 Aug 2015 17:16:50 +0200
Received: from 80.169.169.174 ([80.169.169.174])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 10 Aug 2015 17:16:49 +0200
Received: from eda by 80.169.169.174 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 10 Aug 2015 17:16:49 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 80.169.169.174 (Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:39.0) Gecko/20100101 Firefox/39.0 Cyberfox/39.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275625>

Junio C Hamano <gitster <at> pobox.com> writes:
 
>>Yes, my use case is that I get confused about whether the stash has been
>>dropped or not and whether I might have stashed something else in the
>>meantime.  So for me plain 'git stash drop' feels a bit dangerous.
>
>Then "git stash apply" followed by "git stash drop" would be a pair
>of good workflow elements for you, no?

I like ordinary 'git stash pop' when it applies cleanly.  Only in the cases
where it has conflicts and leaves the stash in place does it get a bit
awkward.  I manually resolve the conflicts and then 'git stash drop', but
that last step is a bit dangerous because it might drop an unrelated stash
if I have done some other stashing in the meantime.

If 'git stash pop' (and 'apply') would always print the name of the stash,
then it would be easy to drop that particular stash afterwards.  Running
one too many or one too few 'git stash drop' commands would no longer cause
problems.

Printing the name of the stash would, for me, largely remove the need for
an --always-drop option to git stash, which is what I at first suggested.

-- 
Ed Avis <eda@waniasset.com>
