From: =?ISO-8859-1?Q?Andreas_F=E4rber?= <andreas.faerber@web.de>
Subject: Re: [PATCH] config.mak.in: Pass on LDFLAGS from configure
Date: Fri, 22 Aug 2008 13:56:53 +0200
Message-ID: <7F6886CA-D061-403D-9611-B4E7D587EBCF@web.de>
References: <20080821193823.GA13293@janet.wally>
Mime-Version: 1.0 (Apple Message framework v926)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Neil Roberts <bpeeluk@yahoo.co.uk>
X-From: git-owner@vger.kernel.org Fri Aug 22 13:58:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWVHY-00016Q-KL
	for gcvg-git-2@gmane.org; Fri, 22 Aug 2008 13:58:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753244AbYHVL5R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Aug 2008 07:57:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753426AbYHVL5R
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Aug 2008 07:57:17 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:39883 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752351AbYHVL5Q (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Aug 2008 07:57:16 -0400
Received: from smtp05.web.de (fmsmtp05.dlan.cinetic.de [172.20.4.166])
	by fmmailgate02.web.de (Postfix) with ESMTP id 4A089E97C297;
	Fri, 22 Aug 2008 13:57:15 +0200 (CEST)
Received: from [91.18.115.90] (helo=[10.0.1.1])
	by smtp05.web.de with asmtp (TLSv1:AES128-SHA:128)
	(WEB.DE 4.109 #226)
	id 1KWVGV-0005tQ-00; Fri, 22 Aug 2008 13:57:15 +0200
In-Reply-To: <20080821193823.GA13293@janet.wally>
X-Mailer: Apple Mail (2.926)
X-Sender: Andreas.Faerber@web.de
X-Provags-ID: V01U2FsdGVkX19sMrU0rVKWzREWal2j+iYk2+Kz1saC8GwO02NQ
	TJXVv10xHJj1Te24ScJXefq9SfgCRZaa25LORkheeQMlc4PYgP
	8HZSd4SxWcu1FSZObpAw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93285>


Am 21.08.2008 um 21:38 schrieb Neil Roberts:

> The configure script allows you to specify flags to pass to the linker
> step in the LDFLAGS environment variable but this was being ignored in
> the Makefile. Now a make variable gets set to the value passed down
> from the configure script.
>
> Signed-off-by: Neil Roberts <bpeeluk@yahoo.co.uk>
> ---

> diff --git a/config.mak.in b/config.mak.in
> index b776149..f67d673 100644
> --- a/config.mak.in
> +++ b/config.mak.in
> @@ -3,6 +3,7 @@
>
> CC = @CC@
> CFLAGS = @CFLAGS@
> +LDFLAGS = @LDFLAGS@
> AR = @AR@
> TAR = @TAR@
> #INSTALL = @INSTALL@		# needs install-sh or install.sh in sources
> --

configure also uses CPPFLAGS for preprocessor options like -I/my/path,  
which are dropped as well. Could we fold them into CFLAGS while we're  
at it?

Andreas
