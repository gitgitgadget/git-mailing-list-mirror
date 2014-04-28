From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH 11/12] MINGW: do not fail at redefining pid_t on MinGW-W64
Date: Mon, 28 Apr 2014 17:24:51 +0200
Message-ID: <CABPQNSZztq3icnPRmt2uR33FvEXDrmqKcOmLAgjxexTR7JWhaA@mail.gmail.com>
References: <1398693097-24651-1-git-send-email-marat@slonopotamus.org> <1398693097-24651-12-git-send-email-marat@slonopotamus.org>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: GIT Mailing-list <git@vger.kernel.org>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Marat Radchenko <marat@slonopotamus.org>
X-From: git-owner@vger.kernel.org Mon Apr 28 17:25:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WenRB-0005bz-CT
	for gcvg-git-2@plane.gmane.org; Mon, 28 Apr 2014 17:25:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932710AbaD1PZh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2014 11:25:37 -0400
Received: from mail-ie0-f176.google.com ([209.85.223.176]:42477 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932612AbaD1PZc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 11:25:32 -0400
Received: by mail-ie0-f176.google.com with SMTP id rd18so6501224iec.7
        for <git@vger.kernel.org>; Mon, 28 Apr 2014 08:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=guUaKCcY3dDsoTKoTcBlbqgFHaEr0uM853hHyTrOZmY=;
        b=l9DN2kJQYSvitS+iSV9xYjtO00wKGkS4FvWOM1zaIl5IG+blpuV/gWo50rgkY+uU9e
         3TS2tVDLcf64pSNj45mczXMLbXVUGfN1pzMTPq5dUMSWI9SzVKx8AMc5WkEWh3PHw/dS
         ZNzxdXVJarM93VhXMB74ypPaNVv+ggVe6vFkngfLll52BqKZdl0dlTIzAiboG4Hmaay8
         ENsFJpMZjoMjpS49wxBlIHKMqdCzR+khd5/UeBax1lHxmGaJnUTBpm8N4ZndeTtdv+4D
         QFhBAaCQQ3THnkDLdKQCDvlV26RNYFDpx7hWpoVp/65BEMGIcprUtW+IdZ9MRpCSrDZb
         IQfQ==
X-Received: by 10.50.36.66 with SMTP id o2mr24444243igj.24.1398698731513; Mon,
 28 Apr 2014 08:25:31 -0700 (PDT)
Received: by 10.64.166.135 with HTTP; Mon, 28 Apr 2014 08:24:51 -0700 (PDT)
In-Reply-To: <1398693097-24651-12-git-send-email-marat@slonopotamus.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247362>

On Mon, Apr 28, 2014 at 3:51 PM, Marat Radchenko <marat@slonopotamus.org> wrote:
> pid_t is available in sys/types.h on both MinGW and MinGW-W64
>
> Signed-off-by: Marat Radchenko <marat@slonopotamus.org>
> ---
>  compat/mingw.h | 1 -
>  compat/msvc.h  | 2 ++
>  2 files changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/compat/mingw.h b/compat/mingw.h
> index c502a22..8850109 100644
> --- a/compat/mingw.h
> +++ b/compat/mingw.h
> @@ -5,7 +5,6 @@
>   * things that are not available in header files
>   */
>
> -typedef int pid_t;
>  typedef int uid_t;
>  typedef int socklen_t;
>  #define hstrerror strerror
> diff --git a/compat/msvc.h b/compat/msvc.h
> index cb41ce3..e2fda48 100644
> --- a/compat/msvc.h
> +++ b/compat/msvc.h
> @@ -18,6 +18,8 @@
>  #define PRIuMAX "I64u"
>  #define PRId64 "I64d"
>
> +typedef int pid_t;
> +
>  static __inline int strcasecmp (const char *s1, const char *s2)
>  {
>         int size1 = strlen(s1);


Looks good!

Acked-by: Erik Faye-Lund <kusmabite@gmail.com>
