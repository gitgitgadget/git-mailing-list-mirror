From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: gitignore design
Date: Fri, 29 Jul 2011 14:58:36 +0200
Message-ID: <4E32AE7C.70004@viscovery.net>
References: <1311934832699-6632987.post@n2.nabble.com>	<4E329EDB.6040007@hupie.com>	<1311940877783-6633274.post@n2.nabble.com> <m339hps2is.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-4
Content-Transfer-Encoding: 7bit
Cc: llucianf <llucianf@gmail.com>, git@vger.kernel.org,
	Ferry Huberts <mailings@hupie.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 29 14:58:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QmmeO-0003cF-T0
	for gcvg-git-2@lo.gmane.org; Fri, 29 Jul 2011 14:58:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756271Ab1G2M6o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Jul 2011 08:58:44 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:55201 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755806Ab1G2M6n (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jul 2011 08:58:43 -0400
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1QmmeF-0003Un-7g; Fri, 29 Jul 2011 14:58:39 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id BC3381660F;
	Fri, 29 Jul 2011 14:58:36 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.18) Gecko/20110616 Thunderbird/3.1.11
In-Reply-To: <m339hps2is.fsf@localhost.localdomain>
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178146>

Am 7/29/2011 14:19, schrieb Jakub Narebski:
> For that you can use 'assume-unachanged' mechanism (note: it is local
> to repository).  The gitignore(7) manpage says:
> 
>   NOTES
>      The purpose of gitignore files is to ensure that certain files not tracked
>      by git remain untracked.
> 
>      To ignore uncommitted changes in a file that is already tracked, use
>      `git update-index --assume-unchanged <file>`.

This statement in our documentation is *wrong*!! Please do not suggest it
for cases like the OP's!

See the discussion of assume-unchanged in git-update-index: This bit
actually means that git may assume that the file was not changed, and it
can take the worktree's data when it otherwise would have to unpack the
index's data. IOW, using it for the purposes that the OP would need is
*dangerous*.

-- Hannes
