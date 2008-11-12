From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: Stgit and refresh-temp
Date: Wed, 12 Nov 2008 13:46:15 +0100
Message-ID: <20081112124615.GA29659@diana.vm.bytemark.co.uk>
References: <9e4733910811040537p4e88c09an94370154eca12778@mail.gmail.com> <20081107054419.GA27146@diana.vm.bytemark.co.uk> <b0943d9e0811110959t4eb236bvd648fbca5e482911@mail.gmail.com> <20081112080103.GA25454@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jon Smirl <jonsmirl@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 12 13:47:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0F8C-00033Z-7T
	for gcvg-git-2@gmane.org; Wed, 12 Nov 2008 13:47:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751802AbYKLMqU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 12 Nov 2008 07:46:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751828AbYKLMqU
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Nov 2008 07:46:20 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1789 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751525AbYKLMqU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Nov 2008 07:46:20 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1L0F6t-0007jE-00; Wed, 12 Nov 2008 12:46:15 +0000
Content-Disposition: inline
In-Reply-To: <20081112080103.GA25454@diana.vm.bytemark.co.uk>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100744>

On 2008-11-12 09:01:03 +0100, Karl Hasselstr=F6m wrote:

> On 2008-11-11 17:59:02 +0000, Catalin Marinas wrote:
>
> > 2008/11/7 Karl Hasselstr=F6m <kha@treskal.com>:
> >
> > > On 2008-11-04 08:37:24 -0500, Jon Smirl wrote:
> > >
> > > > I hit a case when refreshing a buried patch that needed a
> > > > merge conflict sorted out. I'm unable to recover out of the
> > > > state.
> > >
> > > Hmm, so what you're saying is basically that you did something
> > > with "stg refresh -p" that caused a merge conflict, and that
> > > messed things up so that you needed to run "stg repair". Is that
> > > right?
> >
> > Could be related to this - if I run 'stg goto some-patch' and it
> > fails with a conflict, the HEAD points to the previous patch
> > though the stack has the conflicting patch as empty (which is
> > normal) and the conflicts in the index. Anything after that says
> > HEAD and top not equal and 'stg repair' is needed.
>
> Ah, yes, that could definitely be the same problem, since those two
> things end up calling the same functions to handle the conflict.

OK, I just got this error with goto. :-)

=46WIW, the convenient way to recover is

  $ git reset --soft $(stg id $(stg top))

This will point your branch head to the correct commit. stg repair
would pop the top patch, which is much less convenient in this case.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
