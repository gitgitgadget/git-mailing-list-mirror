From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Make git revert warn the user when reverting a merge
 commit.
Date: Sun, 21 Dec 2008 12:23:17 -0800
Message-ID: <7vwsdtmg5m.fsf@gitster.siamese.dyndns.org>
References: <200812182039.15169.bss@iguanasuicide.net>
 <200812202111.17831.bss@iguanasuicide.net>
 <200812211109.36788.robin.rosenberg.lists@dewire.com>
 <200812211359.31991.bss@iguanasuicide.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	git@vger.kernel.org
To: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>
X-From: git-owner@vger.kernel.org Sun Dec 21 21:24:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LEUr1-0001p1-1Y
	for gcvg-git-2@gmane.org; Sun, 21 Dec 2008 21:24:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751050AbYLUUX1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Dec 2008 15:23:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751090AbYLUUX0
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Dec 2008 15:23:26 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:50422 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751022AbYLUUX0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Dec 2008 15:23:26 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 9B3311ACE7;
	Sun, 21 Dec 2008 15:23:25 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 212B61ABF4; Sun,
 21 Dec 2008 15:23:20 -0500 (EST)
In-Reply-To: <200812211359.31991.bss@iguanasuicide.net> (Boyd Stephen Smith,
 Jr.'s message of "Sun, 21 Dec 2008 13:59:14 -0600")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 38880368-CF9D-11DD-B3F6-F83E113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103709>

"Boyd Stephen Smith Jr." <bss@iguanasuicide.net> writes:

> Then why not have "-m 1" be assumed instead of forcing the user to specify it?  

The reason we don't is because until very recently we did not even allow
you to revert a merge relative to any parent.  We wanted to avoid
surprising people who are _relying on_ that behaviour to make sure that
they do not revert a merge by accident.

We could certainly do what you suggest to imply "-m 1" when the commit
requested to be reverted happens to be a merge, but we shouldn't be doing
that without thinking things through.  It will break people's longstanding
expectations.
