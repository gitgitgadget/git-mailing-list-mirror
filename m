Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 623CE447255
	for <git@vger.kernel.org>; Mon, 19 Oct 2026 08:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792399461; cv=pass; b=OPHiPHScATniHdc7ulhBESV1rw+MEY+6qWPm8HiJ+kiauXypOBpsb9pNB1Jt+RXgB8lc6MldnuDvvb/yOurUbEb4Ep26XS7sfC5FCkAbHlweWvTgCAxIZXmgA2xJlQnDphniaEHgNzRku2utyX86wJ8+HmiFauNscUX0Fq2b9iw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792399461; c=relaxed/simple;
	bh=Kf4E86ixdAmVfFdmC75fSSCWp/CLiTKgyQkoPlk6KkU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mdDtXhrRsT8iuhEfi64gEp6q1yTAydFDLV0JRvPk2M4oX0Zm80gfmWz/fhYBE+m5kprbkJ/LpOm1thCJHwl026BIVCjlmwDuC49+9R5SHCRWSfw//QqMaqFdzzaLXdcPTXZ/Okpo9pwW+lz/Xfbhd3EClmAi9j0WuxDKaE71ZQI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Y3Wezc5D; arc=pass smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y3Wezc5D"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-533202fe429so405061cf.0
        for <git@vger.kernel.org>; Mon, 19 Oct 2026 01:44:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792399458; cv=none;
        d=google.com; s=arc-20260327;
        b=pN8s0MaSkMBANRFV5ji6yucw5bCiS+U7Dp2hQCorVUVzKs5RNfJioe1SjWQV/Hvpuv
         mJcLNCb5IVWWjyCZiLyKu6EKf1juHmiQWjCNNq+uqFdNxUEO5aPtFYqxhH/CnJ/760jn
         yjEJ6AfX7poQouF0e10KKgJrHrFC0blqlLfFmA5MvmYzpePio9AOzP24gJLIOMFfQySd
         eBtKfwfOPp7EN/RVupRxSPdo8zDLLulQpPp2N/P+hThiwAsKcIemsxY/qod/ZH3W06b9
         WzbmrI9fGMZS5jtWqDH61G0J6E2GpPgUS1tLTyBJBLmkXqlt8WTlcMsSOVDvO95yU5oX
         oSHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7b1UC0A5YD4bR7I1Jk+yvn4Eud5GX/ITZAYEQYKu4aI=;
        fh=hzL2tD4qwTA+s46zu+jtLoqm73ZfOGj2Hi8JK/enJ2g=;
        b=W+8uUgtLvtG+mqXHyu9sDTMgGcBlpYOeh83/mRb9hkMfMQ5WYpGHCIaU04ULx88Ubt
         M/gxSO6m8NSWLUEkDTlfjFCy2rGlzk6o7ObyxjreZfa3Sjy15vEVKBcdvnv7bn0scg2v
         039q+nl2W0PIq5RExao1yuDbc9A4bC76E9dmAPKBuUD+qlQzzJEHtflZrvD44JX31Qzo
         OKw7/GmYQmLpzcRuLo80cC7t9aqg1qdc5c2nvAd/Yz19cKMhVYBrfPYXoOuTD2HGlbcb
         dOZ+6Ch++ezSJ/UMhhbuII6x8U4q4iQFDA+MigvCiJv9sjPeiX1XJ2xOZVCm+ilJbR2w
         Z4og==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792399458; x=1793004258; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7b1UC0A5YD4bR7I1Jk+yvn4Eud5GX/ITZAYEQYKu4aI=;
        b=Y3Wezc5DV9DMn0ofdAnJvdJogDM53iwghW06HvB7sfDCwyx3ePxYVQE2XJOctIZwmx
         Glo+Z6iCUh3yXz2+B2OBybio3XTrnLUOUOs3VTlTnj1Q/tZlDVjjFU3cp9SX4lwsNICT
         GOBX5vU93C1alHmsLvcsED9U4QqR28LqU1VLcUjFqeuPz37r2ojoOZ2RiJe1NcJ2znwA
         ILEad8usChqqWrrptBxDGTGnpLR1NYdsolMpUlxqkAByImHtdUk+C1aYTjY/AL5P3C4p
         anJu1qzDwxoaUqtGdY0Cb59QIIu4GCPVYIQJLskK7iAFRFJ9Eu3AoSeBxprAoyYNjMoZ
         yAEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792399458; x=1793004258;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7b1UC0A5YD4bR7I1Jk+yvn4Eud5GX/ITZAYEQYKu4aI=;
        b=ngtufEfiBVC5sglGb65YwWOxZAiIxJ5SifSGshzO/d57ZBi2pcQ7YYSoIr2HzOGCA+
         fEbUZqyaBRluKk1gQnBZ8nlrumWzyA0XlQ8DA99OlshrhjJSFt3xANTSEl11aaRBTveG
         JzhHNKhp0p0zNZw1mhnZgtNdihc/yNSLEewZFOpbFW/+Dkm386DadV1JOfTNeZoAB4io
         8MR6C8xJPnsg2u6zirK8KO/JECM8R89HU+OM0pe8FdNYPEI07Ud8tGrn1r3OHfzwl/ZH
         mC1tstKdThzuFh9Kz1i+uaF9bpbgGiQfNF7qZaPv1r5qL/tWznu+7lwfgmhfFwL52LXz
         TcVA==
