From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/6] "git commit --dry-run" updates
Date: Sat, 15 Aug 2009 03:06:37 -0700
Message-ID: <1250330803-22171-1-git-send-email-gitster@pobox.com>
Cc: Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 15 12:06:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1McGA1-0004wS-MK
	for gcvg-git-2@gmane.org; Sat, 15 Aug 2009 12:06:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751607AbZHOKGq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Aug 2009 06:06:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751386AbZHOKGp
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Aug 2009 06:06:45 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:39452 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751345AbZHOKGp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Aug 2009 06:06:45 -0400
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 30BEAB3E1;
	Sat, 15 Aug 2009 06:06:46 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BBD67B3E0; Sat, 15 Aug
 2009 06:06:44 -0400 (EDT)
X-Mailer: git-send-email 1.6.4.224.g3be84
X-Pobox-Relay-ID: 570CF26C-8983-11DE-8CBC-EAC21EFB4A78-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125989>

The first patch describes --dry-run option, and stops mentioning the
equivalence to "git status" in the documentation for "git commit".

The second one fixes "git commit --dry-run -v", which did not show the
diff text in color when asked with the configuration.

The third and the fourth ones tentatively introduce "git stat".  The
former is an incomplete implementation that ignores the pathspec, and the
latter adds pathspec limiting to it.  In the final form before it goes to
'next', these two should probably be squashed.

The fifth one introduces "git stat -s" (short output format) that is
designed to be machine readable, especially with -z (NUL termination).

The sixth one renames "git stat" to take over the traditional "git status"
and obviously is a 1.7.0 material.

The tests still have breakages that future updates to the sixth patch need
to fix.  t4030 still assumes "git status" is "git commit --dry-run" and
expects it to take "-v" to produce diffs, for example.
