From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 1/2] Modified flag field type in rev_list_info struct in
 bisect.h. There is no need for flag field to be signed, as it is not supposed
 to be used as decimal.
Date: Thu, 24 Mar 2016 12:51:24 -0700
Message-ID: <CAGZ79kZmzo+f9YF1K1oC2GfOrzdaojmrca7bUm3cBRoDreeA-g@mail.gmail.com>
References: <1458848469-12663-1-git-send-email-motroniii@gmail.com>
	<1458848469-12663-2-git-send-email-motroniii@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Motroni Igor <motroniii@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 24 20:51:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ajBI2-0002yy-DP
	for gcvg-git-2@plane.gmane.org; Thu, 24 Mar 2016 20:51:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750901AbcCXTv0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Mar 2016 15:51:26 -0400
Received: from mail-yw0-f181.google.com ([209.85.161.181]:35075 "EHLO
	mail-yw0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750775AbcCXTvZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Mar 2016 15:51:25 -0400
Received: by mail-yw0-f181.google.com with SMTP id g127so72385023ywf.2
        for <git@vger.kernel.org>; Thu, 24 Mar 2016 12:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=xUQe/DDPc8Giijm/iISAAdVOFC2oWw5niJ8YymN9A1w=;
        b=ot8aLxiWhtSWKpQi87mpRfcNuOGwj8sCFur8zMhA3ZCzraGT7GZxhXr/wX+rY+RqeG
         OtRE7W9qZ6AGIG08elWlcex9n9BJDJ+iFLBAcehmodgPrr/5zTpwde7ERJhECLGETRSS
         aoNRtrWNNUZhWjTDGb/p0goMIz8QjI9KjY28dIdNeQ9d4O6o7a8ohWs9Ex8qNhRzsIav
         KOvUckdwt/ICTHr4d5hDJLp0G61aTBpRn33L2dIBqdlVVqXyQLhyvEhoMpvAmId1g35b
         JY4I7IVVxVuOd5C/vo9IqpB1nW95eWpr7bMl/Lz+CfzpggC3HtSem0T9i+Ysw6ZbQPQB
         B2PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=xUQe/DDPc8Giijm/iISAAdVOFC2oWw5niJ8YymN9A1w=;
        b=jEPhmWNJVVOeiIf4GvBL7vvLhTZOfzBDTp0HA38qxD5QwPdXAIjMlz5FBccXZYTl5R
         jSGckFF4m0NOD63KSyatmmCaqylsLmer/r3XrGsEn1LHPiM9I0O1E7TpJPHv3QYRbI29
         81Mhs4x4DBfzyW+R1VQqUAmwRvitS/zXfK91mR0OIsfGHxvDtdHiJOmtOg1ch3Ls48Qh
         0W191n0xSHBXrgK1RaMKCS2yFN5B+izvBfk/X8PETj5frYkCijV2Fh+qKN9ug5vJ2a8S
         wi1QvGCIQzGekjHU6qTqkwJZVe5l/jCqMtRKYMoUrWbrUuednS5cUFbt8yg4dxbvipL/
         pTwQ==
X-Gm-Message-State: AD7BkJIN5uNWxxx1WrAn/Ccbha/ciCBsrqYlb3Z0e03CvWqQs+Ya/WE9kdq8isJw6yKwchGF+TwO2Z3shfwgEoin
X-Received: by 10.37.19.66 with SMTP id 63mr5737429ybt.75.1458849084619; Thu,
 24 Mar 2016 12:51:24 -0700 (PDT)
Received: by 10.37.51.137 with HTTP; Thu, 24 Mar 2016 12:51:24 -0700 (PDT)
In-Reply-To: <1458848469-12663-2-git-send-email-motroniii@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289789>

On Thu, Mar 24, 2016 at 12:41 PM, Motroni Igor <motroniii@gmail.com> wrote:
> From: Pontifik <motroniii@gmail.com>

Here is a good place to put reasoning for why this is a good idea.
I see you have a long subject, so maybe we can shorten the first line
(down to less than ~ 80 characters) and put the longer explanation
here.

How about:

  bisect: use unsigned for flag field

  The flags are usually used as a unsigned variable, because it makes
  bit operations easier to follow.



>
> Signed-off-by: Pontifik <motroniii@gmail.com>

>From Documentation/SubmittingPatches:
> Also notice that a real name is used in the Signed-off-by: line. Please
> don't hide your real name.

> ---
>  bisect.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/bisect.h b/bisect.h
> index acd12ef..a979a7f 100644
> --- a/bisect.h
> +++ b/bisect.h
> @@ -16,7 +16,7 @@ extern struct commit_list *filter_skipped(struct commit_list *list,
>
>  struct rev_list_info {
>         struct rev_info *revs;
> -       int flags;
> +       unsigned int flags;

You can also drop the int here and make it just
unsigned.

>         int show_timestamp;
>         int hdr_termination;
>         const char *header_prefix;
> --
> 2.5.0
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
