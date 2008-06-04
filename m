From: Wincent Colaiuta <win@wincent.com>
Subject: Re: User's mailing list? And multiple cherry pick
Date: Wed, 4 Jun 2008 13:02:00 +0200
Message-ID: <72AA7E07-AFE5-40B5-822D-6E7F404B8FC6@wincent.com>
References: <18c1e6480806032355q2002fe0ej1f37dbd7dbd4802b@mail.gmail.com> <7vmym1zny4.fsf@gitster.siamese.dyndns.org> <18c1e6480806040013l72da09aem30f91183e4fcbe41@mail.gmail.com> <m3mym1zkus.fsf@localhost.localdomain> <18c1e6480806040130k3851a89an3fcf986feb661226@mail.gmail.com> <D11EAC1A-B59E-4857-A31F-809809310E40@wincent.com> <18c1e6480806040302k74156d47p4e878fef62d21b87@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v924)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: David <wizzardx@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 04 13:03:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3qlm-0002JD-QS
	for gcvg-git-2@gmane.org; Wed, 04 Jun 2008 13:03:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752996AbYFDLCN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 Jun 2008 07:02:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754082AbYFDLCN
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Jun 2008 07:02:13 -0400
Received: from wincent1.inetu.net ([209.235.192.161]:41171 "EHLO
	wincent1.inetu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752983AbYFDLCM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 Jun 2008 07:02:12 -0400
Received: from cuzco.lan (157.pool85-53-24.dynamic.orange.es [85.53.24.157])
	(authenticated bits=0)
	by wincent1.inetu.net (8.13.8/8.13.8) with ESMTP id m54B253A003062
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Wed, 4 Jun 2008 07:02:09 -0400
In-Reply-To: <18c1e6480806040302k74156d47p4e878fef62d21b87@mail.gmail.com>
X-Mailer: Apple Mail (2.924)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83771>

El 4/6/2008, a las 12:02, David escribi=F3:

> On Wed, Jun 4, 2008 at 11:39 AM, Wincent Colaiuta <win@wincent.com> =20
> wrote:
>> El 4/6/2008, a las 10:30, David escribi=F3:
>>
>>> Thanks :-) This still isn't what I had in mind (see my earlier post
>>> with examples), but I realise now, thanks to your post, that I can
>>> probably do it like this:
>
> [snip]
>
>>
>> Sounds like it would definitely work but it also sounds like a lot o=
f
>> repetitive "busy work"[1] which could be avoided by using finer-=20
>> grained
>> topic branches in the first place.
>>
>
> I see where you're coming from, and I am learning to work more in thi=
s
> way. Using git has made a big difference to how I develop. Not just a=
s
> a SCM, but also for improved work-flow. eg trying out things in code,
> and storing failed attempts for later reference/retries/etc if it
> doesn't work out.
>
> My problem with your post is, even if you take this to the extreme
> (topic branches for every fix that you want to make), there will stil=
l
> be cases where while working on one fix (maybe disruptive to the main
> branch), you uncover problems with master and start fixing it in your
> topic branch.
>
> It isn't always easy to fix the problems in master (that you're seein=
g
> in topic) by changing back to master and making another topic. Maybe
> you can only (easily) find & detect the problems in master because of
> other changes in topic (eg: WIP unit tests) that you aren't ready to
> merge yet.
>
> So you would probably have to jump back and forth between your topic,
> and your new 'fix problems in master' branch a lot to track down the
> issues and get the fixes into master. This sounds like a lot more
> 'busy work' than simply cherry-picking (multiple) those fixes out of
> your topic branch into master, and then rebasing your topic branch :-=
)

I guess it depends on how long-lived your topic branches are, and how =20
urgently you want to get independent fixes back into "master".

If the topic branch isn't very long-lived, and the fix isn't =20
incredibly urgent, you could just keep it in the topic until the =20
entire topic branch is ready to be merged back in.

If the fix depends on changes in the topic branch then getting it into =
=20
master may not be so urgent anyway. How often does this really happen? =
=20
I know that all code bases are different, but in my experience if I =20
discover a problem (in master) while working on a topic, the fix is =20
usually independent of the topic, in which case I have two options: =20
either fix it on master (and then optionally rebase the topic), or =20
just fix it on the topic and let the fix propagate back to the master =20
when I merge in the topic.

Don't forget that you also have "git stash" for those moments when you =
=20
are working on a topic and see a completely unrelated fix or change =20
that you want to do.

But obviously, this is all highly context-dependent and what works for =
=20
me won't always work for everyone.

Wincent
