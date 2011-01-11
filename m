From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH v2] msvc: Fix compilation error due to missing mktemp()
 declaration
Date: Tue, 11 Jan 2011 18:33:46 +0000
Message-ID: <4D2CA28A.4070401@ramsay1.demon.co.uk>
References: <4D1F8F06.9090700@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>, kusmabite@gmail.com
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Tue Jan 11 19:35:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pcj3p-0007VS-TG
	for gcvg-git-2@lo.gmane.org; Tue, 11 Jan 2011 19:35:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932487Ab1AKSfF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Jan 2011 13:35:05 -0500
Received: from anchor-post-3.mail.demon.net ([195.173.77.134]:40998 "EHLO
	anchor-post-3.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932191Ab1AKSfE (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Jan 2011 13:35:04 -0500
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by anchor-post-3.mail.demon.net with esmtp (Exim 4.69)
	id 1Pcj3f-0006Ly-ni; Tue, 11 Jan 2011 18:35:04 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
In-Reply-To: <4D1F8F06.9090700@ramsay1.demon.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164968>

Ramsay Jones wrote:
> Commit d1b6e6e (win32: use our own dirent.h, 2010-11-23) removed
> the compat/vcbuild/include/dirent.h compatibility header file.
> This file, among other things, included the <io.h> system header
> file which provides the declaration of the mktemp() function.
> 
> In order to fix the compilation error, we add an include directive
> for <io.h> to the compat/mingw.h header.
> 
> Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
> ---
> 
> Change from v1:
>     - add #include to compat/mingw.h rather than compat/vcbuild/include/unistd.h
> 
> ATB,
> Ramsay Jones
> 
>  compat/mingw.h |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/compat/mingw.h b/compat/mingw.h
> index cafc1eb..1c6bc02 100644
> --- a/compat/mingw.h
> +++ b/compat/mingw.h
> @@ -1,5 +1,6 @@
>  #include <winsock2.h>
>  #include <ws2tcpip.h>
> +#include <io.h>
>  
>  /*
>   * things that are not available in header files

ping... Are there any remaining concerns regarding this patch?
Just let me know.

ATB,
Ramsay Jones
