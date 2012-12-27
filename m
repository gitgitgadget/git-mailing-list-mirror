From: Alex Vandiver <alex@chmrr.net>
Subject: Re: "fatal: git-write-tree: error building trees" from `git stash`
Date: Thu, 27 Dec 2012 13:55:56 -0500
Message-ID: <1356634556.13818.136.camel@umgah.localdomain>
References: <1356631626.13818.126.camel@umgah.localdomain>
	 <7vsj6rl456.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git discussion list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 27 19:56:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ToId1-0007qt-Ab
	for gcvg-git-2@plane.gmane.org; Thu, 27 Dec 2012 19:56:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752815Ab2L0S4H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Dec 2012 13:56:07 -0500
Received: from chmrr.net ([209.67.253.66]:33575 "EHLO utwig.chmrr.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752795Ab2L0S4H (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Dec 2012 13:56:07 -0500
Received: from 75-147-59-54-newengland.hfc.comcastbusiness.net ([75.147.59.54] helo=[10.1.10.64])
	by utwig.chmrr.net with esmtpsa (SSLv3:CAMELLIA256-SHA:256)
	(Exim 4.76)
	(envelope-from <alex@chmrr.net>)
	id 1ToIck-0000Os-2U; Thu, 27 Dec 2012 13:56:14 -0500
In-Reply-To: <7vsj6rl456.fsf@alter.siamese.dyndns.org>
X-Mailer: Evolution 2.32.2 
X-Authenticated-User: chmrr
X-Authenticator: plain
X-Sender-Verify: SUCCEEDED (sender exists & accepts mail)
X-Exim-Version: 4.76 (build at 25-May-2011 17:04:25)
X-Date: 2012-12-27 13:56:14
X-Connected-IP: 75.147.59.54:40646
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212211>

On Thu, 2012-12-27 at 10:51 -0800, Junio C Hamano wrote:
> > $ git stash
> > foo: needs merge
> > foo: needs merge
> > foo: unmerged (aeaa7e5e87cf309a7368d5d92a71c1f9e6a8c9e7)
> > foo: unmerged (a77fa514de2720c72c1a861de098595959a2c97a)
> > foo: unmerged (4a622d2b991f1a19ba7be313a46dc6f03692cd0a)
> > fatal: git-write-tree: error building trees
> > Cannot save the current index state
> 
> This is totally expected, isn't it?
> 
> You do not save state in the middle of a conflict with "git stash"
> (instead, you would "git stash" away your own work in progress
> before you start operation that may create and leave conflicts).

Apologies for not being clear.  While being unable to stash is not
unexpected, perhaps, "Cannot stash while resolving conflicts" or similar
would be more understandable to the end user than the above.
 - Alex
