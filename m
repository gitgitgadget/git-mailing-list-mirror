From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 3/5] fixup! d5ad6c13
Date: Wed, 8 Jun 2016 17:00:20 -0700
Message-ID: <CAGZ79kYjaWJ8=3rizFE+EZXS3P1LjX8bGD-6LwfmjG83cjgVJQ@mail.gmail.com>
References: <20160608225818.726-1-gitster@pobox.com> <20160608225818.726-4-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 09 02:00:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAnOc-00014g-Ej
	for gcvg-git-2@plane.gmane.org; Thu, 09 Jun 2016 02:00:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932867AbcFIAAW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2016 20:00:22 -0400
Received: from mail-qk0-f170.google.com ([209.85.220.170]:35963 "EHLO
	mail-qk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932119AbcFIAAV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2016 20:00:21 -0400
Received: by mail-qk0-f170.google.com with SMTP id i187so12884554qkd.3
        for <git@vger.kernel.org>; Wed, 08 Jun 2016 17:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=BvKZ6eo5xWUI01UcRKVfGFfAd2SCO14oCRIrQ2qEjDE=;
        b=HnLPBPA4d2+zW0log0TW65qjGvJPF1xC3sfkdC0wpDRwxVRxDRCBVnSiyDSofUTTUn
         q7DERajTABvanKXK+fitoIN1QZKZzWqH8WpacErrYmqfGi6U6CV0ZD/TXJ03fXgXXOrY
         WeoS4425XW+8zXVoujHXzL/x/lMLBJdguviN302MtvfniAXloxx8DM57EcshohHVOWE6
         lsiLlEyiq7L58kSnYtqnmYuOfiElfgvLSibn2X9INQ5R6CFVMeH0yDE8ZHWXRHL4Wc8p
         hf44zJO6dNtU1wkEy7poDgiB3l4y9WPrJf9tU5mWn/wCwi0PKGDAtR5G2xNwfh2Xsxup
         o7UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=BvKZ6eo5xWUI01UcRKVfGFfAd2SCO14oCRIrQ2qEjDE=;
        b=hlsrKFYH5rQFf/VfAxfiCgWVLxdyD53a4seZPPq3bmN/FKTwNRmCZlreedTQTiA8rv
         wQarI2pUNMzaapAd7s1OgD17hp9lJwyCqvfpTeMvMzFeJQe/EyCoiIoPOSE16tkqeB83
         YiMnEJDZ3+XPCmRdSRFFxpUxn19ac673n97P/qzOq9SlkXvxYQK3mCzQtq9XURm+YKQN
         BeCSSNO3J95AKAmRkgXzM7fCpoG7QaXjUM7mTM9GZ9lElO0lJKnUMMMZnfUEmoHRFVFB
         5Nq2z6JmzCNx8lxB6B7afRk1rztym1oio4jp2iamNy+SjLhltynOmlR9CCndpqCfmYBC
         12nA==
X-Gm-Message-State: ALyK8tLzeuOtQ2AOAKv/IVtUmYGLUaz/akag5rk7nKJzkUj9DjrD/cWNP1ul9Wlp9sJpPi0vQjESnxPTHGDN0Eqg
X-Received: by 10.233.223.5 with SMTP id t5mr7161549qkf.35.1465430420764; Wed,
 08 Jun 2016 17:00:20 -0700 (PDT)
Received: by 10.237.42.226 with HTTP; Wed, 8 Jun 2016 17:00:20 -0700 (PDT)
In-Reply-To: <20160608225818.726-4-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296862>

On Wed, Jun 8, 2016 at 3:58 PM, Junio C Hamano <gitster@pobox.com> wrote:
> As the topic is in 'next' already, I'll leave this floating near the
> tip for now, until we can rewind the topic after the next release.

I don't quite understand the motivation behind this commit.

    We return the last element to allow succeeding operations
    access to the bottom of the stack without needing to walk it?
    This makes the follow up operations faster, because we expect the stack
    to be larger than 5 elements.

?


> ---
>  attr.c | 9 ++++++---
>  attr.h | 2 +-
>  2 files changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/attr.c b/attr.c
> index 4e2172a..0e61950 100644
> --- a/attr.c
> +++ b/attr.c
> @@ -899,13 +899,16 @@ struct git_attr_check *git_attr_check_alloc(void)
>         return xcalloc(1, sizeof(struct git_attr_check));
>  }
>
> -void git_attr_check_append(struct git_attr_check *check,
> -                          const struct git_attr *attr)
> +struct git_attr_check_elem *git_attr_check_append(struct git_attr_check *check,
> +                                                 const struct git_attr *attr)
>  {
> +       struct git_attr_check_elem *elem;
>         if (check->finalized)
>                 die("BUG: append after git_attr_check structure is finalized");
>         ALLOC_GROW(check->check, check->check_nr + 1, check->check_alloc);
> -       check->check[check->check_nr++].attr = attr;
> +       elem = &check->check[check->check_nr++];
> +       elem->attr = attr;
> +       return elem;
>  }
>
>  void git_attr_check_clear(struct git_attr_check *check)
> diff --git a/attr.h b/attr.h
> index fc72030..40abc16 100644
> --- a/attr.h
> +++ b/attr.h
> @@ -47,7 +47,7 @@ extern int git_check_attr(const char *path, struct git_attr_check *);
>  extern int git_check_attr_counted(const char *, int, struct git_attr_check *);
>
>  extern struct git_attr_check *git_attr_check_alloc(void);
> -extern void git_attr_check_append(struct git_attr_check *, const struct git_attr *);
> +extern struct git_attr_check_elem *git_attr_check_append(struct git_attr_check *, const struct git_attr *);
>
>  extern void git_attr_check_clear(struct git_attr_check *);
>  extern void git_attr_check_free(struct git_attr_check *);
> --
> 2.9.0-rc2-262-g9161bbf
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
