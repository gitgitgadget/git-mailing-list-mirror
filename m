Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7AF141F97E
	for <e@80x24.org>; Fri, 12 Oct 2018 22:31:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725954AbeJMGFk (ORCPT <rfc822;e@80x24.org>);
        Sat, 13 Oct 2018 02:05:40 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:33699 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725926AbeJMGFj (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Oct 2018 02:05:39 -0400
Received: by mail-ed1-f66.google.com with SMTP id l14-v6so3815818edq.0
        for <git@vger.kernel.org>; Fri, 12 Oct 2018 15:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QY1u56ZJm6P1QvpGwbOLVY4Ju4xeR4VBa/jIe8ZHbAE=;
        b=TnrZ2YLjvuBWou8iZzENE51Yg6gEt3pbnwsUKYk+oIcJJTqiMRf3OQY1nqMpdMJtbk
         35r2/T+LpX/j//DLgHxkVzuQr9N3iZn0ag31yOsVFGxEbrhJQ6cgSzCNX4yAebatHmUl
         0Aubvl+se1d4OAJyLweKDhHKv+jckI2qIsfixRtdX/2d/LtqDIrUmtCc5lWiBHRfn72s
         eD1Lx9k+rV1mMjoiJHbf0YW1ryrnLz3dkxtlOSuFmY8DkI9SHRwabYNfhzZ4R+ZrqqdG
         RvUh3XcXagHrQnscBvGmetkiHS4YNapKHsuCi9SM2b6owGPC+MOEKiiMvaWSTVzzdVvc
         rxOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QY1u56ZJm6P1QvpGwbOLVY4Ju4xeR4VBa/jIe8ZHbAE=;
        b=gJuNYFwI9dy8m5msxp23Fxj3Cbfzh/w4PIzRYcZrcr+WJyXX5SE/IPWGxI/JzJozVz
         fvjlsG1DgA+pNitT2PPjxaTXmE1mkk6pPU9MjbPLnpZPXnrVuIgg5RVQr/eIrtt0pt2s
         LQdpeLJ2MRSVZFjC1u9B1Q2H7YUj9W2v9KNa9R3CN6/qeh++t3Tqy5kQ0ysMENtyRjzb
         uQDvETPcPLmJCVMNhGzawHJWJRktymKzub3yaePfe80m1n3uq04iTShiGo3E576qbmCP
         KP7EW1AFtS4HfC5ZqjR6EBC9dQvyPg7TUUvQgtf4BT/OuS9Cv4r1n4IbRzrSt3+s6cyU
         l9zQ==
X-Gm-Message-State: ABuFfogE+AOfMyx3ig7ZkT/e1krFevDkZn5h6tZUsf/98HuoGEUqNbLx
        e50cU2TNrCw99k+wQs2pWM9NWYvAgv3VBvPBFUqYcw==
X-Google-Smtp-Source: ACcGV61jzM6mN/frJvVEnHfE+06fgiKLU5hiFz5kCdEQtsdrmXqH99hBNi2HF7sM0nhC06hF2/F/H28lrkQ5NxwcQtE=
X-Received: by 2002:a50:bc12:: with SMTP id j18-v6mr11487571edh.154.1539383464297;
 Fri, 12 Oct 2018 15:31:04 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1538516853.git.steadmon@google.com> <cover.1539305180.git.steadmon@google.com>
 <70986cec32880db16568d85c351b33e9a8e16f1c.1539305180.git.steadmon@google.com>
In-Reply-To: <70986cec32880db16568d85c351b33e9a8e16f1c.1539305180.git.steadmon@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 12 Oct 2018 15:30:52 -0700
Message-ID: <CAGZ79kbuVRAceWF5cb4JAk=ss_4sEKthwxMG2wM+gLWbUdcTVQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] protocol: advertise multiple supported versions
To:     Josh Steadmon <steadmon@google.com>
Cc:     git <git@vger.kernel.org>, Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 11, 2018 at 6:02 PM <steadmon@google.com> wrote:
>
> From: Josh Steadmon <steadmon@google.com>
>
> Currently the client advertises that it supports the wire protocol
> version set in the protocol.version config. However, not all services
> support the same set of protocol versions. When connecting to
> git-receive-pack, the client automatically downgrades to v0 if
> config.protocol is set to v2, but this check is not performed for other
> services.
>
> This patch creates a protocol version registry. Individual commands
> register all the protocol versions they support prior to communicating
> with a server. Versions should be listed in preference order; the
> version specified in protocol.version will automatically be moved to the
> front of the registry.
>
> The protocol version registry is passed to remote helpers via the
> GIT_PROTOCOL environment variable.
>
> Clients now advertise the full list of registered versions. Servers
> select the first recognized version from this advertisement.

