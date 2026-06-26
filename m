Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE5213FE64E
	for <git@vger.kernel.org>; Fri, 26 Jun 2026 16:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782493049; cv=pass; b=dtHigPPxaIp7PsVHDkO2pxtCC/bIABuqKGPedHCF/4m8EQ44+20hSJQDKOX7LSYINiHwwyfaOiGyaw93NEUY+nXvKSzKEHKpSmhgUtvyw00DfWixPI+OgjrSP9z4tsZrxZJNldHt/v1QZ3fIyq06+i6vXvXV8X7Og/ytvRJtHoM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782493049; c=relaxed/simple;
	bh=yJKjDMyWeKGynTxxR+rrtuxJ1jr/CBYZ/tkfgCisGf0=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lFusvrkWWpfEhyBkNj7JG220gb3mshmg6iyuIW6ewTypzEDp2DDLh8g8/jkyH58S1a1RhM7Bb7VNmnj4pfPDFNkUniwOvDOq9z+wIAA0Ni3+CmIoD9xAe5s4FmEFzYMVP55EmvgapqtSSd+PSJMZLBQXFfmx3RytU3PvfLah4ww=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NcRpuSHv; arc=pass smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NcRpuSHv"
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-59ebf30a91dso603363e0c.1
        for <git@vger.kernel.org>; Fri, 26 Jun 2026 09:57:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782493045; cv=none;
        d=google.com; s=arc-20260327;
        b=F6RAqAI1HwV0sehTbwK9sVZK9K+S21P/NeI8Fe5fU32ViQl/XmfY/ALLFw2T1zU8O3
         OLhiw8J9ppnsEBbIFV3zFT9E7QNzp9HgzhKriEwhIcjz2zwose2y0Lu4y2NYfVoS1nx8
         rF58ju9QTbHqNU0o5e0tetW61p3ABOd+/ksX2ST/OWMEnEFO86NWNErWNJ+AIwqjD+tU
         M3qaGizjm4NDHdhLFJvs+rwIgcrr/W4vEZ4aCFPwteyJeTB5KtG0BfyZbYUldSwM+JwH
         aMpT0zEhVfGtjLdDCiAD9djOe29sipEIC3WwFOvZxd7Tw1B3jI6fSpkcZF9o5bgrWHd1
         E6mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=WPg+MtJvzxfGHllzA0l0NH5vhXB0gjmOSLozo/ndVOY=;
        fh=Zv3C9iAP01ovv7+0ZpYJjHzwTQ/o4rlxhbQFrnVFCOM=;
        b=rHabso69ap9w5Bub1TJ6fg4Q1HoeDIIpX+rQfGPVR4J3sqv3lehM6kqQL20Hawo/lQ
         UeNtfWFQM303NPWuuMh4OynZPYwQ36Jieg5z05fKet43Dr95s4aq5r9HDGmPppqgZvhx
         I2NWHAqm5/bckXJKrVocgtvLI3Ss7JMCyEzyp2EaDq0wad7PeUjzZUUmKgZTj7JQYC8o
         5usMLRgBYmt9Sn4v6TwVg/6vsa/QH0sn4m28ojxQLowjLiI3ps6ryaycSDufbNMMfgfI
         nVVKtvbBFnRB8JVyDBHSUIFDAv44r8rmjE3Lw4naQSKRFXAKHCo9QdIi3fnJ8DHlyykk
         JYLA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782493045; x=1783097845; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=WPg+MtJvzxfGHllzA0l0NH5vhXB0gjmOSLozo/ndVOY=;
        b=NcRpuSHvQVptjuAiQ9MHfP+pqtdiJ11jEbtFOy52uluaucID3fAWhGcoh6rvqrtLdh
         Mb88D5ZPw6J6Hu7egV4q/x4szbsQRxXJ9jq85H6Mn47RTAa/tAOfiQjVpyJEkYyivOgu
         IHkeewnh30A+5ScEAhAIzrcKrltmx+YncJj/CNN4Zz9w0HXWXkyg/22sJEj+8WJqY/Vj
         5beNOSQoDS7Czq39mheUz+9kECyAeUd77VeNWSoXuu1rdgv1aSV5PGwdHuak2XATXksz
         UGV4d0ZHiR6b0lzR09BUkoR/jEk0Vk5DbzjREoI9wUjz1bY50zVXdjoaS1eU7nJIWBbQ
         ekhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782493045; x=1783097845;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WPg+MtJvzxfGHllzA0l0NH5vhXB0gjmOSLozo/ndVOY=;
        b=F/GY1RgS++DNZPU3n/aW8zGvOTrrQbuwoX7QeRqplkVzPBuWjM1JbNqg0jBc6xOOHi
         fdMKMZoyDuhvORjeJMBk7b2h9Jif5i4ymkkyHh4sdpfArYXFWOTpMrHSxcDWr03cF02m
         VM6bm9sUw+c2RjG0inYx8Vj0Ly2/pfu+iSY9uAX0AQLVTsCs+EyJW/ZIS1t4F6ruz/z9
         Od5rdY+Jn+3OySI6uyHgaeycWstYrREgh7w8p5oxg3UllipZxkPCEF/dk+NIN2JJH5JF
         j7jyMnPo8jYtviUS2CkBJWf84bfiSq5I61CRn/Ij1+NAWuaGKLPpTtwL9jYWvAAzIhgp
         v/ng==
