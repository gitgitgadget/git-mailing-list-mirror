From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 6/7] include $PATH in generating list of commands for "help -a"
Date: Mon, 29 Oct 2007 14:17:26 -0700
Message-ID: <7vir4ptyc9.fsf@gitster.siamese.dyndns.org>
References: <1193474215-6728-6-git-send-email-srp@srparish.net>
	<1193628652-15647-1-git-send-email-srp@srparish.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Scott R Parish <srp@srparish.net>
X-From: git-owner@vger.kernel.org Mon Oct 29 22:17:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ImbzZ-0001Mr-PD
	for gcvg-git-2@gmane.org; Mon, 29 Oct 2007 22:17:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751790AbXJ2VRc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Oct 2007 17:17:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751773AbXJ2VRc
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Oct 2007 17:17:32 -0400
Received: from sceptre.pobox.com ([207.106.133.20]:53479 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751757AbXJ2VRc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Oct 2007 17:17:32 -0400
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id AEC872F2;
	Mon, 29 Oct 2007 17:17:52 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 4698A90137;
	Mon, 29 Oct 2007 17:17:50 -0400 (EDT)
In-Reply-To: <1193628652-15647-1-git-send-email-srp@srparish.net> (Scott
	R. Parish's message of "Sun, 28 Oct 2007 20:30:52 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62626>

Scott R Parish <srp@srparish.net> writes:

> Git had previously been using the $PATH for scripts--a previous
> patch moved exec'ed commands to also use the $PATH. For consistency
> "help -a" should also list commands in the $PATH.
>
> The main commands are still listed from the git_exec_path(), but
> the $PATH is walked and other git commands (probably extensions) are
> listed.
>
> Signed-off-by: Scott R Parish <srp@srparish.net>
> ---
>  help.c |  157 +++++++++++++++++++++++++++++++++++++++++++++++++---------------
>  1 files changed, 120 insertions(+), 37 deletions(-)

Thanks.

It's easier to read if you briefly describe the differences
between the replacement patch and the previous version of the
patch below the three-dash lines.  See for example Lars Knoll's
patch from today <200710290959.32538.lars@trolltech.com>.
