From: Sergey Organov <sorganov@gmail.com>
Subject: Re: git rebase: yet another newbie quest.
Date: Mon, 08 Sep 2014 19:47:38 +0400
Message-ID: <87fvg23yhx.fsf@osv.gnss.ru>
References: <87a96ecqe9.fsf@osv.gnss.ru> <20140905154159.GB1510@thunk.org>
	<87sik28bir.fsf@osv.gnss.ru> <20140908140758.GI1066@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Mon Sep 08 17:47:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XR1AR-00033c-2p
	for gcvg-git-2@plane.gmane.org; Mon, 08 Sep 2014 17:47:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753428AbaIHPrm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Sep 2014 11:47:42 -0400
Received: from mail.javad.com ([54.86.164.124]:58837 "EHLO mail.javad.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752925AbaIHPrl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Sep 2014 11:47:41 -0400
Received: from osv.gnss.ru (unknown [89.175.180.246])
	by mail.javad.com (Postfix) with ESMTPSA id 9B8C860BF3;
	Mon,  8 Sep 2014 15:47:40 +0000 (UTC)
Received: from osv by osv.gnss.ru with local (Exim 4.72)
	(envelope-from <sorganov@gmail.com>)
	id 1XR1AI-00015G-Ux; Mon, 08 Sep 2014 19:47:38 +0400
In-Reply-To: <20140908140758.GI1066@thunk.org> (Theodore Ts'o's message of
	"Mon, 8 Sep 2014 10:07:58 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256653>

Theodore Ts'o <tytso@mit.edu> writes:

> On Mon, Sep 08, 2014 at 05:52:44PM +0400, Sergey Organov wrote:
>> 
>> I didn't intend to make topic branch from the very beginning, and
>> already made a commit or two on the remote tracking branch bofore I
>> realized I'd better use topic branch. It'd create no problem as far as I
>> can see, provided vanilla "git rebase" has "sane" defaults. That said,
>> I've already been once pointed to by Junio that my definition of "sane"
>> doesn't take into account workflows of others, so now I try to be
>> carefull calling vanilla "git rebase" names.
>
> Right, so what I typically in that situation is the following:
>
> <on the master branch>
> <hack hack hack>
> git commit
> <hack hack hack>
> git commit
> <oops, I should have created a topic branch>
> git checkout -b topic-branch
> git branch -f master origin/msater
>
> This resets the master branch to only have what is in the upstream
> commit.

But that's *exactly* what lead me to the problem! Here is relevant part
of my script:

git checkout -b topic
git branch --force master origin_master
git branch -u master

except that I wanted to configure upstream as well for the topic-branch,
that looks like pretty legit desire. If I didn't, I'd need to specify
upstream explicitly in the "git rebase", and I'd not notice the problem
at all, as the actual problem is that "git rebase" and "git rebase
<upstream>" work differently!

-- Sergey.

P.S. Nice 'lgt' alias, BTW. I simply use:

$ git help hist
git hist' is aliased to `log --oneline --graph --decorate'

stolen somewhere.
