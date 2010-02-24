From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCHv3 2/5] connect: use static list of repo-local env vars
Date: Wed, 24 Feb 2010 08:14:05 +0100
Message-ID: <4B84D1BD.2030908@viscovery.net>
References: <1266968136-11129-1-git-send-email-giuseppe.bilotta@gmail.com> <1266968136-11129-3-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	msysGit Mailinglist <msysgit@googlegroups.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 24 08:14:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NkBRq-0000JG-PO
	for gcvg-git-2@lo.gmane.org; Wed, 24 Feb 2010 08:14:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755405Ab0BXHOM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2010 02:14:12 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:42605 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755097Ab0BXHOL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2010 02:14:11 -0500
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1NkBRe-0001ki-AU; Wed, 24 Feb 2010 08:14:06 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id E72401660F;
	Wed, 24 Feb 2010 08:14:05 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <1266968136-11129-3-git-send-email-giuseppe.bilotta@gmail.com>
X-Enigmail-Version: 0.95.5
X-Spam-Score: 1.9 (+)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140906>

Giuseppe Bilotta schrieb:
> -		/* remove these from the environment */

You shouldn't remove this comment.

> -		const char *env[] = {
> -			ALTERNATE_DB_ENVIRONMENT,
> -			DB_ENVIRONMENT,
> -			GIT_DIR_ENVIRONMENT,
> -			GIT_WORK_TREE_ENVIRONMENT,
> -			GRAFT_ENVIRONMENT,
> -			INDEX_ENVIRONMENT,
> -			NO_REPLACE_OBJECTS_ENVIRONMENT,
> -			NULL
> -		};
> -		conn->env = env;
> +		conn->env = local_repo_env;

IMO, you should squash this patch and the previous one under the subject
"Move list of repo-local environment variables to a public place", and
that public place could be environment.c instead of a new file cache.c
(the name "cache.c" is definitely wrong).

-- Hannes
