Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 501532092F
	for <e@80x24.org>; Sun, 22 Jan 2017 21:39:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750708AbdAVVjb (ORCPT <rfc822;e@80x24.org>);
        Sun, 22 Jan 2017 16:39:31 -0500
Received: from mail-qt0-f171.google.com ([209.85.216.171]:36320 "EHLO
        mail-qt0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750703AbdAVVja (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Jan 2017 16:39:30 -0500
Received: by mail-qt0-f171.google.com with SMTP id k15so93692714qtg.3
        for <git@vger.kernel.org>; Sun, 22 Jan 2017 13:39:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=zoKoCli/nFrLKnH3dStkTUOw5mQBcVnBUh88Qr6gcW0=;
        b=aWDBTN8HDTC/Iyd7kNAviXdzuH6em58XE/ag/TbjktNXd5ZKyq5Gp5i1ZEYOY4xCxO
         T0aqHJ71q5zexnevF+FV48SF0A0cwosJCGQAZ34ctjBg7qiaAqIQJzsP+zaU2N5PfVRG
         u2xbPBz3mXa5psBSst2DNa5TD+W6ntG6z6FxnioR6OsujmFdMirTJAZmWope/hWUhrJZ
         j0aP1zbV4UJBY7hlNKXidQmf1rf2PuKw9Cx7A/N/DWcRQ8zvjyr9mb5AYHkvQRaBBPvN
         NDBMGO3SFsrgI1bHd6UNv2W6n/Hu8cG1nlNmQn8orUQSVJRKIn5vqVyxqsS4wBHMdLVV
         gpEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=zoKoCli/nFrLKnH3dStkTUOw5mQBcVnBUh88Qr6gcW0=;
        b=Im5E8ig2J6p1Btb1VzHEAyfgemDPyytd8ZiqdUt9EnhWWhA9TJPIEVabmeEiDhitiq
         s1LInkNkeX3uirc01dfu522xfLV2gYYevKKagyj05+TftE/eqSeZBMMPcC2uNMosCopb
         /3Lir18kvEdBpqteGtFF+aV7i3jeu5kB4dbvxgFJer1OgYXj7ZQmGqF4cBqs+ClxdUSN
         dAMJz7jLRaLtLm+1Xz/l08bklh5+KNp9bCfIz9owilDMU100fBH1eswwpfrnefNwwLBI
         ykQz2j0bQUqoLlbcs0JLmujra20+kIgKrk7biUBgKBiftcnBGZxEUJdv5RPIs2HinJJE
         kB4A==
X-Gm-Message-State: AIkVDXLpkxsO18AM3XX97FFiPBTDlHgZQ5BY+XrXcP+uOl7x70HzWKNDD4ttT9KjOeepp7sCdDBh9iJc6WRuOg==
X-Received: by 10.200.47.53 with SMTP id j50mr20809744qta.273.1485121169531;
 Sun, 22 Jan 2017 13:39:29 -0800 (PST)
MIME-Version: 1.0
Received: by 10.237.45.132 with HTTP; Sun, 22 Jan 2017 13:39:29 -0800 (PST)
In-Reply-To: <20170122212855.25924-1-eantoranz@gmail.com>
References: <20170122212855.25924-1-eantoranz@gmail.com>
From:   Edmundo Carmona Antoranz <eantoranz@gmail.com>
Date:   Sun, 22 Jan 2017 15:39:29 -0600
Message-ID: <CAOc6etaQ-fDWn38YzXkGOC0fSan1vrxjVDUXS924nBXWTTrhNQ@mail.gmail.com>
Subject: Re: [PATCH] blame: add option to print tips (--tips)
To:     Git List <git@vger.kernel.org>
Cc:     Edmundo Carmona Antoranz <eantoranz@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello, everybody!

So, this is a draft of what I mean by "adding tips to blame".

Example output (sample from builtin/blame.c):

15:32 $ ./git blame --tips -L 1934,1960 builtin/blame.c
       cee7f245dc: git-pickaxe: blame rewritten.
cee7f245dc builtin-pickaxe.c (Junio C Hamano           2006-10-19
16:00:04 -0700 1934)
cee7f245dc builtin-pickaxe.c (Junio C Hamano           2006-10-19
16:00:04 -0700 1935) static void emit_other(struct scoreboard *sb,
struct blame_entry *ent, int opt)
cee7f245dc builtin-pickaxe.c (Junio C Hamano           2006-10-19
16:00:04 -0700 1936) {
cee7f245dc builtin-pickaxe.c (Junio C Hamano           2006-10-19
16:00:04 -0700 1937)  int cnt;
cee7f245dc builtin-pickaxe.c (Junio C Hamano           2006-10-19
16:00:04 -0700 1938)  const char *cp;
cee7f245dc builtin-pickaxe.c (Junio C Hamano           2006-10-19
16:00:04 -0700 1939)  struct origin *suspect = ent->suspect;
cee7f245dc builtin-pickaxe.c (Junio C Hamano           2006-10-19
16:00:04 -0700 1940)  struct commit_info ci;
       d59f765ac9: use sha1_to_hex_r() instead of strcpy
d59f765ac9 builtin/blame.c   (Jeff King                2015-09-24
17:08:03 -0400 1941)  char hex[GIT_SHA1_HEXSZ + 1];
       cee7f245dc: git-pickaxe: blame rewritten.
cee7f245dc builtin-pickaxe.c (Junio C Hamano           2006-10-19
16:00:04 -0700 1942)  int show_raw_time = !!(opt &
OUTPUT_RAW_TIMESTAMP);
       f2aea1696f: blame: add option to print tips (--tips)
f2aea1696f builtin/blame.c   (Edmundo Carmona Antoranz 2017-01-22
15:23:31 -0600 1943)  int revision_length = (opt &
OUTPUT_LONG_OBJECT_NAME) ? GIT_SHA1_HEXSZ : abbrev;
       cee7f245dc: git-pickaxe: blame rewritten.
cee7f245dc builtin-pickaxe.c (Junio C Hamano           2006-10-19
16:00:04 -0700 1944)
cee7f245dc builtin-pickaxe.c (Junio C Hamano           2006-10-19
16:00:04 -0700 1945)  get_commit_info(suspect->commit, &ci, 1);
       f2fd0760f6: Convert struct object to object_id
f2fd0760f6 builtin/blame.c   (brian m. carlson         2015-11-10
02:22:28 +0000 1946)  sha1_to_hex_r(hex,
suspect->commit->object.oid.hash);
       cee7f245dc: git-pickaxe: blame rewritten.
cee7f245dc builtin-pickaxe.c (Junio C Hamano           2006-10-19
16:00:04 -0700 1947)
       f2aea1696f: blame: add option to print tips (--tips)
f2aea1696f builtin/blame.c   (Edmundo Carmona Antoranz 2017-01-22
15:23:31 -0600 1948)  if (opt & OUTPUT_SHOW_TIPS)
f2aea1696f builtin/blame.c   (Edmundo Carmona Antoranz 2017-01-22
15:23:31 -0600 1949)          printf("\t%.*s: %s\n", revision_length,
hex, ci.summary.buf);
f2aea1696f builtin/blame.c   (Edmundo Carmona Antoranz 2017-01-22
15:23:31 -0600 1950)
       cee7f245dc: git-pickaxe: blame rewritten.
cee7f245dc builtin-pickaxe.c (Junio C Hamano           2006-10-19
16:00:04 -0700 1951)  cp = nth_line(sb, ent->lno);
cee7f245dc builtin-pickaxe.c (Junio C Hamano           2006-10-19
16:00:04 -0700 1952)  for (cnt = 0; cnt < ent->num_lines; cnt++) {
cee7f245dc builtin-pickaxe.c (Junio C Hamano           2006-10-19
16:00:04 -0700 1953)          char ch;
       f2aea1696f: blame: add option to print tips (--tips)
f2aea1696f builtin/blame.c   (Edmundo Carmona Antoranz 2017-01-22
15:23:31 -0600 1954)          int length = revision_length;
       b11121d9e3: git-blame: show lines attributed to boundary
commits differently.
b11121d9e3 builtin-blame.c   (Junio C Hamano           2006-12-01
20:45:45 -0800 1955)
b11121d9e3 builtin-blame.c   (Junio C Hamano           2006-12-01
20:45:45 -0800 1956)          if (suspect->commit->object.flags &
UNINTERESTING) {
       e68989a739: annotate: fix for cvsserver.
e68989a739 builtin-blame.c   (Junio C Hamano           2007-02-06
01:52:04 -0800 1957)                  if (blank_boundary)
e68989a739 builtin-blame.c   (Junio C Hamano           2007-02-06
01:52:04 -0800 1958)                          memset(hex, ' ',
length);
       7ceacdffc5: "blame -c" should be compatible with "annotate"
7ceacdffc5 builtin-blame.c   (Junio C Hamano           2008-09-05
00:57:35 -0700 1959)                  else if (!(opt &
OUTPUT_ANNOTATE_COMPAT)) {
       4c10a5caa7: blame: -b (blame.blankboundary) and --root (blame.showroot)
4c10a5caa7 builtin-blame.c   (Junio C Hamano           2006-12-18
14:04:38 -0800 1960)                          length--;


Does it look "worthy"? And if so, would it be better to think of
something like an "aggregate" option (or something like that) that
would include the common information as tips, something like:

15:32 $ ./git blame --tips -L 1934,1960 builtin/blame.c
       cee7f245dc: builtin-pickaxe.c (Junio C Hamano
2006-10-19 16:00:04 -0700) git-pickaxe: blame rewritten.
1934
1935 static void emit_other(struct scoreboard *sb, struct blame_entry
*ent, int opt)
1936 {
1937  int cnt;
1938  const char *cp;
1939  struct origin *suspect = ent->suspect;
1940  struct commit_info ci;
       d59f765ac9: builtin/blame.c   (Jeff King
2015-09-24 17:08:03 -0400) use sha1_to_hex_r() instead of strcpy
1941  char hex[GIT_SHA1_HEXSZ + 1];
       cee7f245dc: builtin-pickaxe.c (Junio C Hamano
2006-10-19 16:00:04 -0700) git-pickaxe: blame rewritten.
1942  int show_raw_time = !!(opt & OUTPUT_RAW_TIMESTAMP);
       f2aea1696f: builtin/blame.c   (Edmundo Carmona Antoranz
2017-01-22 15:23:31 -0600) blame: add option to print tips (--tips)
1943  int revision_length = (opt & OUTPUT_LONG_OBJECT_NAME) ?
GIT_SHA1_HEXSZ : abbrev;
       cee7f245dc: builtin-pickaxe.c (Junio C Hamano
2006-10-19 16:00:04 -0700) git-pickaxe: blame rewritten.
1944
1945  get_commit_info(suspect->commit, &ci, 1);

Best regards!

On Sun, Jan 22, 2017 at 3:28 PM, Edmundo Carmona Antoranz
<eantoranz@gmail.com> wrote:
> ---
>  builtin/blame.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/blame.c b/builtin/blame.c
> index 126b8c9e5..4bc449f40 100644
> --- a/builtin/blame.c
> +++ b/builtin/blame.c
> @@ -1884,6 +1884,7 @@ static const char *format_time(unsigned long time, const char *tz_str,
>  #define OUTPUT_NO_AUTHOR       0200
>  #define OUTPUT_SHOW_EMAIL      0400
>  #define OUTPUT_LINE_PORCELAIN 01000
> +#define OUTPUT_SHOW_TIPS      02000
>
>  static void emit_porcelain_details(struct origin *suspect, int repeat)
>  {
> @@ -1939,14 +1940,18 @@ static void emit_other(struct scoreboard *sb, struct blame_entry *ent, int opt)
>         struct commit_info ci;
>         char hex[GIT_SHA1_HEXSZ + 1];
>         int show_raw_time = !!(opt & OUTPUT_RAW_TIMESTAMP);
> +       int revision_length = (opt & OUTPUT_LONG_OBJECT_NAME) ? GIT_SHA1_HEXSZ : abbrev;
>
>         get_commit_info(suspect->commit, &ci, 1);
>         sha1_to_hex_r(hex, suspect->commit->object.oid.hash);
>
> +       if (opt & OUTPUT_SHOW_TIPS)
> +               printf("\t%.*s: %s\n", revision_length, hex, ci.summary.buf);
> +
>         cp = nth_line(sb, ent->lno);
>         for (cnt = 0; cnt < ent->num_lines; cnt++) {
>                 char ch;
> -               int length = (opt & OUTPUT_LONG_OBJECT_NAME) ? GIT_SHA1_HEXSZ : abbrev;
> +               int length = revision_length;
>
>                 if (suspect->commit->object.flags & UNINTERESTING) {
>                         if (blank_boundary)
> @@ -2609,6 +2614,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
>                 { OPTION_CALLBACK, 'C', NULL, &opt, N_("score"), N_("Find line copies within and across files"), PARSE_OPT_OPTARG, blame_copy_callback },
>                 { OPTION_CALLBACK, 'M', NULL, &opt, N_("score"), N_("Find line movements within and across files"), PARSE_OPT_OPTARG, blame_move_callback },
>                 OPT_STRING_LIST('L', NULL, &range_list, N_("n,m"), N_("Process only line range n,m, counting from 1")),
> +               OPT_BIT(0, "tips", &output_option, N_("Show tips before content lines"), OUTPUT_SHOW_TIPS),
>                 OPT__ABBREV(&abbrev),
>                 OPT_END()
>         };
> --
> 2.11.0.rc1
>
