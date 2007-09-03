From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitweb: Fix and simplify "split patch" detection
Date: Mon, 03 Sep 2007 04:00:49 -0700
Message-ID: <7vtzqcj9ni.fsf@gitster.siamese.dyndns.org>
References: <200709022218.43042.jnareb@gmail.com>
	<7vmyw4ob7z.fsf@gitster.siamese.dyndns.org>
	<200709031147.32910.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Yann Dirson <ydirson@altern.org>,
	Petr Baudis <pasky@suse.cz>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 03 13:01:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IS9gT-0000wh-KD
	for gcvg-git@gmane.org; Mon, 03 Sep 2007 13:01:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756758AbXICLA6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Sep 2007 07:00:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754902AbXICLA6
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Sep 2007 07:00:58 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:48626 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753894AbXICLA5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Sep 2007 07:00:57 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 4E98312D963;
	Mon,  3 Sep 2007 07:01:15 -0400 (EDT)
In-Reply-To: <200709031147.32910.jnareb@gmail.com> (Jakub Narebski's message
	of "Mon, 3 Sep 2007 11:47:32 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57466>

Jakub Narebski <jnareb@gmail.com> writes:

> I wonder if the post-image name is unique in raw format of diff
> output, and can be used alone to check if there are two patches
> per one raw output format line...

I think that is a very sane assumption.

You may have a situation that a single preimage is used to
produce more than one postimage, but it does not make sense to
say this postimage is produced by doing this to that preimage
and there is another way to produce the same postimage using
something else.

At least, I do not think the diffcore chain is _capable_ of
coming up with such alternatives even if it wanted to ;-).
