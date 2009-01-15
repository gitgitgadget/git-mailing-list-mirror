From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH] Make the rebase edit mode really end up in an edit
 state
Date: Wed, 14 Jan 2009 22:13:10 -0800
Message-ID: <7v1vv5w0zt.fsf@gitster.siamese.dyndns.org>
References: <87ab9th0rh.fsf@cup.kalibalik.dk>
 <7vfxjlxuu5.fsf@gitster.siamese.dyndns.org>
 <200901142049.54775.bss@iguanasuicide.net>
 <buo8wpdfbv9.fsf@dhapc248.dev.necel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>,
	Anders Melchiorsen <mail@cup.kalibalik.dk>,
	git@vger.kernel.org, Johannes.Schindelin@gmx.de
To: Miles Bader <miles@gnu.org>
X-From: git-owner@vger.kernel.org Thu Jan 15 07:14:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNLVC-0005uM-D7
	for gcvg-git-2@gmane.org; Thu, 15 Jan 2009 07:14:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758126AbZAOGNW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jan 2009 01:13:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757752AbZAOGNW
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Jan 2009 01:13:22 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:61361 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757139AbZAOGNV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jan 2009 01:13:21 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 83AD48F214;
	Thu, 15 Jan 2009 01:13:19 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id F2C338F20F; Thu,
 15 Jan 2009 01:13:12 -0500 (EST)
In-Reply-To: <buo8wpdfbv9.fsf@dhapc248.dev.necel.com> (Miles Bader's message
 of "Thu, 15 Jan 2009 13:10:18 +0900")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 9ADAF926-E2CB-11DD-8764-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105768>

Miles Bader <miles@gnu.org> writes:

> [I do wonder how on earth the current awkward behavior was accepted in
> the first place...]

That's actually very easy to explain.  Both the contributor and the
maintainer were rather familiar with the workflow using tools before
"rebase -i" appeared, and to them, editing an existing commit was
equivalent to first plant yourself on the commit to be amended, issue
"commit --amend", and continue on with other tasks (similarly, "picking" an
existing commit is to cherry-pick the commit to the state whatever the
previous sequence of commands left).  In other words, they both thought in
terms of the underlying command sequence and it did not appear unnatural
at all to them.
