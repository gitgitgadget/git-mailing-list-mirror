From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] interpret_nth_last_branch(): avoid traversing the
 reflogs twice
Date: Tue, 20 Jan 2009 00:35:53 -0800
Message-ID: <7v4ozul6hi.fsf@gitster.siamese.dyndns.org>
References: <7v8wpcs38c.fsf@gitster.siamese.dyndns.org>
 <1232163011-20088-1-git-send-email-trast@student.ethz.ch>
 <alpine.DEB.1.00.0901170646560.3586@pacific.mpi-cbg.de>
 <200901171438.22504.trast@student.ethz.ch>
 <alpine.DEB.1.00.0901171602340.3586@pacific.mpi-cbg.de>
 <7vljt97nld.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0901172028470.3586@pacific.mpi-cbg.de>
 <7vmydp5tqj.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0901180201070.3586@pacific.mpi-cbg.de>
 <7vprilyt1w.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0901182152010.3586@pacific.mpi-cbg.de>
 <7vprijra52.fsf@gitster.siamese.dyndns.org>
 <7vljt7r9mq.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0901191331590.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org,
	Johannes Sixt <johannes.sixt@telecom.at>,
	Johan Herland <johan@herland.net>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jan 20 09:37:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPC7K-00085M-6P
	for gcvg-git-2@gmane.org; Tue, 20 Jan 2009 09:37:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759275AbZATIgH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Jan 2009 03:36:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754616AbZATIgG
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Jan 2009 03:36:06 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:56058 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754440AbZATIgE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jan 2009 03:36:04 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 8ECF21CD1E;
	Tue, 20 Jan 2009 03:36:02 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 3681C1C8F9; Tue,
 20 Jan 2009 03:35:54 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 5EE4C5C2-E6CD-11DD-BABC-BE78113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106456>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> This, together with a removal of the hard-coded limit of 16 could be 
> squashed with this patch:

Yeah, I think that makes very much sense, not because 16 is too small, but
because it does not make sense to keep track of all 16 when you asked for
the last (or the second from the last) event.

Thanks for a free sanity ;-)
