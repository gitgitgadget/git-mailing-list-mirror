Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7A1A920136
	for <e@80x24.org>; Thu, 16 Feb 2017 10:30:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753869AbdBPKac (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Feb 2017 05:30:32 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36066 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752820AbdBPKab (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Feb 2017 05:30:31 -0500
Received: by mail-wm0-f68.google.com with SMTP id r18so2381447wmd.3
        for <git@vger.kernel.org>; Thu, 16 Feb 2017 02:30:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=wZ2s+dxU/2TRY/0GQSn7Ef9Jr9717DFIIgF88VaLkAc=;
        b=E0glEwkdOX+0xxLNCHyQB4CDjndkqeTkXQRsb8HpnCHR/tSDwKQLCN/88atpwpMk/8
         38n6nG3QIAmNamzcSGcQmvL6HQJPVQki9qNfXsbfvta8bXVg6rqDTxCV++q4RRCJnDxJ
         ZhEeHB/fYkzyfSGMZx3FysVAeJYdoEeBYb4lt/nqlBG0GF07I7ZOj7bW3ZZQZ3O/hE6n
         gGPdMhUOuDnY0T9JPuqVlJvLqicBNrZcqJlPD9PxpoZYTnLCPRd4qw/NlH1U44Xcv5l2
         q/KSHlOw2vmjyR3zfajQxUelD06PrtB4d19K3xhOW7aKD0EFfZukRFWZD/IZxpg4URRv
         kukg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=wZ2s+dxU/2TRY/0GQSn7Ef9Jr9717DFIIgF88VaLkAc=;
        b=DDoyrcjVF3NKqwKX8uGe/GqmOhEHepRlMACpjRUloysQYBYApNEsC6mfM7Dzu/9NKt
         mcDg5FV1t4y6TC8xOCrINZ6GSgfVAh3cCkKYk7uHrP5DPMY2lSgHAV5dXVegxF+Anjpw
         P7EBCxprhK19CEFqV4JsA1XrvdaFpgLvPFVWiiTS8rvH5z9Zr9bv2qENXer4UoqVUERB
         T5TfOIArq0EFbxjgff5sj2h3NGg/zxA/D2VTVhhW+9ib2a1rSj6DACxvoMI51iysAvKF
         bro4v+dNvZevfKNo3mjdUqMihgIIf+tRaJY4D7nRLaNECzkxXAqrNJMbhnQQ1YI4hnnv
         Vqfw==
X-Gm-Message-State: AMke39myC63YIRO2Oq0Zt3VrjfZaphXAzwL+Nt/AIlNhfhGhYtHVCYX8qCmBexlrwAlq3Q==
X-Received: by 10.28.227.133 with SMTP id a127mr11095482wmh.104.1487241029830;
        Thu, 16 Feb 2017 02:30:29 -0800 (PST)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id p7sm8357473wrc.34.2017.02.16.02.30.28
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 16 Feb 2017 02:30:29 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH] config: preserve <subsection> case for one-shot config on the command line
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <xmqqa89n10df.fsf_-_@gitster.mtv.corp.google.com>
Date:   Thu, 16 Feb 2017 11:30:28 +0100
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        sbeller@google.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <D0CDD1AC-05CA-47F3-8CB5-61EA1C6515A8@gmail.com>
References: <20170215111704.78320-1-larsxschneider@gmail.com> <xmqqzihn2smp.fsf@gitster.mtv.corp.google.com> <f238248f-0df2-19a5-581d-95c8a61b4632@google.com> <xmqqy3x712if.fsf@gitster.mtv.corp.google.com> <xmqqtw7v123n.fsf@gitster.mtv.corp.google.com> <xmqqa89n10df.fsf_-_@gitster.mtv.corp.google.com>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 16 Feb 2017, at 00:48, Junio C Hamano <gitster@pobox.com> wrote:
>=20
> The "git -c <var>=3D<val> cmd" mechanism is to pretend that a

The problem is also present for gitconfig variables e.g.
git config --local submodule.UPPERSUB.update none

But your patch below fixes that, too!


> configuration variable <var> is set to <val> while the cmd is
> running.  The code to do so however downcased <var> in its entirety,
> which is wrong for a three-level <section>.<subsection>.<variable>.
>=20
> The <subsection> part needs to stay as-is.
>=20
> Reported-by: Lars Schneider <larsxschneider@gmail.com>
> Diagnosed-by: Jonathan Tan <jonathantanmy@google.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
> config.c | 22 +++++++++++++++++++++-
> 1 file changed, 21 insertions(+), 1 deletion(-)
>=20
> diff --git a/config.c b/config.c
> index 0dfed682b8..e9b93b5304 100644
> --- a/config.c
> +++ b/config.c
> @@ -199,6 +199,26 @@ void git_config_push_parameter(const char *text)
> 	strbuf_release(&env);
> }
>=20
> +/*
> + * downcase the <section> and <variable> in <section>.<variable> or
> + * <section>.<subsection>.<variable> and do so in place.  =
<subsection>
> + * is left intact.
> + */
> +static void canonicalize_config_variable_name(char *varname)
> +{
> +	char *dot, *cp;
> +
> +	dot =3D strchr(varname, '.');
minor nit:
I think it would improve readability if we call this "first_dot" ...


> +	if (dot)
> +		for (cp =3D varname; cp < dot; cp++)
> +			*cp =3D tolower(*cp);
> +	dot =3D strrchr(varname, '.');
... and this "last_dot"?


> +	if (dot)
> +		for (cp =3D dot + 1; *cp; cp++)
> +			*cp =3D tolower(*cp);
> +}
> +
> +
> int git_config_parse_parameter(const char *text,
> 			       config_fn_t fn, void *data)
> {
> @@ -221,7 +241,7 @@ int git_config_parse_parameter(const char *text,
> 		strbuf_list_free(pair);
> 		return error("bogus config parameter: %s", text);
> 	}
> -	strbuf_tolower(pair[0]);
> +	canonicalize_config_variable_name(pair[0]->buf);
> 	if (fn(pair[0]->buf, value, data) < 0) {
> 		strbuf_list_free(pair);
> 		return -1;
> --=20
> 2.12.0-rc1-258-g3d3d1e383b
>=20


The patch looks good to me and fixes the problem!

Should we add a test case to this patch?
If not, do you want me to improve my test case patch [1]=20
or do you want to ditch the test?

Thank you,
Lars


[1] =
http://public-inbox.org/git/20170215111704.78320-1-larsxschneider@gmail.co=
m/=
