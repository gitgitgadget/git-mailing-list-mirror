From: =?GB2312?B?y++61Q==?= <sunheehnus@gmail.com>
Subject: Re: [PATCH] OPTION_CMDMODE should be used when not accept an
 argument, and OPTION_NUMBER is of special type. So change the mode to OPTION_CMDMODE
Date: Fri, 28 Feb 2014 22:32:52 +0800
Message-ID: <CAJr59C1qHrQ9qPdDWfGzj9QX3L-EwEcP+updu0SDn24r4i7UMQ@mail.gmail.com>
References: <1393597765-14164-1-git-send-email-sunheehnus@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Sun He <sunheehnus@gmail.com>
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Feb 28 15:33:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJOUl-0003QJ-FB
	for gcvg-git-2@plane.gmane.org; Fri, 28 Feb 2014 15:32:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752242AbaB1Ocz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Feb 2014 09:32:55 -0500
Received: from mail-we0-f178.google.com ([74.125.82.178]:64123 "EHLO
	mail-we0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751915AbaB1Ocy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Feb 2014 09:32:54 -0500
Received: by mail-we0-f178.google.com with SMTP id q59so606237wes.37
        for <git@vger.kernel.org>; Fri, 28 Feb 2014 06:32:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=tsRfcyEnQKgB772nJ4SfyrzbrKzkn4ph6eBjspMiWGw=;
        b=Z+sIG3aydbl/Q2FrCA3ks4atAzsCq0yY/kx6jxEhonO17mprGPzBwWDhPHNvsWGgtO
         p/VvTj99C285bvyDKdhQcCKalS0Fe3odMIETr0YhzxcLiC5Kpge8+SmfoTiJ6nPF/110
         uyEkEoDjEyYoFXk2ct0y+NTxYEK34TQwYr3FMEijiA/a/hHSAnHvOvwnHvB1TvS2IoHW
         5oZQ3UYrIkfAzhrwoNNIKRx226F7TB4Pr7gQUkCRGfAhfCTW9kHDzM4MFXnFBuJuq6Po
         VRIhYM9f0wOSZOfgSD6cpIm+tJ7S3yaJJd+qonm2W5Qgk8JZGX8wT0geUwt+UK9I4iVA
         +TSg==
X-Received: by 10.194.206.102 with SMTP id ln6mr2984384wjc.43.1393597972956;
 Fri, 28 Feb 2014 06:32:52 -0800 (PST)
Received: by 10.216.203.69 with HTTP; Fri, 28 Feb 2014 06:32:52 -0800 (PST)
In-Reply-To: <1393597765-14164-1-git-send-email-sunheehnus@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242967>

I am not sure if this is a bug.
I need your help to find out it.

Cheers,
He Sun

2014-02-28 22:29 GMT+08:00 Sun He <sunheehnus@gmail.com>:
> Signed-off-by: Sun He <sunheehnus@gmail.com>
> ---
>  parse-options.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/parse-options.c b/parse-options.c
> index 7b8d3fa..59a52b0 100644
> --- a/parse-options.c
> +++ b/parse-options.c
> @@ -371,7 +371,7 @@ static void parse_options_check(const struct option *opts)
>                 case OPTION_NEGBIT:
>                 case OPTION_SET_INT:
>                 case OPTION_SET_PTR:
> -               case OPTION_NUMBER:
> +               case OPTION_CMDMODE:
>                         if ((opts->flags & PARSE_OPT_OPTARG) ||
>                             !(opts->flags & PARSE_OPT_NOARG))
>                                 err |= optbug(opts, "should not accept an argument");
> --
> 1.9.0.138.g2de3478.dirty
> ---
> I came across this protential bug.
> According to parse-options.h OPTION_CMDMODE is an option with noarguments and OPTION_NUMBER is special type option.
>
> Thanks,
> He Sun
