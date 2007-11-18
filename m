From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fetch-pack: Prepare for a side-band demultiplexer in a thread.
Date: Sat, 17 Nov 2007 16:42:11 -0800
Message-ID: <7vtznkz8nw.fsf@gitster.siamese.dyndns.org>
References: <200711172309.28364.johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Sun Nov 18 01:42:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ItYF7-0003oc-VX
	for gcvg-git-2@gmane.org; Sun, 18 Nov 2007 01:42:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753054AbXKRAmR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Nov 2007 19:42:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753298AbXKRAmQ
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Nov 2007 19:42:16 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:52265 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752278AbXKRAmQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Nov 2007 19:42:16 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 8ADB32EF;
	Sat, 17 Nov 2007 19:42:37 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 22FC996C2C;
	Sat, 17 Nov 2007 19:42:35 -0500 (EST)
In-Reply-To: <200711172309.28364.johannes.sixt@telecom.at> (Johannes Sixt's
	message of "Sat, 17 Nov 2007 23:09:28 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65327>

Johannes Sixt <johannes.sixt@telecom.at> writes:

> 	This change again originates from the MinGW port. Since we don't
> 	have fork(2) on Windows, we must run the sideband demultiplexer
> 	in a thread.

If the rationale was "running in a thread is more natural on the
platform", I would understand it.

But "_must_ run because there is no fork(2)" solicits a "Huh?
How does Cygwin does it then?" from me.
