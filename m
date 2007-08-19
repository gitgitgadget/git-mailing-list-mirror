From: David Kastrup <dak@gnu.org>
Subject: Re: How do I manage this setup with git-svn and/or git remotes?
Date: Sun, 19 Aug 2007 18:04:46 +0200
Message-ID: <853ayftsrl.fsf@lola.goethe.zz>
References: <86y7gaxef5.fsf@lola.quinscape.zz>
	<alpine.LFD.0.999.0708171042570.30176@woody.linux-foundation.org>
	<86d4xmxbjf.fsf@lola.quinscape.zz> <fa7vrd$afs$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 19 18:08:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IMnK9-0005ql-29
	for gcvg-git@gmane.org; Sun, 19 Aug 2007 18:08:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753831AbXHSQIR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 19 Aug 2007 12:08:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753910AbXHSQIR
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Aug 2007 12:08:17 -0400
Received: from mail-in-05.arcor-online.net ([151.189.21.45]:41219 "EHLO
	mail-in-05.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753545AbXHSQIQ convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Aug 2007 12:08:16 -0400
Received: from mail-in-08-z2.arcor-online.net (mail-in-08-z2.arcor-online.net [151.189.8.20])
	by mail-in-05.arcor-online.net (Postfix) with ESMTP id 78814133D8B;
	Sun, 19 Aug 2007 18:08:12 +0200 (CEST)
Received: from mail-in-02.arcor-online.net (mail-in-02.arcor-online.net [151.189.21.42])
	by mail-in-08-z2.arcor-online.net (Postfix) with ESMTP id 5CAB12130E6;
	Sun, 19 Aug 2007 18:08:12 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-025-172.pools.arcor-ip.net [84.61.25.172])
	by mail-in-02.arcor-online.net (Postfix) with ESMTP id 351EA36E861;
	Sun, 19 Aug 2007 18:08:08 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 2F94F1C36605; Sun, 19 Aug 2007 18:04:46 +0200 (CEST)
In-Reply-To: <fa7vrd$afs$1@sea.gmane.org> (Jakub Narebski's message of "Sun\, 19 Aug 2007 01\:37\:21 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56129>

Jakub Narebski <jnareb@gmail.com> writes:

> David Kastrup wrote:
>
>> Linus Torvalds <torvalds@linux-foundation.org> writes:
>>=20
>>> On Fri, 17 Aug 2007, David Kastrup wrote:
>>>>=20
>>>> Now is there any chance to set up a git structure that will me
>>>> allow to let _git_ perform merges between the standalone dsp
>>>> project and the part that has started off as a copy of it in a
>>>> subdirectory from projects/great, so that I have a merge history i=
n
>>>> my git mirror?
>>>
>>> Yes. That's what git "submodule" support is all about. =A0You could
>>> create that "dsp" project as its own git project, and then include
>>> it within the bigger project as a submodule. Then, that "dsp" thing
>>> is really a totally independent git project in its own right, with
>>> git support for just "tying" it into the superproject.
>>=20
>> But it isn't an independent git project: the superproject has its
>> _own_ copy of dsp, with its _own_ specific commits and fixes that ar=
e
>> not supposed to ever end up in the dsp "mothership". =A0There are
>> sometimes cross merges, but the stuff in the "dsp" subdirectory of
>> "great" is maintained completely together with the branches of
>> "great": tags, branches and all.
>
> Independent git project means independent clone of "dsp" repository,
> perhaps a fork of "dsp" repository with some (superproject) specific
> commits. Which is attached as subritectory of superproject.

Well, the point I was trying to make is that as a subdirectory of the
superproject (in Subversion), the tagging and branching structure is
supposed to follow that of the superproject.  I don't understand
submodules well enough to see how much this is the case.

To be fair: merging will only happen on the trunk of the superproject,
but possibly with different branches of the dsp project.  So this is
likely not going to be much of an issue.

On the other hand, it is unclear what git-svn would think about that
sort of setup.  Since a submodule setup would imply creating
appropriate branches in the dsp module, anyway, I can just import the
superproject dsp as one remote branch into the dsp git repository and
do the merging there.  There is no need to make dsp an actual
submodule of the superproject for that as long as I am working with
git-svn.

--=20
David Kastrup, Kriemhildstr. 15, 44793 Bochum
