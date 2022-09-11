Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95929C6FA83
	for <git@archiver.kernel.org>; Sun, 11 Sep 2022 11:01:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbiIKLBT (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 11 Sep 2022 07:01:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbiIKLBR (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Sep 2022 07:01:17 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E388A2AE1F
        for <git@vger.kernel.org>; Sun, 11 Sep 2022 04:01:16 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id q83so2803670iod.7
        for <git@vger.kernel.org>; Sun, 11 Sep 2022 04:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=u3Tyoo9FTqGoeXCsFBcogzNzlEuxURLHVEz6cqTvhfk=;
        b=H3rmuzydr0R8UA2FiNPRAY15+UpHlrmnURePX5rLu9BvVL54oT/lXZiMRO7wsrFYe9
         oa4xwi6B4ywiOsFuc+4ghPTU0LzVHE3Jg9GZ3sqAitoB52AVixAro3qteYrF1e9iLCQ1
         M3gJDmRi5MNRT7FKZ2Lx3Fyh7eMjHmJDc69miLLrLnsqQUGvyknVWK1jLIjT9X2YXvHL
         GNtNwO8c+V8ZpXOKnmjrb1uBxHOxxvJdIHosTzZ908ypSvGoGTN3g4IJvxIqptb1hAJT
         PPDQHXnRQ1m76w+6sWGqfZt+s9DsAhAmIHz6DemxgZ2gZSQR3EfBpGTwBMgAvPAfBcRT
         KfgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=u3Tyoo9FTqGoeXCsFBcogzNzlEuxURLHVEz6cqTvhfk=;
        b=JMRjYVVoRgvJgMTt6v8B7hvZMywi98ssZd+eEoQtQNX9GG4kILKT76Vk+OLCu+wRjT
         C29IaNFz/Ewvy2ehJ8Z0BF0yv0WxbTFvElyzrca0Fpc5dd4wCXUeHcPGXZ99PPc3VWrl
         lQKoEnCnMAkB24PSEYCfJ7e86qkW4CxWDk5IzKrLhwJ6YmauNuXYp9lAp/DITrCirl6r
         fWKd0c2s7Jo71MHvthcpKPmr3r91z4ZYhdEOiJq+q0EK4JQpllhgmw7ACUwSHk5GOyb7
         Yiwfg14wKgydIw/nKb4xB+EO0ia2tyanf0LUq5k01D1tDZ08YDf7xxXO55V1zGJn7vgF
         2ByA==
X-Gm-Message-State: ACgBeo3EtOQw9YVyvgzpNtpgU7nt4Os1J5YqV67F8/6DKx8GhWA5nIU6
        +Kb5F8r+nvx3LUddKNPcuC9B/kDkNksWsYa01ac=
X-Google-Smtp-Source: AA6agR6OZnYhB/ft8yjcYDcWwDXpPHdM8xFXgPc4shotg8PpchiIh03okkCBqIb7JZiKeY3YzwSJU+CPgdPH0SNVOgg=
X-Received: by 2002:a02:bb02:0:b0:35a:1f6f:6727 with SMTP id
 y2-20020a02bb02000000b0035a1f6f6727mr2232315jan.95.1662894076408; Sun, 11 Sep
 2022 04:01:16 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1262.v8.git.1658334983053.gitgitgadget@gmail.com>
 <pull.1262.v9.git.1658558685407.gitgitgadget@gmail.com> <CANYiYbFGSfg+iFV1ovhCSxW0YQSpemKUN-sS+F0BHee7KD5arA@mail.gmail.com>
In-Reply-To: <CANYiYbFGSfg+iFV1ovhCSxW0YQSpemKUN-sS+F0BHee7KD5arA@mail.gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Sun, 11 Sep 2022 19:01:05 +0800
Message-ID: <CAOLTT8RFWJ=LdZr1s5DWE7C2Uu9juzzfuhbXvQPe=b+ppXsPsw@mail.gmail.com>
Subject: Re: [PATCH v9] ls-files: introduce "--format" option
To:     Jiang Xin <worldhello.net@gmail.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jiang Xin <worldhello.net@gmail.com> =E4=BA=8E2022=E5=B9=B49=E6=9C=888=E6=
=97=A5=E5=91=A8=E5=9B=9B 10:01=E5=86=99=E9=81=93=EF=BC=9A
>
> On Sat, Jul 23, 2022 at 2:54 PM ZheNing Hu via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>
> > diff --git a/builtin/ls-files.c b/builtin/ls-files.c
> > index e791b65e7e9..779dc18e59d 100644
> > --- a/builtin/ls-files.c
> > +++ b/builtin/ls-files.c
> > @@ -222,6 +234,73 @@ static void show_submodule(struct repository *supe=
rproject,
> >         repo_clear(&subrepo);
> >  }
> >
> > +struct show_index_data {
> > +       const char *pathname;
> > +       struct index_state *istate;
> > +       const struct cache_entry *ce;
> > +};
> > +
> > +static size_t expand_show_index(struct strbuf *sb, const char *start,
> > +                               void *context)
> > +{
> > +       struct show_index_data *data =3D context;
> > +       const char *end;
> > +       const char *p;
> > +       size_t len =3D strbuf_expand_literal_cb(sb, start, NULL);
> > +       struct stat st;
> > +
> > +       if (len)
> > +               return len;
> > +       if (*start !=3D '(')
> > +               die(_("bad ls-files format: element '%s' "
>
> Good, the last space acts as a separator between two lines.
>
> > +                     "does not start with '('"), start);
> > +
> > +       end =3D strchr(start + 1, ')');
> > +       if (!end)
> > +               die(_("bad ls-files format: element '%s'"
>
> Missing the last space to seperate two lines, and this leads to wrong
> l10n message. See:
>

Thank you for pointing out the error, I will fix it quickly.

>     https://github.com/git-l10n/pot-changes/blob/pot/main/2022-08-03.diff=
#L70
>
> --
> Jiang Xin

Thanks,
ZheNing Hu
