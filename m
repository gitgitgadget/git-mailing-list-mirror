From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [regression] Newer gits cannot clone any remote repos
Date: Thu, 15 Nov 2012 19:51:29 +0700
Message-ID: <CACsJy8Atj0WsFaYTZE9y9+tu1+L2LumVOk3sUj-t9iKbiqsBZw@mail.gmail.com>
References: <CACYvZ7jPd0_XD6YVdfJ2AnKRnKewmzX4uu7w3zt+_gK+qU49gQ@mail.gmail.com>
 <50A2978D.6080805@ramsay1.demon.co.uk> <CACYvZ7jMC5xw4LxiuG5m+=grpQEg+wZb_7BaU4Xn-r7ix=S-bw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Ramsay Jones <ramsay@ramsay1.demon.co.uk>, git@vger.kernel.org
To: Douglas Mencken <dougmencken@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 15 13:52:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TYyvc-00072d-O5
	for gcvg-git-2@plane.gmane.org; Thu, 15 Nov 2012 13:52:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1767715Ab2KOMwE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Nov 2012 07:52:04 -0500
Received: from mail-ea0-f174.google.com ([209.85.215.174]:58936 "EHLO
	mail-ea0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1767705Ab2KOMwB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Nov 2012 07:52:01 -0500
Received: by mail-ea0-f174.google.com with SMTP id e13so624319eaa.19
        for <git@vger.kernel.org>; Thu, 15 Nov 2012 04:52:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=kUVX4JZf4+13h89UD4d/I0HA1kZRNh1jzJ+f3JLEGPw=;
        b=PH9uqcl8krIbJj2pk9Pgg+hwVHJyMlHocSAc1hhBh3MHrq77wp5uaLOX60xenvobje
         3AwhpW3JebC8X2aVvA8flJsQ+WksNBdXvV4SYvUSjUtj7jUOu88/S6mYBBCpQnutk8aN
         VnU2LQCTBM3wIGiuUsiSwtpJRRlGajVLpFrbuxAIlO0ULCy0rDEUYMrL9DOcNii1W1+V
         Fmu7qbNGibsF8Ocw2ppN6WEI5gnQsIuEIoF3xz7VeqXNl6PddWizk1V6SQAxj9ZmjPju
         +DZdqJe+KW+lN1Ze/2LNs441XnmC6WLCY8W7BtzDHHVBPmy8WfcAFIleHue8ApNKjjLm
         ECuA==
Received: by 10.14.173.137 with SMTP id v9mr3423445eel.41.1352983920775; Thu,
 15 Nov 2012 04:52:00 -0800 (PST)
Received: by 10.14.220.73 with HTTP; Thu, 15 Nov 2012 04:51:29 -0800 (PST)
In-Reply-To: <CACYvZ7jMC5xw4LxiuG5m+=grpQEg+wZb_7BaU4Xn-r7ix=S-bw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209821>

On Wed, Nov 14, 2012 at 2:55 AM, Douglas Mencken <dougmencken@gmail.com> wrote:
>>  Could you try re-building git with the
>> NO_THREAD_SAFE_PREAD build variable set?
>
> Yeah! It works!!!
>
> --- evil/Makefile
> +++ good/Makefile
> @@ -957,6 +957,7 @@
>         HAVE_PATHS_H = YesPlease
>         LIBC_CONTAINS_LIBINTL = YesPlease
>         HAVE_DEV_TTY = YesPlease
> +       NO_THREAD_SAFE_PREAD = YesPlease
>  endif
>  ifeq ($(uname_S),GNU/kFreeBSD)
>         NO_STRLCPY = YesPlease
>
> With this, I do have correctly working git clone.

Sorry you had to figure that out the hard way. Could you make it a
proper patch? I'm surprised that Linux pread does not behave the same
way across platforms though. Or maybe it only happens with certain
Linux versions. What version are you using?
-- 
Duy
