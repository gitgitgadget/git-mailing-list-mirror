From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH 2/3] Compile fix for MSVC: fix poll-related macro redefines
Date: Fri, 18 Nov 2011 18:36:13 +0100
Message-ID: <4EC6978D.3020604@gmail.com>
References: <1321634670-4968-1-git-send-email-vfr@lyx.org> <1321634670-4968-2-git-send-email-vfr@lyx.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com, kusmabite@gmail.com,
	msysgit@googlegroups.com, j.sixt@viscovery.net,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Vincent van Ravesteijn <vfr@lyx.org>
X-From: git-owner@vger.kernel.org Fri Nov 18 18:36:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RRSMS-0004Nj-Aw
	for gcvg-git-2@lo.gmane.org; Fri, 18 Nov 2011 18:36:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752791Ab1KRRgU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Nov 2011 12:36:20 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:42481 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751773Ab1KRRgT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Nov 2011 12:36:19 -0500
Received: by fagn18 with SMTP id n18so4575889fag.19
        for <git@vger.kernel.org>; Fri, 18 Nov 2011 09:36:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:newsgroups:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=0SFXAyFZRTOZ10BYIKThB7HA7qOrjsMkHinJ4PFYmRQ=;
        b=o3BTHI6YHjKSmcCbo+OTZXGRYpIdpJ3GKgAsVC1yVRfHqMwnZXn4JKU4Dx53FXDRn1
         1R3ql/n4KVBrsyawUuAF/TBqRMY5OT43C/o7b/O/38SkcqgplXg/et8fo7VGLJgcgjT/
         5OUMBjWbxji/LvxR5tGfu2WVLCabBqv0nCC+I=
Received: by 10.205.119.11 with SMTP id fs11mr4447613bkc.58.1321637778033;
        Fri, 18 Nov 2011 09:36:18 -0800 (PST)
Received: from [130.73.68.203] (jambul.zib.de. [130.73.68.203])
        by mx.google.com with ESMTPS id o7sm1271813bkw.16.2011.11.18.09.36.15
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 18 Nov 2011 09:36:16 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.12) Gecko/20080213 Thunderbird/2.0.0.12 Mnenhy/0.7.5.0
Newsgroups: gmane.comp.version-control.git,gmane.comp.version-control.msysgit
In-Reply-To: <1321634670-4968-2-git-send-email-vfr@lyx.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185670>

On 18.11.2011 17:44, Vincent van Ravesteijn wrote:

> diff --git a/git-compat-util.h b/git-compat-util.h
> index 5ef8ff7..76cbfe6 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -85,6 +85,7 @@
>  #define _SGI_SOURCE 1
>
>  #ifdef WIN32 /* Both MinGW and MSVC */
> +#  define _WIN32_WINNT 0x0501
>  #define WIN32_LEAN_AND_MEAN  /* stops windows.h including winsock.h */
>  #include<winsock2.h>
>  #include<windows.h>

It seems the indentation is wrong (does not match the surrounding code) 
here.

-- 
Sebastian Schuberth
