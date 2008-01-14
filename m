From: =?utf-8?Q?David_K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: Re: CRLF problems with Git on Win32
Date: Mon, 14 Jan 2008 10:41:40 +0100
Message-ID: <871w8kvj57.fsf@lysator.liu.se>
References: <C3AC3E6F.10D42%jefferis@gmail.com> <alpine.LFD.1.00.0801101556380.3148@woody.linux-foundation.org> <7EAB1DA8-627D-455E-AA23-C404FDC615D9@zib.de> <alpine.LFD.1.00.0801110756260.3148@woody.linux-foundation.org> <D36EB89D-11A3-4EAF-BC1C-6100383FCBFC@zib.de> <alpine.LFD.1.00.0801110924380.3148@woody.linux-foundation.org> <930EC77A-73D1-4DDD-81D4-BF22B248FCB6@zib.de> <alpine.LFD.1.00.0801111005360.3148@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 14 10:41:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JELpC-0000KE-CT
	for gcvg-git-2@gmane.org; Mon, 14 Jan 2008 10:41:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754925AbYANJlU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Jan 2008 04:41:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754838AbYANJlT
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Jan 2008 04:41:19 -0500
Received: from main.gmane.org ([80.91.229.2]:34547 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754721AbYANJlQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jan 2008 04:41:16 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1JELod-0000Zd-Iv
	for git@vger.kernel.org; Mon, 14 Jan 2008 09:41:11 +0000
Received: from 87.96.142.114 ([87.96.142.114])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 14 Jan 2008 09:41:11 +0000
Received: from davidk by 87.96.142.114 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 14 Jan 2008 09:41:11 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 87.96.142.114
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
Cancel-Lock: sha1:GgTBZu1Ya8KIGm+4LM3P+CbuLHA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70450>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Fri, 11 Jan 2008, Steffen Prohaska wrote:
>>=20
>> Ah sorry, I misunderstood you in [1].  I thought your last point
>> "Mixed Windows usage" meant what I have in mind:  A user working
>> in a mixed Windows/Unix environment who creates a file using
>> Windows tools and commits it in the Unix environment.  In this
>> case the CRLF file will be transferred from Windows to Unix
>> without git being involved.  The right thing for git on Unix is
>> to remove CRLF during a commit but still write only LF during
>> check out.  So autocrlf=3Dinput is the right choice.
>
> Oh, ok, I didn't realize.
>
> But yes, if you use a network share across windows and Unixand actual=
ly=20
> *share* the working tree over it, then yes, you'd want "autocrlf=3Din=
put" on=20
> the unix side.
>
> However, I think that falls under the "0.1%" case, not the "99.9%" ca=
se.
>
> I realize that people probably do that more often with centralized=20
> systems, but with a distributed thing, it probably makes a *ton* more=
=20
> sense to have separate trees. But I could kind of see having a shared=
=20
> development directory and accessing it from different types of machin=
es=20
> too.

One case is when you only want to commit compiling code, and to
test-compile on all platforms that you are supposed to be portable to
you need to access the source tree on different systems before
committing anything.

You could of course commit optimistically and checkout on the other
system, and then go back and rewrite the commits if you need to fix
something. But that is a lot more work.

--=20
David K=C3=A5gedal
