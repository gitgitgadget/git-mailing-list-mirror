From: Stephen Haberman <stephen@exigencecorp.com>
Subject: Re: Git with Hudson
Date: Thu, 18 Dec 2008 16:07:34 -0600
Organization: Exigence
Message-ID: <20081218160734.b1992eb8.stephen@exigencecorp.com>
References: <D2F0F023-862A-4BAB-88B9-BFEFC5592D10@strakersoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Indy Nagpal <indy@strakersoftware.com>
X-From: git-owner@vger.kernel.org Thu Dec 18 23:09:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LDR3N-00048s-J0
	for gcvg-git-2@gmane.org; Thu, 18 Dec 2008 23:09:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752547AbYLRWHt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Dec 2008 17:07:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752415AbYLRWHt
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Dec 2008 17:07:49 -0500
Received: from smtp152.sat.emailsrvr.com ([66.216.121.152]:39881 "EHLO
	smtp152.sat.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751801AbYLRWHs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Dec 2008 17:07:48 -0500
Received: from relay5.relay.sat.mlsrvr.com (localhost [127.0.0.1])
	by relay5.relay.sat.mlsrvr.com (SMTP Server) with ESMTP id ABD55DABD8;
	Thu, 18 Dec 2008 17:07:44 -0500 (EST)
Received: by relay5.relay.sat.mlsrvr.com (Authenticated sender: stephen-AT-exigencecorp.com) with ESMTPSA id DA9A5DB510;
	Thu, 18 Dec 2008 17:07:43 -0500 (EST)
In-Reply-To: <D2F0F023-862A-4BAB-88B9-BFEFC5592D10@strakersoftware.com>
X-Mailer: Sylpheed 2.5.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103500>


> However, before we do that I wanted to check if anyone has had any
> experience/feedback in integrating Git with Hudson CI server?

We tried using the Hudson git plugin that you can download from the
Hudson site and ended up with problems--whether we had too many branches
or something, the plugin has some funny "figure out what needs to be
built" logic that issued near-constant git rev-list commands. To the
point where our own "git fetch" calls would get starved for 20-30
seconds.

We eventually wrote our own Hudson git plugin that is simpler and
doesn't do any funny rev-listing/walking. It just stores last hash
built and rebuilds once that doesn't match the branch tip. Once that
was in place, it worked great.

I've got permission to publish it if you're interested--just haven't
yet.

- Stephen
