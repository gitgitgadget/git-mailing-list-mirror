From: "David A. Wheeler" <dwheeler@dwheeler.com>
Subject: Re: Storing permissions
Date: Sun, 17 Apr 2005 12:21:47 -0400
Message-ID: <42628D1B.3000207@dwheeler.com>
References: <20050416230058.GA10983@ucw.cz> <118833cc05041618017fb32a2@mail.gmail.com> <20050416183023.0b27b3a4.pj@sgi.com> <Pine.LNX.4.58.0504162138020.7211@ppc970.osdl.org> <42620092.9040402@dwheeler.com> <Pine.LNX.4.58.0504170857580.7211@ppc970.osdl.org>
Reply-To: dwheeler@dwheeler.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Paul Jackson <pj@sgi.com>, Morten Welinder <mwelinder@gmail.com>,
	mj@ucw.cz, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 17 18:16:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNCRX-0008Uq-Oc
	for gcvg-git@gmane.org; Sun, 17 Apr 2005 18:16:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261348AbVDQQUA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Apr 2005 12:20:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261349AbVDQQUA
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Apr 2005 12:20:00 -0400
Received: from cujo.runbox.com ([193.71.199.138]:63377 "EHLO cujo.runbox.com")
	by vger.kernel.org with ESMTP id S261348AbVDQQT6 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Apr 2005 12:19:58 -0400
Received: from [10.9.9.1] (helo=bolivar.runbox.com)
	by greyhound.runbox.com with esmtp (Exim 4.34)
	id 1DNCUy-0000Wv-H1; Sun, 17 Apr 2005 18:19:52 +0200
Received: from [70.17.101.238] (helo=[192.168.2.73])
	by bolivar.runbox.com with asmtp (uid:258406) (Exim 4.34)
	id 1DNCUy-000125-7o; Sun, 17 Apr 2005 18:19:52 +0200
User-Agent: Mozilla Thunderbird 1.0.2-1.3.2 (X11/20050324)
X-Accept-Language: en-us, en
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504170857580.7211@ppc970.osdl.org>
X-Sender: 258406@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus Torvalds wrote:
> 
> On Sun, 17 Apr 2005, David A. Wheeler wrote:
> 
>>There's a minor reason to write out ALL the perm bit data, but
>>only care about a few bits coming back in: Some people use
>>SCM systems as a generalized backup system
> 
> Yes. I was actually thinking about having system config files in a git 
> repository when I started it, since I noticed how nicely it would do 
> exactly that.
> 
> However, since the mode bits also end up being part of the name of the 
> tree object (ie they are most certainly part of the hash), it's really 
> basically impossible to only care about one bit but writing out many bits: 
> it's the same issue of having multiple "identical" blocks with different 
> names.
...
> One solution is to tell git with a command line flag and/or config file 
> entry that "for this repo, I want you to honor all bits". That should be 
> easy enough to add at some point, and then you really get what you want.

Yes, I thought of that too.  And I agree, that should do the job.

My real concern is I'm looking at the early design of the
storage format so that it's POSSIBLE to extend git in obvious ways.
As long as it's possible later, then that's a great thing.

...
> Also, I made a design decision that git only cares about non-dotfiles. Git 
> literally never sees or looks at _anything_ that starts with a ".". I 
> think that's absolutely the right thing to do for an SCM (if you hide your 
> files, I really don't think you should expect the SCM to see it), but it's 
> obviously not the right thing for a backup thing.

Again, a command line flag or config file entry could change that
in the future, if desired.  So this is a decision that could be
changed later... the best kind of decision :-).

--- David A. Wheeler
