From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: Octopus merge: unique (?) to git, but is it useful?
Date: Tue, 3 Jun 2008 22:39:24 +0200
Message-ID: <20080603203924.GA6588@neumann>
References: <200806030314.03252.jnareb@gmail.com>
	<alpine.LFD.1.10.0806021845210.3473@woody.linux-foundation.org>
	<7v3anv5fy3.fsf@gitster.siamese.dyndns.org>
	<7vskvv3xmx.fsf@gitster.siamese.dyndns.org>
	<20080603104009.GA559@neumann>
	<7vabi22u5h.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 03 22:42:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3dKT-0006EE-AT
	for gcvg-git-2@gmane.org; Tue, 03 Jun 2008 22:42:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759315AbYFCUkr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 Jun 2008 16:40:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759306AbYFCUkq
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jun 2008 16:40:46 -0400
Received: from moutng.kundenserver.de ([212.227.126.171]:63247 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759298AbYFCUkm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jun 2008 16:40:42 -0400
Received: from [127.0.1.1] (p5B133079.dip0.t-ipconnect.de [91.19.48.121])
	by mrelayeu.kundenserver.de (node=mrelayeu5) with ESMTP (Nemesis)
	id 0ML25U-1K3dHx32Du-0007Pg; Tue, 03 Jun 2008 22:39:29 +0200
Content-Disposition: inline
In-Reply-To: <7vabi22u5h.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Provags-ID: V01U2FsdGVkX1/rUG93+rqzCjXQd3YzEXodYQ9rsPXKpGulrTN
 3qdnHIY9bwhKATNQCL2l1CiGwULaqBs0dDuF3LRZ1eQ3Ufp/QQ
 1yEydsuuTIkg1F7gq1v8A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83707>

On Tue, Jun 03, 2008 at 12:30:34PM -0700, Junio C Hamano wrote:
> > ...  It
> > fails at the line 'EDITOR=3D: git commit -a'.
>=20
> Sorry, because it works for me (and presumably for many others --- I
> haven't seen anybody else reporting the breakage you have), you need =
to
> help others to diagnose it with a bit more details.
With debug and verbose options it says following:

* expecting success:=20

        git rev-parse second master >expect &&
        test_must_fail git merge second master &&
        git checkout master g &&
        echo "here comes the breakage" &&
        EDITOR=3D: git commit -a &&
        echo "survived!" &&
        git cat-file commit HEAD | sed -n -e "s/^parent //p" -e "/^$/q"=
 >actual &&
        test_cmp expect actual



*** Please tell me who you are.

Run

  git config --global user.email "you@example.com"
  git config --global user.name "Your Name"

to set your account's default identity.
Omit --global to set the identity only in this repository.

fatal: empty ident  <szeder@neumann.(none)> not allowed
here comes the breakage
fatal: no commit message?  aborting commit.
* FAIL 18: Hand committing of a redundant merge removes dups
       =20
       =20
                git rev-parse second master >expect &&
                test_must_fail git merge second master &&
                git checkout master g &&
                echo "here comes the breakage" &&
                EDITOR=3D: git commit -a &&
                echo "survived!" &&
                git cat-file commit HEAD | sed -n -e "s/^parent //p" -e=
 "/^$/q" >actual &&
                test_cmp expect actual
       =20
       =20

* failed 1 among 18 test(s)
make: *** [t7502-commit.sh] Error 1


My /bin/sh is dash, but it breaks with bash, too.

What else could/should I provide?

Regards,
G=E1bor
