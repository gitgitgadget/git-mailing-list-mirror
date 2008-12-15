From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] rebase -i -p: Fix --continue after a merge could not
 be redone
Date: Mon, 15 Dec 2008 02:16:05 -0800
Message-ID: <7v3agpyc9m.fsf@gitster.siamese.dyndns.org>
References: <1229012461-31377-1-git-send-email-j6t@kdbg.org>
 <1229335531-32707-1-git-send-email-j6t@kdbg.org>
 <1229335531-32707-2-git-send-email-j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Andreas Ericsson <ae@op5.se>,
	Stephen Haberman <stephen@exigencecorp.com>,
	git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Mon Dec 15 11:17:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LCAWP-0001NK-Dc
	for gcvg-git-2@gmane.org; Mon, 15 Dec 2008 11:17:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751972AbYLOKQQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Dec 2008 05:16:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752742AbYLOKQQ
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Dec 2008 05:16:16 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:36315 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752596AbYLOKQP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Dec 2008 05:16:15 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id A9C921A4E3;
	Mon, 15 Dec 2008 05:16:14 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 732491A4D7; Mon,
 15 Dec 2008 05:16:07 -0500 (EST)
In-Reply-To: <1229335531-32707-2-git-send-email-j6t@kdbg.org> (Johannes
 Sixt's message of "Mon, 15 Dec 2008 11:05:31 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 67850A50-CA91-11DD-852D-F83E113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103150>

Johannes Sixt <j6t@kdbg.org> writes:

> When a merge that has a conflict was rebased, then rebase stopped to let
> the user resolve the conflicts. However, thereafter --continue failed
> because the author-script was not saved. (This is rebase -i's way to
> preserve a commit's authorship.) This fixes it by doing taking the same
> failure route after a merge that is also taken after a normal cherry-pick.
>
> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
> ---
>  This is an attempt at fixing the failure.  I don't know whether it is
>  problematic to leave a "patch" behind if there was actually a merge.
>  Nevertheless, all rebase tests pass.

Interesting approach.  Dscho?
