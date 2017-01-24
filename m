Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3368F20A17
	for <e@80x24.org>; Tue, 24 Jan 2017 02:18:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751504AbdAXCSq (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Jan 2017 21:18:46 -0500
Received: from mail-qt0-f171.google.com ([209.85.216.171]:34872 "EHLO
        mail-qt0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750873AbdAXCSp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jan 2017 21:18:45 -0500
Received: by mail-qt0-f171.google.com with SMTP id x49so157308844qtc.2
        for <git@vger.kernel.org>; Mon, 23 Jan 2017 18:18:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=9zmH5nvpQTxBw7QDMiZIqpd04qr51RMQQJzVl1xPg24=;
        b=SXRMTRMkPmqoPIEzAHF10dO0U6j5HwVCF7I8pf4Fsh/Hy+mot9V6FWg9Ce0iNO1kWp
         o8gQA/wvAkp9zRdsjNUHT4ziSCUg0IDT4QDFOQ+fCLFS4i3fCFHItat0Ejt+yaD4cr5X
         TOaO+9AzgXXSII7XsRTHRZwisevc42WoZ0okgCCE0CJlNKDhqnm8+nOCdznV9ZlWhrSo
         dbGHaioowFTu8451KzVB7lXs3GyIxtAlARdZlJyAcJG229PpIizEgw2q9GrGHB/Qr5A6
         Lowg6kn81AczEKmerT7jSg4nfngoSZzwCrUx0SRslyCABbzPcDnTctvg1NG6ti2hKbrJ
         BAEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=9zmH5nvpQTxBw7QDMiZIqpd04qr51RMQQJzVl1xPg24=;
        b=gQ+um5EEeVCzrkIqE8UDbfGvSwmIckSd6u2oEt+TEy3w25bQ/goHf2uJcaCEf+Z7H3
         lZN3Nj3oyWmotqKxKYK1JcV0qTJ7SNXXDOJsikz2Tkq9KBIEQCFFAl5DJS0kNYfLDAp/
         TKae7ZCdAIyqjpGTwFT+rwtPod+4Gq+Yy0j/J4Q5qXDvaDJKtc0/YAevRDkBZEt5zlz7
         /S0/EanUwa/LZaxIpI4v2YffFL/7KbXfCMAvvzIOBz7hTei6FyiR16zbK5Gjk48hVRm7
         UKZqY3MG8idN8TcNx1WX652cDefBX6zzYUH+rsRHB1m8O61FEuAlysHNq33MJWVDUzq8
         rdlg==
X-Gm-Message-State: AIkVDXJvZZWJO7j7nVHsaUr/9D33vv8j3AmqZ1UHIS6CYwduKVzADxGBcj3qm0ESgHwHbcsxsaiWQVQcEwnw8w==
X-Received: by 10.237.47.161 with SMTP id m30mr27713867qtd.20.1485224324139;
 Mon, 23 Jan 2017 18:18:44 -0800 (PST)
MIME-Version: 1.0
Received: by 10.237.45.132 with HTTP; Mon, 23 Jan 2017 18:18:43 -0800 (PST)
In-Reply-To: <20170124021046.30735-1-eantoranz@gmail.com>
References: <20170124021046.30735-1-eantoranz@gmail.com>
From:   Edmundo Carmona Antoranz <eantoranz@gmail.com>
Date:   Mon, 23 Jan 2017 20:18:43 -0600
Message-ID: <CAOc6etYWiY=7-uvz_SRDmun=fX1rO03+-k=TFf_11kt5Vtsxzg@mail.gmail.com>
Subject: Re: [PATCH] [draft]blame: add --aggregate option
To:     Git List <git@vger.kernel.org>
Cc:     Edmundo Carmona Antoranz <eantoranz@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Developers of the world, rejoice! :-)

Junio, Pranit (and whoever is paying attention to the conversation
that was being held about --tips), here's a draft of what I meant when
I was talking about the option of "aggregating" blame output. I'm not
considering _all_ cases yet, just would like for people to give it a
quick test and tell me if they think it's worth "polishing" it for
inclusion into mainline git.

The output would look like this:

$ ./git blame -L 1,19 -t --aggregate builtin/blame.c
Blaming lines:   0% (19/2974), done.
       cee7f245dc builtin-pickaxe.c (Junio C Hamano   1161298804 -0700)
 1) /*
       31653c1abc builtin-blame.c   (Eugene Letuchy   1235170271 -0800)
 2)  * Blame
       cee7f245dc builtin-pickaxe.c (Junio C Hamano   1161298804 -0700)
 3)  *
       7e6ac6e439 builtin/blame.c   (David Kastrup    1398470209 +0200)
 4)  * Copyright (c) 2006, 2014 by its authors
 5)  * See COPYING for licensing conditions
       cee7f245dc builtin-pickaxe.c (Junio C Hamano   1161298804 -0700)
 6)  */
 7)
 8) #include "cache.h"
       fb58c8d507 builtin/blame.c   (Michael Haggerty 1434981785 +0200)
 9) #include "refs.h"
       cee7f245dc builtin-pickaxe.c (Junio C Hamano   1161298804 -0700)
