From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: gitignore design
Date: Fri, 29 Jul 2011 15:31:35 +0200
Message-ID: <4E32B637.1030201@viscovery.net>
References: <1311934832699-6632987.post@n2.nabble.com>	<4E329EDB.6040007@hupie.com>	<1311940877783-6633274.post@n2.nabble.com>	<m339hps2is.fsf@localhost.localdomain> <4E32AE7C.70004@viscovery.net> <m3pqktql6s.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-4
Content-Transfer-Encoding: 7bit
Cc: llucianf <llucianf@gmail.com>, git@vger.kernel.org,
	Ferry Huberts <mailings@hupie.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 29 15:31:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QmnAG-00036K-6D
	for gcvg-git-2@lo.gmane.org; Fri, 29 Jul 2011 15:31:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753774Ab1G2Nbj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Jul 2011 09:31:39 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:13225 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750901Ab1G2Nbi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jul 2011 09:31:38 -0400
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1QmnA8-0004iq-CU; Fri, 29 Jul 2011 15:31:36 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 213F11660F;
	Fri, 29 Jul 2011 15:31:36 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.18) Gecko/20110616 Thunderbird/3.1.11
In-Reply-To: <m3pqktql6s.fsf@localhost.localdomain>
X-Enigmail-Version: 1.1.1
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178150>

Am 7/29/2011 15:19, schrieb Jakub Narebski:
> Are you sure?  It seems to work as I thought it would.
> [...]
> Notice that change to 'bar' didn't get comitted.

Of course, it didn't get committed, you promised not to change it, so why
should git commit it?

However, your example does not show the dangerous part. git-commit is not
dangerous. But you might run into trouble when git has to merge content
into the worktree or index; in this case, git may decide to just read the
file instead of to unpack an object - assuming that the content on disk is
identical to the unpacked object (it will do so because with
--assume-unchanged you promised not to change the file). If you broke your
promise, you get to what you deserve ;)

No code reference, sorry, because I'm just parrotting what I've read
elsewhere on the list, for example,
http://thread.gmane.org/gmane.comp.version-control.git/146082/focus=146353

-- Hannes
