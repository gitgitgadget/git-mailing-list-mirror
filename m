From: =?utf-8?Q?David_K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: Re: Rebasing stgit stacks
Date: Wed, 17 Jan 2007 12:07:45 +0100
Message-ID: <87y7o17vy6.fsf@morpheus.local>
References: <8b65902a0701091335u160c6dfl81a523e4cd5adbee@mail.gmail.com> <8b65902a0701091341v5983c113tc5cd32c6c4c57719@mail.gmail.com> <20070109224125.GF17093@nan92-1-81-57-214-146.fbx.proxad.net> <8b65902a0701150526j5a954529xf45b2d0348a77573@mail.gmail.com> <20070115202412.GE9761@nan92-1-81-57-214-146.fbx.proxad.net> <b0943d9e0701151446l45eff9dbgcae718c1461d0725@mail.gmail.com> <20070115233958.GF9761@nan92-1-81-57-214-146.fbx.proxad.net> <b0943d9e0701161442t6b93e0d6nd88364600f2809ee@mail.gmail.com> <20070116231735.GF7029@nan92-1-81-57-214-146.fbx.proxad.net> <eojn5c$v9u$1@sea.gmane.org> <20070117090313.GA9283@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Wed Jan 17 12:08:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H78ea-0005ad-Tl
	for gcvg-git@gmane.org; Wed, 17 Jan 2007 12:08:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932311AbXAQLI0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 17 Jan 2007 06:08:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932321AbXAQLI0
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Jan 2007 06:08:26 -0500
Received: from main.gmane.org ([80.91.229.2]:57968 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932311AbXAQLIZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jan 2007 06:08:25 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1H78eI-0005VD-7B
	for git@vger.kernel.org; Wed, 17 Jan 2007 12:08:10 +0100
Received: from c83-253-22-207.bredband.comhem.se ([83.253.22.207])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 17 Jan 2007 12:08:10 +0100
Received: from davidk by c83-253-22-207.bredband.comhem.se with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 17 Jan 2007 12:08:10 +0100
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: c83-253-22-207.bredband.comhem.se
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (gnu/linux)
Cancel-Lock: sha1:nIetTA4YB4hnL9/eVBd27A/VGBk=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36994>

Karl Hasselstr=C3=B6m <kha@treskal.com> writes:

> On 2007-01-17 00:30:18 +0100, Jakub Narebski wrote:
>
>> Yann Dirson wrote:
>>
>> > My example is quite similar to the one given by Guilhem: I had a
>> > git branch coming from git-cvsimport, and my stgit stack forked
>> > atop that branch. =C2=A0At some point git-cvsimport fucked somethi=
ng,
>> > and I regenerated a new mirror branch using it in a fresh repo.
>> > Then I wanted to rebase my stack on that new branch.
>>
>> I'm all for calling this command "stg rebase". Currently you can do
>> "stg push -a; stg commit -a; git rebase; stg uncommit -n <n>"...
>
> Or simpler,
>
>   stg pop -a
>   git reset --hard <new_base>
>   stg push -n <n>
>
> This uses stgit for all operations that can conflict.
>
> (BTW, I've never seriously tried git rebase; does anyone have an
> opinion of how convenient its conflict handling is, compared to
> stgit's?)

I have used it a little (together with git-svn), and one thing that
confused me was that when I got a conflict to resolve, it looked like
this:

    ...
    <<<<<<
    base version
    =3D=3D=3D=3D=3D=3D
    my version
    >>>>>>
    ...

Where "my version" is the code in the branch I'm rebasing, and
"base version" is the code in the branch I'm rebasing on.

This is kind of opposite of how e.g. "git pull" works, where the first
alternative is "my version".  I guess it is an effect of the fact that
you are actually merging your branch into another, instead of the
other way around.

--=20
David K=C3=A5gedal
