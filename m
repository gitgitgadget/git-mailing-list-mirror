From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [StGit PATCH 0/6] Two bugfixes
Date: Mon, 24 Mar 2008 19:12:25 +0100
Message-ID: <20080324181225.GC23337@diana.vm.bytemark.co.uk>
References: <20080320002604.13102.53757.stgit@yoghurt> <b0943d9e0803200819k7300fd1fn8a21896c7ad2a1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Erik Sandberg <mandolaerik@gmail.com>
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 24 19:13:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JdrAc-0000vN-83
	for gcvg-git-2@gmane.org; Mon, 24 Mar 2008 19:13:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757205AbYCXSMf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 24 Mar 2008 14:12:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756764AbYCXSMf
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Mar 2008 14:12:35 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2225 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756852AbYCXSMf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Mar 2008 14:12:35 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1Jdr9l-00089N-00; Mon, 24 Mar 2008 18:12:25 +0000
Content-Disposition: inline
In-Reply-To: <b0943d9e0803200819k7300fd1fn8a21896c7ad2a1@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78070>

On 2008-03-20 15:19:12 +0000, Catalin Marinas wrote:

> As I wrote on the patch system, I'd like to put back the explicit
> --keep option in goto.

There are three possible values of "keepiness":

  1. Make sure there are _no_ local changes. (Default for old
     infrastructure.)

  2. Make sure there are no local changes in the files we need to
     touch. (Default for new infrastructure.)

  3. Bring along local changes by means of a merge. (What the --keep
     option does.)

git defaults to doing (2), and optionally does (3). (1) is
significantly slower than (2); I don't know how slow (3) is.

There are two questions: what subset of these options do we support,
and which of the supported modes should be the default?

I think that (2) should be the default, because it's faster, it's what
git does, and I don't really see the point in complaining about local
changes in a file we won't need to touch anyway. Having an option for
(3) might be handy, though.

But I gather you want (1) to be the default (with (3) as an option).
Correct?

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
