From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 2/2] Make Git respect changes to .gitattributes during
 checkout.
Date: Thu, 12 Mar 2009 10:59:57 +0100
Message-ID: <49B8DD1D.3060908@viscovery.net>
References: <1233320413-28069-1-git-send-email-kristian.amlie@trolltech.com> <1236850575-27973-3-git-send-email-kristian.amlie@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Kristian Amlie <kristian.amlie@nokia.com>
X-From: git-owner@vger.kernel.org Thu Mar 12 11:01:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhhjN-0003lT-4y
	for gcvg-git-2@gmane.org; Thu, 12 Mar 2009 11:01:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752653AbZCLKAH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Mar 2009 06:00:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752114AbZCLKAH
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Mar 2009 06:00:07 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:3238 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751192AbZCLKAG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Mar 2009 06:00:06 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Lhhhl-0005T9-Rz; Thu, 12 Mar 2009 10:59:58 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 8F63A69F; Thu, 12 Mar 2009 10:59:57 +0100 (CET)
User-Agent: Thunderbird 2.0.0.19 (Windows/20081209)
In-Reply-To: <1236850575-27973-3-git-send-email-kristian.amlie@nokia.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113034>

Kristian Amlie schrieb:
> We do this by popping off elements on the attribute stack, until we
> reach the level where a new .gitattributes was checked out. The next
> time someone calls git_checkattr(), it will reconstruct the
> attributes from that point.
...
> +	gitattrlen = strlen(GITATTRIBUTES_FILE);
> +	pathlen = strlen(path);
> +	if (!strncmp(path + pathlen - gitattrlen, GITATTRIBUTES_FILE, gitattrlen)) {
> +		/* Invalidate attributes if a new .gitattributes file was checked out. */

But if there was file .abc.txt that was checked out before .gitattributes
was checked out, then the new .gitattributes won't have been used for
.abc.txt, yet, right?

(Disclaimer: I didn't read the code, just your description and this comment.)

-- Hannes
