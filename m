Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4221D1F404
	for <e@80x24.org>; Mon,  9 Apr 2018 04:59:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751855AbeDIE7j (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Apr 2018 00:59:39 -0400
Received: from mail-qk0-f172.google.com ([209.85.220.172]:45461 "EHLO
        mail-qk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751833AbeDIE7i (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Apr 2018 00:59:38 -0400
Received: by mail-qk0-f172.google.com with SMTP id s9so7952281qke.12
        for <git@vger.kernel.org>; Sun, 08 Apr 2018 21:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=kbfggtCrOoVrrQPM0/81U0HcVM4C8u0yQnBrDqpYbXU=;
        b=o69i6JzecHfaE8qU3RTRnEXfc5x1oS3FDcvg4PisUgndooXX/j9V7QF6wBWZOwkUtf
         LPmBUKKLJPFbJf1li7tmTlltgU6UlNEp0+G3cI5Y1fve2gVqYmbdlkiFxZU06Au4a1bL
         0BUXkB1lNWpkfn+HZUwmj3UEZZBotFGGWoWpbptRJEriSm/yl4ETOMrIRKxProbWoBPb
         Ogewe8NcT0IzGq7fttk/mlMQF40bsJIvR6mVno488MUWrVDNO0iRqLlfNqHSYa2I079V
         A94223ACFTZyKnHdH7Av4HGSKDxNG54kynrJFptSEPum8lzNce/ED2upRYqrrLh6shbQ
         FHww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=kbfggtCrOoVrrQPM0/81U0HcVM4C8u0yQnBrDqpYbXU=;
        b=BLgpjviy3+YkaPa6q1XjxXcxI/JLa6BtRKzlBjbR+Xx+wBSFihsmPQqMVvnPKk4/UY
         xjXqCoxHP1CSsr4oUoARwMo6hAdRoWe2lmsYfR+ci0YqhkpTXunJHXF9U2ZDs1kEFRuB
         Hm5bNgTA6fVX1tMmsbuecb3qcMrw5aPiWOdHH+yBF+5C62iDmpF8DyEE85/V/yytj3pM
         o+AnklLX5NDBEfNLXn8+wmfdSJu0QyvJiF8r9Tql4ONtE27BHY+5Xxr4qShxi8uNIHtq
         yjqzMuOgyXi+Cvejb/ukRZLalCK/3BOG6sQyOxHTCoekPMKFJXui2oBXys6CRakZF64A
         LRKw==
X-Gm-Message-State: ALQs6tDkPpjtRQp5qnMKXE6Letvcmif87eYj5PaZnzUGBfHEejJSj1DO
        ToxYlayGiYC7N6yMakKAmEb9j7DwpO9u9bNZRt1GgA==
X-Google-Smtp-Source: AIpwx4/9O+yxnQCHOcVxA7DrzR9LmrN78Md/7X8fqowAsDl7zKAPwqt7Fm/RxdK8cX2la2kC5/QiNontPW4sPfCtUCA=
X-Received: by 10.55.108.69 with SMTP id h66mr47301715qkc.42.1523249977491;
 Sun, 08 Apr 2018 21:59:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.174.202 with HTTP; Sun, 8 Apr 2018 21:59:37 -0700 (PDT)
In-Reply-To: <20180326165520.802-4-pclouds@gmail.com>
References: <20180326165520.802-1-pclouds@gmail.com> <20180326165520.802-4-pclouds@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 9 Apr 2018 00:59:37 -0400
X-Google-Sender-Auth: mM1hbM6k8eAY_QqGWDc9CjIHSyI
Message-ID: <CAPig+cQHzB3zLqhRmDKuYk_w8283202x80BcuH7Mu3NqL95cZQ@mail.gmail.com>
Subject: Re: [PATCH/RFC 3/5] generate-cmdlist.sh: keep all information in common-cmds.h
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 26, 2018 at 12:55 PM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy
<pclouds@gmail.com> wrote:
> common-cmds.h is used to extract the list of common commands (by
> group) and a one-line summary of each command. Some information is
> dropped, for example command category or summary of other commands.
> Update generate-cmdlist.sh to keep all the information. The extra info
> will be used shortly.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.c=
om>
> ---
> diff --git a/generate-cmdlist.sh b/generate-cmdlist.sh
> @@ -2,9 +2,10 @@
>  struct cmdname_help {
> -       char name[16];
> +       char name[32];
>         char help[80];
> -       unsigned char group;
> +       unsigned int category;
> +       unsigned int group;
>  };
> @@ -23,27 +24,50 @@ sed -n '
> +echo "#define GROUP_NONE 0xff /* no common group */"
> +echo "#define GROUP_ 0xff /* no common group */"

Meh, this "GROUP_" alias of "GROUP_NONE" isn't so nice.

>  n=3D0
> -substnum=3D
>  while read grp
>  do
> -       echo "^git-..*[         ]$grp"
> -       substnum=3D"$substnum${substnum:+;}s/[    ]$grp/$n/"
> +       echo "#define GROUP_$grp $n"
>         n=3D$(($n+1))
> -done <"$grps" >"$match"
> +done <"$grps"

This patch drops all use of the file $match. Earlier in this script,
not seen in the context, are a couple references to $match which ought
to be adjusted to take its retirement into account:

    match=3Dmatch$$.tmp
    trap "rm -f '$grps' '$match'" 0 1 2 3 15

However, I'm concerned that this change may be going in the wrong
direction. A line in "### command list" section looks like this:

    command-name  category [deprecated] [common]

Although we don't currently have any commands marked with tag
"deprecated", we very well may have some day. More generally, new
optional or required tags may be added in the future. As such, the
line format is relatively free-form. Current clients don't even care
in what order the tags appears (following 'category') nor how many
tags there are. The new code added by this patch, however, is far less
flexible and accommodating since it assumes hard-coded columns for the
tags (and doesn't even take 'deprecated' into account).

The point of the $match file was to be able to extract only lines
which mentioned one of the "common groups", and the point of the
'substnum' transformation was to transform the group name into a group
number -- both of these operations were done without caring about the
exact column the "common group" tag occupied.

Obviously, one option for addressing this concern would be to change
the definition to make the tag columns fixed and non-optional, which
would allow the simpler implementation used by this patch. Doing so
may require fixing other consumers of command-list.txt (though, I'm
pretty sure existing consumers wouldn't be bothered).

(Perl would be an obvious good choice for retaining the current
relatively free-form line definition without having to jump through
hoops in the shell. Unfortunately, though, a Perl dependency in the
build system can be problematic[1].)

[1]: https://public-inbox.org/git/1440365469-9928-1-git-send-email-sunshine=
@sunshineco.com/

> -printf 'static struct cmdname_help common_cmds[] =3D {\n'
> -grep -f "$match" "$1" |
> +echo '/*'
> +printf 'static const char *cmd_categories[] =3D {\n'
> +grep '^git-' "$1" |

This "grep '^git-'" (and those below) misses some commands, such as
"gitk" and "gitweb". Is that intentional? If not, then you'll probably
need to grab lines following "### command list", as is done earlier in
the script. Same comment for the other couple grep's later in the
patch.

> +awk '{print $2;}' |

At one time, Junio expressed concerns[2] about having an 'awk'
dependency in the build system (in fact, with regards to this same
generation process). Whether he still has such concerns is unknown,
but it should be easy enough to avoid it here (and below).

[2]: https://public-inbox.org/git/20150519004356.GA12854@flurp.local/

> +sort |
> +uniq |
> +while read category; do
> +       printf '\t\"'$category'\",\n'
> +done
> +printf '\tNULL\n};\n\n'
> +echo '*/'
> diff --git a/help.c b/help.c
> @@ -190,6 +190,28 @@ void list_commands(unsigned int colopts,
> +static void extract_common_cmds(struct cmdname_help **p_common_cmds,
> +                               int *p_nr)
> +{
> +       int i, nr =3D 0;
> +       struct cmdname_help *common_cmds;
> +
> +       ALLOC_ARRAY(common_cmds, ARRAY_SIZE(command_list));
> +
> +       for (i =3D 0; i < ARRAY_SIZE(command_list); i++) {
> +               const struct cmdname_help *cmd =3D command_list + i;
> +
> +               if (cmd->category !=3D CAT_mainporcelain ||
> +                   cmd->group =3D=3D GROUP_NONE)
> +                       continue;

Is the CAT_mainporcelain condition necessary? Before this patch, the
command list would contain only commands with an associated group, so
it seems that you could get by just with the GROUP_NONE condition.

> +
> +               common_cmds[nr++] =3D *cmd;
> +       }
> +
> +       *p_common_cmds =3D common_cmds;
> +       *p_nr =3D nr;
> +}