X-Gm-Message-State: AFq9FYIX2eQ+rkh7u0DomuTuFW5nwR/pgnWAqWnAqKA6snYjsAnPCFAh
	C39zWY5CiZUQM+rjlJsfnfeg1FSuDC2dvuAgcaJ1gzjdERcQGFBYiVUdp+yjfC+vtqjs29YSykt
	+WJ4FTbMCIuaSvhQCGN8mPn8IZi3GBFUc3MJlEHO9/wAVt0J767yKJcdtI5k=
X-Gm-Gg: AYBFou26qFIEy+AiiIbVjyN8bpFQjVzLvayj0VkQ7WYYhSE1xJlDGYfV+CMy5ZZ52+E
	VMUxSz13ojtt4PJLViELgJoisALThE/ieC/SmOZGH9bDxAsQVfTSB5zqJkZNO0N7zJhRVFF8Xkh
	waelLymq8ZaohBRq7mB24OMNDkgFwbQEFCB5z5yBIAj3bMV+LiPU5J8Puzjh1Y3cepd8AHceZ8v
	pPy7JATe1bP+rVMhaj7I/tMzWjSS+lg/PggCKwQeQ8zZVeX0/C94g/H3j6mGGxRGOETXE+U2vOr
	RL9kZetzJtip9kg4Z+4GUByfnSglKpO+O2gUqbv62uMjz4HHjo95hu8goZiwMLejx5dYN8bIi+5
	EAFZqG30=
X-Received: by 2002:a05:622a:5a17:b0:532:9003:35b1 with SMTP id
 d75a77b69052e-53649abbe44mr30822981cf.2.1792399457332; Mon, 19 Oct 2026
 01:44:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261012203057.969878-1-dev+git@drbeat.li> <20261017100956.529225-1-dev+git@drbeat.li>
 <20261017100956.529225-2-dev+git@drbeat.li>
In-Reply-To: <20261017100956.529225-2-dev+git@drbeat.li>
From: Xiangfei Ding <xfding@google.com>
Date: Mon, 19 Oct 2026 10:44:05 +0200
X-Gm-Features: AclHuK-RtfW2Iz9uUSZjkslCK5da5kxwPlMtvznm1nYsdII-a97BhunbvMeUL_4
Message-ID: <CABtdbsnrQ61eJv4GhawiFSHkN01tJhV5tYj8MNQT8F3zf3PgYw@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] imap-send: let OpenSSL do the hostname verification
To: Beat Bolli <dev+git@drbeat.li>
Cc: git@vger.kernel.org, Aniket Gupta <aniketgupta3001@gmail.com>, 
	Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>, 
	"brian m. carlson" <sandals@crustytoothpaste.net>, David Benjamin <davidben@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> let OpenSSL do the hostname verification

I think this is a much cleaner solution, thank you so much!

