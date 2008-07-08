From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: stgit error on status command
Date: Tue, 8 Jul 2008 09:02:54 +0200
Message-ID: <20080708070254.GA4129@diana.vm.bytemark.co.uk>
References: <9e4733910807070810i14c8856vfbec24127e711285@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Catalin Marinas <catalin.marinas@gmail.com>
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 08 09:04:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KG7F5-0000ui-VS
	for gcvg-git-2@gmane.org; Tue, 08 Jul 2008 09:04:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751639AbYGHHDF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 Jul 2008 03:03:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751687AbYGHHDE
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jul 2008 03:03:04 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:3987 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751639AbYGHHDE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jul 2008 03:03:04 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1KG7Dy-0001DK-00; Tue, 08 Jul 2008 08:02:54 +0100
Content-Disposition: inline
In-Reply-To: <9e4733910807070810i14c8856vfbec24127e711285@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87725>

Thanks for the report.

The problem is that we mis-parse the output of git diff-index when
rename detection is on (and it prints more than one filename on one
line). This happens if you give stg status the --diff-opts=3D-M flag,
but you didn't -- but it could also happen if you have the
stgit.diff-opts config variable set.

I'll try to get a patch out tonight. In the mean time, if you like you
should be able to work around the problem by unsetting
stgit.diff-opts.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
