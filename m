Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AFA7220248
	for <e@80x24.org>; Mon, 11 Mar 2019 15:23:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727063AbfCKPXU (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Mar 2019 11:23:20 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:55435 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726826AbfCKPXU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Mar 2019 11:23:20 -0400
Received: by mail-it1-f195.google.com with SMTP id z131so7866391itf.5
        for <git@vger.kernel.org>; Mon, 11 Mar 2019 08:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Vo2lazAMYQJ6+rQq6U3Hfps65rwh/N9DycKPVnLPw68=;
        b=eZiisDzAFpyGeEViRkSd9C9QIP/BXBQmqFEEaSuglU/bXM8nUnUy8VHnHygKzX7ynd
         4tmdFMwsbYc/vM4TEl5Y1k7PElB00ootxUaW421uZEj1MCWUy7rY3NeKoj8++sRUNn63
         dCoTqoiOJqHdv8U2or4G9q1xwU/OrqTzuwUhZj1FQjb9jClW1KteByFbpcQ5Wp5ukhg+
         I3Lygq8SHnvr+67osUlJPKaeN+3up+CB5ZtTplDotgexK6cs/CFPQThc0p+QaSf3uYv+
         HsxyZTewvkAKJWvB9vpjtixfoj7mzWSivwqU7YVHKspVWID6ZGeJ0Ohh92m5dgDUJN6W
         7WCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Vo2lazAMYQJ6+rQq6U3Hfps65rwh/N9DycKPVnLPw68=;
        b=RYe7w676ZUzmE1oiJedQjg4+M3fdkSti8LEUNU26WeYQMqxARZdb3Qi9AT9YSqaJHm
         F7wgUMFHeeqN/DagZeyquX73V29Ve2bZueclBACu60VMnamH7f2C3a2znFfuOEvCN72J
         Dg/V2KrIOBChLo5h7o+LEv74YK78KSQL38Z+mKExIlpIUKDzpc6IXh52Mh/YX20FYIMV
         HEP1hFCZO0v6xuWx611Gk/GThox4dE+MmGNc5tPn5Ba0FiPrUbvTH+3dm6i4AWrCGMDX
         o/9hmIUgGAtWUqHdpA1NtGnKBgVR1aTtl19UhkM/P/5x00ijmi2tAQw6EzUxuIshslZT
         DKvA==
X-Gm-Message-State: APjAAAXp07U4+9CEjf/5muP5uJwuAksYrCai5wYngL4ybn1ftMyTUbTk
        j/DZdcgxifKJBZ4iic43Vj4OuK2BVMwli4nrS0FWpA==
X-Google-Smtp-Source: APXvYqxgGEcrLMyvf5aIv2XDC2nMau57l1UM+vQTur/SDJMkHpOBXY4uyk4Tz72rB2iFOQy7uMKUN/BZI3kOxODMBtA=
X-Received: by 2002:a02:1c49:: with SMTP id c70mr178376jac.92.1552317799515;
 Mon, 11 Mar 2019 08:23:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190308101655.9767-1-pclouds@gmail.com> <20190308101655.9767-11-pclouds@gmail.com>
 <CABPp-BGbqYUMEK0V_m0i7dpFb38Mm3sS-h0Ut-GSdvsKEZzRQg@mail.gmail.com>
In-Reply-To: <CABPp-BGbqYUMEK0V_m0i7dpFb38Mm3sS-h0Ut-GSdvsKEZzRQg@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 11 Mar 2019 22:22:53 +0700
Message-ID: <CACsJy8DeGQ=GRnRByNQ18Npe5JEcRXBf2oK3Xg6uv44OCg_EBA@mail.gmail.com>
Subject: Re: [PATCH v1 10/11] completion: support restore
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 10, 2019 at 2:17 AM Elijah Newren <newren@gmail.com> wrote:
>
> On Fri, Mar 8, 2019 at 2:17 AM Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy =
<pclouds@gmail.com> wrote:
> >
> > Completion for restore is straightforward. We could still do better
> > though by give the list of just tracked files instead of all present
> > ones. But let's leave it for later.
>
> s/give/giving/
>
> I'm slightly worried that due to using --no-overlay mode by default in
> restore, having tab-completion include untracked files increases the
> risk of accidentally nuking the wrong file.  restore is a destructive
> command anyway and should thus be used with care, so perhaps this
> isn't a big deal, but I thought I'd mention it.

This makes me think about my "git restore :/" example, which does not
remove untracked files because its source is the index. But isn't it
inconsistent that we only remove untracked files with --source and
keep them without? Will that just confuse people more? Or did I just
forget to implement no-overlay mode for the index too?

Side note, to enable overlay mode again in git restore, maybe "git
restore --keep-untracked --source..." will be better than "git restore
--overlay --source..."
--=20
Duy
