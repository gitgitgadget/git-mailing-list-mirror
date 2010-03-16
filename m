From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [patch 02/15] const-expr.patch
Date: Tue, 16 Mar 2010 08:31:40 +0100
Message-ID: <4B9F33DC.3030309@viscovery.net>
References: <20100316054220.075676000@mlists.thewrittenword.com> <20100316054306.167331000@mlists.thewrittenword.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Gary V. Vaughan" <git@mlists.thewrittenword.com>
X-From: git-owner@vger.kernel.org Tue Mar 16 08:31:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NrRFk-0005xt-RB
	for gcvg-git-2@lo.gmane.org; Tue, 16 Mar 2010 08:31:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966025Ab0CPHbo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Mar 2010 03:31:44 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:2850 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756173Ab0CPHbn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Mar 2010 03:31:43 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1NrRFd-00024I-FB; Tue, 16 Mar 2010 08:31:41 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 35A141660F;
	Tue, 16 Mar 2010 08:31:41 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <20100316054306.167331000@mlists.thewrittenword.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142332>

Gary V. Vaughan schrieb:
> Unfortunately, there are still plenty of production systems with
> vendor compilers that choke unless all compound declarations can be
> determined statically at compile time, for example hpux10.20 (I can
> provide a comprehensive list of our supported platforms that exhibit
> this problem if necessary).

Yes, a comprehensive list would be appreciated. This change is an
uglification that I personally would prefer to stay out of the code base
unless many consumers of git are hurt.

The problem with this non-feature is that it is all too easy that new code
introduces new incompatibilities.

> Index: b/ll-merge.c
> ===================================================================
> --- a/ll-merge.c
> +++ b/ll-merge.c

BTW, did you notice that git is a version control system that hosts itself? ;)

> +	dict[0].placeholder = "O"; dict[0].value = temp[0];
> +	dict[1].placeholder = "A"; dict[1].value = temp[1];
> +	dict[2].placeholder = "B"; dict[2].value = temp[2];
> +	dict[3].placeholder = "L"; dict[3].value = temp[3];
> +	dict[3].placeholder = NULL; dict[3].value = NULL;

	dict[4]...

-- Hannes
