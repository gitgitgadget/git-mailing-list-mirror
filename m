From: Patrick Sudowe <git@sudowe.net>
Subject: Re: git rebase -i and the reflog
Date: Thu, 11 Feb 2010 08:29:01 +0100
Message-ID: <4B73B1BD.7030606@sudowe.net>
References: <fabb9a1e1002101419x40844a42s21108aaa849430c1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 11 08:35:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NfTZw-0008KF-01
	for gcvg-git-2@lo.gmane.org; Thu, 11 Feb 2010 08:35:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751768Ab0BKHfF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Feb 2010 02:35:05 -0500
Received: from vacuity.ath.cx ([85.10.202.48]:40911 "EHLO vacuity.ath.cx"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751300Ab0BKHfD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Feb 2010 02:35:03 -0500
X-Greylist: delayed 359 seconds by postgrey-1.27 at vger.kernel.org; Thu, 11 Feb 2010 02:35:03 EST
Received: from blackparity_k.local (f050093213.adsl.alicedsl.de [78.50.93.213])
	by vacuity.ath.cx (Postfix) with ESMTPSA id 19824AD408E
	for <git@vger.kernel.org>; Thu, 11 Feb 2010 08:29:01 +0100 (CET)
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-US; rv:1.9.1.7) Gecko/20100111 Thunderbird/3.0.1
In-Reply-To: <fabb9a1e1002101419x40844a42s21108aaa849430c1@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139576>



On Wednesday 2/10 2/10  11:19 PM, Sverre Rabbelier wrote:
> Heya,
>
> I use "git rebase -i" a lot, and as a result the output from 'git log
> -g' and 'git reflog' is a tad messy. That is, it's (afaik) not
> possible to check that after my rebasing did not mess things up using
> something like 'git diff HEAD@{1}'. I could of course tag the old head
> or something, but that's not the only problem, due to the clutter it's
> hard to find genuine commits. What I want is a way to see HEAD's
> movement _excluding_ any rebase activity. So if I change history from
> A-o-B-C to A-o-B'-C', I want to see C and C' in the reflog, but not
> B', since B' is often actually identical to B, the only reason that it
> changed is that I did 'git rebase -i' on some far-back commit.
>
> Is there an existing solution to this?
>

Since nobody else mentioned it on the list.

You could also use ORIG_HEAD.
merge, rebase and am (maybe others?) record the position of HEAD to 
ORIG_HEAD before their operation.
So to check for the differences directly after one of these commands
a diff between HEAD and ORIG_HEAD should do.

I really liked the shortcut of ORIG_HEAD when I found out about it
just a couple days ago.

-Patrick
