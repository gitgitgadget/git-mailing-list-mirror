From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] sequencer: trivial cleanup
Date: Sun, 8 Sep 2013 17:53:19 -0500
Message-ID: <CAMP44s1fE0XZScL_gU5JAEdC0hPFHPTovqXLx7gqvwVdZbBaVw@mail.gmail.com>
References: <1378680160-4720-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 09 00:53:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VInrC-0002cd-IH
	for gcvg-git-2@plane.gmane.org; Mon, 09 Sep 2013 00:53:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750847Ab3IHWxW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Sep 2013 18:53:22 -0400
Received: from mail-lb0-f181.google.com ([209.85.217.181]:42342 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750753Ab3IHWxV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Sep 2013 18:53:21 -0400
Received: by mail-lb0-f181.google.com with SMTP id u14so4311365lbd.26
        for <git@vger.kernel.org>; Sun, 08 Sep 2013 15:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=ybL2jiPd6rFP3xk6JqrS5EkD63VowYppY366Y+ym/nQ=;
        b=TyVlXnc4XOkG5CJEs3rx0Eyd2ACac05ohhVc0XttVRp1b64MbcGIhx6yFve3R3g8kI
         Qfv7GhCvSXPijxtvs2fpTMZARHPKcL3GKOuMIpTvGaYQud4WbcJ/d74eYs8jBk+ztj7I
         ARrSU1/QpvK5o7nfbSe/m8sCuUeE3sMqFB58UQkBSjDB4HPeK9V625nX1oprNmm5hZ6o
         ZFU8V4Li6w0PxsYnRGNvXIC74p03CREF+s/crqStVZ2Ow2yhNwDRA62SDd/JJGTWzKOw
         emf8KM37/cuPgFDoV3R8jAAxAyFPfBr6xxBHKSeUMis/5mRIDZ7PZKYoaqBrRePtJgJ9
         bfBw==
X-Received: by 10.112.156.166 with SMTP id wf6mr13532996lbb.13.1378680799888;
 Sun, 08 Sep 2013 15:53:19 -0700 (PDT)
Received: by 10.114.91.169 with HTTP; Sun, 8 Sep 2013 15:53:19 -0700 (PDT)
In-Reply-To: <1378680160-4720-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234277>

On Sun, Sep 8, 2013 at 5:42 PM, Ramkumar Ramachandra <artagnon@gmail.com> wrote:
> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> ---
>  sequencer.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/sequencer.c b/sequencer.c
> index 351548f..8ed9f98 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -466,10 +466,7 @@ static int allow_empty(struct replay_opts *opts, struct commit *commit)
>         empty_commit = is_original_commit_empty(commit);
>         if (empty_commit < 0)
>                 return empty_commit;
> -       if (!empty_commit)
> -               return 0;
> -       else
> -               return 1;
> +       return empty_commit ? 0 : 1;
>  }

Isn't it the other way around? Moreover, 'return !!empty_commit;'
would be simpler.

-- 
Felipe Contreras
