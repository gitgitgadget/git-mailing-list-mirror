From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: possible code error at run_command.c
Date: Mon, 21 Dec 2009 08:18:37 +0100
Message-ID: <4B2F214D.2020905@viscovery.net>
References: <1976ea660912202246k45732bf2p111bbeb78047693e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Frank Li <lznuaa@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 21 08:18:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NMcXV-0004nE-L0
	for gcvg-git-2@lo.gmane.org; Mon, 21 Dec 2009 08:18:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751497AbZLUHSl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Dec 2009 02:18:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751376AbZLUHSl
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Dec 2009 02:18:41 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:25957 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751075AbZLUHSk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Dec 2009 02:18:40 -0500
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1NMcXN-00027K-Li; Mon, 21 Dec 2009 08:18:37 +0100
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 551501660F;
	Mon, 21 Dec 2009 08:18:37 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <1976ea660912202246k45732bf2p111bbeb78047693e@mail.gmail.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135542>

Frank Li schrieb:
> int start_command(struct child_process *cmd)
> {
> 	int need_in, need_out, need_err;
> 	int fdin[2], fdout[2], fderr[2];
> 	int failed_errno = failed_errno;
> 
> I have not found failed_errno as global variable.
> failed_errno = failed_errno means nothing.

This is a commonly used idiom to avoid an (incorrect) compiler warning
about an uninitialized variable.

Strictly speaking, I think that you are right by saying "means nothing"
because the use of the uninitialized variable invokes undefined behavior
(and for this reason, I dislike this construct), but in practice it will
not make a difference.

-- Hannes
