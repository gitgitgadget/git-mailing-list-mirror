From: Bryan Donlan <bdonlan@fushizen.net>
Subject: Re: [PATCH v2 01/10] git-rebase.sh: Fix --merge --abort failures
	when path contains whitespace
Date: Thu, 10 Apr 2008 04:48:20 -0400
Message-ID: <20080410084820.GA1904@shion.is.fushizen.net>
References: <cover.1207702130.git.bdonlan@fushizen.net> <1207810216-27871-1-git-send-email-bdonlan@fushizen.net> <1207810216-27871-2-git-send-email-bdonlan@fushizen.net> <7vr6dexids.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Johannes Sixt <j.sixt@viscovery.net>,
	Adam Roben <aroben@apple.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 10 10:49:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JjsTG-00023U-If
	for gcvg-git-2@gmane.org; Thu, 10 Apr 2008 10:49:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754696AbYDJIsZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Apr 2008 04:48:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754799AbYDJIsZ
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Apr 2008 04:48:25 -0400
Received: from satoko.is.fushizen.net ([64.71.152.231]:38226 "EHLO
	satoko.is.fushizen.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754756AbYDJIsY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Apr 2008 04:48:24 -0400
Received: from [130.111.236.232] (helo=shion)
	by satoko.is.fushizen.net with esmtpa (Exim 4.69)
	(envelope-from <bdonlan@fushizen.net>)
	id 1JjsSE-0004MY-Bc; Thu, 10 Apr 2008 08:48:22 +0000
Received: from bd by shion with local (Exim 4.69)
	(envelope-from <bdonlan@fushizen.net>)
	id 1JjsSC-0000Wo-4Q; Thu, 10 Apr 2008 04:48:20 -0400
Content-Disposition: inline
In-Reply-To: <7vr6dexids.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79198>

On Thu, Apr 10, 2008 at 12:45:51AM -0700, Junio C Hamano wrote:
> Bryan Donlan <bdonlan@fushizen.net> writes:
[snip]
> > +	test_expect_success "rebase$type --abort" "
> > +		cd \"\$work_dir\" &&
> >  		# Clean up the state from the previous one
> > +		git reset --hard pre-rebase &&
> > +		test_must_fail git rebase$type master &&
> > +		test -d \"\$dotest\" &&
> > ...
> 
> this part would become a lot easier to read if you just stayed inside the
> original single quoted test script without introducing excessive
> backslashes.

Oh, wow, what was I thinking? I'll fix that up... it must've been rather
late at night when I wrote that or something :)

Also, I saw your note about changing the git-svn tests to single-quoting
rather than escaping everywhere - but only after I hit send. I'll roll
that into the v3 (and probably wait longer than this time, so people
have time to finish reviewing...)

Thanks,

Bryan
