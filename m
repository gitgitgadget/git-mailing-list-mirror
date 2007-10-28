From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 6/7] include $PATH in generating list of commands for "help -a"
Date: Sun, 28 Oct 2007 04:32:12 -0700
Message-ID: <7vk5p7v5j7.fsf@gitster.siamese.dyndns.org>
References: <1193474215-6728-6-git-send-email-srp@srparish.net>
	<1193570329-11656-1-git-send-email-srp@srparish.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Scott R Parish <srp@srparish.net>
X-From: git-owner@vger.kernel.org Sun Oct 28 12:32:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Im6Nb-00062G-1Q
	for gcvg-git-2@gmane.org; Sun, 28 Oct 2007 12:32:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751301AbXJ1LcS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Oct 2007 07:32:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751283AbXJ1LcS
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Oct 2007 07:32:18 -0400
Received: from sceptre.pobox.com ([207.106.133.20]:47857 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751251AbXJ1LcR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Oct 2007 07:32:17 -0400
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 55CF22F0;
	Sun, 28 Oct 2007 07:32:38 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 894938D302;
	Sun, 28 Oct 2007 07:32:35 -0400 (EDT)
In-Reply-To: <1193570329-11656-1-git-send-email-srp@srparish.net> (Scott
	R. Parish's message of "Sun, 28 Oct 2007 04:18:49 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62558>

Scott R Parish <srp@srparish.net> writes:

> +	while (1) {
> +		if ((colon = strchr(path, ':')))
> +			*colon = 0;
> +
> +		len = list_commands_in_dir(&other_cmds, path);
> +		longest = MAX(longest, len);

Where do we borrow this MAX() macro?

On Linux with glibc, /usr/include/sys/param.h which is included
by git-compat-util.h (meaning, for everybody) is where we find
it, but that somehow does not sound portable assumption.
