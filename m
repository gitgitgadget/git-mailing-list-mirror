From: Stefano Lattarini <stefano.lattarini@gmail.com>
Subject: Re: [PATCH] make color.ui default to 'auto'
Date: Wed, 15 May 2013 15:20:16 +0200
Message-ID: <51938B90.8040004@gmail.com>
References: <vpq61yky2zp.fsf_-_@grenoble-inp.fr> <1368619757-10402-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Wed May 15 15:20:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ucbd4-0004la-Cy
	for gcvg-git-2@plane.gmane.org; Wed, 15 May 2013 15:20:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932338Ab3EONUW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 May 2013 09:20:22 -0400
Received: from mail-bk0-f45.google.com ([209.85.214.45]:45422 "EHLO
	mail-bk0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932241Ab3EONUV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 May 2013 09:20:21 -0400
Received: by mail-bk0-f45.google.com with SMTP id je9so981253bkc.4
        for <git@vger.kernel.org>; Wed, 15 May 2013 06:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=2jhPVGAS0SZI/2C8Pq9Cf3ekvBGvIbpyZ3QoJJGENtg=;
        b=EMCHsyAKcvfOOIpPzeFaFhu9GVLyIoMLNqPNqr61gpgxK2WOEPxtzPn2at8fPWILSc
         Ur9goYBqHRQpDB1bVVy8DEb1ntAi0WLYe/wtqEoKXlbz5AsDO7+HQHghPGNMvCFnh0gF
         AA0tgX8Z3NZWMuVIT8RcdkDmE06yLTWNlvPNfJR6NxJ166WcoultPIV2YR/cH5XOOKOg
         j062ERXhDQWwSyoYkCgPNsbSbRZLd5LsekGzCKJ7x2gZIHmci2973/60StHgZ4ia8+LS
         NMi8xVz3cZ4TiuA2vbcKqidz/VUCW1QhJMcTKk25vQRVsfJbXI93LkjrsAeIgL819yAd
         E+4A==
X-Received: by 10.205.44.129 with SMTP id ug1mr10342169bkb.29.1368624020040;
        Wed, 15 May 2013 06:20:20 -0700 (PDT)
Received: from [192.168.178.20] (host93-95-dynamic.6-79-r.retail.telecomitalia.it. [79.6.95.93])
        by mx.google.com with ESMTPSA id iy11sm824407bkb.11.2013.05.15.06.20.18
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 15 May 2013 06:20:19 -0700 (PDT)
In-Reply-To: <1368619757-10402-1-git-send-email-Matthieu.Moy@imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224405>

On 05/15/2013 02:09 PM, Matthieu Moy wrote:
> Most users seem to like having colors enabled, and colors can help
> beginners to understand the output of some commands (e.g. notice
> immediately the boundary between commits in the output of "git log").
> 
> Many tutorials tell the users to set color.ui=auto as a very first step.
> These tutorials would benefit from skiping
>
s/skiping/skipping/

> this step and starting the
> real Git manipualtions earlier.
>
s/manipualtions/manipulations/

> Other beginners do not know about
> color.ui=auto, and may not discover it by themselves, hence live with
> black&white outputs while they may have prefered colors.
>
s/prefered/preferred/

> A few people (e.g. color-blind) prefer having no colors, but they can
> easily set color.ui=never for this (and googling "disable colors in git"
> already tells them how to do so).
> 
> A transition period with Git emitting a warning when color.ui is unset
> would be possible, but the discomfort of having the warning seems
> superior to the benefit: users may be surprised by the change, but not
> harmed by it.
> 
> The default value is changed, and the documentation is reworded to
> mention "color.ui=false" first, since the primary use of color.ui after
> this change is to disable colors, not to enable it.
> 
> Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
> ---
>>> I'd love to see this by default, yes. Maybe a 2.0 change?
>>>
>>> If people agree that this is a good change, would we need a transition
>>> plan? I'd say no, as there is no real backward incompatibility involved.
>>> People who dislike colors can already set color.ui=false, and seeing
>>> colors can hardly harm them, just temporarily reduce the comfort for
>>> them.
>>
>> I vote for this. It's the first thing I do in any setup, even the ones
>> that are note mine. I've also seen it in basically all the tutorials,
>> even before setting user.name/email.
>>
>> I also don't see the point of a transition plan.
> 
> OK, then let's try turning the discussion into code.
> 
> I'm starting to wonder why we didn't do this earlier ;-).
> 
>  Documentation/config.txt | 11 ++++++-----
>  color.c                  |  2 +-
>  2 files changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 1009bfc..97550be 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -913,11 +913,12 @@ color.ui::
>  	as `color.diff` and `color.grep` that control the use of color
>  	per command family. Its scope will expand as more commands learn
>  	configuration to set a default for the `--color` option.  Set it
> -	to `always` if you want all output not intended for machine
> -	consumption to use color, to `true` or `auto` if you want such
> -	output to use color when written to the terminal, or to `false` or
> -	`never` if you prefer Git commands not to use color unless enabled
> -	explicitly with some other configuration or the `--color` option.
> +	to `false` or `never` if you prefer Git commands not to use
> +	color unless enabled explicitly with some other configuration
> +	or the `--color` option. Set it to `always` if you want all
> +	output not intended for machine consumption to use color, to
> +	`true` or `auto` (this is the default since Git 2.0) if you
> +	want such output to use color when written to the terminal.
>  
>  column.ui::
>  	Specify whether supported commands should output in columns.
> diff --git a/color.c b/color.c
> index e8e2681..f672885 100644
> --- a/color.c
> +++ b/color.c
> @@ -1,7 +1,7 @@
>  #include "cache.h"
>  #include "color.h"
>  
> -static int git_use_color_default = 0;
> +static int git_use_color_default = GIT_COLOR_AUTO;
>  int color_stdout_is_tty = -1;
>  
>  /*
>
With the typos above fixed:

  Reviewed and supported-by: Stefano Lattarini <stefano.lattarini@gmail.com>

Thanks,
  Stefano