10) #include "builtin.h"
11) #include "blob.h"
12) #include "commit.h"
13) #include "tag.h"
14) #include "tree-walk.h"
15) #include "diff.h"
16) #include "diffcore.h"
17) #include "revision.h"
       717d1462ba builtin-blame.c   (Linus Torvalds   1169976846 -0800)
18) #include "quote.h"
       cee7f245dc builtin-pickaxe.c (Junio C Hamano   1161298804 -0700)
19) #include "xdiff-interface.h"



It can be seen that options like -t still work in aggregation.

In relation to the previous conversation about "tips", I think a
better name could be "hints" and it could be added on top of the
aggregation.

On Mon, Jan 23, 2017 at 8:10 PM, Edmundo Carmona Antoranz
<eantoranz@gmail.com> wrote:
> ---
>  builtin/blame.c | 78 +++++++++++++++++++++++++++++++++++++--------------------
>  1 file changed, 51 insertions(+), 27 deletions(-)
>
> diff --git a/builtin/blame.c b/builtin/blame.c
> index 126b8c9e5..9e8403303 100644
> --- a/builtin/blame.c
> +++ b/builtin/blame.c
> @@ -1884,6 +1884,7 @@ static const char *format_time(unsigned long time, const char *tz_str,
>  #define OUTPUT_NO_AUTHOR       0200
>  #define OUTPUT_SHOW_EMAIL      0400
>  #define OUTPUT_LINE_PORCELAIN 01000
> +#define OUTPUT_AGGREGATE      02000
>
>  static void emit_porcelain_details(struct origin *suspect, int repeat)
>  {
> @@ -1931,43 +1932,36 @@ static void emit_porcelain(struct scoreboard *sb, struct blame_entry *ent,
>                 putchar('\n');
>  }
>
> -static void emit_other(struct scoreboard *sb, struct blame_entry *ent, int opt)
> +/**
> + * Print information about the revision.
> + * This information can be used in either aggregated output
> + * or prepending each line of the content of the file being blamed
> + */
> +static void print_revision_info(char* revision_hex, int revision_length, struct blame_entry* ent,
> +               struct commit* commit, struct commit_info ci, int opt, int show_raw_time)
>  {
> -       int cnt;
> -       const char *cp;
> -       struct origin *suspect = ent->suspect;
> -       struct commit_info ci;
> -       char hex[GIT_SHA1_HEXSZ + 1];
> -       int show_raw_time = !!(opt & OUTPUT_RAW_TIMESTAMP);
> -
> -       get_commit_info(suspect->commit, &ci, 1);
> -       sha1_to_hex_r(hex, suspect->commit->object.oid.hash);
> -
> -       cp = nth_line(sb, ent->lno);
> -       for (cnt = 0; cnt < ent->num_lines; cnt++) {
> -               char ch;
> -               int length = (opt & OUTPUT_LONG_OBJECT_NAME) ? GIT_SHA1_HEXSZ : abbrev;
> -
> -               if (suspect->commit->object.flags & UNINTERESTING) {
> +       if (opt & OUTPUT_AGGREGATE)
> +               printf("\t");
> +       int length = revision_length;
> +                       if (commit->object.flags & UNINTERESTING) {
>                         if (blank_boundary)
> -                               memset(hex, ' ', length);
> +                               memset(revision_hex, ' ', length);
>                         else if (!(opt & OUTPUT_ANNOTATE_COMPAT)) {
>                                 length--;
>                                 putchar('^');
>                         }
>                 }
>
> -               printf("%.*s", length, hex);
> +               printf("%.*s", length, revision_hex);
>                 if (opt & OUTPUT_ANNOTATE_COMPAT) {
>                         const char *name;
>                         if (opt & OUTPUT_SHOW_EMAIL)
>                                 name = ci.author_mail.buf;
>                         else
>                                 name = ci.author.buf;
> -                       printf("\t(%10s\t%10s\t%d)", name,
> +                       printf("\t(%10s\t%10s\t", name,
>                                format_time(ci.author_time, ci.author_tz.buf,
> -                                          show_raw_time),
> -                              ent->lno + 1 + cnt);
> +                                          show_raw_time));
>                 } else {
>                         if (opt & OUTPUT_SHOW_SCORE)
>                                 printf(" %*d %02d",
> @@ -1975,11 +1969,7 @@ static void emit_other(struct scoreboard *sb, struct blame_entry *ent, int opt)
>                                        ent->suspect->refcnt);
>                         if (opt & OUTPUT_SHOW_NAME)
>                                 printf(" %-*.*s", longest_file, longest_file,
> -                                      suspect->path);
> -                       if (opt & OUTPUT_SHOW_NUMBER)
> -                               printf(" %*d", max_orig_digits,
> -                                      ent->s_lno + 1 + cnt);
> -
> +                                      ent->suspect->path);
>                         if (!(opt & OUTPUT_NO_AUTHOR)) {
>                                 const char *name;
>                                 int pad;
> @@ -1994,9 +1984,42 @@ static void emit_other(struct scoreboard *sb, struct blame_entry *ent, int opt)
>                                                    ci.author_tz.buf,
>                                                    show_raw_time));
>                         }
> +               }
> +               if (opt & OUTPUT_AGGREGATE)
> +                       printf(")\n");
> +}
> +
> +static void emit_other(struct scoreboard *sb, struct blame_entry *ent, int opt)
> +{
> +       int cnt;
> +       const char *cp;
> +       struct origin *suspect = ent->suspect;
> +       struct commit_info ci;
> +       char hex[GIT_SHA1_HEXSZ + 1];
> +       int show_raw_time = !!(opt & OUTPUT_RAW_TIMESTAMP);
> +       int revision_length = (opt & OUTPUT_LONG_OBJECT_NAME) ? GIT_SHA1_HEXSZ : abbrev;
> +
> +       get_commit_info(suspect->commit, &ci, 1);
> +       sha1_to_hex_r(hex, suspect->commit->object.oid.hash);
> +
> +       if (opt & OUTPUT_AGGREGATE)
> +               print_revision_info(hex, revision_length, ent, suspect->commit, ci, opt, show_raw_time);
> +
> +       cp = nth_line(sb, ent->lno);
> +       for (cnt = 0; cnt < ent->num_lines; cnt++) {
> +               if (!(opt & OUTPUT_AGGREGATE))
> +                       print_revision_info(hex, revision_length, ent, suspect->commit, ci, opt, show_raw_time);
> +               if (opt & OUTPUT_ANNOTATE_COMPAT) {
> +                       printf("%*d) ",
> +                              max_digits, ent->lno + 1 + cnt);
> +               } else {
> +                       if (opt & OUTPUT_SHOW_NUMBER)
> +                               printf(" %*d ", max_orig_digits,
> +                                      ent->s_lno + 1 + cnt);
>                         printf(" %*d) ",
>                                max_digits, ent->lno + 1 + cnt);
>                 }
> +               char ch;
>                 do {
>                         ch = *cp++;
>                         putchar(ch);
> @@ -2609,6 +2632,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
>                 { OPTION_CALLBACK, 'C', NULL, &opt, N_("score"), N_("Find line copies within and across files"), PARSE_OPT_OPTARG, blame_copy_callback },
>                 { OPTION_CALLBACK, 'M', NULL, &opt, N_("score"), N_("Find line movements within and across files"), PARSE_OPT_OPTARG, blame_move_callback },
>                 OPT_STRING_LIST('L', NULL, &range_list, N_("n,m"), N_("Process only line range n,m, counting from 1")),
> +               OPT_BIT(0, "aggregate", &output_option, N_("Aggregate output"), OUTPUT_AGGREGATE),
>                 OPT__ABBREV(&abbrev),
>                 OPT_END()
>         };
> --
> 2.11.0.rc1
>
