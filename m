From: Matthias Fechner <idefix@fechner.net>
Subject: Re: Git and svn as target
Date: Mon, 14 Jun 2010 18:35:44 +0200
Message-ID: <4C165A60.2010508@fechner.net>
References: <4C107BEB.6020209@fechner.net> <20100610060525.GA2177@m62s10.vlinux.de> <AANLkTino5sVtNEFV5_nGi9NmlhBCc0-_4NhTZwKdDzho@mail.gmail.com>
Reply-To: git@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 14 18:36:10 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OOCdr-0007mW-QQ
	for gcvg-git-2@lo.gmane.org; Mon, 14 Jun 2010 18:36:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754645Ab0FNQgA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jun 2010 12:36:00 -0400
Received: from anny.lostinspace.de ([80.190.182.2]:31781 "EHLO
	anny.lostinspace.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753947Ab0FNQf7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jun 2010 12:35:59 -0400
Received: from server.idefix.lan (ppp-88-217-54-73.dynamic.mnet-online.de [88.217.54.73])
	(authenticated bits=0)
	by anny.lostinspace.de (8.14.3/8.14.3) with ESMTP id o5EGZqkC006868
	for <git@vger.kernel.org>; Mon, 14 Jun 2010 18:35:56 +0200 (CEST)
	(envelope-from idefix@fechner.net)
Received: from server.idefix.lan (unknown [127.0.0.1])
	by server.idefix.lan (Postfix) with ESMTP id 2261777B1
	for <git@vger.kernel.org>; Mon, 14 Jun 2010 18:35:52 +0200 (CEST)
X-Virus-Scanned: amavisd-new at server.idefix.lan
Received: from server.idefix.lan ([127.0.0.1])
	by server.idefix.lan (server.idefix.lan [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qpJr4W9bSA7P for <git@vger.kernel.org>;
	Mon, 14 Jun 2010 18:35:45 +0200 (CEST)
Received: from idefix-mobil.idefix.lan (unknown [IPv6:2001:a60:f035:2:226:8ff:fee1:cb6f])
	by server.idefix.lan (Postfix) with ESMTPA id 43C4277A2
	for <git@vger.kernel.org>; Mon, 14 Jun 2010 18:35:45 +0200 (CEST)
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; de; rv:1.9.1.9) Gecko/20100317 Thunderbird/3.0.4
In-Reply-To: <AANLkTino5sVtNEFV5_nGi9NmlhBCc0-_4NhTZwKdDzho@mail.gmail.com>
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.2.5 (anny.lostinspace.de [80.190.182.2]); Mon, 14 Jun 2010 18:35:56 +0200 (CEST)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,UNPARSEABLE_RELAY
	autolearn=ham version=3.3.1
X-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on anny.lostinspace.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149125>

Hi,

Am 10.06.10 09:11, schrieb Avery Pennarun:
> Right. I actually like it that way much more than I like rebasing
> onto master, but that's a matter of opinion, of course.  Another
> option would be to simply do "git svn dcommit" from the 'test' branch
> rather than merging it into master first.  (This essentially asks
> git-svn to do your rebasing for you, so it's roughly the same thing as
> merge-rebase-dcommit.)
>    

thanks, I got it working with the following sequence:
git svn fetch
git svn rebase
git branch test
git checkout test
several commit with commit messages
git checkout master
git svn fetch
git svn rebase
git rebase --interactive --preserve-merges test
git svn dcommit

Now I can see all local git commit as commits to the svn repository.

Bye,
Matthias

-- 
"Programming today is a race between software engineers striving to build bigger and better idiot-proof programs, and the universe trying to produce bigger and better idiots. So far, the universe is winning." -- Rich Cook
