From: Junio C Hamano <gitster@pobox.com>
Subject: Re: gitk from subdirectory
Date: Thu, 30 Aug 2007 21:33:46 -0700
Message-ID: <7v642w5nmd.fsf@gitster.siamese.dyndns.org>
References: <7vabs85ntg.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Aug 31 06:33:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IQyCi-00088h-8r
	for gcvg-git@gmane.org; Fri, 31 Aug 2007 06:33:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752488AbXHaEdv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 31 Aug 2007 00:33:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758704AbXHaEdv
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Aug 2007 00:33:51 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:59373 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752488AbXHaEdu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Aug 2007 00:33:50 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 23D0312A216;
	Fri, 31 Aug 2007 00:34:10 -0400 (EDT)
In-Reply-To: <7vabs85ntg.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Thu, 30 Aug 2007 21:29:31 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57111>

Junio C Hamano <junkio@pobox.com> writes:

> Since commit cdaee5db165ba8bae8d3b524950e61666fc36a84 (gitk:
> Improve handling of -- and ambiguous arguments), running gitk
> from a subdirectory limits the displayed history with the ...

FYI, I picked up your wish in the kernel list and have been
experimenting with this 5-liner whenever I refer to a commit in
the past:

        #!/bin/sh
        for commit
        do
                git show -s --pretty=oneline "$commit"
        done |
        sed -e 's/^[^ ]* /&(/' -e 's/$/)/'