Reviewed-by: Xiangfei Ding <xfding@google.com>

On Sat, Oct 17, 2026 at 12:10=E2=80=AFPM Beat Bolli <dev+git@drbeat.li> wro=
te:
>
> imap-send performs its own TLS hostname verification. This is not ideal
> because it does not support all certificate features.
>
> Let's use OpenSSL built-in verification, which is supported in its
> current form since OpenSSL 1.1.0. This gets us all present and future
> improvements done by OpenSSL for free. E.g., the old code did not handle
> IP addresses in the subject alternative names, while the new code does.
>
> If the verification fails, print the error message as returned by
> OpenSSL.
>
> [1]: https://wiki.openssl.org/index.php/Hostname_validation
>
> Suggested-by: brian m. carlson <sandals@crustytoothpaste.net>
> Signed-off-by: Beat Bolli <dev+git@drbeat.li>
> ---
> We cannot easily print the certificate's hostname in case of a mismatch,
> but the cURL branch does not, either.
>
> Unfortuately, the diff looks bad because two functions are replaced by
> the new verify_peer() function that is completely unrelated.
>
>  imap-send.c | 101 +++++++++++++++++-----------------------------------
>  1 file changed, 33 insertions(+), 68 deletions(-)
>
> diff --git a/imap-send.c b/imap-send.c
> index 9f21705d77..ec4e28e423 100644
> --- a/imap-send.c
> +++ b/imap-send.c
> @@ -222,64 +222,30 @@ static int ssl_socket_connect(struct imap_socket *s=
ock UNUSED,
>
>  #else
>
> -static int host_matches(const char *host, const ASN1_STRING *asn1_str)
> +static int verify_peer(const SSL *ssl, int did_connect)
>  {
> -       const char *pattern =3D (const char *)ASN1_STRING_get0_data(asn1_=
str);
> +       long verify;
>
> -       /* embedded NUL characters may open a security hole */
> -       if (memchr(pattern, '\0', ASN1_STRING_length(asn1_str)))
> -           return 0;
> -
> -       if (pattern[0] =3D=3D '*' && pattern[1] =3D=3D '.') {
> -               pattern +=3D 2;
> -               if (!(host =3D strchr(host, '.')))
> -                       return 0;
> -               host++;
> -       }
> -
> -       return *host && *pattern && !strcasecmp(host, pattern);
> -}
> +       /*
> +        * If we connected, we require a certificate.
> +        * If we did not connect because of a certificate error, the serv=
er
> +        * certificate is not installed in the SSL*, but the verification
> +        * result will still be returned below.
> +        */
> +       if (did_connect) {
> +               X509 *cert =3D SSL_get_peer_certificate(ssl);
>
> -static int verify_hostname(X509 *cert, const char *hostname)
> -{
> -#if (OPENSSL_VERSION_NUMBER >=3D 0x40000000L)
> -       const X509_NAME *subj;
> -#else
> -       X509_NAME *subj;
> -#endif
> -       const X509_NAME_ENTRY *cname_entry;
> -       const ASN1_STRING *cname;
> -       int i, found;
> -       STACK_OF(GENERAL_NAME) *subj_alt_names;
> -
> -       /* try the DNS subjectAltNames */
> -       found =3D 0;
> -       if ((subj_alt_names =3D X509_get_ext_d2i(cert, NID_subject_alt_na=
me, NULL, NULL))) {
> -               int num_subj_alt_names =3D sk_GENERAL_NAME_num(subj_alt_n=
ames);
> -               for (i =3D 0; !found && i < num_subj_alt_names; i++) {
> -                       int ntype;
> -                       GENERAL_NAME *subj_alt_name =3D sk_GENERAL_NAME_v=
alue(subj_alt_names, i);
> -                       ASN1_STRING *subj_alt_str =3D GENERAL_NAME_get0_v=
alue(subj_alt_name, &ntype);
> -
> -                       if (ntype =3D=3D GEN_DNS && host_matches(hostname=
, subj_alt_str))
> -                               found =3D 1;
> -               }
> -               sk_GENERAL_NAME_pop_free(subj_alt_names, GENERAL_NAME_fre=
e);
> +               if (!cert)
> +                       return error("unable to get peer certificate.");
> +               X509_free(cert);
>         }
> -       if (found)
> -               return 0;
>
> -       /* try the common name */
> -       if (!(subj =3D X509_get_subject_name(cert)))
> -               return error("cannot get certificate subject");
> -       if ((i =3D X509_NAME_get_index_by_NID(subj, NID_commonName, -1)) =
< 0 ||
> -           (cname_entry =3D X509_NAME_get_entry(subj, i)) =3D=3D NULL ||
> -           (cname =3D X509_NAME_ENTRY_get_data(cname_entry)) =3D=3D NULL=
)
> -               return error("cannot get certificate common name");
> -       if (host_matches(hostname, cname))
> -               return 0;
> -       return error("certificate owner '%s' does not match hostname '%s'=
",
> -                    ASN1_STRING_get0_data(cname), hostname);
> +       /* check the verification result, ignoring the connection success=
 */
> +       verify =3D SSL_get_verify_result(ssl);
> +       if (verify !=3D X509_V_OK)
> +               return error("unable to verify peer certificate: %s",
> +                            X509_verify_cert_error_string(verify));
> +       return 0;
>  }
>
>  static int ssl_socket_connect(struct imap_socket *sock,
> @@ -293,7 +259,6 @@ static int ssl_socket_connect(struct imap_socket *soc=
k,
>  #endif
>         SSL_CTX *ctx;
>         int ret;
> -       X509 *cert;
>
>         SSL_library_init();
>         SSL_load_error_strings();
> @@ -313,9 +278,6 @@ static int ssl_socket_connect(struct imap_socket *soc=
k,
>         if (use_tls_only)
>                 SSL_CTX_set_options(ctx, SSL_OP_NO_SSLv2 | SSL_OP_NO_SSLv=
3);
>
> -       if (cfg->ssl_verify)
> -               SSL_CTX_set_verify(ctx, SSL_VERIFY_PEER, NULL);
> -
>         if (!SSL_CTX_set_default_verify_paths(ctx)) {
>                 ssl_socket_perror("SSL_CTX_set_default_verify_paths");
>                 return -1;
> @@ -325,6 +287,16 @@ static int ssl_socket_connect(struct imap_socket *so=
ck,
>                 ssl_socket_perror("SSL_new");
>                 return -1;
>         }
> +       if (cfg->ssl_verify) {
> +               /* follow RFC 9525 section 6.3: no partial wildcards */
> +               SSL_set_hostflags(sock->ssl, X509_CHECK_FLAG_NO_PARTIAL_W=
ILDCARDS);
> +               if (!SSL_set1_host(sock->ssl, cfg->host)) {
> +                       ssl_socket_perror("SSL_set1_host");
> +                       return -1;
> +               }
> +               SSL_set_verify(sock->ssl, SSL_VERIFY_PEER, NULL);
> +       }
> +
>         if (!SSL_set_rfd(sock->ssl, sock->fd[0])) {
>                 ssl_socket_perror("SSL_set_rfd");
>                 return -1;
> @@ -348,20 +320,13 @@ static int ssl_socket_connect(struct imap_socket *s=
ock,
>         ret =3D SSL_connect(sock->ssl);
>         if (ret <=3D 0) {
>                 socket_perror("SSL_connect", sock, ret);
> +               if (cfg->ssl_verify)
> +                       verify_peer(sock->ssl, 0);
>                 return -1;
>         }
>
> -       if (cfg->ssl_verify) {
> -               /* make sure the hostname matches that of the certificate=
 */
> -               cert =3D SSL_get_peer_certificate(sock->ssl);
> -               if (!cert)
> -                       return error("unable to get peer certificate.");
> -               if (SSL_get_verify_result(sock->ssl) !=3D X509_V_OK)
> -                       return error("unable to verify peer certificate")=
;
> -               if (verify_hostname(cert, cfg->host) < 0)
> -                       return -1;
> -       }
> -
> +       if (cfg->ssl_verify)
> +               return verify_peer(sock->ssl, 1);
>         return 0;
>  }
>  #endif
> --
> 2.53.0
>
