Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3EBDE1F576
	for <e@80x24.org>; Thu,  1 Feb 2018 10:16:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751923AbeBAKQN (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Feb 2018 05:16:13 -0500
Received: from mail-qt0-f172.google.com ([209.85.216.172]:34930 "EHLO
        mail-qt0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751748AbeBAKQM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Feb 2018 05:16:12 -0500
Received: by mail-qt0-f172.google.com with SMTP id g14so25724727qti.2
        for <git@vger.kernel.org>; Thu, 01 Feb 2018 02:16:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=34OupIy1iuTX+FIHryao63PLrrhs3jQAXb0yjdUod5U=;
        b=NvQmTGHtbdh+qqyEZIVFS8zfQfQZ3XNMgCQjSVRIMXmK4EshWX4np0mDaEn/clrJ4e
         sFYUScvvOSoZ/nfeZY3+PN0MOj2eWTfJbnLmA7LlIARlZT2tHfcA6i4ELboFPfUzcDrI
         OGQJPkhS8h7GjUQ7z3NpNNrDS6l6TUS1vCghO3eBNO2DGRoNnMWxPKcRUi2l7Eeb4Kgk
         vnPXh3lUFO2NHadKRZbqcHufCLWEPWYAP/PVwnIICipGRXrStxxtArvANkec40eaD8Y5
         EU9CSBtwD+5k3UFlIwQ9p3LEKnNI+EFsvOA6LTFnxNfC/t5oqHEPtFbp5g4J26/4hL3N
         Y9Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=34OupIy1iuTX+FIHryao63PLrrhs3jQAXb0yjdUod5U=;
        b=uDHLxYUg3Swg7cOHePuL/wg9pRgKiaqI7PSQ9rrbAzvLIVR8EvfwrgbG/LjKi9BcLx
         QQEX24v6tfrTb+RoQHJ8l7rFgafdnbcaXyzaQKgkLO8XV6syA53oJ6HBPo4N2ncufJnY
         edw3/coUeXdLwCVmtpEZ9v2f73qVO+7cCbBpeXcgh2/JEksCSAat74PnDqijTRZUvI9w
         uEn7lw+uus3NbwPcGiUUhaLK1EzTx9PSMwPtW0pj0BD27vgAvQUcFUn7xWYgA8kumbVU
         1pOh8MqrA1Quy7C2o8eOBkvYeamoLOLEiUep3EOm3LoXIXboUaeVN7QI8lRiT4yzuiWa
         sy7w==
X-Gm-Message-State: AKwxytcZrhszvrhurq+LBsJayFGo+YVvP6889SoZEpFQ9Xqua1YSEdkw
        Immeye7F0uSGZIqCXkU8G32t4W0MPV5YITm74bw=
X-Google-Smtp-Source: AH8x224H7UXuqz4Ykc7cmFBs2P0krodSHHhc8lsBf23/d20SxebtZzlamljPJPif7zJzPHhsyRB3aM0nShWiG9U7qRQ=
X-Received: by 10.200.9.42 with SMTP id t39mr55790357qth.74.1517480171949;
 Thu, 01 Feb 2018 02:16:11 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.175.239 with HTTP; Thu, 1 Feb 2018 02:16:11 -0800 (PST)
In-Reply-To: <450140f4-d410-4f1a-e5c1-c56d345a7f7c@suse.com>
References: <450140f4-d410-4f1a-e5c1-c56d345a7f7c@suse.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 1 Feb 2018 05:16:11 -0500
X-Google-Sender-Auth: tKJSfaGRlw10cHg99sfwf0MyWBo
Message-ID: <CAPig+cTFsp60KB+quuytW_nV2crLcjRV-PYN-3bO7tRY0_xu6w@mail.gmail.com>
Subject: Re: [PATCH] tag: add --edit option
To:     Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 1, 2018 at 4:49 AM, Nicolas Morey-Chaisemartin
<nmoreychaisemartin@suse.com> wrote:
> Add a --edit option whichs allows modifying the messages provided by -m or -F,
> the same way git commit --edit does.
>
> Signed-off-by: Nicolas Morey-Chaisemartin <NMoreyChaisemartin@suse.com>
> ---
> diff --git a/builtin/tag.c b/builtin/tag.c
> @@ -224,7 +225,7 @@ static void create_tag(const struct object_id *object, const char *tag,
> -       if (!opt->message_given) {
> +       if (!opt->message_given || opt->use_editor) {
>
> -               if (!is_null_oid(prev)) {
> +               if (opt->message_given) {
> +                       write_or_die(fd, buf->buf, buf->len);
> +                       strbuf_reset(buf);
> +               } else if (!is_null_oid(prev)) {
>                         write_tag_body(fd, prev);
>                 } else {

A little below this change is where launch_editor() is actually
invoked. If it fails for some reason, it prints:

    Please supply the message using either -m or -F option.

which seems a bit counterintuitive if the user *did* specify one of
those options along with --edit. I wonder if that message needs to be
adjusted.

> diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
> @@ -452,6 +452,23 @@ test_expect_success \
> +get_tag_header annotated-tag-edit $commit commit $time >expect
> +echo "An edited message" >>expect
> +test_expect_success 'set up editor' '
> +       cat >editor <<-\EOF &&
> +       #!/bin/sh
> +       sed -e "s/A message/An edited message/g" <"$1" >"$1-"
> +       mv "$1-" "$1"
> +       EOF
> +       chmod 755 editor

If you use write_script() to create the fake editor, then it supplies
the #!/bin/sh line for you and does the 'chmod', so you only need to
supply the actual script payload. Also, other "editors" in this test
file are named "fakeeditor", so perhaps follow suit.

    write_script fakeeditor <<-\EOF
        sed -e "s/A message/An edited message/g" <"$1" >"$1-"
        mv "$1-" "$1"
    EOF
