From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/4] Add more tests of cvsimport
Date: Sun, 22 Feb 2009 08:48:54 -0800
Message-ID: <7vhc2m2z9l.fsf@gitster.siamese.dyndns.org>
References: <1235221480-31473-1-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
	Johannes.Schindelin@gmx.de, jnareb@gmail.com
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Sun Feb 22 17:50:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbHXL-0004ky-M9
	for gcvg-git-2@gmane.org; Sun, 22 Feb 2009 17:50:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754058AbZBVQtJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Feb 2009 11:49:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754049AbZBVQtH
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Feb 2009 11:49:07 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:61742 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754007AbZBVQtE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Feb 2009 11:49:04 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 0C7652BB1F;
	Sun, 22 Feb 2009 11:49:04 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 05FF72BB1A; Sun,
 22 Feb 2009 11:48:56 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: B6733C04-0100-11DE-A78B-6F7C8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111014>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> Thanks for all the feedback.  I think I have incorporated it all:
>
> - Renamed the library from t/t96xx/cvs-lib.sh to t/lib-cvs.sh.
>
> - Added t/t9601/cvsroot/.gitattributes to avoid whitespace warnings.
>
> - Fixed the "cvs co" command for when checking out a branch/tag.
>
> - Implemented a recursive diff in test_cmp_branch_tree rather than
>   relying on GNU diff features.  It is only a dozen lines of code, but
>   please review this carefully as I'm not such a shell jockey.

Thanks.

>   ....  It would also have the disadvantage of
>   making "git cvsimport" tests fail if there are bugs in "git diff".

This is very true and for the same reason we tend to avoid using it
(especially "git diff --no-index").  The tests are not making sure nobody
has broken "git diff" after all.
