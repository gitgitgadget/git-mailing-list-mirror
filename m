From: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH 03/12] MINGW: compat/mingw.h: do not attempt to redefine
 lseek on mingw-w64
Date: Mon, 28 Apr 2014 21:59:39 +0200
Message-ID: <535EB32B.4050209@web.de>
References: <1398693097-24651-1-git-send-email-marat@slonopotamus.org> <1398693097-24651-4-git-send-email-marat@slonopotamus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: Marat Radchenko <marat@slonopotamus.org>,
	GIT Mailing-list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 28 21:59:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WeriN-0007I3-6O
	for gcvg-git-2@plane.gmane.org; Mon, 28 Apr 2014 21:59:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756609AbaD1T7n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2014 15:59:43 -0400
Received: from mout.web.de ([212.227.15.4]:57951 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753974AbaD1T7n (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 15:59:43 -0400
Received: from [192.168.209.26] ([78.72.74.102]) by smtp.web.de (mrweb002)
 with ESMTPSA (Nemesis) id 0MUnuu-1WOOeX01IS-00YBTm; Mon, 28 Apr 2014 21:59:41
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:24.0) Gecko/20100101 Thunderbird/24.4.0
In-Reply-To: <1398693097-24651-4-git-send-email-marat@slonopotamus.org>
X-Provags-ID: V03:K0:gONp42oAt62HAZq5se5oovKw5U5u+nqZVskcn28/+hhnZHShjeo
 e1JJ8WmQaPCmV3Pleul2L28CD4K0VuWtL23rCvUI2DM5VBc0jCy17bCGrJW1VVi3Mk53xYl
 swOg66+NzOowmsohMkUsZMwiCJkYAlC0cpCKdYr8+KudW/IysYgGtc3aXslR1jvLbxApsdk
 nx5PLvNLbKGGQwUqaLW/g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247431>

On 2014-04-28 15.51, Marat Radchenko wrote:
> mingw-w64 has lseek defined in io.h.
[]
>  #define off_t off64_t
> +#ifndef lseek
>  #define lseek _lseeki64
> +#endif
Is the commit message in line with the code?

I would have expected something in this style:

#if defined(__x86_64__) && ! defined(lseek))
#include <io.h>
#endif 
