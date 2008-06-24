From: "Jan =?UTF-8?B?S3LDvGdlcg==?=" <jk@jk.gs>
Subject: Re: why is git destructive by default? (i suggest it not be!)
Date: Tue, 24 Jun 2008 07:24:09 +0200
Message-ID: <20080624072409.5d499722@neuron>
References: <alpine.LFD.1.10.0806232356340.2979@xanadu.home>
	<willow-jeske-01l5PFjPFEDjCfzf-01l5fAcTFEDjCWA4>
	<willow-jeske-01l5g9o4FEDjCXMB>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "David Jeske" <jeske@google.com>
X-From: git-owner@vger.kernel.org Tue Jun 24 07:25:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KB11f-0000J7-PA
	for gcvg-git-2@gmane.org; Tue, 24 Jun 2008 07:25:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751094AbYFXFYM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2008 01:24:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752068AbYFXFYL
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 01:24:11 -0400
Received: from zoidberg.org ([213.133.99.5]:50130 "EHLO cthulhu.zoidberg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750968AbYFXFYL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2008 01:24:11 -0400
Received: from neuron (xdsl-87-78-133-67.netcologne.de [::ffff:87.78.133.67])
  (IDENT: unknown, AUTH: LOGIN jast, SSL: TLSv1/SSLv3,256bits,AES256-SHA)
  by cthulhu.zoidberg.org with esmtp; Tue, 24 Jun 2008 07:24:09 +0200
  id 00181C65.486084F9.000013EB
In-Reply-To: <willow-jeske-01l5g9o4FEDjCXMB>
X-Mailer: Claws Mail 3.3.1 (GTK+ 2.12.9; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85993>

Hi David,

"David Jeske" <jeske@google.com> wrote:
> I moved a branch around and then deleted it, and I don't see any
> record in the reflog of where it was, or that it ever was.

If a branch you're trying to delete is not part (or, more correctly,
an ancestor) of your current branch, you'll get a warning that you have
to explicitly bypass by using -D rather than -d.

Still, after deleting the branch, its old tip will very likely show up
in the reflog for HEAD (at the point you last worked on the branch),
even if the branch name won't show up anywhere. After locating the
commit in there it's a simple case of git checkout -b whatever
HEAD@{123} to get back that branch.

> What prevents someone from accidentally deleting an old branch that
> nobody is watching, but is important to the history and then not
> noticing as gc silently deletes the old deltas?

One thing to keep in mind is that deleting your branch locally won't
rid you of remote copies of it, so anything that you considered worth
sharing will probably survive even if you accidentally bypassed Git's
warning about deleting branches.

Best,
Jan
