From: Bill Lear <rael@zopyra.com>
Subject: Re: git pull failure, truncated object
Date: Tue, 8 May 2007 10:46:40 -0500
Message-ID: <17984.39776.771508.873437@lisa.zopyra.com>
References: <17984.35097.568689.482933@lisa.zopyra.com>
	<alpine.LFD.0.99.0705081140000.24220@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Tue May 08 17:49:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HlRwf-0000Iz-79
	for gcvg-git@gmane.org; Tue, 08 May 2007 17:49:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968342AbXEHPrJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 8 May 2007 11:47:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968344AbXEHPrI
	(ORCPT <rfc822;git-outgoing>); Tue, 8 May 2007 11:47:08 -0400
Received: from mail.zopyra.com ([65.68.225.25]:61548 "EHLO zopyra.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S968342AbXEHPrF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 May 2007 11:47:05 -0400
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id l48Fkjq06580;
	Tue, 8 May 2007 10:46:45 -0500
In-Reply-To: <alpine.LFD.0.99.0705081140000.24220@xanadu.home>
X-Mailer: VM 7.18 under Emacs 21.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46595>

On Tuesday, May 8, 2007 at 11:41:14 (-0400) Nicolas Pitre writes:
>On Tue, 8 May 2007, Bill Lear wrote:
>
>> He did a git-gc, twice, and retried.  Still failed.
>> 
>> So, he called me in and we tried to see if the server was acting up
>> --- perhaps an NFS problem, as we've had those before, but got very
>> different error messages.  Watched the log file from git-daemon, and
>> saw nothing.  Finally we took a look at the local repos
>> .git/objects/4b, and 4b93eb81265ea4f2b436618a4b1c3bea2bedf06d was of
>> length 0.
>> 
>> So, I looked in the man page of git-gc and thought to try --prune,
>> as this was not an active repository.  This worked, and then
>> the pull did as well.
>> 
>> I'm wondering why git-gc did not at least warn us of this problem when
>> we tried it.  It appeared to us that git-gc gave our repo a clean bill
>> of health, and so we turned our attention to the remote and
>> investigated there, instead of continuing in the local repo.
>
>git-gc != git-fsck.

Indeed, as is now clear to me.  Would it be prudent to have git-gc
run a quick git-fsck internally and warn if things are not in a kosher
state?


Bill
