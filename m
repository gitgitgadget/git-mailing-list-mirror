From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Use line buffering for standard output
Date: Sun, 03 Aug 2008 14:38:50 -0700
Message-ID: <7vhca193th.fsf@gitster.siamese.dyndns.org>
References: <1217798768-18021-1-git-send-email-mail@cup.kalibalik.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Anders Melchiorsen <mail@cup.kalibalik.dk>
X-From: git-owner@vger.kernel.org Sun Aug 03 23:40:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KPlJ6-00079L-0a
	for gcvg-git-2@gmane.org; Sun, 03 Aug 2008 23:40:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757051AbYHCVi4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Aug 2008 17:38:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756956AbYHCVi4
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Aug 2008 17:38:56 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:43457 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756512AbYHCVi4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Aug 2008 17:38:56 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 181CA49088;
	Sun,  3 Aug 2008 17:38:55 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 60ED749087; Sun,  3 Aug 2008 17:38:52 -0400 (EDT)
In-Reply-To: <1217798768-18021-1-git-send-email-mail@cup.kalibalik.dk>
 (Anders Melchiorsen's message of "Sun, 3 Aug 2008 23:26:08 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 9275D6A0-61A4-11DD-97E7-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91277>

Anders Melchiorsen <mail@cup.kalibalik.dk> writes:

> Normally, stdout is fully buffered, unless it refers to a terminal
> device. This gives problems when fork() is in play: the buffer is
> cloned and output appears twice.

I thought we have been careful to flush() them before we fork but perhaps
there are recent changes that were not careful.  Wouldn't it be better to
fix them first, independent of this change?
