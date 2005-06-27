From: "David S. Miller" <davem@davemloft.net>
Subject: git-local-pull
Date: Sun, 26 Jun 2005 20:05:55 -0700 (PDT)
Message-ID: <20050626.200555.39157645.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Mon Jun 27 04:59:23 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DmjqD-0004cZ-Tf
	for gcvg-git@gmane.org; Mon, 27 Jun 2005 04:59:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261769AbVF0DGD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 26 Jun 2005 23:06:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261776AbVF0DGD
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Jun 2005 23:06:03 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:8876
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S261769AbVF0DF6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Jun 2005 23:05:58 -0400
Received: from localhost ([127.0.0.1] ident=davem)
	by sunset.davemloft.net with esmtp (Exim 4.50)
	id 1DmjwZ-0001Bb-Bh
	for git@vger.kernel.org; Sun, 26 Jun 2005 20:05:55 -0700
To: git@vger.kernel.org
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


I tried to start using git-clone-script to clone repositories
locally.  It crunches on the disk for a couple of seconds,
that's fine, but then I notice the disk activity stop and
git-local-pull becomes cpu bound and grows to 80MB in size
over the course of 5 minutes.

Is this a side effect of the new pack/unpack stuff?

Compared to what this thing is doing, manually symlinking
the object database, copying over the HEAD, and building
the index file is significantly faster.

Actually, git-clone-script didn't build an index file.
So the compute time definitely came from something else
entirely.
