From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [STGIT PATCH] replace "git repo-config" usage by "git config"
Date: Thu, 24 Jan 2008 19:08:35 +0100
Message-ID: <20080124180835.GA28723@diana.vm.bytemark.co.uk>
References: <1200453554-14163-1-git-send-email-dpmcgee@gmail.com> <200801162147.33448.kumbayo84@arcor.de> <200801162158.26450.kumbayo84@arcor.de> <20080117074559.GB25213@diana.vm.bytemark.co.uk> <20080118042447.GA13178@diana.vm.bytemark.co.uk> <b0943d9e0801230335m4a2d1855uf465d0d134f3ef39@mail.gmail.com> <20080123161014.GA5850@diana.vm.bytemark.co.uk> <b0943d9e0801230842w250ab963t16a1ab3c8024487e@mail.gmail.com> <20080124070125.GA19653@diana.vm.bytemark.co.uk> <b0943d9e0801240731q856925al267d81548f5e2091@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Peter Oberndorfer <kumbayo84@arcor.de>, git@vger.kernel.org,
	Pavel Roskin <proski@gnu.org>
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 24 19:09:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JI6W9-0003Zx-Dz
	for gcvg-git-2@gmane.org; Thu, 24 Jan 2008 19:09:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753032AbYAXSJH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 Jan 2008 13:09:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753065AbYAXSJG
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jan 2008 13:09:06 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1812 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753014AbYAXSJF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jan 2008 13:09:05 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1JI6V9-0007VS-00; Thu, 24 Jan 2008 18:08:35 +0000
Content-Disposition: inline
In-Reply-To: <b0943d9e0801240731q856925al267d81548f5e2091@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71638>

On 2008-01-24 15:31:40 +0000, Catalin Marinas wrote:

> Another thing, can the '--keep' option be added? Can it work with
> the new structure? I use it quite often as I make some minor
> modification and I'd like to pop patches without affecting the local
> changes.

As is, it works out of the box as long as your local changes are in
files not touched by the command.

Making it work in other cases as well should be doable -- behind the
scenes, we'd save the local changes much like a patch, and try to
apply it at the end. (In fact, we should probably not create this
"patch" until git-read-tree tells us it can't do its job due to local
changes.)

Adding the --keep flag once would make it available for all commands
using the new infrastructure.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
