From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [StGIT RFC PATCH] Don't use refs/bases/<branchname>
Date: Tue, 1 May 2007 20:56:15 +0200
Message-ID: <20070501185615.GA32727@diana.vm.bytemark.co.uk>
References: <20070429220832.5832.251.stgit@yoghurt> <b0943d9e0705010137q4a35f818m7dbbc9d2e77e2fcf@mail.gmail.com> <e5bfff550705010210i352ac9eej6ff7a78aae6535c9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Catalin Marinas <catalin.marinas@gmail.com>, git@vger.kernel.org
To: Marco Costalba <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 01 20:56:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HixWR-0003nf-FS
	for gcvg-git@gmane.org; Tue, 01 May 2007 20:56:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161758AbXEAS4U convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 1 May 2007 14:56:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161759AbXEAS4U
	(ORCPT <rfc822;git-outgoing>); Tue, 1 May 2007 14:56:20 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:3247 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161758AbXEAS4T (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 May 2007 14:56:19 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1HixWJ-00007s-00; Tue, 01 May 2007 19:56:15 +0100
Content-Disposition: inline
In-Reply-To: <e5bfff550705010210i352ac9eej6ff7a78aae6535c9@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45971>

On 2007-05-01 11:10:47 +0200, Marco Costalba wrote:

> On 5/1/07, Catalin Marinas <catalin.marinas@gmail.com> wrote:
>
> > I'm OK with this patch as long as tools like qgit don't rely on
> > this ref.
>
> It's OK for me. A recent qgit already filters out content of
> refs/bases to reduce visual 'noise'.

Good.

> The only StGit data read directly are patches sha's; qgit walks
> recursively all the files called "top" under directory tree
>
>           <git dir>/patches/<current branch>
>
> to get sha list of each applied and unapplied patch in one go. This
> is much faster then calling "stg id <patch name>" for all the
> patches.

Hmm. These are on my kill list too. :-)

The patch tops are already recorded in
refs/patches/<branch>/<patchname> to keep them from being garbage
collected, so these top files are redundant. But it isn't _that_ bad,
so if removing them would break qgit, I guess I could try to restrain
myself. At least all the other metadata is fair game. :-)

(But if I were you, I'd look for the patches under patches/refs
anyway; they _have_ to be there to survive garbage collection, so no
amount of stgit refactoring will break qgit.)

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
