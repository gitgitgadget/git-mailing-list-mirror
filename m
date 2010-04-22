From: Goswin von Brederlow <goswin-v-b@web.de>
Subject: Re: Please default to 'commit -a' when no changes were added
Date: Thu, 22 Apr 2010 20:37:31 +0200
Message-ID: <87wrvzs590.fsf@frosties.localdomain>
References: <20100422151037.2310.2429.reportbug@frosties.localdomain>
	<20100422155806.GC4801@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Goswin von Brederlow <goswin-v-b@web.de>, 578764@bugs.debian.org,
	git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 22 20:37:44 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O51HR-00030l-5A
	for gcvg-git-2@lo.gmane.org; Thu, 22 Apr 2010 20:37:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754508Ab0DVShf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 22 Apr 2010 14:37:35 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:39686 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753932Ab0DVShe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Apr 2010 14:37:34 -0400
Received: from smtp07.web.de (fmsmtp07.dlan.cinetic.de [172.20.5.215])
	by fmmailgate01.web.de (Postfix) with ESMTP id 60EB91575B208;
	Thu, 22 Apr 2010 20:37:33 +0200 (CEST)
Received: from [78.43.204.177] (helo=frosties.localdomain)
	by smtp07.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #4)
	id 1O51HI-0006CR-00; Thu, 22 Apr 2010 20:37:33 +0200
Received: from mrvn by frosties.localdomain with local (Exim 4.71)
	(envelope-from <goswin-v-b@web.de>)
	id 1O51HH-0001AF-Jz; Thu, 22 Apr 2010 20:37:31 +0200
In-Reply-To: <20100422155806.GC4801@progeny.tock> (Jonathan Nieder's message
	of "Thu, 22 Apr 2010 10:58:07 -0500")
User-Agent: Gnus/5.110009 (No Gnus v0.9) XEmacs/21.4.22 (linux, no MULE)
X-Sender: goswin-v-b@web.de
X-Provags-ID: V01U2FsdGVkX184ORK4pQQkfCInih8jBYFaUv/aofoCxAk/zouY
	vDkpHLQSsTJx6sZPIDEVd+NcDYyFLXrO7GVXuN7Qthx9+O6XOP
	UnSOOV6Vs=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145545>

Jonathan Nieder <jrnieder@gmail.com> writes:

> [topic: making =E2=80=98git commit=E2=80=99 more helpful when there a=
re no changes
> registered in the index]
>
> Hi Goswin,
>
> Goswin von Brederlow wrote:
>
>> in most (all but git?) RCS a plain 'commit' without any arguments
>> commits all changes (to registered files).
>
> Yes, but they are wrong. :)
>
>> no changes added to commit (use "git add" and/or "git commit -a")
> [...]
>> Imho in most cases where no changes
>> were added people do want to commit all modified files. And if not
>> then exiting the editor to abort is easy enough.
>
> I absent-mindedly type =E2=80=98git commit=E2=80=99 having forgotten =
to update the
> index with my changes fairly often.  Then I add the appropriate
> changes, which is almost never all of them.  I don=E2=80=99t think th=
is is so
> unusual.

Then you would type C-X C-c or :q or whatever exits your editor. No har=
m
done. Also, as you say below, git can output quite a long list of thing=
s
in the message. With my proposed change you would get the list inside
your editor and could scroll through it and check if it can all go as a
single commit or not. Imho doing nothing as it does now is the least
usefull thing to do.

> Starting out, I can see how it would be comforting to people if
> =E2=80=98git commit=E2=80=99 would default to -a behavior if they ign=
ore the index.
> That is logically a different operation, though, so it would also sen=
d
> a wrong message and make it harder in the long run to get used to the
> interface.
>
> Instead, I think it would be better to focus on making the error
> message more helpful.  Right now there is a screen full of status
> before the advice, which might make it easy to get scared before
> reading it.
>
> Here=E2=80=99s a very rough patch to suppress that screenful.  What d=
o you
> think?

I have never ever needed anything but

git commit -a
git commit <file> <file> ...

I do commit often and commit early and I start and finish one thing
before I start another. Also I keep my files small so they do one thing
and do it well. Overall that means I don't end up with multiple changes
in a single file so I never need to cherry pick changes for a commit.

So I don't think people should be forced to utilize the index. Imho tha=
t
is a matter of the workflow people use. Some people work better with th=
e
index and some people (or projects) don't need it.



Alternatively an option to take all changes but only if the index is
empty would be helpfull. Then people could define an alias for that or
set the option in the config. Other than setting -a that would allow
using an index when needed and commit everything in the normal case
without having to change the command used to commit.

MfG
        Goswin
