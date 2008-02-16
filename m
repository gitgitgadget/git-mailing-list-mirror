From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/6] Automatically close stderr pipes created by
 run_command
Date: Sat, 16 Feb 2008 00:25:30 -0800
Message-ID: <7vwsp5b951.fsf@gitster.siamese.dyndns.org>
References: <20080214062229.GB30516@spearce.org>
 <47B3F51C.3060002@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Sat Feb 16 09:28:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQIP9-0005fV-8F
	for gcvg-git-2@gmane.org; Sat, 16 Feb 2008 09:28:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751690AbYBPI0l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Feb 2008 03:26:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751737AbYBPI0l
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Feb 2008 03:26:41 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:49383 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751538AbYBPI0k (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Feb 2008 03:26:40 -0500
Received: from a-sasl-quonix.pobox.com (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 87861221D;
	Sat, 16 Feb 2008 03:26:38 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.pobox.com (Postfix) with ESMTP id
 B4127221C; Sat, 16 Feb 2008 03:26:27 -0500 (EST)
In-Reply-To: <47B3F51C.3060002@viscovery.net> (Johannes Sixt's message of
 "Thu, 14 Feb 2008 09:00:28 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74031>

Johannes Sixt <j.sixt@viscovery.net> writes:

> Shawn O. Pearce schrieb:
>> Like the out pipe and in pipe, we now automatically close the err
>> pipe if it was requested by the caller and it hasn't been closed
>> by the caller.  This simplifies anyone who wants to get a pipe to
>> the stderr stream for another process.
>
> IMHO, this is backwards.
>
> The .in, .out, .err members of struct child_process serve two different
> purposes:
> ...
> Notice that in a clean implementation:
> ...
> The current implementation of start_command/finish_command as well as its
> callers don't follow these rules (because they are not documented
> anywhere).

We should define what the clean semantics of this API should be,
and update Documentation/technical/api-run-command.txt, before
going any further.

And I happen to notice two of your names in the list of people
who have been involved in its evolution ;-).
