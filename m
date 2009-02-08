From: "Jan =?UTF-8?B?S3LDvGdlcg==?=" <jk@jk.gs>
Subject: Re: Deleting the "current" branch in remote bare repositories
Date: Sun, 8 Feb 2009 01:18:02 +0100
Message-ID: <20090208011802.2b7b9e74@perceptron>
References: <20090207162754.5fb8b63f@perceptron>
	<94a0d4530902071405m33a0804er8030e14bea205898@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Git ML <git@vger.kernel.org>, obrien654j@gmail.com
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 08 01:19:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVxOY-0005qb-Q9
	for gcvg-git-2@gmane.org; Sun, 08 Feb 2009 01:19:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754488AbZBHASI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Feb 2009 19:18:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753970AbZBHASH
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Feb 2009 19:18:07 -0500
Received: from zoidberg.org ([88.198.6.61]:60408 "EHLO cthulhu.zoidberg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753966AbZBHASH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Feb 2009 19:18:07 -0500
Received: from perceptron (xdsl-78-34-149-97.netcologne.de [::ffff:78.34.149.97])
  (IDENT: unknown, AUTH: LOGIN jast, TLS: TLSv1/SSLv3,256bits,AES256-SHA)
  by cthulhu.zoidberg.org with esmtp; Sun, 08 Feb 2009 01:18:48 +0100
  id 0042C632.498E24E8.000008F3
In-Reply-To: <94a0d4530902071405m33a0804er8030e14bea205898@mail.gmail.com>
X-Mailer: Claws Mail 3.5.0 (GTK+ 2.14.4; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108905>

On Sun, 8 Feb 2009 00:05:05 +0200, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> This was brought up before:
> http://marc.info/?l=git&m=123254293910829&w=2
> 
> But I don't think it reached any conclusion.

Okay, somehow I missed that. To reiterate the things from that
discussion that I think are most reasonable:

1) a local broken symref should generally be ignored unless we actually
   need the symref.

2) there should be a more convenient (porcelain) way to change a
   refs/remotes/foo/HEAD symref, e.g. git remote set-default, possibly
   with an option to re-sync from the remote head (we could even make
   that an option for git remote update).

Regarding 2): if we managed to add an option to that to change the
remote HEAD, we could disallow deleting a remote branch that HEAD
points to, and refer to this command. I think the problem is that we
would have to add symref updating logic for all types of remote
protocols.

If people agree with these ideas I think I'll write up a couple of
patches to implement these changes. So, any protests?

-Jan
