From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH] submodule--helper: fix 'dubious bitfield' sparse warnings
Date: Thu, 25 Feb 2016 12:28:06 -0800
Message-ID: <CAGZ79kb5YGyeEeW0LyA=1nX9+XkUPwxsFp6xQqRekvb9W2M2pA@mail.gmail.com>
References: <56CF5908.7090800@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Stefan Beller <stefanbeller@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
X-From: git-owner@vger.kernel.org Thu Feb 25 21:28:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZ2WL-000459-Q8
	for gcvg-git-2@plane.gmane.org; Thu, 25 Feb 2016 21:28:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751238AbcBYU2J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2016 15:28:09 -0500
Received: from mail-ig0-f178.google.com ([209.85.213.178]:34932 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751158AbcBYU2H (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Feb 2016 15:28:07 -0500
Received: by mail-ig0-f178.google.com with SMTP id hb3so21247807igb.0
        for <git@vger.kernel.org>; Thu, 25 Feb 2016 12:28:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=Sd/tYBx3V470zQLqU+yGr1YlUVmSm7KrbkMe/uEO3VM=;
        b=fF2EitSXAu0gy0SYL2uP58QCI8vwFpsXw2D3XPKIaxGbuAIb3oc1XuqwFkpoSDppUd
         Wd8lRbJ1ldHQ4pfYO6EiY5MZnr8+PT+zI8jVpHR7fqjnbSSpXVej/m2/HvtEowKifgIn
         nNtuC1URCV2ICw62zbEvJnFljDPyzCuzf8BK1lpjQCWND1lN4ZJWGfgt9+7fVKtxrtvx
         A1MBOEUpJipnYMWkbEf3CL4CflefqGDi4SOsrj981FiZFq9j5ABQIUSuyFGoLWRCbkMN
         VKNMgxGnEV2C434x93Ho3zw5FgDfegBeiLCXp9Hvklt+GGW0IagKRfwcqQhnXveZr/YX
         hIig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=Sd/tYBx3V470zQLqU+yGr1YlUVmSm7KrbkMe/uEO3VM=;
        b=USPmKMX3w5+lvqLI/zbsSCz3KEVaTmc4oelVXELqdrCbVBv0uN3tC/6AI+nB/x0uLv
         /HbdcbrdAR1v1cZmw1q5MPb9qOYUZjjtGdXj1Qnh1ogUVTS5ULAiYAGEItgpFEOLfc3l
         5GmHRbp3Ks7sjfmRKn6Qs1pVEIg7R6e31MqFhfBiYn6JP33FrWWe33x5AoGlkqp9E9Vc
         s2QIj9dnSquh9HAzHHT2cKQsedSu3N9zvA5noZVWgalai5LJbPiNS71ATTE9mZpz9c9+
         0IyrYJ/gVW1zchbLPXys2aEUlMp88hWJundOIzPMJPm5R0XXSbbOQ3qLGpMItcKOTD2N
         M+Xg==
X-Gm-Message-State: AG10YOQfRBuDD4JWZiuhrqyCRsc3PwtCQbR1If3VZxBk3Rclix8sNBZBgdn4YpVjO4k5VP8SNNdYZ5TFPWubDvJg
X-Received: by 10.50.180.35 with SMTP id dl3mr630083igc.94.1456432086301; Thu,
 25 Feb 2016 12:28:06 -0800 (PST)
Received: by 10.107.58.6 with HTTP; Thu, 25 Feb 2016 12:28:06 -0800 (PST)
In-Reply-To: <56CF5908.7090800@ramsayjones.plus.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287432>

On Thu, Feb 25, 2016 at 11:42 AM, Ramsay Jones
<ramsay@ramsayjones.plus.com> wrote:
>
> Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
> ---
>
> Hi Stefan,
>
> If you need to re-roll (err, one of your) 'sb/submodule-parallel-update'
> branches, could you please squash this into the relevant patch.
> (ie. "git submodule update: have a dedicated helper for cloning", 23-02-2016).
>
> Thanks!

It's part of v17 already.

Thanks,
Stefan

>
> ATB,
> Ramsay Jones
>
>  builtin/submodule--helper.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index f8cdce9..482a3cc 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -563,7 +563,7 @@ struct submodule_update_clone {
>         /* index into 'list', the list of submodules to look into for cloning */
>         int current;
>         struct module_list list;
> -       int warn_if_uninitialized : 1;
> +       unsigned int warn_if_uninitialized : 1;
>         /* update parameter passed via commandline*/
>         struct submodule_update_strategy update;
>         /* configuration parameters which are passed on to the children */
> @@ -575,7 +575,7 @@ struct submodule_update_clone {
>         /* lines to be output */
>         struct string_list projectlines;
>         /* If we want to stop as fast as possible and return an error */
> -       int quickstop : 1;
> +       unsigned int quickstop : 1;
>  };
>  #define SUBMODULE_UPDATE_CLONE_INIT {0, MODULE_LIST_INIT, 0, \
>         SUBMODULE_UPDATE_STRATEGY_INIT, 0, NULL, NULL, NULL, NULL, \
> --
> 2.7.0
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
