From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] remove noise and inaccuracies from git-svn docs
Date: Tue, 19 Apr 2011 14:24:27 +0200
Message-ID: <4DAD7EFB.2050507@drmicha.warpmail.net>
References: <1303138000-27807-1-git-send-email-stsp@stsp.name> <vpqhb9vplu4.fsf@bauges.imag.fr> <7v39lfa1h5.fsf@alter.siamese.dyndns.org> <20110419093108.GA7440@ted.stsp.name> <4DAD6FC4.6060004@drmicha.warpmail.net> <20110419120031.GE4134@ted.stsp.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	git@vger.kernel.org
To: Stefan Sperling <stsp@stsp.name>
X-From: git-owner@vger.kernel.org Tue Apr 19 14:24:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QC9yu-0002BP-Rm
	for gcvg-git-2@lo.gmane.org; Tue, 19 Apr 2011 14:24:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752028Ab1DSMYb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Apr 2011 08:24:31 -0400
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:36099 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751434Ab1DSMYa (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Apr 2011 08:24:30 -0400
Received: from compute4.internal (compute4.nyi.mail.srv.osa [10.202.2.44])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 0F60720AD8;
	Tue, 19 Apr 2011 08:24:30 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute4.internal (MEProxy); Tue, 19 Apr 2011 08:24:30 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=Tn8Y0fFlrxVkkt7BACEsLy41MWo=; b=kLOBW5Yl0j8h74kHBXvzI7A5TSIuGI7YW1l5s74bzhFI5Y4VC4kFVnkDOBowQxb/2Vv/ICDw1BeQ62/HZfayVYl5XQvFoNkgq2bkmbxZlKUSZdU+9lZGXkg5hZOQMZQdxapDSFHwgdiRvF/YKqQ4fbOPo6JUGzgH0JYjBahjlA0=
X-Sasl-enc: 7EKMkXitegy7uYPJW+Svz42D7NElrPOBC3Jnhz6UcrwY 1303215869
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 28DEB44785B;
	Tue, 19 Apr 2011 08:24:29 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.15) Gecko/20110305 Remi/fc14 Lightning/1.0b3pre Thunderbird/3.1.9
In-Reply-To: <20110419120031.GE4134@ted.stsp.name>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171794>

Stefan Sperling venit, vidit, dixit 19.04.2011 14:00:
> On Tue, Apr 19, 2011 at 01:19:32PM +0200, Michael J Gruber wrote:
>> Stefan Sperling venit, vidit, dixit 19.04.2011 11:31:
>>> On Mon, Apr 18, 2011 at 10:55:18AM -0700, Junio C Hamano wrote:
>>>> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>>>>
>>>>> Stefan Sperling <stsp@stsp.name> writes:
>>>>>
>>>>>> -DESIGN PHILOSOPHY
>>>>>> ------------------
>>>>>> -Merge tracking in Subversion is lacking and doing branched development
>>>>>> -with Subversion can be cumbersome as a result.  While 'git svn' can
>>>>>> track
>>>>>
>>>>> Agreed (this and the rest of the patch). Users reading git-svn's doc
>>>>> don't want a dissertation about how bad SVN is, and if they do, they can
>>>>> read whygitisbetterthanx ;-)
>>>
>>> Exactly :)
>>>
>>> And they might rather want to learn more about how Subversion has improved
>>> since version 1.4. It seems that these parts of the text were written
>>> before Subversion's 1.5 release. SVN is a lot more capable now than the
>>> git-svn docs suggest and I'm surprised that git-svn's development seems
>>> to have gotten stuck at the 1.4 level of functionality. Not even CentOS
>>> ships with 1.4 anymore these days.
>>>
>>> E.g. git-svn could be taught to generate svn mergeinfo compatible with other
>>> Subversion clients. It's not easy to come up with a generic mapping between
>>> the two systems but for some use cases it should be reasonably straightforward.
>>> This would be a nice improvement towards making git-svn a proper drop-in
>>> replacement for the standard svn client. Currently, git-svn cannot be
>>> used without disturbing other users doing merges with Subversion itself
>>> which is a pity.
>>
>> 6abd933 (git-svn: allow the mergeinfo property to be set, 2010-09-24)
>>
>> made a first step in that direction so that you can at least add
>> mergeinfo manually.
> 
> Interesting. I didn't see this since I'm using the released version.
> 
> But I've been reading the most recent documentation file.
> How come the documentation wasn't updated?
> Is it intentionally not documented yet?
> 
>> But, git-svn.perl is basically in maintenance mode
>> it seems, and more work is being done to implement a new svn remote helper.
> 
> Is there already code for this new helper I can look at?

Please look for "svn-fe".

>  
>> Also, I think merge tracking wasn't that reliable in svn 1.5 before svn
>> 1.6, and we try to support older versions. In particular, we want to
>> support the versions on typical svn hosting sites which are not always
>> that recent.
> 
> "Not that reliable" is a pretty fuzzy statement that I cannot really
> provide a specific answer to.

"I think" == "fuzzy" ;)

> 
> There were various implementation bugs in early 1.5 releases causing
> miscalculations of mergeinfo. Those were client-side problems.
> The client calculates mergeinfo and uses it to determine which revisions
> to request during a merge. The server only stores mergeinfo and does not
> evaluate it, expect in case of the -g option for "svn log" which makes
> revisions from merged branches show up in the log output (analogous to
> how individual branch commits are shown in gitk).
> 
> So it shouldn't matter much which version of the server a hosting site
> is running. As long as the server is running some 1.5 release git-svn should,
> in general, be able to cope just fine. Even with a 1.4 server git-svn could
> commit svn:mergeinfo properties, though other svn clients won't bother using
> them until the server and repository format is upgraded.
> 
> Maybe there was some server-side problem that prevented you from doing
> something specific? In general it really shouldn't matter.

Well, it's helpful to know all the above!

--"mergeinfo" is halfway implemented in the sense that "git-svn" neither
helps you give that information properly (it could try to find the
revision range and knows the branch) nor does it use it. Also, git-svn
seems to be inconsistent in its use of "--long opt" and "--long=opt".
Anyways, here's a documentation patch. (I'm trying out my newly acquired
knowledge from SubmittingPatches rather then send-email, so hopefully
this is not fl[ao]wed.)

--- >8 ---
From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH] git-svn.txt: Document --mergeinfo

6abd933 (git-svn: allow the mergeinfo property to be set, 2010-09-24)
introduced the --mergeinfo option. Document it.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 Documentation/git-svn.txt |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index ea8fafd..96ac46b 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -217,6 +217,13 @@ config key: svn.commiturl (overwrites all svn-remote.<name>.commiturl options)
 Using this option for any other purpose (don't ask) is very strongly
 discouraged.
 
+--mergeinfo=<mergeinfo>;;
+	Add the given merge information during the dcommit
+	(e.g. `--mergeinfo="/branches/foo:1-10"`). All svn server versions can
+	store this information (as a property), and svn clients starting from
+	version 1.5 can make use of it. 'git svn' currently does not use it
+	and does not set it automatically.
+
 'branch'::
 	Create a branch in the SVN repository.
 
-- 
1.7.5.rc1.312.g1936c
