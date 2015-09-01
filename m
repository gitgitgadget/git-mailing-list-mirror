From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: Windows path handling changed between versions
Date: Tue, 01 Sep 2015 19:30:49 +0200
Organization: gmx
Message-ID: <d2bd100f23980ace0ec9f071fbe18add@www.dscho.org>
References: <CAFPYLHASH_LZ2YgQWjfPKCwq_n-9HVNotkimiQDY1Qy8_8gtwg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Geofrey Sanders <geofrey.sanders@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 01 19:31:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZWpOq-0003fd-Fl
	for gcvg-git-2@plane.gmane.org; Tue, 01 Sep 2015 19:31:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753126AbbIARax (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Sep 2015 13:30:53 -0400
Received: from mout.gmx.net ([212.227.17.21]:57622 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752622AbbIARaw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Sep 2015 13:30:52 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0M7ojs-1YkF1G1rX6-00vMoo; Tue, 01 Sep 2015 19:30:50
 +0200
In-Reply-To: <CAFPYLHASH_LZ2YgQWjfPKCwq_n-9HVNotkimiQDY1Qy8_8gtwg@mail.gmail.com>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.2
X-Provags-ID: V03:K0:tKPT4U/SSA/ih+n2BMGDqbOAoaUQWQmJbIiHjhy668JrmeWXCiN
 83/TSZkum2wz2tyYXI7sbLu4ZoxCC6mtQBjMXJUE5yfyPT/unHnZEHU0JWam0BKHlGwTHod
 mp1GyCffBnPvSEE089fNS8eOu00Lh6AJc7+pzYveyfhcITbUXfPTXbEd2nm1uMWim71P2ic
 BJJOJSGBqcJm9gWWEDhHg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:99kwhg7fccs=:eLPnMSjY/pM18JOMkoq864
 /u2Eovd+7E4BOU9eiqMbCYaLJ7i97nCeevy11PCyVOF0q3ScxyWwgG8HF2PvwtvgOcPyAU74W
 6mQ9MX4JiDPoDwwWm7iP24ddAdzGJWf5SZ19lZiysKhNOGfQQ4NUITmTpwqFrisPc/OS+5MpX
 32lMcCF7Vn3yzUWps4bt6BycTCphTUsUapYt1aUjCCT9EAfBpaTaWQvGYCaAEXQ0pic0qFh2X
 VioAitPWgq+HGnFfCNA2X7us6RAE3lkX1FAPHfdOHzs+bUPMjTO1287sRIZB4kZ0qbG1zXWiK
 ChdmpSxW03FYdXl6NoMFgh1XBubSRzdvrROuuQ+nGNfMjHSFdQGyZY+AYTCbE/nNh4KxFJ9K8
 Tm8SwZ4ClDo0uaOhifBU1ooDrOMo/MalZ3iMRjH3Tqox3eQIL3saecCAgLkc6mEUiMWDzPDqC
 tFxnlksvj3mQQ8nCTbHis7nVLYC9lSjPt1FoFbOBKZ9COUvCF4M1ZKAbUP6gWhMLm1DU4v2yv
 EzK447pVei2YpRFyYsOBERxxUWN2MZZiYOhK2KKemufK/dfY4zNOeFju93tbTwLbrpS+V1IWV
 Y9Js8F55kFPb6Z7JIPjtEiYVKXJ8fVYNIeRX70vXm2SaKmTPwPcsVIKJXRGa8IXGKa0PmNc+J
 XZM3nRtz2w3bZFPc7y7ghh0mNXQyD0pgYbe88uoN3TnYDxfFhcIDjGas31NobETVBuypejvpI
 j7sUScGyYzkmVvz5w6s+0Lw/V/8KHX4rEJ/Cfg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276997>

Hi Geofrey,

On 2015-09-01 18:55, Geofrey Sanders wrote:
> I recently upgraded from Windows Git 1.6.2 to 2.5.0 and found myself
> unable to rebase. Turns out paths didn't used to be case-sensitive and
> now they are, causing a number of operations to halt. A repo created
> by pointing at the directory
>     c:\core\guidewire\Dev\2.4
> would (I suppose) technically have been invalid the whole time because
> Windows reports the current path as
>     C:\core\guidewire\Dev\2.4
> , but msys Git 1.6.2 evidently made a case-insensitive path comparison
> so the discrepancy was suppressed.

Are you sure about that? I seem to recall that `pwd` changed behavior between MSys and MSys2, but Git never made case-insensitive comparisons.

It might help me to understand what is going on if I could have preciser information. What exactly do you mean by "A repo created by pointing at ..."? Could you type out the Git commands you used?

> The proximate cause of errors was
>     git rev-parse --is-inside-work-tree
> which would output 'false' even inside the working tree.

Ah, you are apparently talking about a worktree separate from your repository?

> "--is-inside-git-dir" also printed 'false' in directories where it
> should have said 'true'.

Again, I really need preciser information about this: *How* did you end up in that directory? Did you use Git Bash or Git CMD? Did you call `cd` with a relative path, a POSIX path or a POSIX-ified full DOS path?

> I actually missed the problem in plain sight
> at first, because I created a new repo (in which everything worked as
> expected), and then did a directory diff... the worktree paths were
> different but I only noticed the names, not the case difference in the
> drive letter. More details in this SO question:
> http://stackoverflow.com/q/32280644/2835086

Please understand that I have a lot of tickets to juggle about and that it is a bit unfair to send me onto a goose chase. I would have preferred a proper GitHub issue, as the "Contribute" section of https://git-for-windows.github.io/ explicitly asks for, but I am okay with discussing this ticket on the mailing list. But studying a StackOverflow thread in addition is a bit much... next, people would ask me to search their Twitter feed for the little tid bit of information I need to help.

So please summarize that StackOverflow question, and while we are at it: StackOverflow suggests coming up with a Minimal, Complete and Verifiable Example. That would be a nice thing to have. Maybe you find it in you to come up with that MCVE.

> I was able to repair my existing repos by changing the 'worktree'
> value in gitconfig - s/c/C/ did the trick - but the whole thing was a
> surprise.
> 
> Is this a bug in the current version? Windows doesn't distinguish on
> case, so maybe applications shouldn't either.
> Was this a bug in the prior version? Maybe creating a repo with a
> worktree path that doesn't match the file system should have been an
> error from the very beginning.
> Was this user error? Maybe I did something wrong and should have known
> better, but got away with it for a while.

I think there is a good chance we can fix this, although a 1.x -> 2.x jump always suggests that certain things change in a backwards-incompatible manner.

Looking forward to more detailed information and that MCVE,
Johannes
