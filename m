From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH v2 0/2] clone: simplify progress message
Date: Tue, 11 May 2010 09:27:07 +0200
Message-ID: <4BE906CB.3000303@drmicha.warpmail.net>
References: <4BE60E89.8010709@pcharlan.com> <20100509110221.GA16639@coredump.intra.peff.net> <4BE7166A.5030107@pcharlan.com> <20100510054756.GB13340@coredump.intra.peff.net> <4BE7E09F.3040303@drmicha.warpmail.net> <4BE8954E.3030405@pcharlan.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	git list <git@vger.kernel.org>
To: Pete Harlan <pgit@pcharlan.com>
X-From: git-owner@vger.kernel.org Tue May 11 09:27:14 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OBjs1-00008H-S6
	for gcvg-git-2@lo.gmane.org; Tue, 11 May 2010 09:27:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757241Ab0EKH1I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 May 2010 03:27:08 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:57237 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753441Ab0EKH1E (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 May 2010 03:27:04 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id D9183F5509;
	Tue, 11 May 2010 03:27:02 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Tue, 11 May 2010 03:27:02 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=vzjyJnvlDEAt5FSVhCWrSyWLOzU=; b=iOJwbGwb0GqUcBmyffOkdVJS67ukOa9SxeI8LLdPs7Ka51NWz5tW//NZIYW/BeZ3xnM3nLxyUmv6iopESVLb3N2mtow6wUJpnaa8fmDos9VM4sfh+PCGRPzbSWiUCGXBOQnhwT6v8vFHPyxScbHKsuY5gqoPqeqi8T7r53GiEFk=
X-Sasl-enc: DwfrIag40OIJajbSmDKyML41nN79r/6eGVdkOEfSGRq+ 1273562822
Received: from localhost.localdomain (heawood.math.tu-clausthal.de [139.174.44.4])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 0FE324CF1B1;
	Tue, 11 May 2010 03:27:01 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.5pre) Gecko/20100503 Lightning/1.0b2pre Lanikai/3.1b2pre
In-Reply-To: <4BE8954E.3030405@pcharlan.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146876>

Pete Harlan venit, vidit, dixit 11.05.2010 01:22:
> On 05/10/2010 03:31 AM, Michael J Gruber wrote:
>> Jeff King venit, vidit, dixit 10.05.2010 07:47:
>>> On Sun, May 09, 2010 at 01:09:14PM -0700, Pete Harlan wrote:
>>>
>>>>> I guess it comes down to how much detail we want to show.
>>>>
>>>> For me it isn't only a matter of detail; I find "Cloning into 
>>>> bar/.git" misleading, since bar is getting more than a .git 
>>>> directory.
>>>
>>> Yeah, I can buy that line of reasoning. Junio's nitpick aside, I 
>>> think most users perceive the clone process as creating the whole 
>>> "bar" directory.
>>>
>>>> Thank you for looking at this.  I agree with you, and have added 
>>>> a second patch that implements that.
>>>
>>> These patches look good to me. I agree with Junio about just 
>>> squashing them.
>>>
>>> -Peff
>>
>> Back from a conference, I'm being late for the party (Which way
>> round is better? ;) ).
>>
>> But I still want to suggest not sacrificing correctness for "user's 
>> expectations" and rather trying to do combine them. So how about 
>> saying
>>
>> Cloning into $GIT_DIR... Checking out branch $branch in $WORK_DIR...
>>
>> where the latter happens for non-bare repos only, of course, and 
>> incidently confirms the use of "-b" or of the default.
>>
>> Michael
> 
> Thanks for looking at this.  The patch you posted reports, e.g.:
> 
>   % git clone foo bar
>   Cloning into /tmp/git/bar/.git...
>   done.
>   Checking out branch master into worktree bar.
>   %
> 
> I'd like to see "worktree" either omitted or replaced with "working
> directory".  Git works on trees, but "working directory" is a term
> ordinary users understand and "bar" is a directory being populated
> with files so there's nothing wrong with the user thinking of it that
> way.

"working tree" (short: worktree) is the Git term, core.worktree the name
of the config variable, GIT_WORK_TREE the name of the environment
variable for the directory in which a tree is checked out.

"working directory" is the name of the directory which you are in (i.e.
$(pwd)).

While, technically, the wd is the wt during the check out, using wd
would introduce users to the wrong terminology.

> But on a different note, I think we don't have to be so verbose.  If
> the user asks for details with -v then be as chatty as we want, but
> for the most part operations that succeed should do so quietly.

In fact, we introduced that message not that long ago because until
then, only init's message would be displayed to the user ("Initializing
empty..."), which was highly confusing.

The consensus back then was, without -v nor -q, to have everyday
commands be silent on successful operation, and "infrequent" commands
report progress.

Cheers,
Michael
