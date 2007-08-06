From: Steven Grimm <koreth@midwinter.com>
Subject: Re: [PATCH v2] user-manual: mention git gui citool (commit, amend)
Date: Mon, 06 Aug 2007 17:36:43 +0800
Message-ID: <46B6EBAB.4050805@midwinter.com>
References: <20070803125634.GB28323@fieldses.org> <1186318785677-git-send-email-prohaska@zib.de> <Pine.LNX.4.64.0708051457110.14781@racer.site> <17AA7EBE-B755-4F26-9C7E-AF6D762811F2@zib.de> <85wswa6n1o.fsf@lola.goethe.zz> <5AB64D44-2324-4A98-B010-8D6D6225F116@zib.de> <Pine.LNX.4.64.0708060119320.14781@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Steffen Prohaska <prohaska@zib.de>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Aug 06 11:36:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHz1G-0001Aq-JZ
	for gcvg-git@gmane.org; Mon, 06 Aug 2007 11:36:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761417AbXHFJgu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 6 Aug 2007 05:36:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761430AbXHFJgt
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Aug 2007 05:36:49 -0400
Received: from tater2.midwinter.com ([216.32.86.91]:36099 "HELO midwinter.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1761124AbXHFJgq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Aug 2007 05:36:46 -0400
Received: (qmail 1434 invoked from network); 6 Aug 2007 09:36:45 -0000
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=200606; d=midwinter.com;
  b=dxx311830vTw16ByOhqlTf4UpslzlpSVRbvdOM/QOJG980NEFWq+Igb4QPbpA+hK  ;
Received: from localhost (HELO sgrimm-mbp.local) (koreth@127.0.0.1)
  by localhost with SMTP; 6 Aug 2007 09:36:45 -0000
User-Agent: Thunderbird 2.0.0.6 (Macintosh/20070728)
In-Reply-To: <Pine.LNX.4.64.0708060119320.14781@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55129>

Johannes Schindelin wrote:
> But how do you make sure that it works as expected?  I.e. when you commit 
> a hunk using, say, variable "rule_the_world", and by mistake (happen to me 
> all the time, maybe to you, too?) forgot to select the hunk which declares 
> that variable, maybe because it is hidden in a forest of other variables?
>   

For cases like that, sure, partial commits are dangerous. On the other 
hand, I've sometimes done partial commits for things like correcting 
erroneous comments in code I'm working on, where there is no functional 
change whatsoever in the hunk I'm committing and where I want to isolate 
the corrections from the functional changes I *am* working on.

Also, when I'm working on a topic branch in my local sandbox I like to 
do lots of work-in-progress commits. I usually do those based on the 
granularity of my mental model of what I'm working on, and I have no 
expectation whatsoever that any particular percentage of them represent 
working code or even code that compiles. Sometimes I do partial commits 
in that situation too: I make a change to some function in a file that 
I'm editing elsewhere, and commit just that hunk with a commit log 
message reminding me of why I made the change. Those commits are not 
intended for public consumption; they're just to help me keep track of 
my own work. Once everything is in a working state, I do a squash merge 
or a bunch of cherry-pick -n invocations to build some revisions to 
publish to the outside world, and *then* I am in "each commit must 
represent a non-broken state" mode.

The great thing about git (well, *one* of the great things) is that it 
unifies those two workflows in one system. With, say, svn, the "lots of 
little checkpoints of my work in progress" part of that is awkward at 
best, because it's very much oriented around an "if the version control 
system knows about a change, it is by definition published to the 
outside world" model.

So I guess my point, after all that, is just that assumptions that are 
valid in the context of one workflow are not necessarily as valid in 
others, and that even in a particular context, not all changes are 
created equal.

-Steve
