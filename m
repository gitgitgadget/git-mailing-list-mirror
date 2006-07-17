From: Jeff King <peff@peff.net>
Subject: Re: git-repack not removing files from $GIT_DIR/objects/[00-ff]
Date: Sun, 16 Jul 2006 23:26:23 -0400
Message-ID: <20060717032623.GA32406@coredump.intra.peff.net>
References: <5A14AF34CFF8AD44A44891F7C9FF410507E43005@usahm236.amer.corp.eds.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 17 05:26:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G2Jkj-00088y-Vv
	for gcvg-git@gmane.org; Mon, 17 Jul 2006 05:26:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932277AbWGQD0Z (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 16 Jul 2006 23:26:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932282AbWGQD0Z
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Jul 2006 23:26:25 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:33437 "HELO
	peff.net") by vger.kernel.org with SMTP id S932277AbWGQD0Z (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 16 Jul 2006 23:26:25 -0400
Received: (qmail 5410 invoked from network); 16 Jul 2006 23:26:00 -0400
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 16 Jul 2006 23:26:00 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 16 Jul 2006 23:26:23 -0400
To: "Post, Mark K" <mark.post@eds.com>
Content-Disposition: inline
In-Reply-To: <5A14AF34CFF8AD44A44891F7C9FF410507E43005@usahm236.amer.corp.eds.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23964>

On Sun, Jul 16, 2006 at 08:44:52PM -0400, Post, Mark K wrote:

> I'm having a problem that just started occurring with git-repack not
> removing the files from $GIT_DIR/objects/*, and therefore not removing
> the directories, since they're not empty.  The command I'm using (as the
> git user) is this:
> GIT_DIR=/home/git/pub/scm/linux-2.6.git git-repack -a -d -l

git-prune-packed (which, contrary to what Shawn said, is run by
git-repack -d) will only remove objects which are redundant because of
their presence in packs. It will not remove objects which are not
reachable (which is normal if you have, for example, done a rebase in
this repository). Check out git-prune and git-fsck-objects.

-Peff
