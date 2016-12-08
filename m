Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8689C1FC96
	for <e@80x24.org>; Thu,  8 Dec 2016 11:06:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932197AbcLHLFh (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Dec 2016 06:05:37 -0500
Received: from mail-io0-f193.google.com ([209.85.223.193]:33769 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752728AbcLHLFK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Dec 2016 06:05:10 -0500
Received: by mail-io0-f193.google.com with SMTP id k5so206121ioi.0
        for <git@vger.kernel.org>; Thu, 08 Dec 2016 03:04:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=goIIJfCZwAsT3XWfYeKSzbHcVnm5szIEV+HCyb5cxdA=;
        b=NGx3tsKzlBB+e0JrzUNbXTFrME3JISEt+IHCx6UZVlOjCEHGZHr2R3TIvY6YtoQQWT
         saBm8nu/BhbH9eoDh62dZVAnlhFleeu8OhjnV9PgUOxyNzAwsERWapEJEhOZqTujhRNi
         YQ0y8XN6xwXwFMrPbb4XDANA90UK4vih2GcicKIJcT1j0FY1KKDjZ5l3q08+tBpIANA+
         xWDg+k+GJzzZ79ZOVswIMciGEgCBix2w07EQ2WsF6PsGDqzrL47NyUQbu5ROgt39iC3P
         x2eEgcY1f7pglo6xrxIjKiZ19srmz90QToG+FP+8S27Y3VAADOVIL6fBL5oopyWa3hQp
         xD7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=goIIJfCZwAsT3XWfYeKSzbHcVnm5szIEV+HCyb5cxdA=;
        b=Jl2/aet4/eGNGQik9gne4Y89Mu6RkZrMo7arLvtYgfu4r/iysY+kSMm/jR+NxTKz/N
         59Np2EOxdFa40+I0Jxg8DmkLKVeKSMg6xIjELjveG9ZhZx+J9sTf+QW0hEa+iHsuFbO+
         zLnCk4IRxDHtKa6s8Aa43S9GYaDgTg60hb9wPuqDrrq46G5q5paWaQG7KxnpJoCV5woM
         k8cwlw8oKyc1mO6TEdgByUL2Yyo1PvdLw74zwOXdmkNStR+563xIdosWGkm9eLXEw1KW
         nDCxc9NyDSLKPqX4OilSXM3Ob4dI32DziPmbaVp5JCpyIzm7m0AoONkjpNuoSyjctqX7
         xcyg==
X-Gm-Message-State: AKaTC02NbbEGWjWEXhgDvefytvVVnfdzzmBcdcZ2GZzvQ82lPtQ50keCiex2gHaWJfR9EDayZCdboHTU+7RRrA==
X-Received: by 10.36.90.72 with SMTP id v69mr1153092ita.74.1481195095471; Thu,
 08 Dec 2016 03:04:55 -0800 (PST)
MIME-Version: 1.0
Received: by 10.64.69.3 with HTTP; Thu, 8 Dec 2016 03:04:24 -0800 (PST)
In-Reply-To: <20161208003604.GK116201@google.com>
References: <1481061106-117775-1-git-send-email-bmwill@google.com>
 <1481061106-117775-2-git-send-email-bmwill@google.com> <CACsJy8Bm+Nif_PL1=BzTYLKGrnz94rjKOB=_PXz6OB47Js6v2A@mail.gmail.com>
 <20161208003604.GK116201@google.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 8 Dec 2016 18:04:24 +0700
Message-ID: <CACsJy8DVuOdRsu4x9iFTwweSVn=RRJYzBTm43ufBevTWMf4Qmg@mail.gmail.com>
Subject: Re: [PATCH 01/17] mv: convert to using pathspec struct interface
To:     Brandon Williams <bmwill@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 8, 2016 at 7:36 AM, Brandon Williams <bmwill@google.com> wrote:
>> > @@ -25,25 +26,43 @@ static const char **internal_copy_pathspec(const char *prefix,
>> >  {
>> >         int i;
>> >         const char **result;
>> > +       struct pathspec ps;
>> >         ALLOC_ARRAY(result, count + 1);
>> > -       COPY_ARRAY(result, pathspec, count);
>> > -       result[count] = NULL;
>> > +
>> > +       /* Create an intermediate copy of the pathspec based on the flags */
>> >         for (i = 0; i < count; i++) {
>> > -               int length = strlen(result[i]);
>> > +               int length = strlen(pathspec[i]);
>> >                 int to_copy = length;
>> > +               char *it;
>> >                 while (!(flags & KEEP_TRAILING_SLASH) &&
>> > -                      to_copy > 0 && is_dir_sep(result[i][to_copy - 1]))
>> > +                      to_copy > 0 && is_dir_sep(pathspec[i][to_copy - 1]))
>> >                         to_copy--;
>> > -               if (to_copy != length || flags & DUP_BASENAME) {
>> > -                       char *it = xmemdupz(result[i], to_copy);
>> > -                       if (flags & DUP_BASENAME) {
>> > -                               result[i] = xstrdup(basename(it));
>> > -                               free(it);
>> > -                       } else
>> > -                               result[i] = it;
>> > -               }
>> > +
>> > +               it = xmemdupz(pathspec[i], to_copy);
>> > +               if (flags & DUP_BASENAME) {
>> > +                       result[i] = xstrdup(basename(it));
>> > +                       free(it);
>> > +               } else
>> > +                       result[i] = it;
>> > +       }
>> > +       result[count] = NULL;
>> > +
>> > +       parse_pathspec(&ps,
>> > +                      PATHSPEC_ALL_MAGIC &
>> > +                      ~(PATHSPEC_FROMTOP | PATHSPEC_LITERAL),
>> > +                      PATHSPEC_KEEP_ORDER | PATHSPEC_PREFER_CWD,
>> > +                      prefix, result);
>> > +       assert(count == ps.nr);
>> > +
>> > +       /* Copy the pathspec and free the old intermediate strings */
>> > +       for (i = 0; i < count; i++) {
>> > +               const char *match = xstrdup(ps.items[i].match);
>> > +               free((char *) result[i]);
>> > +               result[i] = match;
>>
>> Sigh.. it looks so weird that we do all the parsing (in a _copy_
>> pathspec function) then remove struct pathspec and return the plain
>> string. I guess we can't do anything more until we rework cmd_mv code
>> to handle pathspec natively.
>>
>> At the least I think we should rename this function to something else.
>> But if you have time I really wish we could kill this function. I
>> haven't stared at cmd_mv() long and hard, but it looks to me that we
>> combining two separate functionalities in the same function here.
>>
>> If "mv" takes n arguments, then the first <n-1> arguments may be
>> pathspec, the last one is always a plain path. The "dest_path =
>> internal_copy_pathspec..." could be as simple as "dest_path =
>> prefix_path(argv[argc - 1])". the special treatment for this last
>> argument [1] can live here. Then, we can do parse_pathspec for the
>> <n-1> arguments in cmd_mv(). It's still far from perfect, because
>> cmd_mv can't handle pathspec properly, but it reduces the messy mess
>> in internal_copy_pathspec a bit, I hope.
>>
>
> Actually, after looking at this a bit more it seems like we could
> technically use prefix_path for both source and dest (based on how the
> current code is structured) since the source's provied must all exist (as
> in no wildcards are allowed).  We could drop using the pathspec struct
> completely in addition to renaming the function (to what I'm still
> unsure).

Yeah that sounds good too (with a caveat: I'm not a heavy user of
git-mv nor touching this code a lot, I might be missing something).
It'll take some looong time before somebody starts converting it to
use pathspec properly, I guess. prefix_path() would keep the code
clean meanwhile.

> I agree that this code should probably be rewritten and made a
> bit cleaner, I don't know if that fits in the scope of this series or
> should be done as a followup patch.  If you think it fits here then I
> can try and find some time to do the rework.
-- 
Duy