X-Forwarded-Encrypted: i=1; AHgh+RoEUQwOu0Xfj5AZUHtkqbHpNxc3yc83tdK8qcLmU5s3mwOufERls90DX9JkhIr6ewyGgic=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDnSH8TnzhdAb0TJQBv/+cfw486sYGFPlaIqClZsYVDcXHkikX
	tjgb8a2MDlI1UmJDVVb82SuZdU1YmtvEWx3CIRZAV5IV6rtQDMIBuIARIjxW3JjXEF+z2SV0Y0g
	4zoE68agmtdIFQ6hMtSAmTPBUVLK5Z7A=
X-Gm-Gg: AfdE7cnH0EOMo0hZZ/Nh28TCQAS7OnOMS9GT989Uu/Uy+qapbgvKlgaA6PQATVuU1j3
	ARLpIBI+9tjdiXn9PKjXYfCSTv811WzALwpXLO4K/U2vzaigbbadwbp6qBKshV14NIjRiw8uzrZ
	4BckKojAVjBA8JTuMtDgPJ+44kf4CBsr+GH0UqefvfltMeVpINpkb6AFUkbg/Hz7eL2swmPPrDE
	r9AGoQwQuMqInvQoTCl0MpvbsELudKJUyxDSTZ3x7Nm0Lr12kB4UpgOjqZgLL2yfkYvETOl3K/O
	e2oIfQ26nWvOVugtVaM0EldvQ8D4Th1Cd6BFN+/CYn49d+SJHI5mfBQHIuNZ6yI=
X-Received: by 2002:a05:6122:e1ae:b0:5bc:3dde:3364 with SMTP id
 71dfb90a1353d-5bd69d92c05mr2972466e0c.7.1782493044401; Fri, 26 Jun 2026
 09:57:24 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 26 Jun 2026 12:57:22 -0400
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 26 Jun 2026 12:57:22 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260625-ps-eric-work-rebase-v14-6-09f7ffe21a53@gmail.com>
References: <20260619-ps-eric-work-rebase-v13-0-3d4c7315d2f8@gmail.com>
 <20260625-ps-eric-work-rebase-v14-0-09f7ffe21a53@gmail.com> <20260625-ps-eric-work-rebase-v14-6-09f7ffe21a53@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 26 Jun 2026 12:57:22 -0400
X-Gm-Features: AVVi8Ccs5PtAPGo2cp6Ki0MPa1s43hXBTUv4kihXiR8ERe2vzNumurTANoBsUxg
Message-ID: <CAOLa=ZRhCXBQN7CqwLyE2F9u+oqAsqvcFP+fuiyw4SVaSDfT6Q@mail.gmail.com>
Subject: Re: [PATCH GSoC v14 06/13] fetch-pack: move function to connect.c
To: Pablo Sabater <pabloosabaterr@gmail.com>, git@vger.kernel.org
Cc: chandrapratap3519@gmail.com, chriscool@tuxfamily.org, 
	eric.peijian@gmail.com, gitster@pobox.com, jltobler@gmail.com, peff@peff.net, 
	toon@iotcl.com, Jonathan Tan <jonathantanmy@google.com>, 
	Calvin Wan <calvinwan@google.com>
