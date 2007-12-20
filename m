From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-commit: add --verbatim to allow unstripped commit messages
Date: Thu, 20 Dec 2007 15:50:04 -0800
Message-ID: <7vlk7plydv.fsf@gitster.siamese.dyndns.org>
References: <20071220211835.GA3052@steel.home>
	<alpine.LFD.0.9999.0712201324270.21557@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Dec 21 00:50:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J5VA5-0002J4-6s
	for gcvg-git-2@gmane.org; Fri, 21 Dec 2007 00:50:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758035AbXLTXuT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Dec 2007 18:50:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757835AbXLTXuS
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Dec 2007 18:50:18 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:54414 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757446AbXLTXuR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Dec 2007 18:50:17 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 78A823474;
	Thu, 20 Dec 2007 18:50:15 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id E83E03470;
	Thu, 20 Dec 2007 18:50:10 -0500 (EST)
In-Reply-To: <alpine.LFD.0.9999.0712201324270.21557@woody.linux-foundation.org>
	(Linus Torvalds's message of "Thu, 20 Dec 2007 13:40:13 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69029>

I said in the log message when applying your version:

    We even stripped "#" lines from messages given this way:

        git commit -m "# Message starting with a hash-mark"

    which was argurably a bug.

But I wonder if people are using a workflow like this:

	$ cp $company_template my_message
        $ edit my_message
        $ git commit -F my_message

To them, this change is a regression, as $company_template may have had
insn like "# Here you describe your changes..." and the workflow relied
on the current behaviour of stripping them.
