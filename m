From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: stgit error on status command
Date: Tue, 8 Jul 2008 14:25:02 +0200
Message-ID: <20080708122502.GA8838@diana.vm.bytemark.co.uk>
References: <9e4733910807070810i14c8856vfbec24127e711285@mail.gmail.com> <20080708070254.GA4129@diana.vm.bytemark.co.uk> <9e4733910807080506k6d51bc98h96a7a7b2bd56d98b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Catalin Marinas <catalin.marinas@gmail.com>
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 08 14:26:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGCH7-0001k2-WE
	for gcvg-git-2@gmane.org; Tue, 08 Jul 2008 14:26:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754576AbYGHMZc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 Jul 2008 08:25:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754440AbYGHMZc
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jul 2008 08:25:32 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1221 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753948AbYGHMZb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jul 2008 08:25:31 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1KGCFi-0002Ki-00; Tue, 08 Jul 2008 13:25:02 +0100
Content-Disposition: inline
In-Reply-To: <9e4733910807080506k6d51bc98h96a7a7b2bd56d98b@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87757>

On 2008-07-08 08:06:04 -0400, Jon Smirl wrote:

> On 7/8/08, Karl Hasselstr=F6m <kha@treskal.com> wrote:
>
> > Thanks for the report.
> >
> > The problem is that we mis-parse the output of git diff-index when
> > rename detection is on (and it prints more than one filename on
> > one line). This happens if you give stg status the --diff-opts=3D-M
> > flag, but you didn't -- but it could also happen if you have the
> > stgit.diff-opts config variable set.
>
> I have -M in my config file. If I don't use people on lkml complain
> about renames generating piles of output in the patches. I'm able to
> work around the problem for the moment.

Oh, I'm certainly not suggesting that you shouldn't have -M in your
stgit.diff-opts -- just that dropping it for the moment is a
workaround to your problem.

Hmm. Another workaround is to pass an explicit --diff-opts=3D"" to stg
status; that'll override your stgit.diff-opts, and avoid triggering
the bug.

But with any luck, I'll have this fixed within 4-6 hours or so.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