Content-Type: multipart/mixed; boundary="000000000000ba0c6506552b0087"

--000000000000ba0c6506552b0087
Content-Type: text/plain; charset="UTF-8"

Pablo Sabater <pabloosabaterr@gmail.com> writes:

Nit: could we mention the function in the subject?

> write_fetch_command_and_capabilities will be refactored in a
> subsequent

Super Nit: Some parts of your patches use backticks for quoting code or
filenames and others skip the convention. It would be nice to be
consistent.

> commit where it will become a more general-purpose function, making it
> more accessible to additional commands in the future.
>
> Move `write_fetch_command_and_capabilities()` to `connect.c`, where
> there are similar purpose functions.
>
> Because string_list is only used as a pointer, use a forward
> declaration [1].
>
> [1]: https://lore.kernel.org/git/Z0RIqUAoEob8lGfM@pks.im/
>
> Helped-by: Jonathan Tan <jonathantanmy@google.com>
> Helped-by: Christian Couder <chriscool@tuxfamily.org>
> Signed-off-by: Calvin Wan <calvinwan@google.com>
> Signed-off-by: Eric Ju <eric.peijian@gmail.com>
> Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
> ---
>  connect.c    | 34 ++++++++++++++++++++++++++++++++++
>  connect.h    |  4 ++++
>  fetch-pack.c | 34 ----------------------------------
>  3 files changed, 38 insertions(+), 34 deletions(-)
>
> diff --git a/connect.c b/connect.c
> index 47e39d2a73..1dced8e632 100644
> --- a/connect.c
> +++ b/connect.c
> @@ -700,6 +700,40 @@ int server_supports(const char *feature)
>  	return !!server_feature_value(feature, NULL);
>  }
>
> +void write_fetch_command_and_capabilities(struct strbuf *req_buf,
> +					  const struct string_list *server_options)
> +{
> +	const char *hash_name;
> +	int advertise_sid;
> +
> +	repo_config_get_bool(the_repository, "transfer.advertisesid", &advertise_sid);
> +
> +	ensure_server_supports_v2("fetch");
> +	packet_buf_write(req_buf, "command=fetch");
> +	if (server_supports_v2("agent"))
> +		packet_buf_write(req_buf, "agent=%s", git_user_agent_sanitized());
> +	if (advertise_sid && server_supports_v2("session-id"))
> +		packet_buf_write(req_buf, "session-id=%s", trace2_session_id());
> +	if (server_options && server_options->nr) {
> +		ensure_server_supports_v2("server-option");
> +		for (size_t i = 0; i < server_options->nr; i++)
> +			packet_buf_write(req_buf, "server-option=%s",
> +					 server_options->items[i].string);
> +	}
> +
> +	if (server_feature_v2("object-format", &hash_name)) {
> +		const unsigned int hash_algo = hash_algo_by_name(hash_name);
> +		if (hash_algo_by_ptr(the_hash_algo) != hash_algo)
> +			die(_("mismatched algorithms: client %s; server %s"),
> +			    the_hash_algo->name, hash_name);
> +		packet_buf_write(req_buf, "object-format=%s", the_hash_algo->name);
> +	} else if (hash_algo_by_ptr(the_hash_algo) != GIT_HASH_SHA1_LEGACY) {
> +		die(_("the server does not support algorithm '%s'"),
> +		    the_hash_algo->name);
> +	}
> +	packet_buf_delim(req_buf);
> +}
> +
>  static const char *url_scheme_name(enum url_scheme scheme)
>  {
>  	switch (scheme) {
> diff --git a/connect.h b/connect.h
> index aa482a37fb..c4f6ea4b0a 100644
> --- a/connect.h
> +++ b/connect.h
> @@ -34,4 +34,8 @@ void check_stateless_delimiter(int stateless_rpc,
>  			       struct packet_reader *reader,
>  			       const char *error);
>
> +struct string_list;
> +void write_fetch_command_and_capabilities(struct strbuf *req_buf,
> +					  const struct string_list *server_options);
> +
>  #endif
> diff --git a/fetch-pack.c b/fetch-pack.c
> index ad07603755..4a8a70b5f3 100644
> --- a/fetch-pack.c
> +++ b/fetch-pack.c
> @@ -1376,40 +1376,6 @@ static int add_haves(struct fetch_negotiator *negotiator,
>  	return haves_added;
>  }
>
> -static void write_fetch_command_and_capabilities(struct strbuf *req_buf,
> -						 const struct string_list *server_options)
> -{
> -	const char *hash_name;
> -	int advertise_sid;
> -
> -	repo_config_get_bool(the_repository, "transfer.advertisesid", &advertise_sid);
> -
> -	ensure_server_supports_v2("fetch");
> -	packet_buf_write(req_buf, "command=fetch");
> -	if (server_supports_v2("agent"))
> -		packet_buf_write(req_buf, "agent=%s", git_user_agent_sanitized());
> -	if (advertise_sid && server_supports_v2("session-id"))
> -		packet_buf_write(req_buf, "session-id=%s", trace2_session_id());
> -	if (server_options && server_options->nr) {
> -		ensure_server_supports_v2("server-option");
> -		for (size_t i = 0; i < server_options->nr; i++)
> -			packet_buf_write(req_buf, "server-option=%s",
> -					 server_options->items[i].string);
> -	}
> -
> -	if (server_feature_v2("object-format", &hash_name)) {
> -		const unsigned int hash_algo = hash_algo_by_name(hash_name);
> -		if (hash_algo_by_ptr(the_hash_algo) != hash_algo)
> -			die(_("mismatched algorithms: client %s; server %s"),
> -			    the_hash_algo->name, hash_name);
> -		packet_buf_write(req_buf, "object-format=%s", the_hash_algo->name);
> -	} else if (hash_algo_by_ptr(the_hash_algo) != GIT_HASH_SHA1_LEGACY) {
> -		die(_("the server does not support algorithm '%s'"),
> -		    the_hash_algo->name);
> -	}
> -	packet_buf_delim(req_buf);
> -}
> -
>  static int send_fetch_request(struct fetch_negotiator *negotiator, int fd_out,
>  			      struct fetch_pack_args *args,
>  			      const struct ref *wants, struct oidset *common,
>
> --
> 2.54.0

--000000000000ba0c6506552b0087
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: e820f6f11c7a8124_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1vK3IzRVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNW94REFDR2YwYTBKbUVHU0k2UUNwOVJabjdvaEZ6SgorbnJlYWFVN0l1
MmRqemRmVTY4NUZob1VVK2hhM21XUzV6NXVYTkcxYWhHSWdDOFlxUWdFS2dGV1BNejZIME1vCktl
WHZ5SS9FLzU0dkRGMFJ1OGhIdUFOZFpvc3N3b0tYQVNXMjgyR3hsSzVGNFEyelNRZTVFczJWaWxV
VUI5bUQKa0IvMzBrWFVaNWdDRE0wQUU5c3ZiV0pwZ00ydURJOG1CZXJJSGlSMUFFM05RMWQ4NFVB
cWE2bHdEOUVnK0FMaAo3RkkxeG1LVTcwN1dUUWNYaEEzSnVLQ2FxZ25DSGpRY0lYbmExUjB4K1c1
NkErazRZTzhqM09HWW1zc2NsWVFZCmxWMjRpbm02Yi9rcFBKS2F2ZjlkeHZ5blJxVUVEUit3MGEx
SE9uVUlSMHRFQ01CK3U0cDlJYkFRNGdyVVVzNlgKSlU5WlBZZzF2UFdOWENzcmJ3Y0xVK3NmRmJZ
amtINEYxZ0N3UzZjaE16UTVYSGZ1ZzBUb1o4aExDdWxOR3NpYwp6NHc5QnVkbGVjd0xpSDRXK1lx
V01ucTZwd2FYMGsxcHhlNmVFcHVQN244cysvd0xFaHR3NVFyVDNvNGJkNWthCmtsVmV2VEF6RVUr
WG1lYVlnUHp0SnRKd3c2MytpVzlieXJiV1o0OD0KPTllVXcKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000ba0c6506552b0087--
