Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 07AF81F404
	for <e@80x24.org>; Mon, 12 Feb 2018 19:26:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751190AbeBLT04 (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Feb 2018 14:26:56 -0500
Received: from mail-qt0-f172.google.com ([209.85.216.172]:42052 "EHLO
        mail-qt0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751085AbeBLT0r (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Feb 2018 14:26:47 -0500
Received: by mail-qt0-f172.google.com with SMTP id l9so653377qtj.9
        for <git@vger.kernel.org>; Mon, 12 Feb 2018 11:26:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=GGxn6qaNMgPgcuT+kZQEzIx32J0PV/nEnxn9/TEu3Ec=;
        b=XFot4ssTWBvzxJa5h5Xy4zpomnH4EAW8lcRRWIh9iNiW6s02UbmCEiUG3JKWW0f2ah
         7ookOCJgrtwKaDjHwCtp1e51XmaEFEx6/gBdeN9jDeWvoB+X2BjtOTTwbNof0ymbS6vw
         7/0ymAIbA8zXOaMfRk2ybsqzSH6BOuvuSVpUNZM6tLLuPWhNQQn9wUYG6A4WsHddAtWH
         D3hKlj9wJqp0/Bw7FcgdYGFXFu1tiVxZaQF9uPkvZC2UMYxgEwnSK3dApAN73J9/3Nh0
         u5vnQL9h8WR0B2/BisAs1ahWDuImwjHpH/tgX5eIVa4prgS82iwb3IaFq85rU8rYkGi7
         nDuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=GGxn6qaNMgPgcuT+kZQEzIx32J0PV/nEnxn9/TEu3Ec=;
        b=d3Q675Q3ICMBxo9cSS9XRDuzRDHxD3pJqHRe/3hHsfoUKKEulkKqgHR8FKuF7tUta/
         zoiHrMfQX9tU7yhRB0kvonUSprzytApyFsECt25A/eVNik52SAHPKBjaiUEZRF79/2Lm
         SQg1qtHxCVAs+BJna5aZ8IV508Dz47aRALf1TeYkr5obpAFudp7DmMSwOJzwSRRv/4G3
         i2GbEDQ/99dePs4Gqm8mAOWCUrlSXhJNC/OCwRjjhwrKvi7bY7fxlJZB6U5v/5IZRMba
         1VcJ8e1PpFexcm5OG1jywu9v29eZSVOiv8KUYQkk9B5XBUtNXa47K60z1TgxNOCcSsFM
         wSkA==
X-Gm-Message-State: APf1xPALG+9Ch4+K6q2Jwj7fdxylxXHS1Qq+KnmXShSZUuDPydkI9TOV
        6vKWL0FIg+ijwwKIHiA9hL+kou/IK5e8JtYdIB8=
X-Google-Smtp-Source: AH8x227Xst628XO1Fu6fwfqEflBg6XfTPs0c77Wf6tRS2eC90jYc9LYbRo0tjxh+4/0AHqRVk1acwJQ68DZxRYeT+t8=
X-Received: by 10.237.36.221 with SMTP id u29mr11973959qtc.116.1518463606996;
 Mon, 12 Feb 2018 11:26:46 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.128.40 with HTTP; Mon, 12 Feb 2018 11:26:46 -0800 (PST)
In-Reply-To: <6c1e131d2eb26534869c06b714cc5cc729004a41.1518307771.git.johannes.schindelin@gmx.de>
References: <cover.1517266437.git.johannes.schindelin@gmx.de>
 <cover.1518307771.git.johannes.schindelin@gmx.de> <6c1e131d2eb26534869c06b714cc5cc729004a41.1518307771.git.johannes.schindelin@gmx.de>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 12 Feb 2018 14:26:46 -0500
X-Google-Sender-Auth: XF0ejm_yjsRJdzjbEhhNia2uwR0
Message-ID: <CAPig+cRVK3r2fSM77=L0zx77oBPyia_8ju79x6WJPT2U5o8e+A@mail.gmail.com>
Subject: Re: [PATCH v3 04/12] sequencer: introduce new commands to reset the revision
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Philip Oakley <philipoakley@iee.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Feb 10, 2018 at 7:10 PM, Johannes Schindelin
<johannes.schindelin@gmx.de> wrote:
> [...]
> This commit implements the commands to label, and to reset to, given
> revisions. The syntax is:
>
>         label <name>
>         reset <name>
> [...]
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
> diff --git a/sequencer.c b/sequencer.c
> @@ -1922,6 +1951,151 @@ static int do_exec(const char *command_line)
> +static int safe_append(const char *filename, const char *fmt, ...)
> +{
> +       [...]
> +       if (write_in_full(fd, buf.buf, buf.len) < 0) {
> +               error_errno(_("could not write to '%s'"), filename);
> +               rollback_lock_file(&lock);

strbuf_release(&buf);

> +               return -1;
> +       }
> +       if (commit_lock_file(&lock) < 0) {
> +               rollback_lock_file(&lock);

strbuf_release(&buf);

> +               return error(_("failed to finalize '%s'"), filename);
> +       }
> +

strbuf_release(&buf);

> +       return 0;
> +}
> +
> +static int do_reset(const char *name, int len, struct replay_opts *opts)
> +{
> +       [...]
> +       unpack_tree_opts.reset = 1;
> +
> +       if (read_cache_unmerged())

rollback_lock_file(&lock);
strbuf_release(&ref_name);

> +               return error_resolve_conflict(_(action_name(opts)));
> +
> +       if (!fill_tree_descriptor(&desc, &oid)) {
> +               error(_("failed to find tree of %s"), oid_to_hex(&oid));
> +               rollback_lock_file(&lock);
> +               free((void *)desc.buffer);
> +               strbuf_release(&ref_name);
> +               return -1;
> +       }
