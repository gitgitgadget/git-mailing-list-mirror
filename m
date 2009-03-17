From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [StGit PATCH 1/5] Check for local changes with "goto"
Date: Tue, 17 Mar 2009 14:36:12 +0100
Message-ID: <20090317133612.GA10001@diana.vm.bytemark.co.uk>
References: <20090312120426.2992.35213.stgit@pc1117.cambridge.arm.com> <20090312120856.2992.48548.stgit@pc1117.cambridge.arm.com> <20090313015755.GA15393@diana.vm.bytemark.co.uk> <b0943d9e0903160756g79ac3464i4bb6f7f61ba0555a@mail.gmail.com> <20090317070654.GA3716@diana.vm.bytemark.co.uk> <b0943d9e0903170351p319bad36icf8252610e5c4f05@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 17 14:38:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjZUc-0005Ih-JI
	for gcvg-git-2@gmane.org; Tue, 17 Mar 2009 14:38:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753807AbZCQNgQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 17 Mar 2009 09:36:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752392AbZCQNgQ
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Mar 2009 09:36:16 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:50251 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752049AbZCQNgQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Mar 2009 09:36:16 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1LjZSm-0002bl-00; Tue, 17 Mar 2009 13:36:12 +0000
Content-Disposition: inline
In-Reply-To: <b0943d9e0903170351p319bad36icf8252610e5c4f05@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113469>

On 2009-03-17 10:51:08 +0000, Catalin Marinas wrote:

> 2009/3/17 Karl Hasselstr=F6m <kha@treskal.com>:
>
> > On 2009-03-16 14:56:11 +0000, Catalin Marinas wrote:
> >
> > > if not iw.worktree_clean():
> > > =A0 =A0 self.__halt('Worktree not clean. Use "refresh" or "status=
 --reset"')
> > > if not iw.index.is_clean(self.stack.head):
> > > =A0 =A0 self.__halt('Index not clean. Use "refresh" or "status --=
reset"')
> [...]
> > Your version doesn't generate the "Your index and worktree are
> > both dirty" warning, but I guess that's OK.
>
> The iw.worktree_clean() only checks whether the worktree is clean
> relative to the index (I just tried "git update-index --refresh"
> after "git add <modified file>" and it returns 0).

Yes, I know. The point I was trying to make was that your code doesn't
make a difference between

  (iw.worktree_clean(), iw.index.is_clean(self.stack.head)) =3D=3D (Fal=
se, True)

and

  (iw.worktree_clean(), iw.index.is_clean(self.stack.head)) =3D=3D (Fal=
se, False)

But as I said, it's not really important.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
