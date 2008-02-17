From: Alexandre Julliard <julliard@winehq.org>
Subject: Re: [PATCH 02/03] Adding checkout function for commitish in git.el
Date: Sun, 17 Feb 2008 19:27:22 +0100
Message-ID: <871w7b5th1.fsf@wine.dyndns.org>
References: <87wsp8u9m7.dlv@maison.homelinux.org>
	<20080213163002.GA5670@diana.vm.bytemark.co.uk>
	<20080213164356.GA5828@diana.vm.bytemark.co.uk>
	<87zlu4vhon.fsf@osv.gnss.ru> <87lk5ku2wn.dlv_-_@maison.homelinux.org>
	<87abm0u2ao.dlv_-_@maison.homelinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	Karl =?utf-8?Q?Hasselstr=C3=B6m?= <kha@treskal.com>,
	Sergei Organov <osv@javad.com>
To: =?utf-8?Q?R=C3=A9mi?= Vanicat <vanicat@debian.org>
X-From: git-owner@vger.kernel.org Sun Feb 17 19:28:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQoFE-0002oN-1W
	for gcvg-git-2@gmane.org; Sun, 17 Feb 2008 19:28:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751489AbYBQS1d convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 17 Feb 2008 13:27:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751405AbYBQS1d
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Feb 2008 13:27:33 -0500
Received: from mail.codeweavers.com ([216.251.189.131]:32891 "EHLO
	mail.codeweavers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751137AbYBQS1c convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Feb 2008 13:27:32 -0500
Received: from adsl-84-226-48-222.adslplus.ch ([84.226.48.222] helo=wine.dyndns.org)
	by mail.codeweavers.com with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <julliard@winehq.org>)
	id 1JQoEW-0004xg-T6; Sun, 17 Feb 2008 12:27:30 -0600
Received: by wine.dyndns.org (Postfix, from userid 1000)
	id 8C4621E715C; Sun, 17 Feb 2008 19:27:22 +0100 (CET)
In-Reply-To: <87abm0u2ao.dlv_-_@maison.homelinux.org> (=?utf-8?Q?=22R?=
 =?utf-8?Q?=C3=A9mi?= Vanicat"'s
	message of "Sat, 16 Feb 2008 20:30:39 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.0.50 (gnu/linux)
X-Spam-Score: -3.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74155>

R=C3=A9mi Vanicat <vanicat@debian.org> writes:

> M-x git-checkout ask for a commitish, and checkout it as in
>   git checkout commitish --
>   key binding: "C"
> M-x git-branch ask for the name of a new branch, create it and
> checkout it as in
>   git checkout -b name
>   key binding: "b"
> M-x git-create-branch ask for a new branchname, a startpoint (a
> commitish) and create a new branch as in
>   git branch branchname startpoint
>   key binding "B"
> A menu is also available for just switching branch

My idea was to put commands that act on commits instead of files on the
C-c prefix, for instance amend-commit is on C-c C-a, I have a
preliminary cherry-pick implementation that I put on C-C C-p, then we
could have git-checkout on C-c C-o, git-branch on C-c C-b, git-merge on
C-c C-m. Otherwise we'll soon run out of single letter bindings.

Also for more complex operations like git-create-branch we may want
another prefix, as there would probably be more branch manipulations
commands.  For instance something like "B C" for create-branch, "B D"
for delete-branch, "B M" for move-branch etc.

--=20
Alexandre Julliard
julliard@winehq.org
