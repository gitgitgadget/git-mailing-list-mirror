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
	by dcvr.yhbt.net (Postfix) with ESMTP id C16E81F4C0
	for <e@80x24.org>; Fri, 25 Oct 2019 15:23:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440671AbfJYPXd (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 Oct 2019 11:23:33 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:34159 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731562AbfJYPXd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Oct 2019 11:23:33 -0400
Received: by mail-io1-f66.google.com with SMTP id q1so2882134ion.1
        for <git@vger.kernel.org>; Fri, 25 Oct 2019 08:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/pJYR8mFaHBgc/bi3q+Rqple5QSOKD/TYFrami1tTBY=;
        b=dUXf8LMLmxeSyKFz7IiNeHZaamHzORZceQ1WL2lHDYn+0vZYMmSRftvfucWmHWzEaS
         2qjWeBbanXzYdSE1KsYue45mIeyCqqi0Shho/GDQAWrppOOXmgH6z1qqBRpBgyOuFjGo
         2nJmht0CihIQ4O+Vw09kj6ssEXD1lwpIw4dzWbFb08SEOEWYVIoz04Y+xG2xUTpZKDtj
         Xgyqy+4X4oiarIG/Xl6ymVfzIG+JAz2KH1dOiP7CSsTzP6nEqBGK7d5I7yHrQX6kC6sM
         6v3EWLqpz0OZ8zj3r4iUN9OKWEb8zu1RfKPOxr/FIkemklVyv91U0KMNKkGKU+kWYNTU
         En6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/pJYR8mFaHBgc/bi3q+Rqple5QSOKD/TYFrami1tTBY=;
        b=YIPEvHX07EgQlfxoaKP4GLltnSx5L3AObeSqk2UHycYYLFDZpK5qoQmPYxZstmL42z
         rBEFuLvyeBIyom8xluiMcw3TSVwYHf5OJ7/MWwmc76vczm5qFmbdn6wYZ3kTUs1I98mc
         +xbBmsMVgZXTfdWz81LTW2sVdfuNg6ZTc9wcn3fCZPVn2GVwCUFjF89wqhq8e6NP7aVI
         CSwVB0bDGmrNIE/TI392IWQdDKrszP+cLKC3uCzFEHoZJ+zJJcDlcRWJnpEptJzT/tEG
         2SQ9KNTBAYHNxW9caLtHhdt2BmcX2IotMZnszNZ5vXS9aC6TOJieb6qQc8/n6n2QfWw2
         Ih0Q==
X-Gm-Message-State: APjAAAXywWIwJYWaXmHcpKT21Xl6oi8ydkK3TgAA5lb3tCwL5GLH2JI/
        PdLxNuW24LOwcSENXa4hZRK7xSlnkFmWhza3P+G91A==
X-Google-Smtp-Source: APXvYqwzj/sT+jH0bmpTKoYR3wtl8QDsv9AZdz9ePmDTh1vQWv+6fWqzC+0/6jOu50qT0fp6M7BnWKYz6aQOPvLFdVU=
X-Received: by 2002:a5d:8344:: with SMTP id q4mr3859574ior.99.1572017012159;
 Fri, 25 Oct 2019 08:23:32 -0700 (PDT)
MIME-Version: 1.0
References: <20191024092745.97035-1-mirucam@gmail.com> <20191024114148.GK4348@szeder.dev>
 <xmqqmudpee57.fsf@gitster-ct.c.googlers.com> <CAN7CjDB9mRTNRKRoE8XfLz4in5gV6pxrKrqcjLPfthDHaf20nA@mail.gmail.com>
 <xmqqzhhpb1nx.fsf@gitster-ct.c.googlers.com> <CAP8UFD1_vnjApobt+aN3M12g8mLqOZJGyvr4oqqTax5=cmLhsg@mail.gmail.com>
In-Reply-To: <CAP8UFD1_vnjApobt+aN3M12g8mLqOZJGyvr4oqqTax5=cmLhsg@mail.gmail.com>
From:   "Miriam R." <mirucam@gmail.com>
Date:   Fri, 25 Oct 2019 17:23:21 +0200
Message-ID: <CAN7CjDC169rv8p9ZJcoLMeisXh7eMVcE4_-bpz8XFiYUsWAakQ@mail.gmail.com>
Subject: Re: [Outreachy][PATCH] abspath: reconcile `dir_exists()` and `is_directory()`
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ok! Thanks to everyone.

Best,
Miriam

El vie., 25 oct. 2019 a las 16:48, Christian Couder
(<christian.couder@gmail.com>) escribi=C3=B3:
>
> On Fri, Oct 25, 2019 at 11:43 AM Junio C Hamano <gitster@pobox.com> wrote=
:
> >
> > "Miriam R." <mirucam@gmail.com> writes:
> >
> > > Ok, then after discussion, finally the issue tasks would be:
> > >
> > > - Add path_exists() that will work same as file_exists(), keeping for
> > > now the latter.
> > > - Use path_exists() instead of dir_exists() in builtin/clone.c.
> >
> > Sounds about right.
> >
> > > And also:
> > > - Rename is_directory() to dir_exists(), as it is the equivalent to
> > > path_exists()/file_exists(), isn't it?
> >
> > I wouldn't go there in the same series, if I were doing it.  I'd
> > expect that such a patch would be more noisy than it is worth if
> > done in a single step.  In order to avoid becoming a hindrance to
> > other topics in flight, an ideal series to do so would support the
> > same functionality with both old and new names, convert code that
> > use the old name to use the new name, possibly in multiple patches
> > to avoid unnecessary textual conflicts (i.e. some of these patches
> > made to areas that are seeing active development will be discarded
> > and need to be retried later when the area is more quiet) and then
> > finally the function wither the old name gets removed.
> >
> > You would not want to mix the first two bullet points that are
> > relatively isolated with such a long transition.
>
> Yeah, and for a micro-project it is more than enough if you only work
> on the first two bullet points.
