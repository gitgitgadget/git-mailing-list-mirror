From: Steven Noonan <steven@uplinklabs.net>
Subject: Re: git-reflog 70 minutes at 100% cpu and counting
Date: Thu, 17 Dec 2009 19:44:44 -0800
Message-ID: <f488382f0912171944m6c7d7fdas8fe2b12755358b@mail.gmail.com>
References: <1260822484.9379.53.camel@localhost>
	 <alpine.LFD.2.00.0912142245240.23173@xanadu.home>
	 <1260851180.9379.88.camel@localhost>
	 <alpine.LFD.2.00.0912152201300.23173@xanadu.home>
	 <1260970885.2788.87.camel@localhost>
	 <alpine.LFD.2.00.0912161526080.23173@xanadu.home>
	 <1261003041.2788.142.camel@localhost>
	 <alpine.LFD.2.00.0912161841210.23173@xanadu.home>
	 <1261067369.2868.10.camel@localhost>
	 <alpine.LFD.2.00.0912172149020.23173@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Paris <eparis@redhat.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Fri Dec 18 04:47:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NLTnx-0003h5-0G
	for gcvg-git-2@lo.gmane.org; Fri, 18 Dec 2009 04:47:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752934AbZLRDop convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 Dec 2009 22:44:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750746AbZLRDop
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Dec 2009 22:44:45 -0500
Received: from mail-px0-f174.google.com ([209.85.216.174]:53395 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750778AbZLRDoo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Dec 2009 22:44:44 -0500
Received: by pxi4 with SMTP id 4so1953141pxi.33
        for <git@vger.kernel.org>; Thu, 17 Dec 2009 19:44:44 -0800 (PST)
Received: by 10.142.56.18 with SMTP id e18mr2243396wfa.40.1261107884175; Thu, 
	17 Dec 2009 19:44:44 -0800 (PST)
In-Reply-To: <alpine.LFD.2.00.0912172149020.23173@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135397>

On Thu, Dec 17, 2009 at 7:33 PM, Nicolas Pitre <nico@fluxnic.net> wrote=
:
> On Thu, 17 Dec 2009, Eric Paris wrote:
>
>> This alone almost certainly tells me how I broke it.
>>
>> For quite some time (a period of months) linux-next was broken and I=
 had
>> to carry a patch to ACPI to make it boot. =A0I dropped that patch at=
 the
>> head of my stgit trees in all of my repositories. =A0So I wouldn't b=
e at
>> all surprised to learn that eventually kernel-2 found that object in
>> kernel-1. =A0Sometime when I dropped that patch from kernel-1 (becau=
se it
>> finally got fixed upstream) I can see how it broke.
>>
>> But now that patch shouldn't be needed by any tree since I have long
>> since dropped it from the stgit stack. =A0So if we cleaned up all of=
 the
>> useless objects in this tree I bet this object wouldn't be needed. =A0=
Not
>> exactly a situation that I'd expect git to be able to dig out of its=
elf
>> thought.
>
> I let the script I provided previously ran for a while. =A0And the co=
mmit
> I found to contain the missing object belongs to
> refs/patches/fsnotify/fsnotify-group-priorities.log. =A0So I simply
> deleted that branch entirely and now the repack can proceed. =A0And w=
ith a
> 'git gc --aggressive' the 1.2GB repository shrank to a mere 5.2 MB. =A0=
:-)
> Of course I didn't bring back all the reflogs though. =A0But I would
> have expected a repository reduction of the same magnitude even with
> them.
>

Are we talking about the same Linux kernel repository as before?
Because if so, that reduction in size doesn't make any sense to me.
The smallest size I've seen for the Linux kernel repository (in the
past year) is 250MB.

- Steven
