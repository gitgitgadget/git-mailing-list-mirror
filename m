From: Alex Vandiver <alex@chmrr.net>
Subject: Re: [PATCH] Allow --quiet option to git remote, particularly for `git remote update`
Date: Mon, 07 Dec 2009 01:15:05 -0500
Message-ID: <1260156352-sup-6170@utwig>
References: <1260057623-28960-1-git-send-email-alex@chmrr.net> <20091206145000.GC26440@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Dec 07 07:15:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NHWsP-0000Fq-IW
	for gcvg-git-2@lo.gmane.org; Mon, 07 Dec 2009 07:15:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753084AbZLGGPA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Dec 2009 01:15:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752519AbZLGGO7
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Dec 2009 01:14:59 -0500
Received: from chmrr.net ([209.67.253.66]:40932 "EHLO utwig.chmrr.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751634AbZLGGO6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Dec 2009 01:14:58 -0500
Received: from chmrr by utwig.chmrr.net with local (Exim 4.69)
	(envelope-from <chmrr@chmrr.net>)
	id 1NHWsD-0000k5-41; Mon, 07 Dec 2009 01:15:05 -0500
In-reply-to: <20091206145000.GC26440@coredump.intra.peff.net>
User-Agent: Sup/git
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134714>

At Sun Dec 06 09:50:00 -0500 2009, Jeff King wrote:
> Should --quiet also affect this "Updating %s" line?

Looking at it more closely, I think this patch should -- but for
reasons unrelated o your argument below.  The "Updating %s" line there
is in fetch_remote, which is _only_ called during `git remote add -f`.
It stands in for the "Fetching %s" line which `git fetch` (and `git
remote update`) outputs, which (after this patch), _is_ controlled by
--quiet.

Thus I feel like "Updating %s" should change to "Fetching %s" for both
consistency and explicitness, and should also be controlled by
--quiet.  The --quiet-remote option is an entirely different bikeshed,
which I don't have a strong opinion on, offhand.

 - Alex
-- 
Networking -- only one letter away from not working
