From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [STGIT PATCH] replace "git repo-config" usage by "git config"
Date: Wed, 23 Jan 2008 17:10:14 +0100
Message-ID: <20080123161014.GA5850@diana.vm.bytemark.co.uk>
References: <1200453554-14163-1-git-send-email-dpmcgee@gmail.com> <200801162147.33448.kumbayo84@arcor.de> <200801162158.26450.kumbayo84@arcor.de> <20080117074559.GB25213@diana.vm.bytemark.co.uk> <20080118042447.GA13178@diana.vm.bytemark.co.uk> <b0943d9e0801230335m4a2d1855uf465d0d134f3ef39@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Peter Oberndorfer <kumbayo84@arcor.de>, git@vger.kernel.org,
	Pavel Roskin <proski@gnu.org>
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 23 17:13:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JHiEE-0005MD-Kh
	for gcvg-git-2@gmane.org; Wed, 23 Jan 2008 17:13:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757239AbYAWQK5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 23 Jan 2008 11:10:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754832AbYAWQK4
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jan 2008 11:10:56 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2185 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754776AbYAWQKz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jan 2008 11:10:55 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1JHiB4-0001zj-00; Wed, 23 Jan 2008 16:10:14 +0000
Content-Disposition: inline
In-Reply-To: <b0943d9e0801230335m4a2d1855uf465d0d134f3ef39@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71549>

On 2008-01-23 11:35:03 +0000, Catalin Marinas wrote:

> On 18/01/2008, Karl Hasselstr=F6m <kha@treskal.com> wrote:
>
> > The following changes since commit
> > 5b2666bab799830ac5e511f35103d04fc3968b32:
>
> I merged your patches but I have some wishes. Could we keep pretty
> much the same reporting messages? For example, pushing reports a
> conflict but it no longer lists which files conflicted.

Mmm, that's a regression. Will try to see where that got lost.

> The 'goto' checks the local status before pushing but doesn't report
> this (and my machine is slow and it might wait even 20 seconds or
> more, it is useful to get some messages).

No, it doesn't anymore, so it should be faster than before. Instead of
checking the entire tree for cleanliness, it just relies on
git-read-tree -u -m to abort without changes if any of the files that
need updating are dirty.

This goes for all commands using the new infrastructure, by the way.
They share a _lot_ of code.

> The pop/push commands report that the action took place. The one
> with "action ... done" was friendlier I think, especially with the
> 'pop' command reporting that it popped the patches but it waits
> quite a lot before returning.

Yes, I agree that the current output is not optimal.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
