From: "Jan =?UTF-8?B?S3LDvGdlcg==?=" <jk@jk.gs>
Subject: Re: [PATCH] pull --rebase: exit early when the working directory is
 dirty
Date: Wed, 21 May 2008 15:31:10 +0200
Message-ID: <20080521153110.059bc6a3@neuron>
References: <alpine.DEB.1.00.0805211230290.30431@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed May 21 15:38:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JyoVq-0008H3-9L
	for gcvg-git-2@gmane.org; Wed, 21 May 2008 15:37:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934585AbYEUNg5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 21 May 2008 09:36:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934532AbYEUNg4
	(ORCPT <rfc822;git-outgoing>); Wed, 21 May 2008 09:36:56 -0400
Received: from zoidberg.org ([213.133.99.5]:35572 "EHLO cthulhu.zoidberg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934189AbYEUNgz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 May 2008 09:36:55 -0400
X-Greylist: delayed 338 seconds by postgrey-1.27 at vger.kernel.org; Wed, 21 May 2008 09:36:55 EDT
Received: from neuron (xdsl-87-78-68-47.netcologne.de [::ffff:87.78.68.47])
  (IDENT: unknown, AUTH: LOGIN jast, SSL: TLSv1/SSLv3,256bits,AES256-SHA)
  by cthulhu.zoidberg.org with esmtp; Wed, 21 May 2008 15:31:11 +0200
  id 001622D4.48342423.00003DDE
In-Reply-To: <alpine.DEB.1.00.0805211230290.30431@racer>
X-Mailer: Claws Mail 3.3.1 (GTK+ 2.12.9; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82542>

Hi,

> When rebasing fails during "pull --rebase", you cannot just clean up
> the working directory and call "pull --rebase" again, since the
> remote branch was already fetched.
>=20
> Therefore, die early when the working directory is dirty.

Good idea.

> +	git update-index --refresh &&
> +	git diff-files --quiet &&
> +        git diff-index --cached --quiet HEAD -- ||
> +	die "refusing to pull with rebase: your working tree is not
> up-to-date"

Perhaps the "up-to-date" should be changed to something else, following
the recent discussion about the "up-to-date" message in checkout (but
here we don't have to worry about breaking anything else). In that case=
,
I'd suggest:

"Refusing to pull with rebase: your working tree has uncommitted
changes"

--=20
Best regards
Jan Kr=C3=BCger <jk@jk.gs>
