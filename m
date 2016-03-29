From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 06/17] index-helper: add --detach
Date: Tue, 29 Mar 2016 09:35:59 +0700
Message-ID: <CACsJy8BMq4U65Ub0GPZJ8tU1F2bTwowmJ9PM_L907CJvMMRSZw@mail.gmail.com>
References: <1458349490-1704-1-git-send-email-dturner@twopensource.com> <1458349490-1704-7-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Tue Mar 29 04:36:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1akjWG-0004K1-Kx
	for gcvg-git-2@plane.gmane.org; Tue, 29 Mar 2016 04:36:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755595AbcC2Cgc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Mar 2016 22:36:32 -0400
Received: from mail-lf0-f49.google.com ([209.85.215.49]:33535 "EHLO
	mail-lf0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755547AbcC2Cga (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Mar 2016 22:36:30 -0400
Received: by mail-lf0-f49.google.com with SMTP id f67so1670343lfb.0
        for <git@vger.kernel.org>; Mon, 28 Mar 2016 19:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=CG/DntDC+bj4wlpm9MJE47xRF98zK21nEc/fNeLaVL4=;
        b=0DXRluZo4eiTYY4DlzK0LllSxZJ4ysX33fLxn6dIjbcxKyLWHyeKtg0uSf5V2A/RMB
         OLfUuy9lZQdhZZmXOcP7AkrXWtyDsOdjbAlXoVe/FDz49pjTJNOm73UoMg7kDOkeZ4Vk
         WR15SxbC8NFx99w9msla+/Xm9iPa632NR5xHwxespYSKCEwBaHT4dEwMdFulnL1sompR
         99P1OdK4eI+ydB44DNxfyppK1zt1K7ikeJwOlX8t11uVkkBCM8p5E0f9PiI55hioThrG
         aKEaTmydPbjLcWk9FGmKAFd0zcnNhPv6UzVQA8C3WNxlpxj/VyH5XvcX9DRPtzV0+pmr
         OVXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=CG/DntDC+bj4wlpm9MJE47xRF98zK21nEc/fNeLaVL4=;
        b=JsUjWdj4dDLWEfIq/bSA60yfk6HavISu7OzNjF94I9CHpnSYG3r1Z5eYWemUL9Bpro
         CLb8y8SfhduvHpSvv39stuFqQ0nF1ck53PWP5gJ0swB1tRVYcas/PUyMzZ8Vnauo43V+
         MynunOYCpFHpr2Bzq23RM42papdubvYCX9ajAwyLkF0WvjmkUWIRHMP9p08S60jsiv9Y
         ctnqWD5p31C0cK65j5sliSLQZRrRAC1oNKn3Iuxa19/x+UtC9d4MwEPWjMT85a8Fd/sj
         BUJW+NYJPQkEqQAp+U4xor1hW1uTt73DDzemOIQ1cgSdJNoCS/WeYNIbc0zDJ82LvKy1
         gBng==
X-Gm-Message-State: AD7BkJLw2QG6Nbie57FXwpAj9erShT+1oDNaG7QJin/9PvmqP9oxM1KDJ9y4EZdWXUuP6/XkUjrswa8qCTYMqw==
X-Received: by 10.25.153.198 with SMTP id b189mr1688835lfe.94.1459218989206;
 Mon, 28 Mar 2016 19:36:29 -0700 (PDT)
Received: by 10.112.167.10 with HTTP; Mon, 28 Mar 2016 19:35:59 -0700 (PDT)
In-Reply-To: <1458349490-1704-7-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290096>

On Sat, Mar 19, 2016 at 8:04 AM, David Turner <dturner@twopensource.com> wrote:
> @@ -237,6 +239,7 @@ int main(int argc, char **argv)
>                             N_("exit if not used after some seconds")),
>                 OPT_BOOL(0, "strict", &to_verify,
>                          "verify shared memory after creating"),

N_() here (my bad)

> +               OPT_BOOL(0, "detach", &detach, "detach the process"),

ditto

>                 OPT_END()
>         };
>
> @@ -258,6 +261,10 @@ int main(int argc, char **argv)
>         fd = setup_pipe(pipe_path.buf);
>         if (fd < 0)
>                 die_errno("Could not set up index-helper.pipe");

_() here

> +
> +       if (detach && daemonize(&daemonized))
> +               die_errno("unable to detach");

and here

> +
>         loop(fd, idle_in_seconds);
>         return 0;
>  }
> --
> 2.4.2.767.g62658d5-twtrsrc
>



-- 
Duy
