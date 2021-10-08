Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6372C433F5
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 23:15:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95DC560F92
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 23:15:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243749AbhJHXRT (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Oct 2021 19:17:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231876AbhJHXRS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Oct 2021 19:17:18 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 924B1C061570
        for <git@vger.kernel.org>; Fri,  8 Oct 2021 16:15:22 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id k13so11506872ilo.7
        for <git@vger.kernel.org>; Fri, 08 Oct 2021 16:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=uW2PEZfeSdLSHdLSCb5xQw1H/oXnf5DXCKRlroW2dJU=;
        b=SLKr5EuPhcSc8S2YjMNNxFXttuu4O43uy2mnHmNft0JylqMZ/hJSC1ZgLR7QD9n+Ru
         A1F18sIncm0c9k2bkHEhB8SX0rZlF+YzViMdhDZ19D146MFbRURJkCK/aWOR/2UYBSuV
         S1FXQ/w3wgZwBwQ2wTLlh0G+vHk6ogvHbqnWIv/y53Vt1KmUhcqbxYb6NuljULwB4EmY
         NZFM+wNOmPx87IfuEmUrYgTT65FU+447UhE7+imjyGGMShYOGtO/v04BaGvj0LHEPCxY
         JsVSFsc5xQoDuRxXSieuV/y2PEajZGt4VffJUJGKV8Bs2sjuhubrtrX5DIjCbrcsCpau
         RSmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=uW2PEZfeSdLSHdLSCb5xQw1H/oXnf5DXCKRlroW2dJU=;
        b=uWmYolhkyR6CHGxGBvi457PZGlne0kcSsEfoYY8n4SfuqD/9jk6UNvXNMBFGgBjrUC
         GjJuyC6j3fG35kuNBZdU6dCcf2/TryR9WoAnWemxzTlGdwFPbmIX13w2jPHcuq5pQwvC
         W9B+J9jIcQQV9vNMB/5ry5DS+sWriEqGUXfYapOHnAv54Lcn6Qt4OBipnBTJRla20rOX
         kjNhcaA8cS2c3JaBpVAvQb42thSaeZvmvHyrBEqIxQdbzxgcjeN4UxRTyLZ2xRdiWcRz
         6zsOzcUwA2g0YoXkySYW40jXX2h7lp9pquRkHYlquu6ELrFtZfQR2Km/n0NgE9b93esl
         3/Zg==
X-Gm-Message-State: AOAM533ADr6Vfd5KX/VPA5mw2Tpqcq11T8xJ9Kcg53ZRVIiV8E/9XMNA
        MPixa0FB2H3vprzuNLoU9meqcYU0jRDLYMSPRqnL3A==
X-Google-Smtp-Source: ABdhPJzu8rtKrwW4O+BOHVaTppK9rC9M8gBa9Qa8asGuz6HQ69tyFkWCshq0IVUADe9lL0wY297OGOM44B0+bRZHxWY=
X-Received: by 2002:a05:6e02:144d:: with SMTP id p13mr9948451ilo.15.1633734921848;
 Fri, 08 Oct 2021 16:15:21 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1052.git.1633708986.gitgitgadget@gmail.com>
 <b473f145a87a22db99734c6a21395f0d24c3da3c.1633708986.git.gitgitgadget@gmail.com>
 <87zgrjmhgd.fsf@evledraar.gmail.com>
In-Reply-To: <87zgrjmhgd.fsf@evledraar.gmail.com>
From:   Ivan Frade <ifrade@google.com>
Date:   Fri, 8 Oct 2021 16:15:10 -0700
Message-ID: <CANQMx9Wd36xdMS5xyu759=aw1gVVnuGqsWzGsDVXqYLO_wuh1A@mail.gmail.com>
Subject: Re: [PATCH 1/2] fetch-pack: redact packfile urls in traces
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Ivan Frade via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 8, 2021 at 12:42 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
>
> On Fri, Oct 08 2021, Ivan Frade via GitGitGadget wrote:
>
> > diff --git a/http-fetch.c b/http-fetch.c
> > index fa642462a9e..d35e33e4f65 100644
> > --- a/http-fetch.c
> > +++ b/http-fetch.c
> > @@ -63,7 +63,9 @@ static void fetch_single_packfile(struct object_id *p=
ackfile_hash,
> >       if (start_active_slot(preq->slot)) {
> >               run_active_slot(preq->slot);
> >               if (results.curl_result !=3D CURLE_OK) {
> > -                     die("Unable to get pack file %s\n%s", preq->url,
> > +                     int showUrl =3D git_env_bool("GIT_TRACE_REDACT", =
1);
> > +                     die("Unable to get offloaded pack file %s\n%s",
> > +                         showUrl ? preq->url : "<redacted>",
> >                           curl_errorstr);
> >               }
> >       } else {
>
> Your CL and commit message just talk about traes, but this is a die()
> message.
>
> Perhaps it makes sense to redact it there too for some reason, but that
> seems to be a thing to separately argue for.
>
> This message is shown interactively to users, and I could see it be
> annoying to not have the URL that failed in your terminal output, even
> if it has some one-time token.


For a regular user the URL could be confusing (should they click on
it? try to download it by themselves?). I also got a suggestion to
print e.g. only the domain and maybe the packname.

In any case, I agree it is a different thing than trace logging. I
removed it from this patch.

>
> > +
> > +     grep -A1 "clone<\ ..packfile-uris" log | grep "clone<\ <redacted>=
"
>
> We don't rely on GNU options like those for the test suite, it'll break
> on various supported platformrs.
>
> In this case the whole LHS of the pipe looks like it could be dropped,
> why not grep for "^clone< <redacted>"?
>
>
> Also you don't need to quote the space character in regexes, it's not a
> metacharacter.

Updated the grep expressions to look only for the relevant lines and
removed the escaping of the space char.

I was trying to limit the grep to the "packfile-uri" section, not to
match something else by accident, but I think "obj-id http://"
shouldn't match anything else in the clone response (no ref can start
with http://).

Thanks for the quick review!

Ivan
