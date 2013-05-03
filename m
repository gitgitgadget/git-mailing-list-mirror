From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 2/2] cygwin: Remove the CYGWIN_V15_WIN32API build variable
Date: Fri, 3 May 2013 04:17:28 -0400
Message-ID: <CAPig+cR3s4nzSOrG+=-MYEA4heTeMHpHQmAChWLEuFY2v+PhPA@mail.gmail.com>
References: <5182BE80.7060400@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>, mlevedahl@gmail.com
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Fri May 03 10:17:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UYBBR-0001Oh-4f
	for gcvg-git-2@plane.gmane.org; Fri, 03 May 2013 10:17:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761750Ab3ECIRc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 May 2013 04:17:32 -0400
Received: from mail-lb0-f182.google.com ([209.85.217.182]:55117 "EHLO
	mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751018Ab3ECIRa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 May 2013 04:17:30 -0400
Received: by mail-lb0-f182.google.com with SMTP id r11so1284726lbv.41
        for <git@vger.kernel.org>; Fri, 03 May 2013 01:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=mHFJfTL4HdbZLaYXL3T8WVTcAdS4/kA5i+8EOtrZ1ME=;
        b=dV9j9CDSpKTzuGyKC6YN+GQ3x9GBwzHETUW6nXRLa3Qs1fBHofAXxZ6mFVsnvy6cP1
         aBdsDNF/CYYLh+QCvwxYp9QG6EM6SEkTvk+3nMx/vgoBwg/GPmNTQWgcjrgb+LlyliYY
         e5hDkMRkPS5eIwIcnJ64DB5YXzH9goaKqLDthMnReKux4AkzMVWxs5FyWAos0CfD6diL
         9cdQJvyUdzIJM9zbA73qE1fQLOUmicODeZEo+sLgMdNYi7ExddF/tYwTLIHHrhH+40AM
         qPan3m4kpSVd4ft/k69CuCE0AVeYxDE0SrjmvIhCXl++ODrf8/NioCxOvbim9mI+Hp/4
         uh1A==
X-Received: by 10.112.159.1 with SMTP id wy1mr3832187lbb.80.1367569048404;
 Fri, 03 May 2013 01:17:28 -0700 (PDT)
Received: by 10.114.186.233 with HTTP; Fri, 3 May 2013 01:17:28 -0700 (PDT)
In-Reply-To: <5182BE80.7060400@ramsay1.demon.co.uk>
X-Google-Sender-Auth: dWym59wvQApuYbUXHZdlIk51IAc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223296>

On Thu, May 2, 2013 at 3:29 PM, Ramsay Jones <ramsay@ramsay1.demon.co.uk> wrote:
> Commit 380a4d92 ("Update cygwin.c for new mingw-64 win32 api headers",
> 11-11-2012) solved an header include order problem on cygwin 1.7 when
> using the new mingw-64 WIN32 API headers. The solution involved using
> a new build variable (V15_MINGW_HEADERS) to conditionally compile the
> cygwin.c source file to use an include order appropriate for the old
> and new header files. (The build variable was later renamed in commit
> 9fca6cff to CYGWIN_V15_WIN32API).
>
> The include order used for cygwin 1.7 includes the "win32.h" header
> before "../git-compat-util.h". This order was problematic on cygwin
> 1.5, since it lead to the WIN32 symbol being defined along with the

s/lead/led/

> inclusion of some WIN32 API headers (e.g. <winsock2.h>) which cause
> compilation errors.
>
> The header include order problem on cygwin 1.5 has since been fixed
> (see commit "mingw: rename WIN32 cpp macro to GIT_WINDOWS_NATIVE"),
> so we can now remove the conditional compilation along with the
> associated CYGWIN_V15_WIN32API build variable.
>
> Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