I like this patch from the users point of view (i.e. inside fetch/push etc),
and I need to through the details in connect/protocol as that seems
to be a lot of new code, but hides the complexity very well.

> +       register_allowed_protocol_version(protocol_v2);
> +       register_allowed_protocol_version(protocol_v1);
> +       register_allowed_protocol_version(protocol_v0);

Would it make sense to have a

    register_allowed_protocol_versions(protocol_v2, protocol_v1,
protocol_v0, NULL);

similar to argv_array_pushl  or would that be overengineered?

> @@ -1085,10 +1085,9 @@ static struct child_process *git_connect_git(int fd[2], char *hostandport,
>                     target_host, 0);
>
>         /* If using a new version put that stuff here after a second null byte */
> -       if (version > 0) {
> +       if (strcmp(version_advert->buf, "version=0")) {
>                 strbuf_addch(&request, '\0');
> -               strbuf_addf(&request, "version=%d%c",
> -                           version, '\0');
> +               strbuf_addf(&request, "%s%c", version_advert->buf, '\0');

It's a bit unfortunate to pass around the string, but reading through
the following
lines seems like it is easiest.


> @@ -1226,16 +1226,10 @@ struct child_process *git_connect(int fd[2], const char *url,
>  {
>         char *hostandport, *path;
>         struct child_process *conn;
> +       struct strbuf version_advert = STRBUF_INIT;
>         enum protocol protocol;
> -       enum protocol_version version = get_protocol_version_config();
>
> -       /*
> -        * NEEDSWORK: If we are trying to use protocol v2 and we are planning
> -        * to perform a push, then fallback to v0 since the client doesn't know
> -        * how to push yet using v2.
> -        */
> -       if (version == protocol_v2 && !strcmp("git-receive-pack", prog))
> -               version = protocol_v0;
> +       get_client_protocol_version_advertisement(&version_advert);

Nice to have this special casing gone!

> diff --git a/protocol.c b/protocol.c
> index 5e636785d1..f788269c47 100644
> +
> +static const char protocol_v0_string[] = "0";
> +static const char protocol_v1_string[] = "1";
> +static const char protocol_v2_string[] = "2";
> +
...
> +/* Return the text representation of a wire protocol version. */
> +static const char *format_protocol_version(enum protocol_version version)
> +{
> +       switch (version) {
> +       case protocol_v0:
> +               return protocol_v0_string;
> +       case protocol_v1:
> +               return protocol_v1_string;
> +       case protocol_v2:
> +               return protocol_v2_string;
> +       case protocol_unknown_version:
> +               die(_("Unrecognized protocol version"));
> +       }
> +       die(_("Unrecognized protocol_version"));
> +}

Up to now we have the textual representation that can easily
be constructed from protocol_version by using e.g.
    sprintf(buf, "%d", version);
which is why I initially thought this could be worded way
shorter, but I guess this is more future proof?


> +
>  enum protocol_version get_protocol_version_config(void)
>  {
>         const char *value;
> @@ -30,6 +55,79 @@ enum protocol_version get_protocol_version_config(void)
>         return protocol_v0;
>  }
>
> +void register_allowed_protocol_version(enum protocol_version version)
> +{
> +       if (have_advertised_versions_already)
> +               error(_("attempting to register an allowed protocol version after advertisement"));

This would be a
    BUG(...)
instead?
