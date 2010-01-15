From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 2/2] Fix variable initialization in insert_packed_refs().
Date: Fri, 15 Jan 2010 08:34:53 +0100
Message-ID: <4B501A9D.6060703@viscovery.net>
References: <201001150029.01486.richard@nod.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com
To: Richard Weinberger <richard@nod.at>
X-From: git-owner@vger.kernel.org Fri Jan 15 08:35:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVgi9-0006gr-QE
	for gcvg-git-2@lo.gmane.org; Fri, 15 Jan 2010 08:35:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751780Ab0AOHfA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jan 2010 02:35:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751622Ab0AOHe7
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Jan 2010 02:34:59 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:21855 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751061Ab0AOHe7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jan 2010 02:34:59 -0500
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1NVghq-0007XH-Ck; Fri, 15 Jan 2010 08:34:54 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 05CBC1660F;
	Fri, 15 Jan 2010 08:34:53 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <201001150029.01486.richard@nod.at>
X-Spam-Score: 1.9 (+)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137057>

Richard Weinberger schrieb:
> -		int cmp = cmp, len;
> +		int cmp, len;

If you look around in the code, you'll find more *cough* initializations
*cough* like this. They are written this way for a reason: they avoid
unwarranted compiler warnings "'foo' may be used uninitialized". Are you
saying that this warning is not triggered anymore after your change?

-- Hannes
