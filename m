From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [StGit PATCH 1/5] Check for local changes with "goto"
Date: Tue, 17 Mar 2009 08:06:54 +0100
Message-ID: <20090317070654.GA3716@diana.vm.bytemark.co.uk>
References: <20090312120426.2992.35213.stgit@pc1117.cambridge.arm.com> <20090312120856.2992.48548.stgit@pc1117.cambridge.arm.com> <20090313015755.GA15393@diana.vm.bytemark.co.uk> <b0943d9e0903160756g79ac3464i4bb6f7f61ba0555a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 17 08:08:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjTPl-0006B9-S9
	for gcvg-git-2@gmane.org; Tue, 17 Mar 2009 08:08:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753437AbZCQHHE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 17 Mar 2009 03:07:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753243AbZCQHHD
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Mar 2009 03:07:03 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:33746 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752838AbZCQHHB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Mar 2009 03:07:01 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1LjTO2-000122-00; Tue, 17 Mar 2009 07:06:54 +0000
Content-Disposition: inline
In-Reply-To: <b0943d9e0903160756g79ac3464i4bb6f7f61ba0555a@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113426>

On 2009-03-16 14:56:11 +0000, Catalin Marinas wrote:

> 2009/3/13 Karl Hasselstr=F6m <kha@treskal.com>:
>
> > "Repository" is misleading here. Maybe something like
> >
> > =A0 ix_c =3D iw.index.is_clean(self.stack.head)
> > =A0 wt_c =3D iw.worktree_clean()
> > =A0 if not ix_c or not wt_c:
> > =A0 =A0 =A0 self.__halt('%s not clean. Use "refresh" or "status --r=
eset"'
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 % { (False, True): 'Index', (Tr=
ue, False): 'Worktree',
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (False, False): 'Index =
and worktree' }[(ix_c, wt_c)])
>
> I added two separate if's as I don't find the above readable :-)
>
> if not iw.worktree_clean():
>     self.__halt('Worktree not clean. Use "refresh" or "status --reset=
"')
> if not iw.index.is_clean(self.stack.head):
>     self.__halt('Index not clean. Use "refresh" or "status --reset"')

It's actually quite nice once you get used to the idea of ephemeral
dictionaries just for selection inside an expression ... :-)

Your version doesn't generate the "Your index and worktree are both
dirty" warning, but I guess that's OK.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
