From: Eugene Sajine <euguess@gmail.com>
Subject: Re: Coping with the pull-before-you-push model
Date: Tue, 14 Sep 2010 12:24:51 -0400
Message-ID: <AANLkTi=Yg-Pgu7E_hxzPVToO0wDjiTm=NxKPdrgk9JaE@mail.gmail.com>
References: <4C8866F9.1040705@workspacewhiz.com>
	<AANLkTikY55ZJvSTqyFKLqwABqnJZuODz3yrc7CFvQf0K@mail.gmail.com>
	<4C88F2A9.2080306@workspacewhiz.com>
	<AANLkTikdV3W1d7uNokKRRiT4FeznL1uM=Y9SQLDqgAic@mail.gmail.com>
	<20100910141527.GA6936@sigill.intra.peff.net>
	<4C8EFE62.7080908@workspacewhiz.com>
	<D4360EBB-7891-457E-A6AC-7159CADCAC6C@mit.edu>
	<4C8F99FA.3040003@workspacewhiz.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Theodore Tso <tytso@mit.edu>, Jeff King <peff@peff.net>,
	Jon Seymour <jon.seymour@gmail.com>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Joshua Jensen <jjensen@workspacewhiz.com>
X-From: git-owner@vger.kernel.org Tue Sep 14 18:25:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OvYJY-0007Im-CE
	for gcvg-git-2@lo.gmane.org; Tue, 14 Sep 2010 18:25:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752152Ab0INQYy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 14 Sep 2010 12:24:54 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:59890 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751665Ab0INQYx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Sep 2010 12:24:53 -0400
Received: by qwh6 with SMTP id 6so4477440qwh.19
        for <git@vger.kernel.org>; Tue, 14 Sep 2010 09:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=8sTj6CB6XpopFGFLoQW71W3hpue0/bb7VkP7V95ygxw=;
        b=X+SG31/WF99wAHlMeM/PjvQlZl8uzgDkMg5/jx/4W071uXkRX9RtpOoEqxY234aSjf
         jLogFsIl4AIZCGQTDbxq3z/UsWXFfjBrEE8wgIkpqwhKLLzzvIiF5CtxP3iODtN9Zcnj
         zYly6HzTfyZgSLoiv+Kz7nLSH7cWYlVMN+WEY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=f9AlFQsIFWCNnf+2zjnkAxfNHETG0mzZ6su8XDrHrtMqHMwErZ6HZBZOcFt1YM+TZu
         PQ7MfREcXXEdgTDdb4+QDcQZvlKFJFWhodcps3rmZILWbfmbcQ43dtWw9TMe4xhPR0KX
         syVQX1Df+4J4xqert6OVHvyf/QeB68N2ZNMCY=
Received: by 10.224.45.139 with SMTP id e11mr148043qaf.60.1284481491982; Tue,
 14 Sep 2010 09:24:51 -0700 (PDT)
Received: by 10.224.73.207 with HTTP; Tue, 14 Sep 2010 09:24:51 -0700 (PDT)
In-Reply-To: <4C8F99FA.3040003@workspacewhiz.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156200>

On Tue, Sep 14, 2010 at 11:51 AM, Joshua Jensen
<jjensen@workspacewhiz.com> wrote:
> =C2=A0----- Original Message -----
> From: Theodore Tso
> Date: 9/14/2010 6:12 AM
>>
>> On Sep 14, 2010, at 12:47 AM, Joshua Jensen wrote:
>>>>
>>>> Bear in mind that you can still shift to a maintainer model, but k=
eep
>>>> the maintainer automated. That is, you can queue up "to-pull" head=
s, and
>>>> then have an automated process pull them one by one and do some ba=
sic QA
>>>> (does it merge, does it build, does it pass automated tests, etc).=
 Which
>>>
>>> Do you know of any existing software that does this? =C2=A0This may=
 be ideal
>>> in the short ter
>>
>> Our workflow at $WORK involves pushing changes to gerrit to various
>> "effort branches", and then once they are approved, we have a "Mergi=
tator"
>> script that will attempt to merge the effort branch with the merged =
master
>> branch, and then attempt to do a build. =C2=A0If the build succeeds,=
 then the
>> changes will get pushed back to the publically visible merged master=
 branch,
>> and then the Mergitator will move on to the next effort branch that =
requires
>> merging. =C2=A0 If there is a merge conflict, the Mergitator will re=
fuse the
>> merge, and then give instructions on how to fix up the tree to avoid=
 merge
>> conflicts.
>>
> How does the integration with Gerrit work here? =C2=A0The only thing =
that comes
> to mind is that you do something like:
>
> git push gerrit HEAD:refs/for/merged-master
>
> Then the approvals are done. =C2=A0Afterward, Gerrit merges to the me=
rged-master
> branch.
>
> I would suppose an external script is performing regular fetches. =C2=
=A0When it
> sees new code, it builds.
>
> No, this can't be right, but I'll leave my incorrect workflow here.
>>
>> So this probably doesn't help you since I suspect you meant to ask t=
he
>> question, "do you know of any existing publically available software=
", but I
>> can tell you that it certainly can be done, and that software exists=
=2E
>> =C2=A0Making it be software which is useful and usable to you would =
definitely
>> take more work...
>
> It's the branch queueing issue that is my current hang up. =C2=A0Gerr=
it's method
> is slick, but that won't work outside of JGit. =C2=A0I'm not opposed =
to JGit; I
> just haven't touched Java in years.
>
> So, perhaps, a web interface where the branch owner selects the (push=
ed to
> central server) branch name that is ready to go. =C2=A0A merge is att=
empted. =C2=A0If
> it succeeds, great. =C2=A0If it fails, then the merge is reset?
>
> Josh
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
>


In our case we have moved from CVS to git and had pretty much same
problems.  The only difference was that we are working with java and
trying to have every project in separate repository. So we don't have
many commits into common codebase. We have a server keeping bare
mainline repos.
In order to integrate the project with others we are using Hudson CI
which performs builds upon each change detected on the server side
(i.e. mainline repository) and also builds the projects that are
dependent on the one you just changed. Those dependencies can be
described inside each hudson job, but we are using Ivy for dependency
management. If you have good testing infrastructure that is even
better.

So generally the amount of contributors to one project is pretty
small. Some projects are solo, some have small teams coworking on one
project code base.

We are using two main branch model.
The development goes in topic branches. The qa branch is a staging
branch for the changes to be accumulated for the release. People are
using direct pushes to qa branch to integrate or a maintainer. Hudson
builds this codebase. When all release functionality is done the
person responsible for the release is merging qa branch into the
master, which gets released (this must be a fast-forward).

So, i would say component oriented approach is the key here.

HTH,
Eugene
