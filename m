From: Neil Horman <nhorman@tuxdriver.com>
Subject: Re: [PATCH] add test case for rebase of empty commit
Date: Tue, 3 Jul 2012 14:20:00 -0400
Message-ID: <20120703182000.GB10864@hmsreliant.think-freely.org>
References: <1340814121-23813-1-git-send-email-martin.von.zweigbergk@gmail.com>
 <7vr4t079jp.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 03 20:20:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sm7iD-0006Bm-MY
	for gcvg-git-2@plane.gmane.org; Tue, 03 Jul 2012 20:20:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932326Ab2GCSU3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jul 2012 14:20:29 -0400
Received: from charlotte.tuxdriver.com ([70.61.120.58]:40286 "EHLO
	smtp.tuxdriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932104Ab2GCSU2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jul 2012 14:20:28 -0400
Received: from hmsreliant.think-freely.org ([2001:470:8:a08:7aac:c0ff:fec2:933b] helo=localhost)
	by smtp.tuxdriver.com with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.63)
	(envelope-from <nhorman@tuxdriver.com>)
	id 1Sm7hi-00086S-W1; Tue, 03 Jul 2012 14:20:19 -0400
Content-Disposition: inline
In-Reply-To: <7vr4t079jp.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Score: -2.9 (--)
X-Spam-Status: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200927>

On Wed, Jun 27, 2012 at 02:02:34PM -0700, Junio C Hamano wrote:
> Thanks.
> 
> We recently had a topic to add an option to allow rebase to carry
> empty commits forward, but I notice that it only had tests for the
> component cherry-pick to keep empty or redundant commits, so it may
> not be a bad idea to add tests for that series to the same t3401
> after this commit (Neil Horman CC'ed).
> 
> 
So, I've been thinking about this some, and I'm a bit stuck on it.  Reading the
test description for t3401, I see that we're testing gits ability to detect
patches merged upstream when doing a rebase.  That said, how are we supposed to
differentiate between upstream empty patches that have been cherry-picked or
merged, and local branch empty changes that haven't.  As humans we can see that
the changelog might be the same, but git has no way to detect that, and if
--allow-empty is specified will just apply any empty patch it finds between the
two branches merge base and the topic branch head.  Does anyone have an idea as
to how we should detect such duplication?

Neil
