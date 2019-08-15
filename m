Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C33CC1F45A
	for <e@80x24.org>; Thu, 15 Aug 2019 22:07:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732073AbfHOWHE (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Aug 2019 18:07:04 -0400
Received: from mail-ua1-f45.google.com ([209.85.222.45]:38850 "EHLO
        mail-ua1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730952AbfHOWHE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Aug 2019 18:07:04 -0400
Received: by mail-ua1-f45.google.com with SMTP id g13so1363556uap.5
        for <git@vger.kernel.org>; Thu, 15 Aug 2019 15:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=cDKGKATdOT1TxJFO+V5ImRhM0QVtPP8r+2NS59mGgW4=;
        b=TZqMX3vu9mHoijk/9UjyBoIzZrfUsqLDEh1k0rkpLwnvXtDISjRWkqYRSL2Kjb1OSD
         JFfb7QNQJ9erYSjP4DVHnV4tH5ywrUgxS804dgxeQn3izS4aDE15iw3ac0gyliHEbC+R
         BB66jOMnv45z5hI3N5Nlcw2ktRBr03Ed9YNnXCdrcSwxU2wU6VGvsPorM7ZwOUNklygW
         RdLYe7d/M7+KvvJxbGTqI4PtqPZa9BAgBskvMUIn32ur1Z7hGuf+xzC05usrfpAkaskp
         wxLWmbwjkSk0g+UL7TI4Rdg9Z8ErobfQvdz2U9kJUMGY7cidhOHnmzMOAOjopvqNHPxv
         u9Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=cDKGKATdOT1TxJFO+V5ImRhM0QVtPP8r+2NS59mGgW4=;
        b=I0DQ2yx84JOpMNM/Eol+Nxr3EOJXgSsnL+Do0ylqI9l7pPXAqhBtsc7e42Y4pPzUoP
         fQW67ZbkaBQvQrKxWv+fYHhdQBFBoVumLOaNAg8n1EOZDypyPSHslkn8uGs2OcWx2t6Q
         tmGfi9pqCssnjAt49fdZoGl9EARWpCbCwnFfA6URyjpR5sWDpNUQYwbYlA0rvF+ra1MJ
         NqgGv52CIuujA6kw39mRGEbNm61W4hEmL6jbd5R8Ywd0OPSVn7lXMbCPTsJZJuDGn++a
         vVNxDmwMF3leHZdDra6dhNhMUgWqqeUgPOAJgIF2Jb9NOEek+2xVB8klG8PWK7Gsf6CN
         pBpw==
X-Gm-Message-State: APjAAAVk8ZDp/m1hRWUY/B97Oy15t8GNR9aAZahiPvTvGSJuhhz0sOZ5
        /KpkcemCVXTUkX5A/u9flgPhtOyKMlLVUQT+exBw+g==
X-Google-Smtp-Source: APXvYqwK0C1xWVQ0JlbEQQc67ll8r5avqjL21nSSP5NIoEofNn8qRImIr/67DtTCIU5t8j8eSHZXqfhO18UE+3y48kc=
X-Received: by 2002:ab0:3159:: with SMTP id e25mr4372503uam.81.1565906823308;
 Thu, 15 Aug 2019 15:07:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190815220303.17209-1-newren@gmail.com>
In-Reply-To: <20190815220303.17209-1-newren@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 15 Aug 2019 15:06:51 -0700
Message-ID: <CABPp-BHupqJaJzK9yXxvTEPkuaoq_yW0ZJ7z0nZXODhaRdrYyg@mail.gmail.com>
Subject: Re: BUG?: xdl_merge surprisingly does not recognize content conflict
To:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 15, 2019 at 3:03 PM Elijah Newren <newren@gmail.com> wrote:
>
> It appears git.git had a case of a patch being resubmitted and both the
> original (nd/checkout-m-doc-update) and new (nd/checkout-m) versions
> getting applied, with the merge picking to include both versions of some
> of the text rather than just one of the two.  I have a patch below to
> delete the duplicate hunk, but more surprising to me was the fact that
> re-running the merge in question did not show any conflicts despite the
> two patches adding different text in the same location.

Sorry, I should specify that I've tested that this behavior goes back
to at least git-1.6.0, so it certainly isn't a new regression and
doesn't need to hold up git-2.23.0 by any means.
