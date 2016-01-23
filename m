From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v6 09/11] config: add core.untrackedCache
Date: Sat, 23 Jan 2016 07:50:37 +0700
Message-ID: <CACsJy8B+qC_hR1+5PqwAVfsmLtSowFvkQrvN16qO_LCHDxGb9g@mail.gmail.com>
References: <1453283984-8979-1-git-send-email-chriscool@tuxfamily.org> <1453283984-8979-10-git-send-email-chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	David Turner <dturner@twopensource.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	Christian Couder <chriscool@tuxfamily.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 23 01:51:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aMmQ5-00065Y-N4
	for gcvg-git-2@plane.gmane.org; Sat, 23 Jan 2016 01:51:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753931AbcAWAvJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jan 2016 19:51:09 -0500
Received: from mail-lb0-f193.google.com ([209.85.217.193]:35754 "EHLO
	mail-lb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753058AbcAWAvI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jan 2016 19:51:08 -0500
Received: by mail-lb0-f193.google.com with SMTP id dx9so4423720lbc.2
        for <git@vger.kernel.org>; Fri, 22 Jan 2016 16:51:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=WgP7XenlEdd4eZLgkHZWcuTvslaW3VuxnPxjZU3FLmo=;
        b=lPuUg4IMiudqzYKWtUkDSLBDONkAZKM/cNvJku2c1qCvLWnnDXPSphKlgjZFflb/gU
         1qehAeQgOq+8Ms9phUI5fxOdM92MhO//KIplsjKfX9/R8lXEjCuXlaSGkdIoa9J/dw6X
         SishpPs0h50zjyqKhrqyRwwuM1a2Jl1Vb+5/nevtb2UD4nGbmjDfK5FRDnxYx+NqLa6l
         qI0zYaeSKtxSrpY0XmNCmbRcbW2xvzbtCHo88IFBk0Hzp/CmzkF6S5qQZ8uDY78JHpaJ
         RJ+gbZ9+52QgPtDyJ6O21s43PkAMn/LKkIWwCBgwl5YK1Xs+b2C6i0fT9+/swWEcWxfL
         v1jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=WgP7XenlEdd4eZLgkHZWcuTvslaW3VuxnPxjZU3FLmo=;
        b=VWnjSDpKZLiryTIsUiM5J1FF3Hrnf5x0iHmsgsGc+cof89W7F0OHBfFUERqp5vlWVd
         bfW81E9muJD/qJQ7+uO31wt0oFmuiNXwelps01lGM3ZKDAyj7vT6clsLRsCWNgDaVz+X
         zEOd3accjOydIJvt/IwUPbNBHNdLV9SFKcu4Bk71xRmLpVaSw4YCi9ta/t3gEp1d+PHB
         1cB/ahVd4sskfXQfH8TwOA6bK+0BDeE0s5nkCU9Ue0E8WUrNDiPAEX8FnzWGLoxfljfJ
         7hxuq7esQ0JqqE7DhMuwEwekJyDvpTNHBEme02Hc1wQXyEc5JFlRWYwAlsa5fniT9cM6
         l0Yw==
X-Gm-Message-State: AG10YOTKxr6l1jVAGPqiDpmsrA5AwqwuK1gCRZXNBxPjdnVrCClJH7WhI1JttP3nGTLP1LqHiCFH5k/HYJ+3ow==
X-Received: by 10.112.209.99 with SMTP id ml3mr2267511lbc.26.1453510266910;
 Fri, 22 Jan 2016 16:51:06 -0800 (PST)
Received: by 10.112.97.72 with HTTP; Fri, 22 Jan 2016 16:50:37 -0800 (PST)
In-Reply-To: <1453283984-8979-10-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284618>

On Wed, Jan 20, 2016 at 4:59 PM, Christian Couder
<christian.couder@gmail.com> wrote:
> diff --git a/read-cache.c b/read-cache.c
> index 84616c8..1d5696c 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -1622,6 +1622,20 @@ int read_index_from(struct index_state *istate, const char *path)
>                 return istate->cache_nr;
>
>         ret = do_read_index(istate, path, 0);
> +
> +       switch (git_config_get_untracked_cache()) {
> +       case -1: /* keep: do nothing */
> +               break;
> +       case 0: /* false */
> +               remove_untracked_cache(istate);
> +               break;
> +       case 1: /* true */
> +               add_untracked_cache(istate);
> +               break;
> +       default: /* unknown value: do nothing */
> +               break;
> +       }
> +

It would be safer to do this after a split index is merged. That is,
after merge_base_index() in this function. It's not wrong, because uc
can't be in the base index. But who knows what people will do in the
future. Because there are two exits in this function, maybe you can
rename check_ce_order() to post_read_index_from() and do this check
there too.

>         split_index = istate->split_index;
>         if (!split_index || is_null_sha1(split_index->base_sha1)) {
>                 check_ce_order(istate);
-- 
Duy
