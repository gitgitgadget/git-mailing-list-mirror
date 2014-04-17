From: Andreas Schwab <schwab@suse.de>
Subject: Re: [PATCH] tag: add -i and --introduced modifier for --contains
Date: Thu, 17 Apr 2014 19:30:21 +0200
Message-ID: <87zjjj50eq.fsf@igel.home>
References: <1397681938-18594-1-git-send-email-mcgrof@do-not-panic.com>
	<xmqqppkhexw3.fsf@gitster.dls.corp.google.com>
	<mvm8ur42zn6.fsf@hawking.suse.de>
	<xmqq8ur3ga2y.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>, git@vger.kernel.org,
	"Luis R. Rodriguez" <mcgrof@suse.com>, Jiri Slaby <jslaby@suse.cz>,
	Jan Kara <jack@suse.cz>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 17 19:30:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Waq8s-0007q8-NO
	for gcvg-git-2@plane.gmane.org; Thu, 17 Apr 2014 19:30:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751030AbaDQRaZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Apr 2014 13:30:25 -0400
Received: from cantor2.suse.de ([195.135.220.15]:33664 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751213AbaDQRaX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Apr 2014 13:30:23 -0400
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id 147F0AC15;
	Thu, 17 Apr 2014 17:30:21 +0000 (UTC)
X-Yow: ..  he dominates the DECADENT SUBWAY SCENE.
In-Reply-To: <xmqq8ur3ga2y.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Thu, 17 Apr 2014 10:05:57 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246426>

Junio C Hamano <gitster@pobox.com> writes:

> I also think this illustrates my earlier point. Depending on the
> project and the expectation of the users, which tags are good
> candidates as anchor points differ.  Your example using --match
> probably shows a good direction to go in---somehow tell Git which
> tags to base the description on, to reject names that the users do
> not want.

I've used --match only to force git describe to find a better match.

> When your project does not mind basing the description on rc tags,
> between v3.4-rc1~192^2~9^2 and v3.5-rc1~120^3~76^2, I am not sure if
> we would want to say that "the former is not so longer than the
> latter, so use that", or what kind of heuristics to employ to reach
> that conclusion.  Date-based selection (i.e. earliest first) is one
> possibility.  Tagname-based selection has the issue of having to
> configure "whose version numbering convention would you use when
> sorting tags, and how you would tell Git that sorting order rule?"

IMHO git should select based on topology: the first tag that isn't
contained in any other tag still containing the commit in question, only
when ambigous it needs to fall back to other criteria.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
