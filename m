From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Refactoring git-rebase.sh and git-rebase--interactive.sh
Date: Tue, 02 Nov 2010 13:46:19 +0100
Message-ID: <4CD0081B.5080405@viscovery.net>
References: <AANLkTimeWDbJPor9PnKgW5sD7DLjqrm-vTzEtnARvP3M@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Johannes.Schindelin@gmx.de,
	christian.couder@gmail.com, trast@student.ethz.ch
To: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 02 13:46:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PDGFw-0002oW-Iw
	for gcvg-git-2@lo.gmane.org; Tue, 02 Nov 2010 13:46:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752140Ab0KBMqY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Nov 2010 08:46:24 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:18994 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751822Ab0KBMqX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Nov 2010 08:46:23 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1PDGFo-0004PZ-9L; Tue, 02 Nov 2010 13:46:20 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 07FD91660F;
	Tue,  2 Nov 2010 13:46:19 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.12) Gecko/20101027 Thunderbird/3.1.6
In-Reply-To: <AANLkTimeWDbJPor9PnKgW5sD7DLjqrm-vTzEtnARvP3M@mail.gmail.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160518>

Am 11/2/2010 13:33, schrieb Martin von Zweigbergk:
> There are currently quite some
> functional differences between 'git rebase' and 'git rebase -i' (not
> just the obvious one).

Differences in the option handling is my favorite gripe with git-rebase,
too. I suggest to write a command line processor, git-rebase.sh, that sets
shell variables from options that it collects from various sources, then
dispatches to one of git-rebase--interactive.sh, git-rebase--merge.sh, or
git-rebase--am.sh (the latter two would be stripped-down copies of the
current git-rebase.sh).

-- Hannes
