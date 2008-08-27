From: Junio C Hamano <gitster@pobox.com>
Subject: Re: "failed to read delta base object at..."
Date: Wed, 27 Aug 2008 13:14:00 -0700
Message-ID: <7vy72inrlj.fsf@gitster.siamese.dyndns.org>
References: <20080825164602.GA2213@fieldses.org>
 <alpine.LFD.1.10.0808251153210.3363@nehalem.linux-foundation.org>
 <20080825213104.GI2213@fieldses.org>
 <alpine.LFD.1.10.0808251435540.3363@nehalem.linux-foundation.org>
 <20080825221321.GL2213@fieldses.org>
 <alpine.LFD.1.10.0808251616240.3363@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "J. Bruce Fields" <bfields@fieldses.org>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Aug 27 22:15:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYRQD-0003mj-Us
	for gcvg-git-2@gmane.org; Wed, 27 Aug 2008 22:15:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751964AbYH0UON (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2008 16:14:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751909AbYH0UON
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Aug 2008 16:14:13 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:65353 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751118AbYH0UOL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2008 16:14:11 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id C3E766A70B;
	Wed, 27 Aug 2008 16:14:10 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id C68136A702; Wed, 27 Aug 2008 16:14:06 -0400 (EDT)
In-Reply-To: <alpine.LFD.1.10.0808251616240.3363@nehalem.linux-foundation.org> (Linus
 Torvalds's message of "Mon, 25 Aug 2008 16:59:26 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: B5E86A34-7474-11DD-A270-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93939>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> And as far as I can tell, that's the _only_ corruption in the whole file, 
> but I didn't really double-check.

Just FYI, replacing these 3619 bytes in JBF's packfile with the good
object with

	dd conv=notrunc bs=1 seek=3025976 count=3619

makes the fixed pack pass verify-pack, so this part seems to be the only
corruption.
