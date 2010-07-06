From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 1/2] Fix MSVC build
Date: Tue, 06 Jul 2010 07:55:08 +0200
Message-ID: <4C32C53C.8020105@viscovery.net>
References: <1278358897-488-1-git-send-email-pharris@opentext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: msysgit@googlegroups.com, git@vger.kernel.org,
	ramsay@ramsay1.demon.co.uk, jrnieder@gmail.com
To: Peter Harris <pharris@opentext.com>
X-From: git-owner@vger.kernel.org Tue Jul 06 07:55:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OW17z-0007fq-IZ
	for gcvg-git-2@lo.gmane.org; Tue, 06 Jul 2010 07:55:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752686Ab0GFFzN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jul 2010 01:55:13 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:32997 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752472Ab0GFFzM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jul 2010 01:55:12 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1OW17c-0004JP-Vx; Tue, 06 Jul 2010 07:55:09 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 9D6611660F;
	Tue,  6 Jul 2010 07:55:08 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.1.10) Gecko/20100512 Thunderbird/3.0.5
In-Reply-To: <1278358897-488-1-git-send-email-pharris@opentext.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150321>

Am 7/5/2010 21:41, schrieb Peter Harris:
> Signed-off-by: Peter Harris <pharris@opentext.com>
> ---
>  compat/mingw.h |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/compat/mingw.h b/compat/mingw.h
> index 8104039..08fea02 100644
> --- a/compat/mingw.h
> +++ b/compat/mingw.h
> @@ -14,11 +14,13 @@ typedef int uid_t;
>  #define S_ISSOCK(x) 0
>  
>  #ifndef _STAT_H_
> +#ifndef S_IRUSR
>  #define S_IRUSR 0
>  #define S_IWUSR 0
>  #define S_IXUSR 0
>  #define S_IRWXU (S_IRUSR | S_IWUSR | S_IXUSR)
>  #endif
> +#endif
>  #define S_IRGRP 0
>  #define S_IWGRP 0
>  #define S_IXGRP 0

This doesn't apply: I don't see the #ifndef _STAT_H_ brackets anywhere in
my version of compat/mingw.h.

-- Hannes
