From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Teach remote machinery about remotes.default config variable
Date: Sun, 13 Jan 2008 20:42:45 -0800
Message-ID: <7vabn9m30a.fsf@gitster.siamese.dyndns.org>
References: <1200022189-2400-1-git-send-email-mlevedahl@gmail.com>
	<1200022189-2400-2-git-send-email-mlevedahl@gmail.com>
	<7v1w8o4ws0.fsf@gitster.siamese.dyndns.org>
	<30e4a070801111252s4e17b9c4m62adeb9032963e66@mail.gmail.com>
	<7v63xzzszp.fsf@gitster.siamese.dyndns.org>
	<478855B5.9070600@gmail.com>
	<7vbq7ry405.fsf@gitster.siamese.dyndns.org>
	<47885B2C.8020809@gmail.com>
	<7v7iify2wm.fsf@gitster.siamese.dyndns.org>
	<4788BFA8.2030508@gmail.com>
	<7vwsqeubj8.fsf@gitster.siamese.dyndns.org>
	<47891658.3090604@gmail.com>
	<alpine.LSU.1.00.0801122123430.8333@wbgn129.biozentrum.uni-wuerzburg.de>
	<47893F53.2070908@gmail.com>
	<alpine.LSU.1.00.0801132220200.8333@wbgn129.biozentrum.uni-wuerzburg.de>
	<478AD5A0.50900@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Mark Levedahl <mlevedahl@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 14 05:43:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JEHAe-0000YS-VA
	for gcvg-git-2@gmane.org; Mon, 14 Jan 2008 05:43:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751230AbYANEm5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jan 2008 23:42:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751200AbYANEm4
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Jan 2008 23:42:56 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:33364 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751222AbYANEm4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jan 2008 23:42:56 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 5F16A4FE4;
	Sun, 13 Jan 2008 23:42:52 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id D0DC94FE3;
	Sun, 13 Jan 2008 23:42:47 -0500 (EST)
In-Reply-To: <478AD5A0.50900@gmail.com> (Mark Levedahl's message of "Sun, 13
	Jan 2008 22:23:12 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70437>

Mark Levedahl <mlevedahl@gmail.com> writes:

> ... if what
> we need to fetch from is in fact not origin (even though the master
> project knows what server to access), submodule update in fact doesn't
> even work ...

This is an interesting point.

Perhaps git-submodule.sh::modules_update should use $url it
obtains from the configuration in the upper level when running
git-fetch in the submodule.

If you view the problem this way, your earlier "git fetch while
the HEAD is detached always uses 'origin'" may turn out to be a
non-issue.

Which again brings us back to Johannes's earlier point.  If the
issue is about submodule, maybe what needs to be fixes is in
git-submodule, and not the defaulting to 'origin' git-fetch and
friends do.
