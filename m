Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE8C420966
	for <e@80x24.org>; Mon, 10 Apr 2017 12:49:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753255AbdDJMtC (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Apr 2017 08:49:02 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34188 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752997AbdDJMtB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Apr 2017 08:49:01 -0400
Received: by mail-wm0-f68.google.com with SMTP id x75so9475561wma.1
        for <git@vger.kernel.org>; Mon, 10 Apr 2017 05:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=vnfOw3Yl3kCzPKTouJSCiA3ApNoItXfkZs+dFbwxHUI=;
        b=O5wUujr2p3qLH++XdC8XxGGAMUhaSpTRXHuNfL5RzwGXWF7uhRITFl1im28yEPxbEl
         9iWJodS+Jw/Sk8xoTOYUrG0gItZaYdux0y7Ca1zGPOhi889vOA4YI4b8bktgZQ33Seph
         5OrUOIP0x6wlVyW19tinzaMdc/PuXjMZ7jCVe+GylvlgP20Qb+wsNkd194PE/WuUW6hE
         MLHC6aliz9NfaIa16Akxo0ZjKAkyEaimdmtnNBqtSHNNXik9tyjX7/OucMHdtrBZaWKD
         9g5GX/Dt8ry29fkAJbZP5hxY5pxUhZvSMUlVMAHbwM4fmIwhX9MT2FVoioEnOH/Fklk/
         tNgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=vnfOw3Yl3kCzPKTouJSCiA3ApNoItXfkZs+dFbwxHUI=;
        b=QvYEnZ4XIp7ItbzpkJxgb52CVzKvukPypd0q2Zed50EvLv5iELFXMKZubcVawGeF3S
         Pvxft4wUrrQ1pP575M47usPRhTGGFAG8+cEYHenX/h9xoC/GKyBLXNZvrU2fDBZFugIV
         z6v4yU9eUMJBDh4evB1zsazkG6/tejXgQnTHptLWXo9QgT5tXcZjWmS0iJWvoLhBfhNP
         Shc76zOJ/qWgEP1+j9otmISmREseu9eVPT2NfCFYjxJmjB5QqaLryvk0m1z2v8KDKXab
         57nXDd8HsGcXkMMELK5JlOq4S0oBVYv0fsmwLN2KAp64I+X2XPoOsTHQcJKGzm5fzc75
         HM+Q==
X-Gm-Message-State: AN3rC/44NTw/yjCjYne8LHkAWZSxenX8FYs8vwMFs/4oqSiK9VXzl3dk
        JKeknf7mX8CHSA==
X-Received: by 10.28.212.67 with SMTP id l64mr10470760wmg.76.1491828540395;
        Mon, 10 Apr 2017 05:49:00 -0700 (PDT)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id l14sm17342397wre.23.2017.04.10.05.48.59
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 10 Apr 2017 05:48:59 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v5 8/8] convert: Update subprocess_read_status to not die on EOF
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <20170407120354.17736-9-benpeart@microsoft.com>
Date:   Mon, 10 Apr 2017 14:48:59 +0200
Cc:     git@vger.kernel.org, gitster@pobox.com, benpeart@microsoft.com,
        christian.couder@gmail.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <DD629A2F-362D-41F0-9240-F79C319AA76B@gmail.com>
References: <20170407120354.17736-1-benpeart@microsoft.com> <20170407120354.17736-9-benpeart@microsoft.com>
To:     Ben Peart <peartben@gmail.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 07 Apr 2017, at 14:03, Ben Peart <peartben@gmail.com> wrote:
>=20
> Enable sub-processes to gracefully handle when the process dies by
> updating subprocess_read_status to return an error on EOF instead of
> dying.
>=20
> Update apply_multi_file_filter to take advantage of the revised
> subprocess_read_status.
>=20
> Signed-off-by: Ben Peart <benpeart@microsoft.com>
> ---
> convert.c     | 10 ++++++++--
> sub-process.c | 10 +++++++---
> sub-process.h |  2 +-
> 3 files changed, 16 insertions(+), 6 deletions(-)
>=20
> diff --git a/convert.c b/convert.c
> index baa41da760..9e181e27ad 100644
> --- a/convert.c
> +++ b/convert.c
> @@ -629,7 +629,10 @@ static int apply_multi_file_filter(const char =
*path, const char *src, size_t len
> 	if (err)
> 		goto done;
>=20
> -	subprocess_read_status(process->out, &filter_status);
> +	err =3D subprocess_read_status(process->out, &filter_status);
> +	if (err)
> +		goto done;
> +
> 	err =3D strcmp(filter_status.buf, "success");
> 	if (err)
> 		goto done;
> @@ -638,7 +641,10 @@ static int apply_multi_file_filter(const char =
*path, const char *src, size_t len
> 	if (err)
> 		goto done;
>=20
> -	subprocess_read_status(process->out, &filter_status);
> +	err =3D subprocess_read_status(process->out, &filter_status);
> +	if (err)
> +		goto done;
> +
> 	err =3D strcmp(filter_status.buf, "success");
>=20
> done:
> diff --git a/sub-process.c b/sub-process.c
> index 60bb650012..c5057cafcd 100644
> --- a/sub-process.c
> +++ b/sub-process.c
> @@ -30,13 +30,15 @@ struct subprocess_entry =
*subprocess_find_entry(const char *cmd)
> 	return hashmap_get(&subprocess_map, &key, NULL);
> }
>=20
> -void subprocess_read_status(int fd, struct strbuf *status)
> +int subprocess_read_status(int fd, struct strbuf *status)
> {
> 	struct strbuf **pair;
> 	char *line;
> +	int len;
> +
> 	for (;;) {
> -		line =3D packet_read_line(fd, NULL);
> -		if (!line)
> +		len =3D packet_read_line_gently(fd, NULL, &line);
> +		if ((len =3D=3D -1) || !line)

Minor nit: Maybe "if ((len < 0) || !line)" ?


> 			break;
> 		pair =3D strbuf_split_str(line, '=3D', 2);
> 		if (pair[0] && pair[0]->len && pair[1]) {
> @@ -48,6 +50,8 @@ void subprocess_read_status(int fd, struct strbuf =
*status)
> 		}
> 		strbuf_list_free(pair);
> 	}
> +
> +	return len =3D=3D -1 ? len : 0;

Minor nit: Maybe "return len < 0 ? len : 0;

> }
>=20
> void subprocess_stop(struct subprocess_entry *entry)
> diff --git a/sub-process.h b/sub-process.h
> index 0cf1760a0a..5a1eeeece0 100644
> --- a/sub-process.h
> +++ b/sub-process.h
> @@ -41,6 +41,6 @@ static inline struct child_process =
*subprocess_get_child_process(
>  * key/value pairs and return the value from the last "status" packet
>  */
>=20
> -void subprocess_read_status(int fd, struct strbuf *status);
> +int subprocess_read_status(int fd, struct strbuf *status);
>=20
> #endif
> --=20
> 2.12.0.windows.1.31.g1548525701.dirty
>=20

Looks good to me.

Thanks,
Lars

