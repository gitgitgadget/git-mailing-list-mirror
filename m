Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D759B1FA7B
	for <e@80x24.org>; Tue, 13 Jun 2017 17:06:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752167AbdFMRGd (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Jun 2017 13:06:33 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:33470 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751805AbdFMRGc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jun 2017 13:06:32 -0400
Received: by mail-pf0-f196.google.com with SMTP id w12so12622046pfk.0
        for <git@vger.kernel.org>; Tue, 13 Jun 2017 10:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=YT151+uOHclb0iwmn7dp52Uu3/wGL9Kj4MAbCK0lIBU=;
        b=h2Bom20yEEk6XHwBn4vfYORWKaDykdhSWLbwyydCLTgn19HeDF9BW6TrFA/xonL16J
         dhnE7rK3DxpMU2i2n24wa3Ekua4AqQedtakdUefX2J+8f/L0MTozfwjP3tea+zNLaMO6
         ygw1UcbkIADiVqsI4EWW523c9zdkitGnh89StEmUMpU71LJhTM3UjJt3XvOd3CYxS3z7
         dPFbVY+ns7e22lvhqdlWuVXGTo8MdWlXlaUYPphcpMPOvQM0ARhzFuSY0OHSbXeh4GRR
         JeIbdacsVa86cP3Po7x20h8AwULNX8tDDtJpL5kTKuSVVXs6X7969QJ9pZAr7Ul/+BC2
         33Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=YT151+uOHclb0iwmn7dp52Uu3/wGL9Kj4MAbCK0lIBU=;
        b=nDlvinYaZcA+EMbamQ8gCwL4dFPNGw4+WvbNS8UmGxTDkaMk9i0T4BQ/Xakiafs9R1
         LfyOpnDD/B4IPEl1ywauYzY/ykmI4GDfmJ107/yiG75xHCe2wcSnqgvVkvRO1l+gXVu+
         hDkIfPZU3nlUJT65Ae8PlE/lEDH7yEzh0r6hGlkDfjUG1HwAwy+ZOFfyliZVEhjt+28T
         NGOCU23H04OJj9VwUI6d1N6ySgfD1w/B5dbGcOF7n9eMZZ0N9aOZ2A/h4LYDqnFSMx0R
         K4HYaadoY0gS9ixaQ3cWvqT92wvPpwU+9I1tWh31ot2MRpWYJouldxw+gADd/tBkM7Mb
         7ZGg==
X-Gm-Message-State: AKS2vOzeH1QBD2AXXa4msGj2ZZGLbIpxXuBk7GQN7fqG3dkRXB5i0wVz
        QZtUHbEDblhMiUXTnUE=
X-Received: by 10.98.50.129 with SMTP id y123mr569325pfy.53.1497373591484;
        Tue, 13 Jun 2017 10:06:31 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:b4c1:e9f6:bf2b:dcec])
        by smtp.gmail.com with ESMTPSA id v62sm22791926pfb.124.2017.06.13.10.06.30
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 13 Jun 2017 10:06:30 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sahil Dua <sahildua2305@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/3] config: create a function to format section headers
References: <0102015c79fcbda0-2779b4ff-54ad-46f4-bef0-14eeb58338d4-000000@eu-west-1.amazonses.com>
        <0102015ca23f0488-7423db93-b65f-4214-8221-af6a1bb4c2e5-000000@eu-west-1.amazonses.com>
Date:   Tue, 13 Jun 2017 10:06:29 -0700
In-Reply-To: <0102015ca23f0488-7423db93-b65f-4214-8221-af6a1bb4c2e5-000000@eu-west-1.amazonses.com>
        (Sahil Dua's message of "Tue, 13 Jun 2017 16:17:38 +0000")
Message-ID: <xmqq1sqn95re.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sahil Dua <sahildua2305@gmail.com> writes:

> Factor out the logic which creates section headers in the config file,
> e.g. the 'branch.foo' key will be turned into '[branch "foo"]'.
>
> This introduces no function changes, but is needed for a later change
> which adds support for copying branch sections in the config file.
>
> Signed-off-by: Sahil Dua <sahildua2305@gmail.com>
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>  config.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/config.c b/config.c
> index 146cb3452adab..d5bb69e925dac 100644
> --- a/config.c
> +++ b/config.c
> @@ -2169,10 +2169,10 @@ static int write_error(const char *filename)
>  	return 4;
>  }
>  
> -static int store_write_section(int fd, const char *key)
> +struct strbuf store_create_section(const char *key)
>  {
>  	const char *dot;
> -	int i, success;
> +	int i;
>  	struct strbuf sb = STRBUF_INIT;
>  
>  	dot = memchr(key, '.', store.baselen);
> @@ -2188,6 +2188,15 @@ static int store_write_section(int fd, const char *key)
>  		strbuf_addf(&sb, "[%.*s]\n", store.baselen, key);
>  	}
>  
> +	return sb;
> +}
> +
> +static int store_write_section(int fd, const char *key)
> +{
> +	int success;
> +
> +	struct strbuf sb = store_create_section(key);
> +
>  	success = write_in_full(fd, sb.buf, sb.len) == sb.len;
>  	strbuf_release(&sb);
>  
>
> --
> https://github.com/git/git/pull/363

Makes sense.
