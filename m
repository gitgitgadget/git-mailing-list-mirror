From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Rebasing stgit stacks
Date: Fri, 19 Jan 2007 10:47:59 +0100
Organization: At home
Message-ID: <eoq439$7ml$1@sea.gmane.org>
References: <8b65902a0701091335u160c6dfl81a523e4cd5adbee@mail.gmail.com> <8b65902a0701091341v5983c113tc5cd32c6c4c57719@mail.gmail.com> <20070109224125.GF17093@nan92-1-81-57-214-146.fbx.proxad.net> <8b65902a0701150526j5a954529xf45b2d0348a77573@mail.gmail.com> <20070115202412.GE9761@nan92-1-81-57-214-146.fbx.proxad.net> <b0943d9e0701151446l45eff9dbgcae718c1461d0725@mail.gmail.com> <20070115233958.GF9761@nan92-1-81-57-214-146.fbx.proxad.net> <b0943d9e0701161442t6b93e0d6nd88364600f2809ee@mail.gmail.com> <20070116231735.GF7029@nan92-1-81-57-214-146.fbx.proxad.net> <b0943d9e0701180105t7b01cb4di43b4db1fdc314bb7@mail.gmail.com> <20070118205233.GK9761@nan92-1-81-57-214-146.fbx.proxad.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Fri Jan 19 10:47:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H7qLh-00029U-5e
	for gcvg-git@gmane.org; Fri, 19 Jan 2007 10:47:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965031AbXASJrt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 19 Jan 2007 04:47:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965029AbXASJrt
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Jan 2007 04:47:49 -0500
Received: from main.gmane.org ([80.91.229.2]:37431 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965031AbXASJrs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jan 2007 04:47:48 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1H7qLS-0002Rt-LG
	for git@vger.kernel.org; Fri, 19 Jan 2007 10:47:38 +0100
Received: from host-81-190-20-200.torun.mm.pl ([81.190.20.200])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 19 Jan 2007 10:47:38 +0100
Received: from jnareb by host-81-190-20-200.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 19 Jan 2007 10:47:38 +0100
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-20-200.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37168>

Yann Dirson wrote:
> On Thu, Jan 18, 2007 at 09:05:47AM +0000, Catalin Marinas wrote:

>> As Jakub said, I would also call this command 'rebase' instead of
>> 'pull --to', even if we duplicate a bit of code.
>> It would make the implementation even simpler
>=20
> A new command is fine with me, it's just that I feel "rebase <target>=
"
> may be confusing to beginners. =A0I'd rather say "rebase [<stack>] --=
to
> <target>", but it's just that I don't see the case for specifying a
> different stack than the current one.

If you want to move some stack from one branch to other, for example
from 'next' or next-based branch to 'origin'/'master' or origin-based
branch you could do either:

  $ git checkout <newbase>
  $ stg rebase <stack>

or

  $ git checkout <oldbase>
  $ stg rebase --onto <newbase>

(or even "stg rebase <stack> --onto <newbase>" or "stg rebase=20
--onto <newbase> <stack>").

Although usually you have separate branch as StGIT stack "base", and
you can simply rebase git branch, then do

  $ stg rebase

--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
