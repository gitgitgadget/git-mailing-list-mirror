From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [StGIT PATCH] Test "stg rebase" after "stg commit"
Date: Sun, 6 May 2007 14:21:16 +0200
Message-ID: <20070506122116.GA18883@diana.vm.bytemark.co.uk>
References: <20070504081021.14786.77675.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Yann Dirson <ydirson@altern.org>
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 06 14:22:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HkfkY-0004DR-E3
	for gcvg-git@gmane.org; Sun, 06 May 2007 14:22:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752540AbXEFMVW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 6 May 2007 08:21:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752880AbXEFMVW
	(ORCPT <rfc822;git-outgoing>); Sun, 6 May 2007 08:21:22 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2120 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752540AbXEFMVT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 May 2007 08:21:19 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1Hkfjp-0004v1-00; Sun, 06 May 2007 13:21:17 +0100
Content-Disposition: inline
In-Reply-To: <20070504081021.14786.77675.stgit@yoghurt>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46327>

On 2007-05-04 10:13:21 +0200, Karl Hasselstr=F6m wrote:

>   2. Try to commit a patch, and then rebase. This doesn't work,
>      because "stg rebase" aborts if orig-base !=3D base, and "stg
>      commit" doesn't update orig-base. (It does work if "stg rebase"
>      is given the --force flag.)
>
> (2) shows a bug in "stg rebase"'s safety logic. I'm not sure how to
> fix it, because I don't know how it's supposed to work in the first
> place. (An obvious fix would be to update it whenever the base
> changes, but that'll take some work, and I'm not convinced it can't
> be done with les work. Yes, I'm lazy.) Yann, could you explain?

Another reason why this is impractical is that it's not only stgit
that's allowed to change the base. For example, doing "stg pop -a &&
git reset --hard foobar && stg rebase qwrtflsptk" will also trigger
the alarm.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
