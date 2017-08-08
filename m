Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A76D11F991
	for <e@80x24.org>; Tue,  8 Aug 2017 10:09:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751958AbdHHKJl (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Aug 2017 06:09:41 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33954 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751921AbdHHKJk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Aug 2017 06:09:40 -0400
Received: by mail-pf0-f193.google.com with SMTP id t86so2625685pfe.1
        for <git@vger.kernel.org>; Tue, 08 Aug 2017 03:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=dYlEVQlq5PGL/dHbOsttjy5GCwtkj8GfepdlVdOQ6kQ=;
        b=WKUCBtk2djSDCEYZe0oYcaz6MmunFkIymDvDbmnB/Cz5dzyDkih0f2YhonUIEQ5t4S
         mdMFdBfriqEiVNsQWj6bnQJB17TCgv7IeXaU5p6Enb1nztZUiD4otoJPBopOzMfJb9EV
         Sw5tNlGLMrGx16zCAv3oYEecGWZaQgIHmKD8vAJsRe85MDtglGc9Oe5Rmn79bumT8Zji
         CoPoLDakXMHo3SWkn4u1kG5HWMvOXqQgW1aiskDZu5tqj88Riiy+B+Jxf9uzlLPFCp8B
         X2nhXizQJPSAk4SPGY3+LjrSeCgIEvJHTkodeO6G5ZikKj4xsYDW35IRxlQwJBA1h6yB
         bmYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=dYlEVQlq5PGL/dHbOsttjy5GCwtkj8GfepdlVdOQ6kQ=;
        b=nnlFNbrVuWosNamwsRXcFoNjYt2ph4N+mtYmSJmcrsCCdLI4PynbO1K8q8/s/O721i
         Chnb36eHGiZJw/1V/nOElMNb3uH4rwYvNg+Chd2dxWyL529BtZmLqHgdXmG6Ql0QuNiu
         R1+jvKtWPysjugP1HgQMjRKCa3LcxReAhNaYAJXpHB5D0au1rqXtK0n7cGx+93mOPFtJ
         IRkign5968ooLA78IkjZQa7IZi+JrrbWQsddW0QZO+1h6Uv/36Ynpqto18DCHpIWDIkK
         zHLlQ0mVaCHhDMRVs5pEiEo+TnmU5X9/FAi0pPNsQpnhd9xZ3U1C75QFW6kbG+86HE9Q
         9TYg==
X-Gm-Message-State: AHYfb5g6+8MaUPCMOwPbRus0Xtr9pd4/GlzAQ+g0jFuOuS+wIfzNdG3h
        7MZ0II6DN8LYPTBdN6NncyhVvmWM6g==
X-Received: by 10.99.112.16 with SMTP id l16mr3462654pgc.143.1502186980022;
 Tue, 08 Aug 2017 03:09:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.165.238 with HTTP; Tue, 8 Aug 2017 03:09:39 -0700 (PDT)
In-Reply-To: <43798048-d896-f93b-951a-53ca9cce6bbc@morey-chaisemartin.com>
References: <3637fd31-3120-eca0-b7ee-8e6e324b6b58@morey-chaisemartin.com> <43798048-d896-f93b-951a-53ca9cce6bbc@morey-chaisemartin.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Tue, 8 Aug 2017 12:09:39 +0200
Message-ID: <CAN0heSoqtp=48t5vK7QjsPY1jZz0jPL2arryP0BZTPouXiUOCw@mail.gmail.com>
Subject: Re: [PATCHv2 3/4] imap_send: setup_curl: retreive credentials if not
 set in config file
To:     Nicolas Morey-Chaisemartin <nicolas@morey-chaisemartin.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8 August 2017 at 09:48, Nicolas Morey-Chaisemartin
<nicolas@morey-chaisemartin.com> wrote:
> Up to this point, the curl mode only supported getting the username
> and password from the gitconfig file while the legacy mode could also
> fetch them using the credential API.
>
> Signed-off-by: Nicolas Morey-Chaisemartin <nicolas@morey-chaisemartin.com>
> ---
>  imap-send.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/imap-send.c b/imap-send.c
> index 448a4a0b3..5e80edaff 100644
> --- a/imap-send.c
> +++ b/imap-send.c
> @@ -1398,7 +1398,7 @@ static int append_msgs_to_imap(struct imap_server_conf *server,
>  }
>
>  #ifdef USE_CURL_FOR_IMAP_SEND
> -static CURL *setup_curl(struct imap_server_conf *srvc)
> +static CURL *setup_curl(struct imap_server_conf *srvc, struct credential *cred)

Hmm, yeah, that really did pollute the interface. :)

>  {
>         CURL *curl;
>         struct strbuf path = STRBUF_INIT;
> @@ -1411,6 +1411,7 @@ static CURL *setup_curl(struct imap_server_conf *srvc)
>         if (!curl)
>                 die("curl_easy_init failed");
>
> +       server_fill_credential(&server, cred);
>         curl_easy_setopt(curl, CURLOPT_USERNAME, server.user);
>         curl_easy_setopt(curl, CURLOPT_PASSWORD, server.pass);
>
> @@ -1460,8 +1461,9 @@ static int curl_append_msgs_to_imap(struct imap_server_conf *server,
>         struct buffer msgbuf = { STRBUF_INIT, 0 };
>         CURL *curl;
>         CURLcode res = CURLE_OK;
> +       struct credential cred = CREDENTIAL_INIT;
>
> -       curl = setup_curl(server);
> +       curl = setup_curl(server, &cred);
>         curl_easy_setopt(curl, CURLOPT_READDATA, &msgbuf);
>
>         fprintf(stderr, "sending %d message%s\n", total, (total != 1) ? "s" : "");
> @@ -1496,6 +1498,10 @@ static int curl_append_msgs_to_imap(struct imap_server_conf *server,
>         curl_easy_cleanup(curl);
>         curl_global_cleanup();
>
> +       if (res == CURLE_OK && cred.username)
> +               credential_approve(&cred);

Maybe a similar call to credential_reject(&cred) here? I guess all we'll
know is that some sort of error happened, possibly credentials-related,
possibly not. Just a thought.

> +       credential_clear(&cred);
> +
>         return res == CURLE_OK;
>  }
>  #endif
> --
> 2.14.0.rc1.16.gcc208c97c
>
>
