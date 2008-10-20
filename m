From: Christian Jaeger <christian@jaeger.mine.nu>
Subject: Re: Feedback outside of the user survey
Date: Mon, 20 Oct 2008 17:20:28 +0200
Message-ID: <48FCA1BC.3060300@jaeger.mine.nu>
References: <2d460de70810160319r4bed8643g884508cdeba772@mail.gmail.com> <20081016115628.GA24836@garry-x300.arpnetworks.com> <2d460de70810160618u1803375aj913145a5060e5308@mail.gmail.com> <48F7A4F8.2080600@jaeger.mine.nu> <20081018134906.GA13894@garry-thinkpad.arpnetworks.com> <48F9EC2B.2010200@jaeger.mine.nu> <48FC55F9.3060509@op5.se> <48FC9927.5030903@jaeger.mine.nu> <48FC9D87.3010303@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Garry Dolley <gdolley@arpnetworks.com>,
	Richard Hartmann <richih.mailinglist@gmail.com>,
	git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Mon Oct 20 20:41:33 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KrwZk-0002GF-8O
	for gcvg-git-2@gmane.org; Mon, 20 Oct 2008 17:21:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751054AbYJTPUc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Oct 2008 11:20:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751134AbYJTPUc
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Oct 2008 11:20:32 -0400
Received: from ethlife-a.ethz.ch ([129.132.49.178]:41702 "HELO ethlife.ethz.ch"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1750976AbYJTPUb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Oct 2008 11:20:31 -0400
Received: (qmail 28264 invoked from network); 20 Oct 2008 15:20:29 -0000
Received: from unknown (HELO elvis-jaeger.mine.nu) (127.0.0.1)
  by localhost with SMTP; 20 Oct 2008 15:20:29 -0000
Received: (qmail 11803 invoked from network); 20 Oct 2008 15:20:29 -0000
Received: from unknown (HELO ?127.0.0.1?) (10.0.5.1)
  by elvis-jaeger.mine.nu with SMTP; 20 Oct 2008 15:20:29 -0000
User-Agent: Mozilla-Thunderbird 2.0.0.16 (X11/20080724)
In-Reply-To: <48FC9D87.3010303@op5.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98689>

Andreas Ericsson wrote:
> Christian Jaeger wrote:
>> Andreas Ericsson wrote:
>>> Christian Jaeger wrote:
>>>> If you really wanted, I suppose you could additionally look into 
>>>> implementing a kind of shallow cloning that only copies objects 
>>>> over the wire which are necessary for representing the subdirectory 
>>>> you're interested in.
>>>>
>>>
>>> So what do you do when one such commit also affects something outside
>>> the subdirectory?
>>
>> You haven't said what you mean with "affect".
>>
>
> I mean "how would you handle a commit (and its tree-object) that updates
> all Makefiles in, for example, the Linux kernel project?". Those files
> are spread far and wide, and you'd want that change to *your* tree, but
> getting it into your tree either means you need to rewrite the tree (and
> thereby the commit) itself to get rid of uninteresting blob's from the
> tree, and you'd also have to prune the tree to not reveal the directory
> layout of the rest of the repository.

You have said "either" but not "or".

> I take it parentage could be resolved by a ridiculously large 
> grafts-file.

Hm, not sure whether you mean to rescue the situation with rewritten 
commits here -- but hell no, I certainly don't mean to have different 
commit objects for different clones/checkouts.

> What you'd end up with wouldn't be a git repository at all anymore. It
> would be a "stump", as it'd be missing large parts of the tree entirely.

That was my point, yes.

> I'm unsure just how much you'd have to compute to be able to use such a
> stump to incorporate your changes with other users again, but I doubt it
> would be trivial to implement. Good thing it's not my itch, really.

I've been suggesting it to Garry :)

Maybe whoever writes up something on the wiki regarding subdirectory 
checkouts in SVN versus Git could still care about what the "fundamental 
technical" limits are versus what the current implementation (or 
practicalness) imposes. It will be both a more enlightening and 
potentially more future-proof explanation then.

Christian.
