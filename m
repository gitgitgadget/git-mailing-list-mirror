Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 48E4C1F404
	for <e@80x24.org>; Wed, 28 Mar 2018 03:32:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752252AbeC1Dck (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Mar 2018 23:32:40 -0400
Received: from mail-yw0-f195.google.com ([209.85.161.195]:38275 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751096AbeC1Dch (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Mar 2018 23:32:37 -0400
Received: by mail-yw0-f195.google.com with SMTP id x20so352458ywg.5
        for <git@vger.kernel.org>; Tue, 27 Mar 2018 20:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=tK76N8ktTF4mQV4BJ2LEaJ1sRWegC1+gK9dXdvb/xxM=;
        b=smLJhkd42sgx7wiOs6Lha34jsSLm+9kdBPyw1zqdHkC/XpHBcY1DuIfLhW226Svke0
         f0pr9z9DZYZmB02zxaq0wsWHQrw8OuL0YcPLj5gnQtdwBZzoN6HXJMm18e2ZvTx5pFGi
         cjXYOBpfiCHi62JOSlnSSAY0WuYmLojJeMYyWkbWk7wULObM39DsluH3WUjCPonlSCUM
         lOJQPquGbE9LRm7k3x4KyGX1NHJ6qeT39IaCDVLL4URr9FfdvQ5L2sv1vZPDe1ecdMnN
         KPm9HV06HjYSYbXHxV53AWEm2azjxvbtBIOL6g0Y9i88EUvQ3/qqUDz/NKJY2oG5sKhN
         xVAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=teichroeb-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=tK76N8ktTF4mQV4BJ2LEaJ1sRWegC1+gK9dXdvb/xxM=;
        b=TLqKMMiE2DZyJShysGKjsTLL3kPQJUzZWHA9gRAiVYidivqhjKm06/r9Wp8VHKQDdA
         Gccbz73ZRtg2omJmuixgYGZiS+aqvQv5kksXtFyzo0mJkBZo/Lcd0d8oT2d7v8zbIWj/
         jZ661CBXI9BGSHmsFjBJlnwUe/Tft7DmpDDK6A6zQo4hu1d/6ofzgOx/U6RlON1Qu4Wq
         jAyyMkjOj6zy/WlzjAQGNxkRi4j01Eshn9/papzDMOiF3X/Rixn9rw176kQU4xNq5iaU
         uyP3rP8sklXRDN0+QqEBm0dAYUKdC4Hy6tBLbdILc9PKWc2kWI+7cucSluLsKSmAUOWQ
         pJcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=tK76N8ktTF4mQV4BJ2LEaJ1sRWegC1+gK9dXdvb/xxM=;
        b=M3L8u52sRWkE7gPXCDYcrumJJSOMMm00s/gCrrr0PVF9iakOMVY5pS5j0rqA5Kokfa
         MX/Omt/ZOdrQewaHKbbyApxiZfZ52sRFbmJ4EEYmn+0eZ51KxAVJpWwrKIrwboV3fIyd
         9p1gVK429ZOD8ROwS2Fj7RwUlmFIIW8vqq/KBx4VFnE+U+fRn/3rzZm/PjEUazDfhm/I
         SI68qOwI8q8SjuNbvcYnbLXHqHCQp899frnmT8SQhzVlAaJ4enXMs/JYGhmMzz1hNlb1
         VqnlFhDV3srNUshgqSrhKltAiAThdN6aeRLY324rpn9orE/0XCzcjB6VbQQu2iIrQ6LW
         0taw==
X-Gm-Message-State: AElRT7FHFTU4H996TJ+LIi0GyZPol7GR24VtSdVrkEJ+aYz+wMFDY4It
        Dn1MVHG7Vcp8CGdaFzqVWOoy5mJ1nY0fZqc84wU=
X-Google-Smtp-Source: AIpwx49gpG+Caecl1KH2JrsVCnpIpOMb8IteguZmNaz48tIBQEwSy2h5An0E5Vo5no3L/rxfdZfGMs6bFjcwJQyg03s=
X-Received: by 10.129.47.15 with SMTP id v15mr1175384ywv.248.1522207956058;
 Tue, 27 Mar 2018 20:32:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:3804:0:0:0:0:0 with HTTP; Tue, 27 Mar 2018 20:32:15
 -0700 (PDT)
In-Reply-To: <CAP8UFD0wc2i3W4FNZPcDs3ELJGJj=4NaP8mhd-zMAkdK=vXT1A@mail.gmail.com>
References: <20180326011426.19159-1-joel@teichroeb.net> <20180326011426.19159-4-joel@teichroeb.net>
 <CAP8UFD0wc2i3W4FNZPcDs3ELJGJj=4NaP8mhd-zMAkdK=vXT1A@mail.gmail.com>
From:   Joel Teichroeb <joel@teichroeb.net>
Date:   Tue, 27 Mar 2018 20:32:15 -0700
X-Google-Sender-Auth: fzC_Z6SeZlKpCtgtBIUA-dtac4I
Message-ID: <CA+CzEk8xDG39Fb5GU2gHDvsPo=xGXxwNCdBOg4D+eQ2wPVaTOg@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] stash: convert apply to builtin
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 26, 2018 at 12:05 AM, Christian Couder
<christian.couder@gmail.com> wrote:
> On Mon, Mar 26, 2018 at 3:14 AM, Joel Teichroeb <joel@teichroeb.net> wrote:
>> Signed-off-by: Joel Teichroeb <joel@teichroeb.net>
>
> The commit message in this patch and the following ones could be a bit
> more verbose. It could at least tell that the end goal is to convert
> git-stash.sh to a C builtin.
>
>> +static void destroy_stash_info(struct stash_info *info)
>> +{
>> +       strbuf_release(&info->revision);
>> +}
>
> Not sure if "destroy" is the right word in the function name. I would
> have used "free" instead.
>
>> +static int get_stash_info(struct stash_info *info, int argc, const char **argv)
>> +{
>> +       struct strbuf w_commit_rev = STRBUF_INIT;
>> +       struct strbuf b_commit_rev = STRBUF_INIT;
>> +       struct strbuf w_tree_rev = STRBUF_INIT;
>> +       struct strbuf b_tree_rev = STRBUF_INIT;
>> +       struct strbuf i_tree_rev = STRBUF_INIT;
>> +       struct strbuf u_tree_rev = STRBUF_INIT;
>> +       struct strbuf symbolic = STRBUF_INIT;
>> +       struct strbuf out = STRBUF_INIT;
>> +       int ret;
>> +       const char *revision;
>> +       const char *commit = NULL;
>> +       char *end_of_rev;
>> +       info->is_stash_ref = 0;
>> +
>> +       if (argc > 1) {
>> +               int i;
>> +               fprintf(stderr, _("Too many revisions specified:"));
>> +               for (i = 0; i < argc; ++i) {
>> +                       fprintf(stderr, " '%s'", argv[i]);
>> +               }
>
> The brackets are not needed.
>
>> +               fprintf(stderr, "\n");
>> +
>> +               return -1;
>> +       }
>> +
>> +       if (argc == 1)
>> +               commit = argv[0];
>> +
>> +       strbuf_init(&info->revision, 0);
>> +       if (commit == NULL) {
>> +               if (have_stash()) {
>> +                       destroy_stash_info(info);
>> +                       return error(_("No stash entries found."));
>> +               }
>> +
>> +               strbuf_addf(&info->revision, "%s@{0}", ref_stash);
>> +       } else if (strspn(commit, "0123456789") == strlen(commit)) {
>> +               strbuf_addf(&info->revision, "%s@{%s}", ref_stash, commit);
>> +       } else {
>> +               strbuf_addstr(&info->revision, commit);
>> +       }
>> +
>> +       revision = info->revision.buf;
>> +
>> +       strbuf_addf(&w_commit_rev, "%s", revision);
>
> Maybe use strbuf_addstr()?
>
>> +
>> +
>
> Spurious new line.
>
> [...]
>
>> +static int diff_cached_index(struct strbuf *out, struct object_id *c_tree)
>> +{
>> +       struct child_process cp = CHILD_PROCESS_INIT;
>> +    const char *c_tree_hex = oid_to_hex(c_tree);
>
> Indent looks weird.
>
>> +
>> +       cp.git_cmd = 1;
>> +       argv_array_pushl(&cp.args, "diff-index", "--cached", "--name-only", "--diff-filter=A", NULL);
>> +       argv_array_push(&cp.args, c_tree_hex);
>> +       return pipe_command(&cp, NULL, 0, out, 0, NULL, 0);
>> +}
>> +
>> +static int update_index(struct strbuf *out) {
>
> The opening bracket should be on its own line.
>
>> +       struct child_process cp = CHILD_PROCESS_INIT;
>
> Maybe add a new line here to be more consistent with other such functions.
>
>> +       cp.git_cmd = 1;
>> +       argv_array_pushl(&cp.args, "update-index", "--add", "--stdin", NULL);
>> +       return pipe_command(&cp, out->buf, out->len, NULL, 0, NULL, 0);
>> +}
>
> [...]
>
>> +       if (info->has_u) {
>> +               struct child_process cp = CHILD_PROCESS_INIT;
>> +               struct child_process cp2 = CHILD_PROCESS_INIT;
>> +               int res;
>> +
>> +               cp.git_cmd = 1;
>> +               argv_array_push(&cp.args, "read-tree");
>> +               argv_array_push(&cp.args, oid_to_hex(&info->u_tree));
>> +               argv_array_pushf(&cp.env_array, "GIT_INDEX_FILE=%s", stash_index_path);
>> +
>> +               cp2.git_cmd = 1;
>> +               argv_array_pushl(&cp2.args, "checkout-index", "--all", NULL);
>> +               argv_array_pushf(&cp2.env_array, "GIT_INDEX_FILE=%s", stash_index_path);
>
> Maybe use small functions for the above read-tree and checkout-index.
>
>> +               res = run_command(&cp) || run_command(&cp2);
>> +               remove_path(stash_index_path);
>> +               if (res)
>> +                       return error(_("Could not restore untracked files from stash"));
>> +       }
>
> Thanks.

Thanks for your detailed comments! I've fixed them all in my next patch set.
