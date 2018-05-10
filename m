Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 276011F406
	for <e@80x24.org>; Thu, 10 May 2018 18:21:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757277AbeEJSVt (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 May 2018 14:21:49 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:45362 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757103AbeEJSVs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 May 2018 14:21:48 -0400
Received: by mail-pf0-f196.google.com with SMTP id c10-v6so1460249pfi.12
        for <git@vger.kernel.org>; Thu, 10 May 2018 11:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=DMoiEQ52HyGA3the/x1cCv+/WuHLtM3IOSf1FiX96Do=;
        b=KloFcJyB9Q2nFks0xhew5/6kgpQYwm8URgz5zLocIXULv2mCYjA1GEzsIOQyZPZj+T
         hNjPeRXqU4h3X4q1TiVfz7p8vD/qf5xmSRQxz8QVI7qOWuYKwwJLR3zgyadIiDgFCRjr
         x0vcHvPdfdxZOOOAHsENQe8OpOn+WJ2qUYTe/q0Qx/u0CX8anOePegBfLUQ+mwdMAvwN
         sR65EsJYVrpuRq8JQIUUK6wt5ygiSL1I0i/07KpDLyQ/MRY66MxLUbnHOe2I4quHP+OF
         IJmm4Dg1piXycFAtP6wQ7qTPBQWG0E0+/wXhBidl+PCNeO5mi3KaWHfFRNyQ31oY+x2F
         b+hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=DMoiEQ52HyGA3the/x1cCv+/WuHLtM3IOSf1FiX96Do=;
        b=Fsw8mpm8vW2faUpjlk/+UcUn79l6o6TDHzE7YBUjKtrT5v5fv4QB5jq53W3jIiUP1G
         zHGJzc+A/H0DQcg9f2J4e6gnfuHfDzRL3tQzQ2Ux4l7s9C60WsDOjupUxxBfLLr7Kmry
         o9dUojTCGlWdddRbb0PJ0Hzd3fUHW8WUuBHYTK2t5CX25SV8ptLnJp/YgTE5tNOyIWxf
         gRcjWYzCDYZPURzfVE/CKjYMOUfWwneE8mIkVnxKKvp0uKT4oXMbHbm5j2gcfmGA6uEA
         KyQMVWAIK68zSoXsWCePFSE+7zB0ZYNsMl3/I3FfARZ78TEbrNrRaSh7zI8U6+pW5VD6
         lvrA==
X-Gm-Message-State: ALKqPwc8wZYYA1skbFBcDSbgoTSlDRFYAzryMQxJ5AeXElG70s+Qq9Ue
        S42QWN+Vl2iisjXd3KiJHZzoumpN0R+oveUt/yE=
X-Google-Smtp-Source: AB8JxZogp0DLlOOQKL3m6XUTEhoVK3AJw0Y2AeL5e/gbIqrLVR+ar6SMnrVs1u6AReCGz5cc8CdaKIMGZAyZVRWRy/M=
X-Received: by 2002:a63:7e08:: with SMTP id z8-v6mr1899683pgc.383.1525976507873;
 Thu, 10 May 2018 11:21:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.236.187.139 with HTTP; Thu, 10 May 2018 11:21:47 -0700 (PDT)
In-Reply-To: <20180510173345.40577-3-dstolee@microsoft.com>
References: <20180417181028.198397-1-dstolee@microsoft.com>
 <20180510173345.40577-1-dstolee@microsoft.com> <20180510173345.40577-3-dstolee@microsoft.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Thu, 10 May 2018 20:21:47 +0200
Message-ID: <CAN0heSrNdHGyrZ2qF6J2daD0VdjXDhErs1nVzO+KT5GvOPfAPw@mail.gmail.com>
Subject: Re: [PATCH 02/12] commit-graph: verify file header information
To:     Derrick Stolee <dstolee@microsoft.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "peff@peff.net" <peff@peff.net>,
        "sbeller@google.com" <sbeller@google.com>,
        "jnareb@gmail.com" <jnareb@gmail.com>,
        "stolee@gmail.com" <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10 May 2018 at 19:34, Derrick Stolee <dstolee@microsoft.com> wrote:
> During a run of 'git commit-graph verify', list the issues with the
> header information in the commit-graph file. Some of this information
> is inferred from the loaded 'struct commit_graph'. Some header
> information is checked as part of load_commit_graph_one().
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  commit-graph.c | 23 ++++++++++++++++++++++-
>  1 file changed, 22 insertions(+), 1 deletion(-)
>
> diff --git a/commit-graph.c b/commit-graph.c
> index b25aaed128..c3b8716c14 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -818,7 +818,28 @@ void write_commit_graph(const char *obj_dir,
>         oids.nr = 0;
>  }
>
> +static int verify_commit_graph_error;
> +#define graph_report(...) \
> +       do {\
> +               verify_commit_graph_error = 1;\
> +               printf(__VA_ARGS__);\
> +       } while (0);
> +

It seems to me that other users of __VA_ARGS__ are protected with a
check for HAVE_VARIADIC_MACROS and provide an alternative
non-__VA_ARGS__-implementation. Or maybe I've missed something in my
grepping and we are actually (slowly) moving towards assuming
__VA_ARGS__ is always available?

>  int verify_commit_graph(struct commit_graph *g)
>  {
> -       return !g;
> +       if (!g) {
> +               graph_report(_("no commit-graph file loaded"));
> +               return 1;
> +       }
> +
> +       verify_commit_graph_error = 0;
> +
> +       if (!g->chunk_oid_fanout)
> +               graph_report(_("commit-graph is missing the OID Fanout chunk"));
> +       if (!g->chunk_oid_lookup)
> +               graph_report(_("commit-graph is missing the OID Lookup chunk"));
> +       if (!g->chunk_commit_data)
> +               graph_report(_("commit-graph is missing the Commit Data chunk"));
> +
> +       return verify_commit_graph_error;

If you can't rely on __VA_ARGS__, maybe bite the bullet and introduce
braces... The expanded code wouldn't be too horrible, albeit a bit
repetitive.

Martin
