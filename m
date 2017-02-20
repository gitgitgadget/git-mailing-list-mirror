Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F26CF201A9
	for <e@80x24.org>; Mon, 20 Feb 2017 12:32:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752869AbdBTMcK (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Feb 2017 07:32:10 -0500
Received: from mail-oi0-f66.google.com ([209.85.218.66]:32796 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752767AbdBTMcJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Feb 2017 07:32:09 -0500
Received: by mail-oi0-f66.google.com with SMTP id 2so2323096oif.0
        for <git@vger.kernel.org>; Mon, 20 Feb 2017 04:32:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lKfC1hospWYKEzQVKU8yJ4Ti8hnEwzKgBM1+cPW5SvY=;
        b=JcY82hhEfwf2MEfVG3mI0kx1gAX9hHbpYjYIkXf9PYzUcyDrp8bwIkeJJXyTmqiqb2
         1WoUwkAi0RbE1hIp/4jZMMWIg7tX0uB4Vl9K76v3dL7DBVj/xhR8w8318SBPt1vDkUv8
         nBMghYvlr2dXhHQCNpKKvXd71J7ygrdv4kBsojcX8QDDRmY9mhxX4+hybjqeGki+j3ZO
         Vh8mipT1M8S7aljPOF6fnZc5pH7Gf9cjX0pCMid2L1Mckklhx05GtanYlMvSCbLsZ2Dq
         viiNLR3hC72m2jUk+KVZrGHgs+oErAVTBKftr1asZIZUNDyifQ83HjMjTZZ3JkpEJnBU
         gobQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lKfC1hospWYKEzQVKU8yJ4Ti8hnEwzKgBM1+cPW5SvY=;
        b=hrzzXRf0pdQeNKCUgdZlJifVa8fcqqLhwn/AmQJuuo2XmZXtUy1W/pfB0d7XdT9Ikl
         GQmerXeRn3w1Efl4OqnG8ZLGNAbendb7cLY/krTtQN+wtQU3M7o6f0kEkNgik/LAy3sg
         W126zZEjQlDB0bKSK80XPpAL/J/Ye2ewfasfzZldQy3a3SDlSqHLY2LuqoiSzNr5ATli
         KuXx6nYte3WhvGzTlfWGMoKCtsT2RSoWH6nQsfom8QYmB/E5vE/ZnwyGAIO62mDWuPcY
         +Dd3Mw5p1hzYS4rs99yIbjEm96XQwRZsLUdnyFo9mKQ/2gQaop6z/EMDM3fECAccTmeH
         n1aw==
X-Gm-Message-State: AMke39kGLRnPF4KiZP/KeKTBe/CG1orXBnKnQPlt/8uGIgGB0IUboSv9KCficd7R8shpY4C7lI09dmlpfhCGww==
X-Received: by 10.202.173.18 with SMTP id w18mr11562957oie.146.1487593928829;
 Mon, 20 Feb 2017 04:32:08 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.158.84 with HTTP; Mon, 20 Feb 2017 04:31:38 -0800 (PST)
In-Reply-To: <1d750672-441d-14ae-21e9-d7bdd47a50a4@alum.mit.edu>
References: <20170217140436.17336-1-pclouds@gmail.com> <20170218133303.3682-1-pclouds@gmail.com>
 <20170218133303.3682-7-pclouds@gmail.com> <1d750672-441d-14ae-21e9-d7bdd47a50a4@alum.mit.edu>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 20 Feb 2017 19:31:38 +0700
Message-ID: <CACsJy8Dk+DY0Evf0_P9mg_ezkTWJDL-eDdXChrp8K1P5C1rQdg@mail.gmail.com>
Subject: Re: [PATCH v4 06/15] files-backend: remove the use of git_path()
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Stefan Beller <sbeller@google.com>,
        David Turner <novalis@novalis.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 20, 2017 at 6:34 PM, Michael Haggerty <mhagger@alum.mit.edu> wr=
ote:
> On 02/18/2017 02:32 PM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
>> Given $GIT_DIR and $GIT_COMMON_DIR, files-backend is now in charge of
>> deciding what goes where. The end goal is to pass $GIT_DIR only. A
>> refs "view" of a linked worktree is a logical ref store that combines
>> two files backends together.
>>
>> (*) Not entirely true since strbuf_git_path_submodule() still does path
>> translation underneath. But that's for another patch.
>>
>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.=
com>
>> ---
>>  refs/files-backend.c | 37 +++++++++++++++++++++++++++++++++----
>>  1 file changed, 33 insertions(+), 4 deletions(-)
>>
>> diff --git a/refs/files-backend.c b/refs/files-backend.c
>> index b599ddf92..dbcaf9bda 100644
>> --- a/refs/files-backend.c
>> +++ b/refs/files-backend.c
>> @@ -924,6 +924,9 @@ struct files_ref_store {
>>        */
>>       const char *submodule;
>>
>> +     struct strbuf gitdir;
>> +     struct strbuf gitcommondir;
>
> Is there a reason for these to be `strbuf`s rather than `const char *`?
> (One reason would be if you planned to use the `len` field, but I don't
> think you do so.)

Nope. I just didn't think about char *. It may have to lose "const"
though because in submodule case we may need a new allocation.

>
>> @@ -937,15 +940,33 @@ static void files_path(struct files_ref_store *ref=
s, struct strbuf *sb,
>>  {
>>       struct strbuf tmp =3D STRBUF_INIT;
>>       va_list vap;
>> +     const char *ref;
>>
>>       va_start(vap, fmt);
>>       strbuf_vaddf(&tmp, fmt, vap);
>>       va_end(vap);
>> -     if (refs->submodule)
>> +     if (refs->submodule) {
>>               strbuf_git_path_submodule(sb, refs->submodule,
>>                                         "%s", tmp.buf);
>> -     else
>> -             strbuf_git_path(sb, "%s", tmp.buf);
>> +     } else if (!strcmp(tmp.buf, "packed-refs") ||
>> +                !strcmp(tmp.buf, "logs")) { /* non refname path */
>> +             strbuf_addf(sb, "%s/%s", refs->gitcommondir.buf, tmp.buf);
>> +     } else if (skip_prefix(tmp.buf, "logs/", &ref)) { /* reflog */
>> +             if (is_per_worktree_ref(ref))
>> +                     strbuf_addf(sb, "%s/%s", refs->gitdir.buf, tmp.buf=
);
>> +             else
>> +                     strbuf_addf(sb, "%s/%s", refs->gitcommondir.buf, t=
mp.buf);
>
> This code would also be simpler if there were separate functions for
> packed-refs, loose references, and reflogs.

And maybe keep the path to packed-refs, the base path up to "logs" in
struct files_ref_store too (they will be calculated at ref store
init)? That way the files_packed_refs_path() does no calculation.
files_reflog_path() and files_ref_path() will just do string
concatenation, no fancy addf.
--=20
Duy
