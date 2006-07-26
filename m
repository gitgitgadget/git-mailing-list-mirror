From: linux@horizon.com
Subject: Re: Handling very large numbers of symbolic references?
Date: 26 Jul 2006 14:38:41 -0400
Message-ID: <20060726183841.10196.qmail@science.horizon.com>
Cc: git@vger.kernel.org, linux@horizon.com
X-From: git-owner@vger.kernel.org Wed Jul 26 20:38:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G5oHO-0000Az-L8
	for gcvg-git@gmane.org; Wed, 26 Jul 2006 20:38:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161022AbWGZSin (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 26 Jul 2006 14:38:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161026AbWGZSin
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Jul 2006 14:38:43 -0400
Received: from science.horizon.com ([192.35.100.1]:45369 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S1161022AbWGZSin
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Jul 2006 14:38:43 -0400
Received: (qmail 10197 invoked by uid 1000); 26 Jul 2006 14:38:41 -0400
To: nix@esperi.org.uk
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24233>

Just to contribute a litle brainstorming....

- Remember that git refs only point to one end of a commit chain.
  The origin is kind of implicit.  If bug IDs correspond to *changes*,
  especially ones that you want to mix and match rebasing, is this a
  job for StGit or quilt or something else that tracks patches rather
  than states?
- If you do use core git to label bits of development history, are the
  labels supposed to be mutable heads or mostly frozen tags?
- Assuming they're tags, do you need them to be part of the root set
  for garbage collection purposes?  Or do you assume they are already
  referenced by the development history, and the bug ID links are
  symlinks that moight be broken if the patch isn't merged?

I really should look at StGit more, because from my current position
of ignorance, it looks like possibly a better match to the problem.
The main problems I see are that its patches are per-branch, not global,
and there's no fetch/push mechanism for sharing them.

Also, you might want to have a "patch" with a single name be a
patch SERIES, which I don't think StGit does.
