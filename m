From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] t3400-rebase: Move detached HEAD check earlier
Date: Mon, 02 Mar 2009 00:03:19 -0800
Message-ID: <7vmyc45p2w.fsf@gitster.siamese.dyndns.org>
References: <1235902803-32528-1-git-send-email-j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Mon Mar 02 09:04:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Le38y-0003MO-AU
	for gcvg-git-2@gmane.org; Mon, 02 Mar 2009 09:04:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755676AbZCBID2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Mar 2009 03:03:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755631AbZCBID2
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Mar 2009 03:03:28 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:57218 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755575AbZCBID1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Mar 2009 03:03:27 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id B74782D3E;
	Mon,  2 Mar 2009 03:03:25 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 2D67E2D3D; Mon, 
 2 Mar 2009 03:03:21 -0500 (EST)
In-Reply-To: <1235902803-32528-1-git-send-email-j6t@kdbg.org> (Johannes
 Sixt's message of "Sun, 1 Mar 2009 11:20:03 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 9B77DD82-0700-11DE-BB6D-CBE7E3B37BAC-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111914>

Johannes Sixt <j6t@kdbg.org> writes:

> Long story: The test that preceded the one in question tests that a
> rebased commit degrades from a content change with mode change to a
> mere mode change.  But on Windows, where we have core.filemode=false,
> the original commit did not record the mode change, and so the rebase
> operation did not rebase anything.  This caused the subsequent detached
> HEAD test to fail.

Thanks.

I'll apply it as is since it is very close to the real release, but I
think a more suitable fix would be to make tests less dependent on the
outcome of earlier tests.
