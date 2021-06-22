Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B14EFC4743C
	for <git@archiver.kernel.org>; Tue, 22 Jun 2021 00:43:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 884A46124B
	for <git@archiver.kernel.org>; Tue, 22 Jun 2021 00:43:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbhFVApu convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Mon, 21 Jun 2021 20:45:50 -0400
Received: from mail-ed1-f43.google.com ([209.85.208.43]:33639 "EHLO
        mail-ed1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230318AbhFVApt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Jun 2021 20:45:49 -0400
Received: by mail-ed1-f43.google.com with SMTP id d7so21437470edx.0
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 17:43:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=BdiJqDWsC8RJhGb65o3d8NJbLFGchh+cwwaA/DSm8dI=;
        b=uMwDjn1oSbmZ32pZiDpQkHFpgre0aohGiGQ4rAqQ+8C84fEvZ0Q85q7YZHUfKrSsdz
         NsV3mgNWwkXGbdsDkwjhjjuCO+WjlrGWRVYSDeB2+qoImCgrCHXl06JUvbXD/XYtsJoT
         gj9oQwZkeFsoAV1xD742jrSA5B8uUnyMa7hnQyDZIUFVjnC+auolDNpe1blv2mjvW5KY
         kTTgdynZHywv6kXx1xsWgf6x6ou2XtnZi/3r2FYQyuY6KW7b3uOyq1folH4FuymacE2w
         wvoHF9SWU6fXMX5TrQGGUzLOeCOflga5KGThQEnvygbP05TUleGuzWc+7NLgyxUz56oL
         saGg==
X-Gm-Message-State: AOAM533M9NXpANJlzCTmJVZIw3r/zauxqZSB1rjK9oz8jeFmlGa8JVwx
        IK19fsSREBWrnZv+EAj5Q7YFz56i+cYwIu/YfrY=
X-Google-Smtp-Source: ABdhPJxXXpDhswt9HtvjMiibgmzyC9gpei7M3/aOk9eLKjYd7tBYn5SUXP+5V48B8L6vD2lr6fT3KfgN0kV7KV5nHKo=
X-Received: by 2002:a50:9d8d:: with SMTP id w13mr1360503ede.94.1624322612822;
 Mon, 21 Jun 2021 17:43:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210615172038.28917-1-congdanhqx@gmail.com> <20210619013035.26313-1-congdanhqx@gmail.com>
 <CAPig+cR7tUXB4=j3fGHN07=tPJ-skGb_6M7SExTq5eAH7FSwOQ@mail.gmail.com>
 <xmqqfsxel6oo.fsf@gitster.g> <CAPig+cQdDibt2K6jFKehaWyGdtb72pj7FQ9nGLJYEmqna3vf5w@mail.gmail.com>
 <xmqqy2b6jql2.fsf@gitster.g> <YNEmN0HmQbiCMuaU@danh.dev>
In-Reply-To: <YNEmN0HmQbiCMuaU@danh.dev>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 21 Jun 2021 20:43:22 -0400
Message-ID: <CAPig+cSmzCJB3LUwFT0YC4uMJ20nysPue7rUAutyvKVB4uyMbg@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] t: new helper test_line_count_cmd
To:     =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 21, 2021 at 7:52 PM Đoàn Trần Công Danh
<congdanhqx@gmail.com> wrote:
> On 2021-06-19 15:50:17+0900, Junio C Hamano <gitster@pobox.com> wrote:
> > Eric Sunshine <sunshine@sunshineco.com> writes:
> > > Indeed, I have no problem seeing this as a new mode of
> > > test_line_count() triggered by an option. In fact, I suggested exactly
> > > that[1] when this idea first arose (except I named the option `-c`
> > > rather than `-e`, but the latter is fine). However, my suggestion was
> > > pretty much shot down[2] (and I don't entirely disagree with [2],
> > > which is why I didn't pursue the idea in [1]).
> >
> > Yeah, I still am skeptical that we'd gain much by hiding the
> > redirection to >actual behind the helper, so as I said in response
> > to the v2 series, I am fine without this new helper or an enhanced
> > test_line_count, but go with more use of test_must_be_empty etc.
>
> I guess the overall feedback for this new helper is negative.
> I think the consensus here is a local helper in t640{0,2} for counting
> ls-files?

A local specialized function makes sense to me.
