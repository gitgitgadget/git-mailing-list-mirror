From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 2/4] Makefile: merge two Cygwin configuration sections
 into   one
Date: Tue, 03 Nov 2009 08:22:39 +0100
Message-ID: <4AEFDA3F.2070405@viscovery.net>
References: <4AE745FB.1060902@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>,
	Marius Storm-Olsen <mstormo@gmail.com>, dpotapov@gmail.com
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Tue Nov 03 08:22:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5Dj7-00057d-Ux
	for gcvg-git-2@lo.gmane.org; Tue, 03 Nov 2009 08:22:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755941AbZKCHWe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Nov 2009 02:22:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755640AbZKCHWe
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Nov 2009 02:22:34 -0500
Received: from lilzmailmt02.liwest.at ([212.33.55.12]:20385 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753064AbZKCHWe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Nov 2009 02:22:34 -0500
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1N5Diw-0005pv-24; Tue, 03 Nov 2009 08:22:38 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by linz.eudaptics.com (Postfix) with ESMTP
	id E5B9A6D9; Tue,  3 Nov 2009 08:22:37 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <4AE745FB.1060902@ramsay1.demon.co.uk>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131948>

Ramsay Jones schrieb:
> diff --git a/Makefile b/Makefile
> index fea237b..8e1cfc5 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -782,6 +782,8 @@ ifeq ($(uname_O),Cygwin)
>  	NO_MMAP = YesPlease
>  	NO_IPV6 = YesPlease
>  	X = .exe
> +	COMPAT_OBJS += compat/cygwin.o
> +	UNRELIABLE_FSTAT = UnfortunatelyYes
>  endif
>  ifeq ($(uname_S),FreeBSD)
>  	NEEDS_LIBICONV = YesPlease
> @@ -891,10 +893,6 @@ ifeq ($(uname_S),HP-UX)
>  	NO_SYS_SELECT_H = YesPlease
>  	SNPRINTF_RETURNS_BOGUS = YesPlease
>  endif
> -ifneq (,$(findstring CYGWIN,$(uname_S)))
> -	COMPAT_OBJS += compat/cygwin.o
> -	UNRELIABLE_FSTAT = UnfortunatelyYes
> -endif
>  ifdef MSVC
>  	GIT_VERSION := $(GIT_VERSION).MSVC
>  	pathsep = ;

I think this an obviously good change even outside this series.

-- Hannes
