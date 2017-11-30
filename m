Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6970520C11
	for <e@80x24.org>; Thu, 30 Nov 2017 17:53:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753656AbdK3RxS (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Nov 2017 12:53:18 -0500
Received: from mail-qt0-f195.google.com ([209.85.216.195]:40110 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753356AbdK3RxR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Nov 2017 12:53:17 -0500
Received: by mail-qt0-f195.google.com with SMTP id u42so9780681qte.7
        for <git@vger.kernel.org>; Thu, 30 Nov 2017 09:53:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=3VHsBVt/8sGSgIDq6pHkXt5fxyr4j06s18zh09QE7sE=;
        b=g6eQYzbHzpU9HzyQ9Oc9i558dpdv3mHAaM6SiKwmBN7PcZy6oDAErz0pOpPgPRIsMA
         FmC6tD4MtEiGwsomXB9n2Lr7n6o99fIBj/rAwxs6ySdRXCpKxAuzaJHs9iktpazVC95n
         Pe0lYHOEVT16bvGi+JTiMzlIKhGLiJvld7787++UbOEqMHOsgG2tWt28RRp1oce+3S9j
         GIStpItncAs7+P9bN8UKIZNiCQDkR710AubSRtW/I4gOssQLsjxRH7bpGTXSiNhm7LZN
         usEnot3XRsN4j0RUfXmUWVAaBi++8gBS+zquWziBeF0ps6I6xQzREludHCtO9ETmDPRy
         Rl/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=3VHsBVt/8sGSgIDq6pHkXt5fxyr4j06s18zh09QE7sE=;
        b=oeHo0nSJpMYXlaYnzh5D4O0pQyjuelQuW3RvhZL+w7KtaQh5qepJrQqBHtSocYIsav
         nPNB1Cqk7/Yw5XjOHuhOTr1WH+CRejjqNsz5CT2Tapw/TPrk8aQOCHfbXenblYFM3eKw
         q0K3fP/Y6XuCS7ddxkhih778MiV5gVsKsYUxvEWdBIjU4jITkULkGdh0ET/uG1u1E4AS
         WO1EAB/UPX1RQSZShIRNzUbuhb47ywaKu97zVG4lilDORdJqfmREKcuyY7V8JCDFRmAQ
         YiTiI2OyP622HSX53ZRdi/VPftw8rxPlO709B1jAc3TvX/k5R4p2no7VjZEz5DiPd3jf
         6V4Q==
X-Gm-Message-State: AKGB3mLceVDQteECzu8tPjT6iIXRnTcW+TYGz4CK9nt0s9cTgRpxVWVU
        WTAOfKdpQ5n//n5CyZKs+xd/yCLFmajtYL44ujs=
X-Google-Smtp-Source: AGs4zMbHR9++h3Ts1APYS3K02on2gK0LupLAMf8hSYt1qQU99JxVmEghXkhrYvh6qfgyoi1HGhKRd3sOONbZrV6lQV8=
X-Received: by 10.200.39.104 with SMTP id h37mr4692101qth.114.1512064396624;
 Thu, 30 Nov 2017 09:53:16 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.198.4 with HTTP; Thu, 30 Nov 2017 09:53:16 -0800 (PST)
In-Reply-To: <18c9478b-19fc-69f2-229f-67c05a42d4f5@suse.com>
References: <20171129171301.l3coiflkfyy533yz@NUC.localdomain> <18c9478b-19fc-69f2-229f-67c05a42d4f5@suse.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 30 Nov 2017 12:53:16 -0500
X-Google-Sender-Auth: ydh3unIcYk--vua_sqKvHx-UJfc
Message-ID: <CAPig+cSEYHfupRt+-0sZK6H3_WcT_=wdNB2FfdYuB6geGQYZ3A@mail.gmail.com>
Subject: Re: [PATCH] imap-send: URI encode server folder
To:     Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Cc:     Git List <git@vger.kernel.org>, daniel@haxx.se,
        Jonathan Nieder <jrnieder@gmail.com>, doron.behar@gmail.com,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 30, 2017 at 5:07 AM, Nicolas Morey-Chaisemartin
<nmoreychaisemartin@suse.com> wrote:
> URI encode the server folder string before passing it to libcurl.
> This fixes the access to the draft folder on Gmail accounts (named [Gmail]/Drafts)

For someone reading this commit message in the future -- someone who
didn't follow the email thread which led to this patch -- "this fixes"
doesn't say much about the actual problem being addressed. Can you
expand the commit message a bit to make it more self-contained? At
minimum, perhaps show the error message you were experiencing, and
cite (as Daniel pointed out) RFC 3986 and the bit about a "legal" URL
not containing brackets.

Also, a natural question which pops into the head of someone reading
this patch is whether other parts of the URL (host, user, etc.) also
need to be handled similarly. It's possible that you audited the code
and determined that they are handled fine already, but the reader of
the commit message is unable to infer that. Consequently, it might be
nice to have a sentence about that, as well ("other parts of the URL
are already encoded, thus are fine" or "other parts of the URL are not
subject to this problem because ...").

The patch itself looks okay (from a cursory read).

Thanks.

> Reported-by: Doron Behar <doron.behar@gmail.com>
> Signed-off-by: Nicolas Morey-Chaisemartin <NMoreyChaisemartin@suse.com>
> ---
>  imap-send.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/imap-send.c b/imap-send.c
> index 54e6a80fd..36c7c1b4f 100644
> --- a/imap-send.c
> +++ b/imap-send.c
> @@ -1412,6 +1412,7 @@ static CURL *setup_curl(struct imap_server_conf *srvc, struct credential *cred)
>  {
>         CURL *curl;
>         struct strbuf path = STRBUF_INIT;
> +       char *uri_encoded_folder;
>
>         if (curl_global_init(CURL_GLOBAL_ALL) != CURLE_OK)
>                 die("curl_global_init failed");
> @@ -1429,7 +1430,12 @@ static CURL *setup_curl(struct imap_server_conf *srvc, struct credential *cred)
>         strbuf_addstr(&path, server.host);
>         if (!path.len || path.buf[path.len - 1] != '/')
>                 strbuf_addch(&path, '/');
> -       strbuf_addstr(&path, server.folder);
> +
> +       uri_encoded_folder = curl_easy_escape(curl, server.folder, 0);
> +       if (!uri_encoded_folder)
> +               die("failed to encode server folder");
> +       strbuf_addstr(&path, uri_encoded_folder);
> +       curl_free(uri_encoded_folder);
>
>         curl_easy_setopt(curl, CURLOPT_URL, path.buf);
>         strbuf_release(&path);
> --
> 2.15.1.272.g8e603414b
