Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D47101FAFB
	for <e@80x24.org>; Sun,  9 Apr 2017 19:43:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752418AbdDITnG (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Apr 2017 15:43:06 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33646 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752320AbdDITnF (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Apr 2017 15:43:05 -0400
Received: by mail-wm0-f67.google.com with SMTP id o81so6402270wmb.0
        for <git@vger.kernel.org>; Sun, 09 Apr 2017 12:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=5X6dlFvbyCToF6X2O2zsuxZeMrKmBi5c6nVDzoqB+e0=;
        b=fv8+o3mTLgYKKleqR7iOJOorHgry1hK33Fuzm10OM5EN68oej/qrzNBUU5FmjBsZHP
         xCTz3MwdYkLOsi2/GeikMWWxKyLAAfeb+J8pa4v7Bsj/ZsKbCXTxfat9WX7Gx2RZGCFE
         FYTktXd14C1sNIwntVelGxKJMKP0R33pM/NLDHRxzAaEFEgYL1hnLIgFImd2gHTiw1S7
         siSssb+wOfSbXXjJM4mSipBKD5n7tKDH3M3g/gXc7K+AgJWmziqzxvCt+mMpsx7OHcNV
         DAM+dflnSpZogfJzw7WViiW/q68RusV8sY6jHXTc4ZRBpczaioGxLJICUeWeuCyt3eaC
         6q9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=5X6dlFvbyCToF6X2O2zsuxZeMrKmBi5c6nVDzoqB+e0=;
        b=Or3J5PD4U4ClwYgGGwexnY5l5QppAs3BJUHzGZU1r1fJ59vVdnUeKT82amVpnPGVqY
         L42I1tc89cjU7oMuHXQ4oz7fxwe633WLWDjyJbPwLoNjpKmH0px7VflTdggmIkKLxekB
         Bdb7n6bly+4WfO/8rIK3+mNnJ/2QxG9+MngKG8NbtNR80v4wtNrVLsPuYTuCyfNouzAc
         9NxhAybi7O4cPU3ouHGhzX6gZ15JzeM3lh6HKnTOwVgiGCh2MQYbpzUmpR/FhBJNgKte
         vi/g7ogKXCyPX289MrJnZ6KItkPaRBB/NG0sEnX8fq1LQOMbz3r77PmIthC31L8bc+hL
         kPRA==
X-Gm-Message-State: AN3rC/7LbIwxSMznqdNWlXxzmC65uKf8SmBkZlg3P1tllPpDw8V8uFQa6qlfIjy9SFoe0w==
X-Received: by 10.28.217.136 with SMTP id q130mr6672162wmg.132.1491766983472;
        Sun, 09 Apr 2017 12:43:03 -0700 (PDT)
Received: from slxbook4.fritz.box (p5DDB5F77.dip0.t-ipconnect.de. [93.219.95.119])
        by smtp.gmail.com with ESMTPSA id a66sm14677671wrc.58.2017.04.09.12.43.02
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 09 Apr 2017 12:43:02 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v5 2/8] convert: move packet_write_list() into pkt-line as packet_writel()
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <20170407120354.17736-3-benpeart@microsoft.com>
Date:   Sun, 9 Apr 2017 21:43:02 +0200
Cc:     git@vger.kernel.org, gitster@pobox.com, benpeart@microsoft.com,
        christian.couder@gmail.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <F62E46F7-6829-46E3-A890-106964CB632E@gmail.com>
References: <20170407120354.17736-1-benpeart@microsoft.com> <20170407120354.17736-3-benpeart@microsoft.com>
To:     Ben Peart <peartben@gmail.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 07 Apr 2017, at 14:03, Ben Peart <peartben@gmail.com> wrote:
>=20
> Add packet_writel() which writes multiple lines in a single call and
> then calls packet_flush_gently(). Update convert.c to use the new
> packet_writel() function from pkt-line.
>=20
> Signed-off-by: Ben Peart <benpeart@microsoft.com>
> ---
> convert.c  | 23 ++---------------------
> pkt-line.c | 19 +++++++++++++++++++
> pkt-line.h |  1 +
> 3 files changed, 22 insertions(+), 21 deletions(-)
>=20
> diff --git a/convert.c b/convert.c
> index 8d652bf27c..793c29ebfd 100644
> --- a/convert.c
> +++ b/convert.c
> @@ -521,25 +521,6 @@ static struct cmd2process =
*find_multi_file_filter_entry(struct hashmap *hashmap,
> 	return hashmap_get(hashmap, &key, NULL);
> }
>=20
> -static int packet_write_list(int fd, const char *line, ...)
> -{
> -	va_list args;
> -	int err;
> -	va_start(args, line);
> -	for (;;) {
> -		if (!line)
> -			break;
> -		if (strlen(line) > LARGE_PACKET_DATA_MAX)
> -			return -1;
> -		err =3D packet_write_fmt_gently(fd, "%s\n", line);
> -		if (err)
> -			return err;
> -		line =3D va_arg(args, const char*);
> -	}
> -	va_end(args);
> -	return packet_flush_gently(fd);
> -}
> -
> static void read_multi_file_filter_status(int fd, struct strbuf =
*status)
> {
> 	struct strbuf **pair;
> @@ -616,7 +597,7 @@ static struct cmd2process =
*start_multi_file_filter(struct hashmap *hashmap, cons
>=20
> 	sigchain_push(SIGPIPE, SIG_IGN);
>=20
> -	err =3D packet_write_list(process->in, "git-filter-client", =
"version=3D2", NULL);
> +	err =3D packet_writel(process->in, "git-filter-client", =
"version=3D2", NULL);
> 	if (err)
> 		goto done;
>=20
> @@ -632,7 +613,7 @@ static struct cmd2process =
*start_multi_file_filter(struct hashmap *hashmap, cons
> 	if (err)
> 		goto done;
>=20
> -	err =3D packet_write_list(process->in, "capability=3Dclean", =
"capability=3Dsmudge", NULL);
> +	err =3D packet_writel(process->in, "capability=3Dclean", =
"capability=3Dsmudge", NULL);
>=20
> 	for (;;) {
> 		cap_buf =3D packet_read_line(process->out, NULL);
> diff --git a/pkt-line.c b/pkt-line.c
> index 58842544b4..2788aa1af6 100644
> --- a/pkt-line.c
> +++ b/pkt-line.c
> @@ -171,6 +171,25 @@ int packet_write_fmt_gently(int fd, const char =
*fmt, ...)
> 	return status;
> }
>=20
> +int packet_writel(int fd, const char *line, ...)
> +{
> +	va_list args;
> +	int err;
> +	va_start(args, line);
> +	for (;;) {
> +		if (!line)
> +			break;
> +		if (strlen(line) > LARGE_PACKET_DATA_MAX)
> +			return -1;
> +		err =3D packet_write_fmt_gently(fd, "%s\n", line);
> +		if (err)
> +			return err;
> +		line =3D va_arg(args, const char*);
> +	}
> +	va_end(args);
> +	return packet_flush_gently(fd);
> +}
> +
> static int packet_write_gently(const int fd_out, const char *buf, =
size_t size)
> {
> 	static char packet_write_buffer[LARGE_PACKET_MAX];
> diff --git a/pkt-line.h b/pkt-line.h
> index 12b18991f6..cb3eda9695 100644
> --- a/pkt-line.h
> +++ b/pkt-line.h
> @@ -25,6 +25,7 @@ void packet_buf_flush(struct strbuf *buf);
> void packet_buf_write(struct strbuf *buf, const char *fmt, ...) =
__attribute__((format (printf, 2, 3)));
> int packet_flush_gently(int fd);
> int packet_write_fmt_gently(int fd, const char *fmt, ...) =
__attribute__((format (printf, 2, 3)));
> +int packet_writel(int fd, const char *line, ...);
> int write_packetized_from_fd(int fd_in, int fd_out);
> int write_packetized_from_buf(const char *src_in, size_t len, int =
fd_out);
>=20
> --=20
> 2.12.0.windows.1.31.g1548525701.dirty

Looks good to me.

Thanks,
Lars
