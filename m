From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: backup git repo on every commit
Date: Mon, 12 Oct 2009 07:15:44 -0700
Message-ID: <20091012141544.GF9261@spearce.org>
References: <194a2c240910120641sccf0e55xef4226269df78864@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Israel Garcia <igalvarez@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 12 16:24:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxLpP-0003mq-DK
	for gcvg-git-2@lo.gmane.org; Mon, 12 Oct 2009 16:24:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756775AbZJLOQV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2009 10:16:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756761AbZJLOQV
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Oct 2009 10:16:21 -0400
Received: from george.spearce.org ([209.20.77.23]:54093 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756668AbZJLOQU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2009 10:16:20 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id C2FD8381FE; Mon, 12 Oct 2009 14:15:44 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <194a2c240910120641sccf0e55xef4226269df78864@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130014>

Israel Garcia <igalvarez@gmail.com> wrote:
> Which is the simplest  way to backup a git repository after every commit?

Add a commit hook to push to another location, e.g.:

  git remote add --mirror backup you@another.host:path/to/backup.git

  cat >.git/hooks/post-commit
  #!/bin/sh
  git push backup
  ^D

  chmod a+x .git/hooks/post-commit

-- 
Shawn.
