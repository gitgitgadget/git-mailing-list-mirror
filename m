From: =?utf-8?Q?David_K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: Re: [StGit PATCH 07/10] Teach the new infrastructure about the index and worktree
Date: Mon, 26 Nov 2007 09:56:42 +0100
Message-ID: <874pf9bd11.fsf@lysator.liu.se>
References: <20071125203717.7823.70046.stgit@yoghurt>
	<20071125205140.7823.46991.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>,
	Karl =?utf-8?Q?Hasselstr?= =?utf-8?Q?=C3=B6m?= 
	<kha@treskal.com>
X-From: git-owner@vger.kernel.org Mon Nov 26 09:57:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IwZlv-000154-Ec
	for gcvg-git-2@gmane.org; Mon, 26 Nov 2007 09:56:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753399AbXKZI4e convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 26 Nov 2007 03:56:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752702AbXKZI4d
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Nov 2007 03:56:33 -0500
Received: from mail.lysator.liu.se ([130.236.254.3]:56441 "EHLO
	mail.lysator.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753358AbXKZI4d convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Nov 2007 03:56:33 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id C0FD6200A1BE;
	Mon, 26 Nov 2007 09:56:31 +0100 (CET)
Received: from mail.lysator.liu.se ([127.0.0.1])
	by localhost (lenin.lysator.liu.se [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 14710-01-32; Mon, 26 Nov 2007 09:56:31 +0100 (CET)
Received: from krank (c83-253-242-75.bredband.comhem.se [83.253.242.75])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.lysator.liu.se (Postfix) with ESMTP id 41AE4200A1A7;
	Mon, 26 Nov 2007 09:56:31 +0100 (CET)
Received: by krank (Postfix, from userid 1000)
	id E89457B406D; Mon, 26 Nov 2007 09:56:42 +0100 (CET)
In-Reply-To: <20071125205140.7823.46991.stgit@yoghurt> ("Karl =?utf-8?Q?Ha?=
 =?utf-8?Q?sselstr=C3=B6m=22's?= message of "Sun\, 25 Nov 2007 21\:51\:40
 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at lysator.liu.se
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66056>

Karl Hasselstr=C3=B6m <kha@treskal.com> writes:

> --- a/stgit/lib/git.py
> +++ b/stgit/lib/git.py
> @@ -95,6 +95,8 @@ class Commitdata(Repr):
>          return type(self)(committer =3D committer, defaults =3D self=
)
>      def set_message(self, message):
>          return type(self)(message =3D message, defaults =3D self)
> +    def is_empty(self):
> +        return self.tree =3D=3D self.parent.data.tree
>      def __str__(self):
>          if self.tree =3D=3D None:
>              tree =3D None

But a Commitdata describes a Git commit, right? And not an StGit
patch. So what does it mean to say that a commit is empty? I could
just as well mean that the tree is the null tree.

I think I would have called this "is_nochange" or something.

--=20
David K=C3=A5gedal
