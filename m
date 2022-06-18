Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AAAAC43334
	for <git@archiver.kernel.org>; Sat, 18 Jun 2022 11:15:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232102AbiFRLPQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 18 Jun 2022 07:15:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234715AbiFRLPP (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Jun 2022 07:15:15 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 633C82253E
        for <git@vger.kernel.org>; Sat, 18 Jun 2022 04:15:14 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id u18so5869099plb.3
        for <git@vger.kernel.org>; Sat, 18 Jun 2022 04:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b4gq3NRnnlpkgMdSGQ7wli/06rWc6YCbk4xnPCJdhWM=;
        b=jx6qUjrlipdftMfFeuL12qbdoXpQJndM0ewwFCrlkX2lnNyGbJ51DSliIzRc2y9CAC
         4qGeX7G3Qq7XGtlbGmFWZykMtfXcuZq6N3St7PDeCz7J/5uvTQRlzuliT4/LoJ78mESt
         FlV5bKsf4iaMBiHHeYZaPxuc5BQ9Hx6WTPV55k3lmtbejfLtVW8Bye3TjKYNDOKIdk31
         Lrk9KFUkQ7r/0p+C+ZhMYZ5fttpVkw/sTZATmarR0/uiosJtCUavHPw5zq+H9uqiZOyA
         QLrdGUpQcDjnh93uJ/s7dXuPOyQIC2J+jj4muuJ6IYwb3UhKC3It5m5TJvS1/z4dzhPk
         gU7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b4gq3NRnnlpkgMdSGQ7wli/06rWc6YCbk4xnPCJdhWM=;
        b=cuw4jLfe9WW58js616ov0JEXuL9Z5k7ddDBsYOtFZnjl/HRxGeaegYN363tx+W4XQM
         8JOPyZFoj/ST/WOXJAlbdqe1lXyPF8ob/oOdJWMvyDCaSFBnnifRvS3ltRLl8ZT2q2DQ
         pHphnwaZ3rtFT+nfFd11a3RgjxsAa7A4qqRqOQfXcKgdVMZGm222RryOhDj44IaW7D+T
         KsRe+xe2eKUoRCu5KrNlIGnu/p/LigTnqsNXgGK0tqXeYnZ+OWyOGYwXUnyO5I4hzk/Z
         n6QIqWqRBjDI8egajG871q98idLpXRV3XhueHfI3y0QZieGYwIFVzTbxyfwPn0ATTn7r
         RlLg==
X-Gm-Message-State: AJIora/uwTYQcgfJAwnGM0nfugqSuuHQIK1hAkFRVzzjGfu1M79+FSNn
        OmQ8sr5bG0rBtEeM9rpDme5d3HgG8tpsHTWAgsJSWAiG65Y=
X-Google-Smtp-Source: AGRyM1s1uKflLq6Lsb2WQ8lvnc3J8kRtjuT80QzActtL2RG2jsDmjj+3q7+DxKXxCmjPhX5rLnt+83BnSdmc6BmxDOw=
X-Received: by 2002:a17:902:d5ce:b0:167:6c02:754c with SMTP id
 g14-20020a170902d5ce00b001676c02754cmr13964686plh.135.1655550913817; Sat, 18
 Jun 2022 04:15:13 -0700 (PDT)
MIME-Version: 1.0
References: <b4f40821-8592-1a35-8b60-219fd7e29e9f@luigifab.fr> <CAJyCBORdr3kaBbBmec5T5JAjcUpq6mSKQC=8_poLaZzSpkMJLA@mail.gmail.com>
In-Reply-To: <CAJyCBORdr3kaBbBmec5T5JAjcUpq6mSKQC=8_poLaZzSpkMJLA@mail.gmail.com>
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Date:   Sat, 18 Jun 2022 19:15:01 +0800
Message-ID: <CAJyCBOSc_n0is=77Ua_VZbce81qA0yKbUm6Dp2TxxpFAgVQ1OA@mail.gmail.com>
Subject: Re: git a/xyz or b/xyz
To:     Fabrice Creuzot <code@luigifab.fr>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jun 18, 2022 at 7:09 PM Shaoxuan Yuan <shaoxuan.yuan02@gmail.com> wrote:
>
> On Sat, Jun 18, 2022 at 6:50 PM Fabrice Creuzot <code@luigifab.fr> wrote:
> >
> > Hello
> >
> > When we are reading a "git diff", all paths are prefixed with "a/" and
> > "b/". Example:
> > diff --git a/xyz
> > index 4aa4b5230..1c2b8b69e 100644
> > --- a/xyz
> > +++ b/xyz
> > @@ -1,7 +1,7 @@
> >
> >
> > With my terminal, I double click on the path to select the full path for
> > copy.
> >
> > Then, when I paste: "git log a/xyz",
> >   git says: unknown revision or path not in the working tree
> >
> > Ok, I need to remove the "a/" or "b/".
> > But, is git can understand that "a/xyz" is "xyz" because "a/xyz" does
> > not exist?
> >
> > Thanks
>
> Hi Fabrice,
>
> You can think that "a/" stands for "before" or "old content", whereas
>  "b/" stands for "after" or "new content". Paths are prefixed with these
> to indicate which is before and which is after.
>
> For example, when you call "git diff", it is to "view the changes you made
> relative to the index (staging area for the next commit)".
> In this case, "before" is the index, namely "a/", whereas "after"
> is your current working tree, namely "b/".

A more precise way of saying is "a/" stands for source, whereas "b/"
stands for destination.

-- 
Thanks & Regards,
Shaoxuan
