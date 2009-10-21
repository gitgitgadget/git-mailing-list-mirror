From: Jan =?UTF-8?B?S3LDvGdlcg==?= <jk@jk.gs>
Subject: Re: confusion with git diff-tree output
Date: Wed, 21 Oct 2009 19:51:03 +0200
Message-ID: <20091021195103.01cef9c4@perceptron>
References: <117f2cc80910211043q3a92a7b6o15464cc049ee33dc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: David Roundy <roundyd@physics.oregonstate.edu>
X-From: git-owner@vger.kernel.org Wed Oct 21 19:51:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0fLF-0005tO-Mv
	for gcvg-git-2@lo.gmane.org; Wed, 21 Oct 2009 19:51:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754622AbZJURvJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Oct 2009 13:51:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753929AbZJURvI
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Oct 2009 13:51:08 -0400
Received: from zoidberg.org ([88.198.6.61]:40857 "EHLO cthulhu.zoidberg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753846AbZJURvI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Oct 2009 13:51:08 -0400
Received: from perceptron (xdsl-78-35-156-26.netcologne.de [::ffff:78.35.156.26])
  (IDENT: unknown, AUTH: LOGIN jast, TLS: TLSv1/SSLv3,128bits,AES128-SHA)
  by cthulhu.zoidberg.org with esmtp; Wed, 21 Oct 2009 19:51:06 +0200
  id 004D0101.4ADF4A0B.00006C48
In-Reply-To: <117f2cc80910211043q3a92a7b6o15464cc049ee33dc@mail.gmail.com>
X-Mailer: Claws Mail 3.7.3 (GTK+ 2.16.1; i486-pc-linux-gnu)
X-Obscure-Spam: http://music-jk.net/
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130945>

> David Roundy <roundyd@physics.oregonstate.edu> wrote:

> I've been struggling with trying to figure out how to make diff-tree
> output the actual files changed.  Below is the output when I run
> diff-tree on a given commit.  It reports that the directory is
> modified, rather than that a single file within that directory is
> modified.

Tree objects are recursively nested, i.e.

> 66b67ea1763799c0b2ac01f6803177ca870f6544 M	Iolaus

is a reference to another tree object... and since a file in that
subtree changed, a new tree object that contains a different file
record is now referenced as "Iolaus".

By default git diff-tree doesn't recurse, but you can use -r for that.
Which is documented, I might add. ;)

Jan
