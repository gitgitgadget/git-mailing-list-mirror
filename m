From: Steven Noonan <steven@uplinklabs.net>
Subject: Re: git-reflog 70 minutes at 100% cpu and counting
Date: Thu, 17 Dec 2009 20:26:56 -0800
Message-ID: <f488382f0912172026ye9950c9sd4f505d8db1e47d1@mail.gmail.com>
References: <1260822484.9379.53.camel@localhost>
	 <alpine.LFD.2.00.0912152201300.23173@xanadu.home>
	 <1260970885.2788.87.camel@localhost>
	 <alpine.LFD.2.00.0912161526080.23173@xanadu.home>
	 <1261003041.2788.142.camel@localhost>
	 <alpine.LFD.2.00.0912161841210.23173@xanadu.home>
	 <1261067369.2868.10.camel@localhost>
	 <alpine.LFD.2.00.0912172149020.23173@xanadu.home>
	 <f488382f0912171944m6c7d7fdas8fe2b12755358b@mail.gmail.com>
	 <alpine.LFD.2.00.0912172255500.23173@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Paris <eparis@redhat.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Fri Dec 18 05:27:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NLUQk-0005rJ-2i
	for gcvg-git-2@lo.gmane.org; Fri, 18 Dec 2009 05:27:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753496AbZLRE06 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 Dec 2009 23:26:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752363AbZLRE06
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Dec 2009 23:26:58 -0500
Received: from mail-pw0-f42.google.com ([209.85.160.42]:37264 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751470AbZLRE05 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Dec 2009 23:26:57 -0500
Received: by pwj9 with SMTP id 9so1697416pwj.21
        for <git@vger.kernel.org>; Thu, 17 Dec 2009 20:26:57 -0800 (PST)
Received: by 10.142.152.2 with SMTP id z2mr11211wfd.183.1261110416915; Thu, 17 
	Dec 2009 20:26:56 -0800 (PST)
In-Reply-To: <alpine.LFD.2.00.0912172255500.23173@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135401>

On Thu, Dec 17, 2009 at 7:57 PM, Nicolas Pitre <nico@fluxnic.net> wrote=
:
> On Thu, 17 Dec 2009, Steven Noonan wrote:
>
>> On Thu, Dec 17, 2009 at 7:33 PM, Nicolas Pitre <nico@fluxnic.net> wr=
ote:
>> > On Thu, 17 Dec 2009, Eric Paris wrote:
>> >
>> >> This alone almost certainly tells me how I broke it.
>> >>
>> >> For quite some time (a period of months) linux-next was broken an=
d I had
>> >> to carry a patch to ACPI to make it boot. =A0I dropped that patch=
 at the
>> >> head of my stgit trees in all of my repositories. =A0So I wouldn'=
t be at
>> >> all surprised to learn that eventually kernel-2 found that object=
 in
>> >> kernel-1. =A0Sometime when I dropped that patch from kernel-1 (be=
cause it
>> >> finally got fixed upstream) I can see how it broke.
>> >>
>> >> But now that patch shouldn't be needed by any tree since I have l=
ong
>> >> since dropped it from the stgit stack. =A0So if we cleaned up all=
 of the
>> >> useless objects in this tree I bet this object wouldn't be needed=
=2E =A0Not
>> >> exactly a situation that I'd expect git to be able to dig out of =
itself
>> >> thought.
>> >
>> > I let the script I provided previously ran for a while. =A0And the=
 commit
>> > I found to contain the missing object belongs to
>> > refs/patches/fsnotify/fsnotify-group-priorities.log. =A0So I simpl=
y
>> > deleted that branch entirely and now the repack can proceed. =A0An=
d with a
>> > 'git gc --aggressive' the 1.2GB repository shrank to a mere 5.2 MB=
=2E =A0:-)
>> > Of course I didn't bring back all the reflogs though. =A0But I wou=
ld
>> > have expected a repository reduction of the same magnitude even wi=
th
>> > them.
>> >
>>
>> Are we talking about the same Linux kernel repository as before?
>
> As before in this thread.
>
>> Because if so, that reduction in size doesn't make any sense to me.
>
> Sure it does.
>
>> The smallest size I've seen for the Linux kernel repository (in the
>> past year) is 250MB.
>
> Depends if you have an alternate repository from which you may borrow
> objects from, which was the case here. =A0In that context, 1.2 GB of =
disk
> space was completely insane.
>

Ahh. That makes sense. I should really read up on alternates then.

- Steven
