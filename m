From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] Introduce --dirty option to git-rebase, allowing you to start from a dirty state.
Date: Thu, 01 Nov 2007 15:30:33 -0700
Message-ID: <7vmytx8upi.fsf@gitster.siamese.dyndns.org>
References: <1193952624-608-1-git-send-email-Simon.Sasburg@gmail.com>
	<1193952624-608-2-git-send-email-Simon.Sasburg@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, git@vger.kernel.org
To: Simon Sasburg <simon.sasburg@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 01 23:30:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IniYz-0001F2-8s
	for gcvg-git-2@gmane.org; Thu, 01 Nov 2007 23:30:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754633AbXKAWam (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Nov 2007 18:30:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752771AbXKAWam
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Nov 2007 18:30:42 -0400
Received: from sceptre.pobox.com ([207.106.133.20]:48136 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752611AbXKAWal (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Nov 2007 18:30:41 -0400
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 870882F2;
	Thu,  1 Nov 2007 18:31:02 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id B846E912E0;
	Thu,  1 Nov 2007 18:30:58 -0400 (EDT)
In-Reply-To: <1193952624-608-2-git-send-email-Simon.Sasburg@gmail.com> (Simon
	Sasburg's message of "Thu, 1 Nov 2007 22:30:22 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63025>

Doesn't this have the exact same problem with the one in 'next'
that uses "git-stash create", which Shawn said he was upset
about, and I said I will revert?

FYI, this is what I wrote in the log for the revert.

commit 0f49327c9755b6575b447f79b540749d231cb26d
Author: Junio C Hamano <gitster@pobox.com>
Date:   Thu Nov 1 13:46:20 2007 -0700

    Revert "rebase: allow starting from a dirty tree."
    
    This reverts commit 6c9ad166dbbf9e5a0c09450b892151dbec49b8dc.
    Allowing rebase to start in a dirty tree might have been a worthy
    goal, but it is not necessarily always wanted (some people prefer
    to be reminded that the state is dirty, and think about the next
    action that may not be to stash and proceed).  Furthermore, depending
    on the nature of local changes, unstashing the dirty state on top of
    the rebased result is not always desirable.
    
    Signed-off-by: Junio C Hamano <gitster@pobox.com>
