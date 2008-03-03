From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-submodule: Fix typo 'url' which should be '$url'
Date: Sun, 02 Mar 2008 18:19:37 -0800
Message-ID: <7vy790k0qu.fsf@gitster.siamese.dyndns.org>
References: <1204509798-671-1-git-send-email-pkufranky@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, git@vger.kernel.org
To: Ping Yin <pkufranky@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 03 03:20:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JW0I3-00075r-PM
	for gcvg-git-2@gmane.org; Mon, 03 Mar 2008 03:20:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752432AbYCCCTy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Mar 2008 21:19:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752454AbYCCCTy
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Mar 2008 21:19:54 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:53082 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752388AbYCCCTx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Mar 2008 21:19:53 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 2088C1994;
	Sun,  2 Mar 2008 21:19:52 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 7A2081990; Sun,  2 Mar 2008 21:19:44 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75868>

Ping Yin <pkufranky@gmail.com> writes:

> More thinking, why does empty url mean uninitialized? How about the
> case that the submodule url is deleted from .git/config?

That means the user is not interested in that subproject.

In-tree .gitmodules is merely a place a user who is interested in a
partcular module described in it will pick up a _hint_ about attributes
(currently, URL but there may be others) on the module from, when showing
and recording his interest.

Notice I said "hint"; .gitmodules is _not_ meant as "default" in the sense
that "if the user does not have it in .git/config then read from it".

"Is it checked-out", would be a good indication of user's interest when
you talk about the current status (like "git submodule summary"), but if
you think about the case of switching between branches that has and does
not have a module, you would realize that "is it checked-out?" cannot be
the authoritative and only place to record the user's interest.
