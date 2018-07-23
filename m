Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 56AD41F597
	for <e@80x24.org>; Mon, 23 Jul 2018 18:14:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388265AbeGWTRB (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Jul 2018 15:17:01 -0400
Received: from mail-yw0-f193.google.com ([209.85.161.193]:40944 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387873AbeGWTRB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jul 2018 15:17:01 -0400
Received: by mail-yw0-f193.google.com with SMTP id z143-v6so566663ywa.7
        for <git@vger.kernel.org>; Mon, 23 Jul 2018 11:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iBvXa5QfTkzFv6IL7AlM55eDgTC4xEMygmmp+2yAfBM=;
        b=iz598U3Od0kwIM+IzzM1Z4JujnZpkvzeEFcp3NZv1e+TFS/X7tT/mXj/Tf1ll4y8wl
         18VUfq4nd21QSAHWhVfdFaG31yBAk40jVm0TwWHXqNJ9x7f2kUYs0peAFKC/RLSc8dJw
         49G8Bqn5lU9+fdHWnTyrS9U7NisqLqOpT4yFOpdQMD6s3BwbQ3pEVzScx82Ir3gh0os3
         whbJhMmk7IU/ZWRpXINn4b9IFKAnq3HBTg7ry2G5qwfPLl69Hnrb00b2VErc7sqo8Euq
         5+VBMrHlgngpwHsTfCEidl4LrJArLaUfyUos79IyFdeb4kBQNEz1fXotZM4NhsM+ubMD
         0OPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iBvXa5QfTkzFv6IL7AlM55eDgTC4xEMygmmp+2yAfBM=;
        b=JycKFvktvbQ2m1M6zU/QUNru/MRTQPYvK4AV3dAiGqjc+JysmlJqrJkd7gVjSa5gIz
         JqtTUOl+/c7wUX6VwIGLchGGLCL1Qwe8A939DcNiVGhi+epQd+5i6IlrjRe4rShWUkeb
         qkeWOIx5tywG/MF23lM7TnNxEHHnEf/XwSTLmTSvVpJmWfNR7i3ep9/UZfdU9rD+cPTa
         6naRHeRjsOLQ1A1/mWr04UGN0V3Eb7D7vwhBlWWId2pscuIFt0SszSgUTSI+ejvKtQLh
         g7kNqCHDSBLEYiJfvn7mxzvYoR6dp5Pj3UNr43NbaFACVjlNiEOvexCQfeHDGnmojv5I
         DC2A==
X-Gm-Message-State: AOUpUlENSQaTBU8LHACYf6mWyAoofBIwllY2RUo4mtxBAK5NNViGHGLt
        +u2z7GHl7ntCH5uDr9xZ0p1sdPICXRUiF4E2SSoHCDvFA8A=
X-Google-Smtp-Source: AAOMgpcoIieZIi1Xxgh80qFuUOBDWVm9QuzIFa0KHghzaLBb8/H9yhBKJIhAL2Iu84yZaEX/2Et1NiDXT7SMcsnfL8M=
X-Received: by 2002:a0d:c5c7:: with SMTP id h190-v6mr7639159ywd.421.1532369674500;
 Mon, 23 Jul 2018 11:14:34 -0700 (PDT)
MIME-Version: 1.0
References: <CACsJy8CJG5RCL40vCbNnQMHmtjQmch9qntxeh_Pt6ZUfnRN9uA@mail.gmail.com>
 <20180723175635.31323-1-bmwill@google.com>
In-Reply-To: <20180723175635.31323-1-bmwill@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 23 Jul 2018 11:14:23 -0700
Message-ID: <CAGZ79kbVk=FHp3RQ3WKsG-_crGkJV32R4gfnJ_ys7tmyvFfiew@mail.gmail.com>
Subject: Re: [PATCH] fetch-pack: mark die strings for translation
To:     Brandon Williams <bmwill@google.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 23, 2018 at 10:56 AM Brandon Williams <bmwill@google.com> wrote:
>

fetch-pack is listed as a plumbing command, which means its prime consumer
is supposedly a machine; But fetch-pack is also used by git-fetch that
is invoked
by a human, who prefers translations.

.. goes reads code...

This translates protocol v2 messages, and p0 messages are translated already,
so this just aligns the new protocol to the old protocol w.r.t. i18n.

Sounds good,

Thanks,
Stefan

[ This message is a gentle hint for better commit messages. ;-) ]

> Signed-off-by: Brandon Williams <bmwill@google.com>
> ---
>  fetch-pack.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/fetch-pack.c b/fetch-pack.c
> index 0b4a9f288f..51abee6181 100644
> --- a/fetch-pack.c
> +++ b/fetch-pack.c
> @@ -1245,13 +1245,13 @@ static int process_section_header(struct packet_reader *reader,
>         int ret;
>
>         if (packet_reader_peek(reader) != PACKET_READ_NORMAL)
> -               die("error reading section header '%s'", section);
> +               die(_("error reading section header '%s'"), section);
>
>         ret = !strcmp(reader->line, section);
>
>         if (!peek) {
>                 if (!ret)
> -                       die("expected '%s', received '%s'",
> +                       die(_("expected '%s', received '%s'"),
>                             section, reader->line);
>                 packet_reader_read(reader);
>         }
> @@ -1289,12 +1289,12 @@ static int process_acks(struct packet_reader *reader, struct oidset *common)
>                         continue;
>                 }
>
> -               die("unexpected acknowledgment line: '%s'", reader->line);
> +               die(_("unexpected acknowledgment line: '%s'"), reader->line);
>         }
>
>         if (reader->status != PACKET_READ_FLUSH &&
>             reader->status != PACKET_READ_DELIM)
> -               die("error processing acks: %d", reader->status);
> +               die(_("error processing acks: %d"), reader->status);
>
>         /* return 0 if no common, 1 if there are common, or 2 if ready */
>         return received_ready ? 2 : (received_ack ? 1 : 0);
> @@ -1331,7 +1331,7 @@ static void receive_shallow_info(struct fetch_pack_args *args,
>
>         if (reader->status != PACKET_READ_FLUSH &&
>             reader->status != PACKET_READ_DELIM)
> -               die("error processing shallow info: %d", reader->status);
> +               die(_("error processing shallow info: %d"), reader->status);
>
>         setup_alternate_shallow(&shallow_lock, &alternate_shallow_file, NULL);
>         args->deepen = 1;
> @@ -1346,7 +1346,7 @@ static void receive_wanted_refs(struct packet_reader *reader, struct ref *refs)
>                 struct ref *r = NULL;
>
>                 if (parse_oid_hex(reader->line, &oid, &end) || *end++ != ' ')
> -                       die("expected wanted-ref, got '%s'", reader->line);
> +                       die(_("expected wanted-ref, got '%s'"), reader->line);
>
>                 for (r = refs; r; r = r->next) {
>                         if (!strcmp(end, r->name)) {
> @@ -1356,11 +1356,11 @@ static void receive_wanted_refs(struct packet_reader *reader, struct ref *refs)
>                 }
>
>                 if (!r)
> -                       die("unexpected wanted-ref: '%s'", reader->line);
> +                       die(_("unexpected wanted-ref: '%s'"), reader->line);
>         }
>
>         if (reader->status != PACKET_READ_DELIM)
> -               die("error processing wanted refs: %d", reader->status);
> +               die(_("error processing wanted refs: %d"), reader->status);
>  }
>
>  enum fetch_state {
> --
> 2.18.0.233.g985f88cf7e-goog
>
