Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D60E820248
	for <e@80x24.org>; Tue, 26 Feb 2019 11:33:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726056AbfBZLdX (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Feb 2019 06:33:23 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:40491 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726004AbfBZLdX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Feb 2019 06:33:23 -0500
Received: by mail-ed1-f66.google.com with SMTP id 10so10412396eds.7
        for <git@vger.kernel.org>; Tue, 26 Feb 2019 03:33:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=aGGQrKVHt6IpbB5jkfOClHKclJtAaDidsg+XQkz9E9M=;
        b=PJdM47/TYx+Xib9E6LFoqMP/p8P9AQlDMtRjATeXuWSJLxYPfAK4cs/oHvj25dDFDy
         Mn7qwZl1jubqd+PSNh/a/JjVrcRt8gvorsq3tb4/5IE7dDLOABqSFOx8dbRBPG6bffj5
         EsfSW765sQFTGKmiLoy2uWGpAuzWjVOTatzR4g89DhEbulOEzi0D06ScnS4iZA6G1DT4
         LTpDVXuGqqTSdlqjAfyYTeHCzhOnyv+J3JboZDrevfo4sf+NEKAS/iOLF7BRhMHMbNz2
         /LOdSH515Levvr/IMUR50Kowq3nxWq+fXCun4Gv6rwnUSv4RzwZOFzgsQL5TUiQ6c5OS
         X5ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=aGGQrKVHt6IpbB5jkfOClHKclJtAaDidsg+XQkz9E9M=;
        b=M483Xg13lSomwzOzpqjrM1H63RtAOifjhii8EIFT8a8tZJDayWFH8WODa7ctWO5GF/
         1UsTQydCS9oc9SAcEZp5lo4k3wscHOr/XebK9vB64241QKjmVM7INPpQRtXhkb8Jk9YA
         EveJhZicOKU3q8OvEwVZP9nFaqGT4wnC2+VNqWvhEJVhlKvMB6K+u1hMZkl6XtPCLgoA
         8j1La9fy467AgIH8MYPLG/CjCmt3GhKPeDCntU6wr4EGJD8ESuh/EVtXI8UgaIFUvd/y
         fugyzpryXvjFeSGjqzPMtLPR/f4zthpN8SU/JGAZZegZd80aZsBMhcULp6rLmMR0hZ6X
         hM8Q==
X-Gm-Message-State: AHQUAuYXJVsPKInzKgwNu732QLo/eDF9Y/36+G9g6jJeycCAhun5EZCX
        y8U/FIYvb9Y4XVb2BfyAd44=
X-Google-Smtp-Source: AHgI3IbKjygfz3utBBeeyRh00TPK2T/gcUo/Urw1QczVOQN1r/aCDA8heQT4+aYEuvwGIeOrKf5EDA==
X-Received: by 2002:a50:ae8d:: with SMTP id e13mr18586659edd.124.1551180800733;
        Tue, 26 Feb 2019 03:33:20 -0800 (PST)
Received: from evledraar ([5.57.21.48])
        by smtp.gmail.com with ESMTPSA id gl18sm321722ejb.49.2019.02.26.03.33.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Feb 2019 03:33:19 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: [WIP RFC PATCH 5/7] clone: use dir-iterator to avoid explicit dir traversal
References: <CACsJy8Bw-mXLyT7VaKBjYKLe6uSAQqyLG=_AzjDXykYzSQLkcg@mail.gmail.com> <20190226002625.13022-6-avarab@gmail.com> <CAHd-oW7HvhkORZogjb0nPioe3KWmXDDACF6Tu-Kmayc7=1z7nA@mail.gmail.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <CAHd-oW7HvhkORZogjb0nPioe3KWmXDDACF6Tu-Kmayc7=1z7nA@mail.gmail.com>
Date:   Tue, 26 Feb 2019 12:33:18 +0100
Message-ID: <87y362vl6p.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Feb 26 2019, Matheus Tavares Bernardino wrote:

> On Mon, Feb 25, 2019 at 9:26 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
>>
>> From: Matheus Tavares <matheus.bernardino@usp.br>
>>
>> Replace usage of opendir/readdir/closedir API to traverse directories
>> recursively, at copy_or_link_directory function, by the dir-iterator
>> API. This simplifies the code and avoid recursive calls to
>> copy_or_link_directory.
>>
>> [=C3=86var: This should be bug-compatible with the existing "clone"
>> behavior. The whole bit here with "iter->relative_path[0] =3D=3D '.'" is=
 a
>> dirty hack. We don't copy dot-dirs, and then later on just blindly
>> ignore ENOENT errors as we descend into them. That case really wants
>> to be a is_dotdir_or_file_within() test instead]
>>
>> Now, copy_or_link_directory will call die() in case of an error on
>> openddir, readdir or lstat, inside dir_iterator_advance. That means it
>> will abort in case of an error trying to fetch any iteration entry.
>>
>> Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
>> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>> ---
>>  builtin/clone.c | 55 +++++++++++++++++++++++++++++--------------------
>>  1 file changed, 33 insertions(+), 22 deletions(-)
>>
>> diff --git a/builtin/clone.c b/builtin/clone.c
>> index 862d2ea69c..c32e9022b3 100644
>> --- a/builtin/clone.c
>> +++ b/builtin/clone.c
>> @@ -23,6 +23,8 @@
>>  #include "transport.h"
>>  #include "strbuf.h"
>>  #include "dir.h"
>> +#include "dir-iterator.h"
>> +#include "iterator.h"
>>  #include "sigchain.h"
>>  #include "branch.h"
>>  #include "remote.h"
>> @@ -411,42 +413,47 @@ static void mkdir_if_missing(const char *pathname,=
 mode_t mode)
>>  }
>>
>>  static void copy_or_link_directory(struct strbuf *src, struct strbuf *d=
est,
>> -                                  const char *src_repo, int src_baselen)
>> +                                  const char *src_repo)
>>  {
>> -       struct dirent *de;
>> -       struct stat buf;
>>         int src_len, dest_len;
>> -       DIR *dir;
>> -
>> -       dir =3D opendir(src->buf);
>> -       if (!dir)
>> -               die_errno(_("failed to open '%s'"), src->buf);
>> +       struct dir_iterator *iter;
>> +       int iter_status;
>> +       struct stat st;
>>
>>         mkdir_if_missing(dest->buf, 0777);
>>
>> +       iter =3D dir_iterator_begin(src->buf, 1);
>> +
>>         strbuf_addch(src, '/');
>>         src_len =3D src->len;
>>         strbuf_addch(dest, '/');
>>         dest_len =3D dest->len;
>>
>> -       while ((de =3D readdir(dir)) !=3D NULL) {
>> +       while ((iter_status =3D dir_iterator_advance(iter)) =3D=3D ITER_=
OK) {
>>                 strbuf_setlen(src, src_len);
>> -               strbuf_addstr(src, de->d_name);
>> +               strbuf_addstr(src, iter->relative_path);
>>                 strbuf_setlen(dest, dest_len);
>> -               strbuf_addstr(dest, de->d_name);
>> -               if (stat(src->buf, &buf)) {
>> +               strbuf_addstr(dest, iter->relative_path);
>> +
>> +               /*
>> +                * dir_iterator_advance already calls lstat to populate =
iter->st
>> +                * but, unlike stat, lstat does not checks for permissio=
ns on
>> +                * the given path.
>> +                */
>> +               if (stat(src->buf, &st)) {
>>                         warning (_("failed to stat %s\n"), src->buf);
>>                         continue;
>>                 }
>> -               if (S_ISDIR(buf.st_mode)) {
>> -                       if (de->d_name[0] !=3D '.')
>> -                               copy_or_link_directory(src, dest,
>> -                                                      src_repo, src_bas=
elen);
>> +
>> +               if (S_ISDIR(iter->st.st_mode)) {
>> +                       if (iter->relative_path[0] =3D=3D '.')
>
> I think it should be iter->basename[0] here, instead, right?

Yeah, sounds better.

> I also have a more conceptual question here: This additions (or the
> is_dotdir_of_file_within as suggested) are just to make patch
> compatible with the current behaviour, but are going to be removed
> soon after.

Yes. it's not an endorsement of the current behavior, but for ease of
review. I.e. to split changes into smaller logical ones ones that are
refactoring on the one hand, and behavior changes on the other.

> As this would be kind of a noise, wouldn't it be better to have a
> patch before this, already correcting copy_or_link_directory's
> behaviour on hidden dirs and them this?

Yeah, maybe structuring it like that is more readable.


>> +                               continue;
>> +                       mkdir_if_missing(dest->buf, 0777);
>>                         continue;
>>                 }
>>
>>                 /* Files that cannot be copied bit-for-bit... */
>> -               if (!strcmp(src->buf + src_baselen, "/info/alternates"))=
 {
>> +               if (!strcmp(iter->relative_path, "info/alternates")) {
>>                         copy_alternates(src, dest, src_repo);
>>                         continue;
>>                 }
>> @@ -456,14 +463,18 @@ static void copy_or_link_directory(struct strbuf *=
src, struct strbuf *dest,
>>                 if (!option_no_hardlinks) {
>>                         if (!link(src->buf, dest->buf))
>>                                 continue;
>> -                       if (option_local > 0)
>> -                               die_errno(_("failed to create link '%s'"=
), dest->buf);
>> +                       if (option_local > 0 && errno !=3D ENOENT)
>> +                               warning_errno(_("failed to create link '=
%s'"), dest->buf);
>>                         option_no_hardlinks =3D 1;
>>                 }
>> -               if (copy_file_with_time(dest->buf, src->buf, 0666))
>> +               if (copy_file_with_time(dest->buf, src->buf, 0666) && er=
rno !=3D ENOENT)
>>                         die_errno(_("failed to copy file to '%s'"), dest=
->buf);
>>         }
>> -       closedir(dir);
>> +
>> +       if (iter_status !=3D ITER_DONE) {
>> +               strbuf_setlen(src, src_len);
>> +               die(_("failed to iterate over '%s'"), src->buf);
>> +       }
>>  }
>>
>>  static void clone_local(const char *src_repo, const char *dest_repo)
>> @@ -481,7 +492,7 @@ static void clone_local(const char *src_repo, const =
char *dest_repo)
>>                 get_common_dir(&dest, dest_repo);
>>                 strbuf_addstr(&src, "/objects");
>>                 strbuf_addstr(&dest, "/objects");
>> -               copy_or_link_directory(&src, &dest, src_repo, src.len);
>> +               copy_or_link_directory(&src, &dest, src_repo);
>>                 strbuf_release(&src);
>>                 strbuf_release(&dest);
>>         }
>> --
>> 2.21.0.rc2.1.g2d5e20a900.dirty
>>
