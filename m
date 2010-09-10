From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: Coping with the pull-before-you-push model
Date: Fri, 10 Sep 2010 15:35:21 +1000
Message-ID: <AANLkTikdV3W1d7uNokKRRiT4FeznL1uM=Y9SQLDqgAic@mail.gmail.com>
References: <4C8866F9.1040705@workspacewhiz.com>
	<AANLkTikY55ZJvSTqyFKLqwABqnJZuODz3yrc7CFvQf0K@mail.gmail.com>
	<4C88F2A9.2080306@workspacewhiz.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Joshua Jensen <jjensen@workspacewhiz.com>
X-From: git-owner@vger.kernel.org Fri Sep 10 07:35:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OtwGm-0005Gx-1Z
	for gcvg-git-2@lo.gmane.org; Fri, 10 Sep 2010 07:35:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756712Ab0IJFfX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 10 Sep 2010 01:35:23 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:57471 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752715Ab0IJFfW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 Sep 2010 01:35:22 -0400
Received: by qyk33 with SMTP id 33so2348367qyk.19
        for <git@vger.kernel.org>; Thu, 09 Sep 2010 22:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=nuR/fCUNW45boO9/m6dJ39lfv14B0OBlj5LE0VMlzHU=;
        b=Zo9G7mKc9gG8ct+aLrM9NV+geKqpwI2UgF0XxmGmt6ihG6qEXRHYl/BZ9+xIbSDbE8
         L1GlIaCxaXP49MZXkDJxpXKOdtfwQ6dk/8NfuNh3U95e8qVgxtLkGM7WNAVcVwlwNaxq
         ipSsn0RpEbsj7jry9y/PnosFodbLOh7PDGJHs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=AfLygSmgLloKAO7/zmXmbCCUo7i0cfaifTlsxksT4J7bMWNigTndnD52RftQFUtgZx
         KJf4QzcSqxvte13+malVs2EMVGQfLkp0Vnddbnf7634MQ4JLO8+GEtsPYiggRJYNReiU
         9Hu+MCwcDnL0kuwtBJxbjJAyyptdCgdX0QwRg=
Received: by 10.224.67.81 with SMTP id q17mr982203qai.276.1284096921124; Thu,
 09 Sep 2010 22:35:21 -0700 (PDT)
Received: by 10.229.96.7 with HTTP; Thu, 9 Sep 2010 22:35:21 -0700 (PDT)
In-Reply-To: <4C88F2A9.2080306@workspacewhiz.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155920>

On Fri, Sep 10, 2010 at 12:43 AM, Joshua Jensen
<jjensen@workspacewhiz.com> wrote:>>
>> Presumably you had exactly the same problem in perforce, i.e. becaus=
e
>> you only had have the files you were changing checked out in Perforc=
e
>> in the time between `hack&& =C2=A0pull&& =C2=A0test&& =C2=A0push` so=
meone else might
>> have already pushed. Thus what you just submitted wasn't guaranteed =
to
>> pass tests.
>>
>> So is the flow in Git where you don't run the tests again, rebase an=
d
>> push and hope for the best any different?
>
> The end result is the same; submitted code is never really tested aga=
inst
> latest in Perforce either. =C2=A0The primary difference between the t=
wo is that
> the Perforce submit is successful the majority of the time (odds of s=
omeone
> editing and submitting the same file as you are low), and the Git pus=
h fails
> the majority of the time.
>
> Don't get me wrong. =C2=A0I've given training on why Git's enforced
> pull-before-you-push model can be better than what we had before
> (reproducible state, fewer broken builds, etc). =C2=A0Nevertheless, t=
he issue is
> very frequent, and that's why I am querying others.

I am not sure that git does enforce a pull before push model, except
if you attempt
to use git without the equivalent of a maintainer - in essence
devolving responsibility of maintaining the tip of the shared branch
to the whole team.

This is probably the cultural shift that is hardest for enterprises to
accept - why do I need a _person_ to do this _manual_ work when tools
like {insert favourite non-DVCS here} can do this for me? To
management, this looks like a step-backwards.

In our case, the team leaders act like the subsystem leads and the
build team acts like the maintainer. Team leads have a more review
oriented focus, where as the build team doesn't understand the code
that well and will reject merge conflicts if they are non-trivial.
Their focus is just to keep the daily build rhythm going.

If you don't have a maintainer role, then everyone is obliged to pull,
test, pull-again, then push because there is no-one else there to do
it and no other time to do it. The delays inherent in the test process
inevitably mean you have to cycle several times until your commit
wins.

But with a maintainer role on your project, you don't need to do this.
Everyone develops on yesterday's baseline and verifies that they don't
regress anything with respect to that baseline - there is no
requirement to certify against the bleeding edge of the integration
stream - that's the role of the maintainer/build team once the daily
build is done, thereby amortising test execution effort across the
whole team.

>
> I'm grossly oversimplifying the process, but the Linux model seems to=
 be
> built on hierarchical 'pull requests'. =C2=A0I can tell a subsystem m=
aintainer I
> have some changes and then ask that maintainer to pull them from a ce=
rtain
> location. =C2=A0When that person has time/inclination, the change is =
pulled,
> merged in, and then another pull request is sent to the upstream hier=
archy.
>

Note that one difference between the maintainer and maintainer-less
model is that the tip of the reference branch is published relatively
rarely - it is quite stable. This is quite helpful because the
baseline doesn't keep shifting every 30 minutes. In the
maintainer-less model, you never have stability, nor any opportunity
to acquire it.

> This _is_ compelling, but even if it would work within the company I =
work
> for, it is such a dramatic shift in workflow that I am certain it cou=
ld not
> be done in one fell swoo
>

The big difference between commercial work and open source projects
like git and linux is that the latter have just one constraint -
quality whereas the former also have budgets and schedules to worry
about. Unintegrated crap code has cost the open source project almost
nothing. Commercial enterprises, on the other hand, pay lots of money
for people to develop code whether it is crap or otherwise. The idea
of leaving expensive code unintegrated causes management paroxysms of
concern that are hard to ignore - a tool that blindly integrates crap
code automatically is a soothing balm for such people. Hence the
resistance to tools like git that encourage a maintainer role and,
implicit in that, the possibility of review that might result in crap
code being exposed for what it is.

jon seymour.
