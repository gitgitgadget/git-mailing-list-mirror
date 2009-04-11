From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git diff after merge (with conflict)
Date: Fri, 10 Apr 2009 17:47:33 -0700
Message-ID: <7vvdpcnhi2.fsf@gitster.siamese.dyndns.org>
References: <324.1239298063@relay.known.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: layer <layer@known.net>
X-From: git-owner@vger.kernel.org Sat Apr 11 02:49:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LsRPx-0006Uo-G7
	for gcvg-git-2@gmane.org; Sat, 11 Apr 2009 02:49:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753523AbZDKArm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Apr 2009 20:47:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753394AbZDKArk
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Apr 2009 20:47:40 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:41548 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753210AbZDKArk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Apr 2009 20:47:40 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 7A56FD359;
	Fri, 10 Apr 2009 20:47:37 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id E7004D358; Fri,
 10 Apr 2009 20:47:34 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 5A6B9AC6-2632-11DE-9686-DC76898A30C1-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116283>

layer <layer@known.net> writes:

> Is there some way to get regular unified diff behavior instead of the
> combined diff?  For certain files (like ChangeLog's) the combined diff
> format after a merge is *very* confusing.

If you mean the resolution preview (that is you said "after merge with
conflict", but what you meant was really "during a merge with conflict, I
haven't recorded the final resolution with git-add yet"), I often find
these two useful:

	What change does the other branch brought to my tree anyway?
	$ git diff HEAD -- that-file

	What did we do to the other branch?
	$ git diff MERGE_HEAD -- that-file
