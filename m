From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [StGit PATCH 00/17] Series short description
Date: Tue, 18 Dec 2007 10:24:19 +0100
Message-ID: <20071218092419.GA16029@diana.vm.bytemark.co.uk>
References: <20071214105238.18066.23281.stgit@krank> <b0943d9e0712170309n415dc6cs9d1c1f8a9c687bf8@mail.gmail.com> <20071217224812.GA6342@diana.vm.bytemark.co.uk> <b0943d9e0712180111l3294e1adj60b5271b9820c60c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David =?iso-8859-1?Q?K=E5gedal?= <davidk@lysator.liu.se>,
	git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 18 10:24:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4Yh1-0006pw-4h
	for gcvg-git-2@gmane.org; Tue, 18 Dec 2007 10:24:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752136AbXLRJY0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 18 Dec 2007 04:24:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752134AbXLRJY0
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Dec 2007 04:24:26 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4770 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752131AbXLRJYZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Dec 2007 04:24:25 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1J4YgW-0004Qi-00; Tue, 18 Dec 2007 09:24:20 +0000
Content-Disposition: inline
In-Reply-To: <b0943d9e0712180111l3294e1adj60b5271b9820c60c@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68715>

On 2007-12-18 09:11:00 +0000, Catalin Marinas wrote:

> On 17/12/2007, Karl Hasselstr=F6m <kha@treskal.com> wrote:
>
> > Be careful about merging past the "goto" patch -- I'm pretty sure
> > it breaks when called from a subdirectory, and I don't have time
> > to fix that right now. (It should be a clean fix, though -- just
> > adjust the cwd for precisely those git subprocesses that need it,
> > which is very few. I think.)
>
> Why not just change the cwd when the command starts and it should be
> safe for all the git subprocesses.

It doesn't feel very clean to require the caller of some unspecified
subset of git calls to remember to set the correct piece of global
state.

And the correct solution should really be very simple, since it's
precisely the worktree operations (specifically, the subset thereof
that have to operate on the whole tree) that require setting cwd. And
those are very clearly separated out from the rest in the new
infrastructure.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
