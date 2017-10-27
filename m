Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7B25F1FAED
	for <e@80x24.org>; Fri, 27 Oct 2017 17:35:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932307AbdJ0RfY (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Oct 2017 13:35:24 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:50427 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932190AbdJ0RfX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Oct 2017 13:35:23 -0400
Received: by mail-pg0-f65.google.com with SMTP id y5so5795584pgq.7
        for <git@vger.kernel.org>; Fri, 27 Oct 2017 10:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=AmOtPeMvMoeTQpeHc+VNNLVPV1frdOsetxGWGM5b2h8=;
        b=a8TlByMmrIfkshQs9/hioejwNAeVqGVy9S8z9w9Pars5Lgyj7dbSct3JW3wZILCQTF
         eLa2MlX2PmXg2YQfISda6e7o8gQa53cjqLvCqMSI+QRHmUwcip8+sA3hsnL8uob88mLv
         sgvn8OzToPuXqb3rLBRbdF9ecnZw+jAjpldeu0pSoLtQZ2NKF1DzsxrHIps64jh/yWv3
         SnKb6GhneCQcxbcOamW4yDz3amWDLRawqCmLM52v/56jQSqqrqiij9QX++yss4QrNQ6U
         Cpt1Ob6fpwTbY+AIQ4Xuzum+WgIDhe2HQqoYlXDfXdhThhKcDB5x/9I7h74VJNKU6Ipq
         pbFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=AmOtPeMvMoeTQpeHc+VNNLVPV1frdOsetxGWGM5b2h8=;
        b=Y520RYFHOi0hkwroyylgh0nyimYeC/jnQA/KR1Z99sTSKj4e5jIFu3bz3ySQIQrc8R
         K1EjeuNXTET+0nnJwQjBB+Zzkc61TL/d66xeyXimpEujEOdyhGu4lqsEPK2qxk75n1cO
         ZhDJbeR25ylOt51E3OBQzvOm8HXQ8k5UBFHxmtSv3XxaE76eFtab+Wq36quKWohh9G2R
         kmjcVJWAe/aBDznqT8yTv5k5JklaUsmzpTrtYv/OhPKWybLUR/Wv3nFolAfcfDVWMuw4
         DiTKRlx4uLjKG/hhDUAXSpRo5HcR8XPycSg/UhmQaqDQhimyIY8w6fv2M+nLmCs2YgSp
         4kDA==
X-Gm-Message-State: AMCzsaVik77rUdUAs0OiEJvjakrfysgpG3pN4o6Y5CM2ZWUvxvJGdytS
        nCp3HVh/qzCpWjr7d+QsqwG9eFwGjfNNXZDKSTw=
X-Google-Smtp-Source: ABhQp+T313OF0jRyDuPpimCPy32GXF2hgUl3gKNjnMlIDTjJTCZmEMxMLaIAd+L/yIxDpEPPCaR8DRsrqP6dhTOsCLs=
X-Received: by 10.99.63.199 with SMTP id m190mr863964pga.201.1509125722827;
 Fri, 27 Oct 2017 10:35:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.177.141 with HTTP; Fri, 27 Oct 2017 10:35:22 -0700 (PDT)
In-Reply-To: <0102015f5e5ee2ca-bf824205-86e6-4259-b7d7-a68e2fbb087d-000000@eu-west-1.amazonses.com>
References: <0102015f5e5ee171-f30f4868-886f-47a1-a4e4-b4936afc545d-000000@eu-west-1.amazonses.com>
 <0102015f5e5ee2ca-bf824205-86e6-4259-b7d7-a68e2fbb087d-000000@eu-west-1.amazonses.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Fri, 27 Oct 2017 19:35:22 +0200
Message-ID: <CAN0heSpRc5VwuMgusoPBegUSsc3t8USK6hm2wd5CyqNpKUiObg@mail.gmail.com>
Subject: Re: [PATCH v16 Part II 5/8] bisect--helper: `bisect_next_check` shell
 function in C
To:     Pranit Bauva <pranit.bauva@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Jiang Xin <worldhello.net@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 27 October 2017 at 17:06, Pranit Bauva <pranit.bauva@gmail.com> wrote:
> +               /*
> +                * have bad (or new) but not good (or old). We could bisect
> +                * although this is less optimum.
> +                */
> +               fprintf(stderr, _("Warning: bisecting only with a %s commit\n"),
> +                       terms->term_bad);

Maybe this should use `warning()`?

> -               # have bad (or new) but not good (or old).  we could bisect although
> -               # this is less optimum.
> -               eval_gettextln "Warning: bisecting only with a \$TERM_BAD commit." >&2

I wonder if we can somehow pick up the existing translation? It would
now be fuzzy, in some sense, but since the string was originally in a
different file, maybe the po-tools won't be able to discover the
fuzzyness? We could add a TRANSLATORS-comment, so that the translators
know that this string matches an old one. There are more strings like
that in this patch, and maybe in some others as well, I haven't looked.

(Adding Jiang to cc.)
