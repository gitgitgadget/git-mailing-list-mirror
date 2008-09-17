From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [StGit PATCH] Convert "sink" to the new infrastructure
Date: Wed, 17 Sep 2008 15:04:32 +0200
Message-ID: <20080917130432.GA26365@diana.vm.bytemark.co.uk>
References: <20080912215613.10270.20599.stgit@localhost.localdomain> <20080914085118.GC30664@diana.vm.bytemark.co.uk> <b0943d9e0809141419q6facb21at627e658805f1d223@mail.gmail.com> <20080915075740.GB14452@diana.vm.bytemark.co.uk> <b0943d9e0809150944o71acafe7ndeda500b1fba97df@mail.gmail.com> <20080916074024.GA2454@diana.vm.bytemark.co.uk> <b0943d9e0809160759w5c9be510t3b33d5d983bff5a7@mail.gmail.com> <20080916193647.GA12513@diana.vm.bytemark.co.uk> <b0943d9e0809170455m53eaf677t87e9ade3f001d044@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 17 14:43:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KfwNh-0004XH-92
	for gcvg-git-2@gmane.org; Wed, 17 Sep 2008 14:43:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752416AbYIQMma convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 17 Sep 2008 08:42:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752352AbYIQMma
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Sep 2008 08:42:30 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:3211 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751979AbYIQMma (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Sep 2008 08:42:30 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1Kfwhs-0006uw-00; Wed, 17 Sep 2008 14:04:32 +0100
Content-Disposition: inline
In-Reply-To: <b0943d9e0809170455m53eaf677t87e9ade3f001d044@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96103>

On 2008-09-17 12:55:39 +0100, Catalin Marinas wrote:

> 2008/9/16 Karl Hasselstr=F6m <kha@treskal.com>:
>
> > When benchmarking recent StGits, you'll want to try goto as well,
> > since push and pop are not yet new-infrastructure-ized (meaning
> > they're getting slowdowns from the stack log, but no speedups (if
> > any) from the new infrastructure).
>
> Indeed, goto is faster even than the stable branch.

When push+pop are converted to the new infrastructure, their
performance should be identical to goto's.

> I attached the new figures. I think it could go even faster if
> pushing attempts a "git apply" first before the index merge. With
> the stack log, the patch diff should be saved already so no need for
> a "git diff" (as in the stable branch).

Actually, the new infrastructure already uses apply (with fall-back to
merge-recursive). It doesn't use the saved diff, though.

> 2.6.27-rc5-mm1 kernel, 300 patches uncommitted
>
> pop/push ran a few times to heat the caches before running the
> benchmarks.

Have you tried the benchmarks I committed a while back?

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
