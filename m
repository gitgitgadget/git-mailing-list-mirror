From: "Stephen R. van den Berg" <srb@cuci.nl>
Subject: Re: Git vs Monotone
Date: Thu, 31 Jul 2008 20:33:17 +0200
Message-ID: <20080731183317.GA31085@cuci.nl>
References: <bd6139dc0807311113n50dda9f0t1aab46b724510de2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailinglist <git@vger.kernel.org>
To: Sverre Rabbelier <alturin@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 31 20:34:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOcyh-00024a-Ma
	for gcvg-git-2@gmane.org; Thu, 31 Jul 2008 20:34:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752980AbYGaSdT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jul 2008 14:33:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753281AbYGaSdT
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Jul 2008 14:33:19 -0400
Received: from aristoteles.cuci.nl ([212.125.128.18]:42120 "EHLO
	aristoteles.cuci.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752308AbYGaSdS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jul 2008 14:33:18 -0400
Received: by aristoteles.cuci.nl (Postfix, from userid 500)
	id 4C7E75466; Thu, 31 Jul 2008 20:33:17 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <bd6139dc0807311113n50dda9f0t1aab46b724510de2@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90959>

Sverre Rabbelier wrote:
>If I clone the git mirror of our monotone repository, I find a
>checkout size of 148 MB after git-repack--running git-gc also
>increased the size by 2 MB, but I'll stick with the initial checkout
>size for fairness. If I multiply this by my 11 checkouts, I will have
>1628 MB. This is even more compelling for me, as I now save 728 MB of
>disk space with monotone."

You have at least two options to reduce diskspace:
a. Clone once from remote, then clone from that clone, it should
   hardlink the larger packfiles to the initial clone and therefore not
   cost you a lot.
b. Clone once from remote, and create 11 branches inside the new cloned
   repo.  Switch branches while doing development.

Most git users pick b.  It's easier to work with.  Having 11 unpacked
repos means that all the object files in those trees are almost up to
date, but it adds to the complexity of comparing changes and merging
changes between branches.  The compilation speed can be increased with
ccache if need be.
-- 
Sincerely,
           Stephen R. van den Berg.
"There are three types of people in this world: those who make things happen,
 those who watch things happen and those who wonder what happened."
