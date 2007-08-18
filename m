From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: How do I manage this setup with git-svn and/or git remotes?
Date: Sun, 19 Aug 2007 01:37:21 +0200
Organization: At home
Message-ID: <fa7vrd$afs$1@sea.gmane.org>
References: <86y7gaxef5.fsf@lola.quinscape.zz> <alpine.LFD.0.999.0708171042570.30176@woody.linux-foundation.org> <86d4xmxbjf.fsf@lola.quinscape.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 19 01:37:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IMXrh-0005i9-Lx
	for gcvg-git@gmane.org; Sun, 19 Aug 2007 01:37:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758885AbXHRXhc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 18 Aug 2007 19:37:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758872AbXHRXhc
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Aug 2007 19:37:32 -0400
Received: from main.gmane.org ([80.91.229.2]:47984 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758843AbXHRXhb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Aug 2007 19:37:31 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IMXr9-0001HY-MM
	for git@vger.kernel.org; Sun, 19 Aug 2007 01:37:23 +0200
Received: from host-89-229-8-65.torun.mm.pl ([89.229.8.65])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 19 Aug 2007 01:37:23 +0200
Received: from jnareb by host-89-229-8-65.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 19 Aug 2007 01:37:23 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-89-229-8-65.torun.mm.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56117>

David Kastrup wrote:

> Linus Torvalds <torvalds@linux-foundation.org> writes:
>=20
>> On Fri, 17 Aug 2007, David Kastrup wrote:
>>>=20
>>> Now is there any chance to set up a git structure that will me
>>> allow to let _git_ perform merges between the standalone dsp
>>> project and the part that has started off as a copy of it in a
>>> subdirectory from projects/great, so that I have a merge history in
>>> my git mirror?
>>
>> Yes. That's what git "submodule" support is all about. =A0You could
>> create that "dsp" project as its own git project, and then include
>> it within the bigger project as a submodule. Then, that "dsp" thing
>> is really a totally independent git project in its own right, with
>> git support for just "tying" it into the superproject.
>=20
> But it isn't an independent git project: the superproject has its
> _own_ copy of dsp, with its _own_ specific commits and fixes that are
> not supposed to ever end up in the dsp "mothership". =A0There are
> sometimes cross merges, but the stuff in the "dsp" subdirectory of
> "great" is maintained completely together with the branches of
> "great": tags, branches and all.

Independent git project means independent clone of "dsp" repository,
perhaps a fork of "dsp" repository with some (superproject) specific
commits. Which is attached as subritectory of superproject.
=20
> But I would like to be able to merge this _subdirectory_ with branche=
s
> from the "mothership" dsp from which it was originally copied.

You would be able to, both from "mothership" to "submodule", and from
"submodule" (perhaps only some selected commits on 'maint' branch) to
"mothership".

Putting files of "dsp" project directly in superproject and merging fro=
m
"mothership" using 'subtree' merge strategy as mentioned allows only fo=
r
one direction (well, except for sending patches).

--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
