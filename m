From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: Re: Strange happening with 'git fetch'
Date: Thu, 7 Jan 2010 20:07:42 +0200
Message-ID: <20100107180742.GA27643@Knoppix>
References: <de73f1891001070959h30e4ecebw7c852f0417647419@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: David Kirk <davemkirk@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 07 19:07:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NSwm1-0008Kg-Ad
	for gcvg-git-2@lo.gmane.org; Thu, 07 Jan 2010 19:07:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752972Ab0AGSHs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 7 Jan 2010 13:07:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752638Ab0AGSHs
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Jan 2010 13:07:48 -0500
Received: from emh03.mail.saunalahti.fi ([62.142.5.109]:57338 "EHLO
	emh03.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752604Ab0AGSHr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 Jan 2010 13:07:47 -0500
Received: from saunalahti-vams (vs3-10.mail.saunalahti.fi [62.142.5.94])
	by emh03-2.mail.saunalahti.fi (Postfix) with SMTP id 31BE9EB9A5;
	Thu,  7 Jan 2010 20:07:46 +0200 (EET)
Received: from emh04.mail.saunalahti.fi ([62.142.5.110])
	by vs3-10.mail.saunalahti.fi ([62.142.5.94])
	with SMTP (gateway) id A01B9229954; Thu, 07 Jan 2010 20:07:46 +0200
Received: from LK-Perkele-V (a88-113-39-59.elisa-laajakaista.fi [88.113.39.59])
	by emh04.mail.saunalahti.fi (Postfix) with ESMTP id 1AE3141BE6;
	Thu,  7 Jan 2010 20:07:43 +0200 (EET)
Content-Disposition: inline
In-Reply-To: <de73f1891001070959h30e4ecebw7c852f0417647419@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136373>

On Thu, Jan 07, 2010 at 11:59:39AM -0600, David Kirk wrote:
> This is very strange, and defies the understanding of everyone in the
> office familiar with git.=C2=A0 Is it a bug, or some feature we don't
> understand?
>=20
> Basically, when I do a 'git fetch', it updates my local repository.
> Now nobody else is doing anything, so the remote repository does not
> change.=C2=A0 Doing another 'git fetch' should report that nothing ne=
eds to
> be done and nothing should change.=C2=A0 But instead, it reports some=
thing
> about the remote HEAD, and changes my local branch 'master' to some
> strange location!=C2=A0 Running 'git fetch' again restores it to the
> correct state, reporting that it is updating 'master'.=C2=A0 Repeated
> invocations will toggle between these two results.=C2=A0 Below is a
> transcript from the bash shell.
>=20
> Can someone please explain this?

I have seen that before. Looks like you have local branch 'HEAD' (_not_
the special ref HEAD) on remote side and that is messing it up.

ls-remote'ing the repository shows 'refs/heads/HEAD', right (there's
also HEAD, that's the required special ref)?

-Ilari
