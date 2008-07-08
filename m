From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: Can I remove stg sync --undo ?
Date: Tue, 8 Jul 2008 06:14:25 +0200
Message-ID: <20080708041425.GA2247@diana.vm.bytemark.co.uk>
References: <20080702072524.GA26805@diana.vm.bytemark.co.uk> <b0943d9e0807031502x5f7c4babtd65511d7966c69f6@mail.gmail.com> <20080704020918.GA30669@diana.vm.bytemark.co.uk> <b0943d9e0807041505oc15660bpcd62a62100e517b9@mail.gmail.com> <20080705083348.GA21097@diana.vm.bytemark.co.uk> <b0943d9e0807071347n17e2e09ai761b849d2d03bc9c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 08 06:15:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KG4by-0007GL-0S
	for gcvg-git-2@gmane.org; Tue, 08 Jul 2008 06:15:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751003AbYGHEOc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 Jul 2008 00:14:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751035AbYGHEOc
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jul 2008 00:14:32 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:3381 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750994AbYGHEOb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jul 2008 00:14:31 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1KG4av-0000cr-00; Tue, 08 Jul 2008 05:14:25 +0100
Content-Disposition: inline
In-Reply-To: <b0943d9e0807071347n17e2e09ai761b849d2d03bc9c@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87703>

On 2008-07-07 21:47:13 +0100, Catalin Marinas wrote:

> 2008/7/5 Karl Hasselstr=F6m <kha@treskal.com>:
>
> > On 2008-07-04 23:05:11 +0100, Catalin Marinas wrote:
> >
> > > There are two operations that can conflict for sync - pushing a
> > > patch and the actual sync'ing, i.e. a three-way merge with the
> > > patch to be synchronised with (kind of fold).
> >
> > My guess is that conflicts of the first type would work out of the
> > box (i.e. they'd get an extra log entry) while conflicts of the
> > second type would not.
>
> I don't really care as long as I can get back to the patch state
> before running the sync command if anything goes wrong. So, one undo
> level would be enough.
>
> > We need a sync undo test.
>
> Yes but not sure what how undo would behave in this situation yet.

OK, then I'll write a simple test that makes sure undo and sync
interact the way I imagine they should. ;-)

> > With just "stg undo" (or reset or redo), you get the usual
> > new-infrastructure check about dirty index and working tree (the
> > whole index must be clean, and the parts of the worktree we need
> > to touch must be clean). Which prevents you from undoing a
> > conflicting push, for example.
> >
> > With the --hard flag, any uncleanliness in index or worktree
> > simply gets zapped (just like with git reset --hard). I'm not 100%
> > happy with this -- what I'd really like is to zap only the files
> > that we need to touch. But I haven't figured out a good way to do
> > that.
>
> OK, not much to comment here, it's your implementation :-).

But you too get to live with the design decisions ...

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
