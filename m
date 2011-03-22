From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH 1/2] git-submodule.sh: Handle submodules with merge conflicts
Date: Tue, 22 Mar 2011 20:22:23 +0100
Message-ID: <4D88F6EF.3020804@web.de>
References: <4D886430.3080300@kalray.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Nicolas Morey-Chaisemartin <nmorey@kalray.eu>
X-From: git-owner@vger.kernel.org Tue Mar 22 20:23:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q27AT-0004yG-Kc
	for gcvg-git-2@lo.gmane.org; Tue, 22 Mar 2011 20:23:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751671Ab1CVTW5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Mar 2011 15:22:57 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:59527 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750757Ab1CVTW4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Mar 2011 15:22:56 -0400
Received: from smtp07.web.de  ( [172.20.5.215])
	by fmmailgate03.web.de (Postfix) with ESMTP id 662C918A4995D;
	Tue, 22 Mar 2011 20:22:23 +0100 (CET)
Received: from [93.240.123.209] (helo=[192.168.178.43])
	by smtp07.web.de with asmtp (WEB.DE 4.110 #2)
	id 1Q279r-0003bu-00; Tue, 22 Mar 2011 20:22:23 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.15) Gecko/20110303 Thunderbird/3.1.9
In-Reply-To: <4D886430.3080300@kalray.eu>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX1/uBouCIY2vtPlX0RGmbdyjuyBAKcQ2cjiaHVnC
	4/Z2EA9gOrmxCAhuOUWATbMG7By+QGUQvC1l6BcKds0+cup6oK
	TZvk5cbukgB43CS+ZMhw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169767>

Thanks, that fixes it nicely!

Am 22.03.2011 09:56, schrieb Nicolas Morey-Chaisemartin:
> During a merge with conflict on a submodule, the submodule appears 3 times in git ls-files (stage 1,2,3) which caused the submodule to be used 3 times in git submodule init, sync, update and status command.
> This patch filters the results of git ls-files to generate a single entry for conflicting submodules with a 0 SHA1 and 'U' as stage.

Nit: Usually we wrap commit messages at about 72 characters.

> After this patch:
> - init and sync behave as previously but only once per submodule
> - update skips submodule with merge conflicts
> - status now display a null SHA1 prefixed by 'U' for submodule with merge conflicts

A test case would be nice (t7405 looks like the right spot for one).
