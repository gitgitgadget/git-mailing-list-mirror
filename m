From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] interpret_nth_last_branch(): avoid traversing the
 reflogs twice
Date: Sat, 17 Jan 2009 16:43:32 -0800
Message-ID: <7vmydp5tqj.fsf@gitster.siamese.dyndns.org>
References: <7v8wpcs38c.fsf@gitster.siamese.dyndns.org>
 <1232163011-20088-1-git-send-email-trast@student.ethz.ch>
 <alpine.DEB.1.00.0901170646560.3586@pacific.mpi-cbg.de>
 <200901171438.22504.trast@student.ethz.ch>
 <alpine.DEB.1.00.0901171602340.3586@pacific.mpi-cbg.de>
 <7vljt97nld.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0901172028470.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org,
	Johannes Sixt <johannes.sixt@telecom.at>,
	Johan Herland <johan@herland.net>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jan 18 01:45:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOLmq-0006GW-3N
	for gcvg-git-2@gmane.org; Sun, 18 Jan 2009 01:45:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755911AbZARAnm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Jan 2009 19:43:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753664AbZARAnm
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Jan 2009 19:43:42 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:45289 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753534AbZARAnl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Jan 2009 19:43:41 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 1E5EE9120D;
	Sat, 17 Jan 2009 19:43:40 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 1B55E9120C; Sat,
 17 Jan 2009 19:43:33 -0500 (EST)
In-Reply-To: <alpine.DEB.1.00.0901172028470.3586@pacific.mpi-cbg.de>
 (Johannes Schindelin's message of "Sat, 17 Jan 2009 20:29:40 +0100 (CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 0CA52552-E4F9-11DD-8A54-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106118>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> That is correct.  But this is such a highly uncritical code path that I'd 
> like to keep this simple rather than fast.

I actually not worried about "fast" at all; it was more about unbounded
memory consumption.
