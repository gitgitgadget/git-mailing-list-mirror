Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 848FBC636C9
	for <git@archiver.kernel.org>; Mon, 19 Jul 2021 08:57:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CB51613D2
	for <git@archiver.kernel.org>; Mon, 19 Jul 2021 08:57:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235301AbhGSIRF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Jul 2021 04:17:05 -0400
Received: from mail-qv1-f50.google.com ([209.85.219.50]:43536 "EHLO
        mail-qv1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235018AbhGSIRF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jul 2021 04:17:05 -0400
Received: by mail-qv1-f50.google.com with SMTP id i4so8011639qvq.10
        for <git@vger.kernel.org>; Mon, 19 Jul 2021 01:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=13ys/b94zwEkeXTnmDM94D2CTwNSi/arlD+cT1qKlr8=;
        b=u2gw8jjt+TuIU4xe4UoTDbjfnYkV5bXQHtAllBCTghXpa8P+6l8BZjko/o6KimIxdB
         rq6F23HqZAwJ6w+8koAan7dWfaLHT8o0oKKVwdyttdorGMVQCUd8QhOYtynusGEzPmLT
         yjOEYx7N0TOPjujNdV0eHHu9M8naN65RNwDgMzycezwEgrS3rmClN1+yRBWMYyKgCRP4
         YUzxLy1XtmKbvNdMf6ETK1XzzG9PqDOimTejkoNL9uP7LKqdKN1/nWk88fF+JgvwPRyE
         cst1EPGh2MzmWgX7qfydUhnsE4OD3RgdeAfwbBzwoEF4BMk8VAtqjiB6I6sUqo9J9ADx
         7fZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=13ys/b94zwEkeXTnmDM94D2CTwNSi/arlD+cT1qKlr8=;
        b=alvz4bhYsmQz2SBh8AFusqRDKm8Eh/ntnQSESctJDgE5Dlf6DaMdJchiLkex+Vy+D8
         uj2bkm0cPb9K1BqvT9S4B/f/pnWXxa9ofRF/bgYz3ydeYIDeohRwksm5fu1fRf5XjWxQ
         TZrVnDAffbHhIGDgRYTIeScN5i2GjnJc7/L2y1T64QS6P4Gt1G04ENnHatU8gwKYCc59
         dH3BrF4HEApzBIMBXEvGPrrHl/ehWmfLKwB96RJjnRBBHRMowECfxMzcCX/Yp6xwB48C
         8t9Ww+R2huJoI62/ri0JygKDcoGwdtkPlIg7X9KV1m3OY4QQkDhkYI2F119Mm8XjIKt6
         cD/A==
X-Gm-Message-State: AOAM531HTA+4LIGbM8aHTYJoLlq/ngjM9JTnugHFqDkjnWAYSfqJR3+Y
        sSGohcuB2PDXaviPvqwNpibjgxjP3ontBQ==
X-Google-Smtp-Source: ABdhPJzXlizUzM7QybKsqMzPSCrJsWke16BAz0kTQEfhwOOfgBNMkfaMX7FxlnS6kBhZJeIPiK/WYg==
X-Received: by 2002:a17:902:ff13:b029:129:9a0b:c2dc with SMTP id f19-20020a170902ff13b02901299a0bc2dcmr18781634plj.45.1626684534247;
        Mon, 19 Jul 2021 01:48:54 -0700 (PDT)
Received: from smtpclient.apple ([119.82.121.47])
        by smtp.gmail.com with ESMTPSA id y82sm19313108pfb.121.2021.07.19.01.48.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Jul 2021 01:48:53 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.100.0.2.22\))
Subject: Re: My Git Dev Blog - Week 9
From:   Atharva Raykar <raykar.ath@gmail.com>
In-Reply-To: <a8122438-8d8b-9e7d-d66a-dc6eff7a0817@gmail.com>
Date:   Mon, 19 Jul 2021 14:18:50 +0530
Cc:     Git List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Shourya Shukla <periperidip@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <6A97A724-4B80-4DDC-B5D2-83F8AD0B27EF@gmail.com>
References: <ED260A04-153A-46D5-8A84-CF517085DEC9@gmail.com>
 <09edd920-e9ef-f8f9-79e6-d27badd2e5a6@gmail.com>
 <a8122438-8d8b-9e7d-d66a-dc6eff7a0817@gmail.com>
To:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
X-Mailer: Apple Mail (2.3654.100.0.2.22)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 19-Jul-2021, at 08:28, Kaartic Sivaraam <kaartic.sivaraam@gmail.com> =
wrote:
>=20
> Hi Atharva and all,
>=20
> On 19/07/21 12:49 am, Kaartic Sivaraam wrote:
>> On 18/07/21 5:29 pm, Atharva Raykar wrote:
>>> Passing the superprefix explicitly
>> My gut instinct tells me we could get away without having to go this =
way but
>> I haven't yet been able to figure out how. How 'prefix', =
'super-prefix' and
>> 'recursive-prefix' is still puzzling me. In case anyone has knowledge =
about
>> this please chime in and enlighten us. It would be very helpful.
>>=20
>=20
> I just noticed I was short and unhelpful here. To expand on what =
information would be
> helpful on this respect, here's a snippet of a private e-mail I sent =
which I've
> tweaked a little to make it relevant for the list audience:
>=20
> -- 8< --
>>> ...
>>>=20
>=20
> I took a look at this. I'm not able to find the exact issue but my gut =
instinct tells me
> it has something to do with how prefix, super-prefix and =
recursive-prefix
> are handled before and after the conversion. To be more specific, I'm =
having doubts
> about whether the following code snippet[4] in shell ...
>=20
>    prefix=3D$(git submodule--helper relative-path "$prefix$sm_path/" =
"$wt_prefix")
>    wt_prefix=3D
>    sanitize_submodule_env
>    cd "$sm_path" &&
>    eval cmd_update
>=20
> ... has been properly converted to C. Particularly, the fact that =
recursive calls to
> 'cmd_update' is made in the existing shell implementation in case =
'--recusive' is
> passed needs to be observed well. This would subsequently result in =
multiple calls to
> 'cmd_init' with different 'prefix' and 'wt_prefix' values. So, that =
needs to be
> observed well too.

The whole deal with prefixes confused me initially a lot as well, so =
I'll try to
explain what's going on there first, and then show why I had trouble =
with it.

The terminology of 'recursive-prefix' was something I borrowed from the =
update-clone
helper[5]. Just to give you a summary of which shell variable maps to =
which C
variable, along with my understanding of what they represent:

| shell      | C                | description                            =
   |
=
|------------+------------------+-----------------------------------------=
--|
| $prefix    | recursive_prefix | this represents the superproject =
prefix,  |
|            |                  | ie, the path of the superproject =
relative |
|            |                  | to the current subproject.             =
   |
|            |                  |                                        =
   |
| $wt_prefix | prefix           | this is the path into the working =
tree,   |
|            |                  | ie, the path of the directory from the =
   |
|            |                  | root of the git directory's worktree   =
   |

The display paths that are generated for the error messages require one =
of these to
be non-NULL, but not both[6].

I feel confident the values of the various prefixes are handled properly =
during the
recursion because I setup a new worktree on based master as my =
"control", and a
combination of running with GIT_TRACE2 and printing the values showed me =
that both
of them handle the prefixes identically.

The issue with the subprocess approach[7] seems to be not with the =
prefixes, but
rather with the configuration not being properly read when it is set in =
the same
command invocation.

[5] =
https://github.com/git/git/blob/75ae10bc75336db031ee58d13c5037b929235912/g=
it-submodule.sh#L536-L550
[6] =
https://github.com/git/git/blob/75ae10bc75336db031ee58d13c5037b929235912/b=
uiltin/submodule--helper.c#L258-L260
[7] =
https://github.com/tfidfwastaken/git/commits/submodule-helper-update-1a

> I have not been able to get a complete picture of this myself. I'll =
try to take better
> look later and see if I could get anything.
>=20
> Note that this could also be me just not being able to get a proper =
picture of it.
> Just wanted to share it in case others are able to get any ideas or =
able to think of a
> possible cause.
>=20
> [4]: =
https://github.com/git/git/blob/abb21c7263616f01c5e950861a29279ab21cb02f/g=
it-submodule.sh#L654-L658
> -- >8 --
>=20
> I hope that gives a better idea about what kind of information would =
be helpful.
> Kindly let me know if it doesn't.
>=20
> Atharva,
>=20
> In the meanwhile, I think you could continue polishing your attempted =
solution
> and preparing to send it to the list. I'll try to dig more on my gut =
instinct
> and let you know if I get anything. If you have some free time left =
after
> polishing your series, you could try digging into it too :)

Sure. Thanks for the time and effort you are putting into this!

> --=20
> Sivaraam

