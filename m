From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] pack-objects: Add runtime detection of online CPU's
Date: Tue, 12 Feb 2008 09:49:16 +0100
Message-ID: <47B15D8C.1000600@viscovery.net>
References: <47B156CD.1010209@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Nicolas Pitre <nico@cam.org>
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Tue Feb 12 09:50:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOqq0-0001j6-PP
	for gcvg-git-2@gmane.org; Tue, 12 Feb 2008 09:50:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761753AbYBLItX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Feb 2008 03:49:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761707AbYBLItX
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Feb 2008 03:49:23 -0500
Received: from lilzmailso02.liwest.at ([212.33.55.13]:41261 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761649AbYBLItV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Feb 2008 03:49:21 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1JOqov-0003nf-Ox; Tue, 12 Feb 2008 09:48:54 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id BC7F86B7; Tue, 12 Feb 2008 09:49:16 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <47B156CD.1010209@op5.se>
X-Spam-Score: 1.2 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_95=3, UPPERCASE_25_50=0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73643>

Andreas Ericsson schrieb:
> +#ifndef THREAD_COMPAT_H
> +#define THREAD_COMPAT_H
> +
> +#include "cache.h"
> +
> +#ifdef THREADED_DELTA_SEARCH
> +#include <pthread.h>
> +# ifdef _WIN32
> +#  define WIN32_LEAN_AND_MEAN
> +# include <windows.h>
> +# endif

And now what?

If you don't provide a pthread_* implementation for Windows, you can just
drop the #ifdef _WIN32 part as long as the THREADED_DELTA_SEARCH guards
remain.

-- Hannes
