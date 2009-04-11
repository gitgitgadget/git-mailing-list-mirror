From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Update delta compression message to be less misleading
Date: Sat, 11 Apr 2009 12:24:10 -0700
Message-ID: <7veivzdmed.fsf@gitster.siamese.dyndns.org>
References: <7v4owzr72g.fsf@gitster.siamese.dyndns.org>
 <1239291939-613-1-git-send-email-dpmcgee@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Dan McGee <dpmcgee@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 11 21:26:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lsiqe-0005Gm-Va
	for gcvg-git-2@gmane.org; Sat, 11 Apr 2009 21:26:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759012AbZDKTYU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Apr 2009 15:24:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758697AbZDKTYT
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Apr 2009 15:24:19 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:40269 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758821AbZDKTYT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Apr 2009 15:24:19 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 6CCC7EEA5;
	Sat, 11 Apr 2009 15:24:18 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id B75F0EEA4; Sat,
 11 Apr 2009 15:24:15 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 5A186E0E-26CE-11DE-8259-DC76898A30C1-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116331>

Dan McGee <dpmcgee@gmail.com> writes:

> Signed-off-by: Dan McGee <dpmcgee@gmail.com>

Empty log message?

I am scratching my head because this came as a reply to:

    ...
    > This I have absolutely no issue with.
    >
    > Acked-by: Nicolas Pitre <nico@cam.org>

    I do not have problem with the wording either, but then the commit log
    message needs to change, I think.  Care to re-submit?

and your original read quite nicely:

    Subject: [PATCH 2/2] pack-objects: report actual number of threads to be used
    Date: Sat,  4 Apr 2009 11:59:56 -0500
    Message-ID: <1238864396-8964-2-git-send-email-dpmcgee@gmail.com>

    In the case of a small repository, pack-objects is smart enough to not start
    more threads than necessary. However, the output to the user always reports
    the value of the pack.threads configuration and not the real number of
    threads to be used. This is easily fixed by moving the printing of the
    message after we have partitioned our work.

    (pack.threads is on autodetect and would be set to 4)
    $ git-repack -a -d -f
    Counting objects: 55, done.
    Delta compression using 2 threads.
    Compressing objects: 100% (48/48), done.
    Writing objects: 100% (55/55), done.
    Total 55 (delta 10), reused 0 (delta 0)

    Signed-off-by: Dan McGee <dpmcgee@gmail.com>

I was expecting to see something with a similar structure.  An updated
title, an introductory text and the problem description, and the
description of the solution.  Then "Acked-by:" you already received.

The new title looks correct, the problem description from the original
should still apply, but the solution is different, and that needs to
change.

I've committed it like this:

    Author: Dan McGee <dpmcgee@gmail.com>
    Date:   Thu Apr 9 10:45:39 2009 -0500

    Update delta compression message to be less misleading
    
    In the case of a small repository, pack-objects is smart enough to not
    start more threads than necessary. However, the output to the user always
    reports the value of the pack.threads configuration and not the real
    number of threads to be used.
    
    Signed-off-by: Dan McGee <dpmcgee@gmail.com>
    Acked-by: Nicolas Pitre <nico@cam.org>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>

Thanks.
