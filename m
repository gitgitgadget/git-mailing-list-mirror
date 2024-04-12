Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF0D814BF89
	for <git@vger.kernel.org>; Fri, 12 Apr 2024 18:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712947781; cv=none; b=njor9bTkkWgYPRMX8rmjrqtXJ/8ngm35iyPOyd0w6nGBaB5WdxaMDw769Kk2kY2cGEs5VB9TssgLwxOXgysQiBQJZgtMFwGPKlW8lRX5ZYq5k172GQe0Kua1oexb3H0HCDM15Tgrkq9nFLqqSXtmdFgpyPngLFO0/pbKsw2NMyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712947781; c=relaxed/simple;
	bh=bGOiG0JRqDbeonBH67Z8xjhEUvjeeep/BqFY47xUW98=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n2am4wVpnFBamDFFvJPL0g1C3JnvdfWneC9y2sN4jlymQmfbpR6k/CpngyC3UDrNmk/zpAR+iWrciDe/rD99NSxB5kO4Bk/JPVbmXyN5gbOhSzrVIWuJVCaWMQgkXHpqrLHO0FzBAKIGE6beoQMXXF2+66BKXK7EE0QWwxZbP1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hz5lWNpa; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hz5lWNpa"
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5a9d93ed063so491948eaf.0
        for <git@vger.kernel.org>; Fri, 12 Apr 2024 11:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712947779; x=1713552579; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=0oOzsrbKJY2l2HyN6tYnX0rrLdAVJQMG9cPMw8BiRbA=;
        b=Hz5lWNpayV6hKUrAuLrOmh3VMjlv2stNPCQZOcQlohzNC9yvmA52IK1RDoYg1G+v9m
         lMqO3RgIurK7fmVG0MlvzrF40ubh00/DKKpFOv+MGE1Hp1Ncfzlg7aF4bCKgxTheuq48
         Sw6DIxjwdEe5kIpsvc3kKHEkafKjig41y7NrLr4MsgBYjKsehU+NYiIn04mhSOdfViCc
         vDa8f0CbkuoVbQiOivog0L+/qTz6NqUW7PYFeFqKjzxEfhlSl2qYXC5Ot4WNPLhU8i0l
         gvFPTuoDE73If02j+Qv+25NhT/1NzTcnGOQ+e8PAwViJTAJoQZLyY9Q0qzxfzGPa48MP
         M8lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712947779; x=1713552579;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0oOzsrbKJY2l2HyN6tYnX0rrLdAVJQMG9cPMw8BiRbA=;
        b=KWCvGw8n3M9XQPcNXccvbIYcK462EbZG4cs5NhKncBOd2TAEe2BZra0PMbbVaiIs2b
         HtbTZRXM+4CC2TpqsrjC99KHA+jXrsHBPoBG4s0bCPfm3IgVL5G4KzcAE41rDzhKTeHI
         RRpiQMUhoZmVXYqlm/M9krkOFPGGsgSGSHWC3KRWg5dzTr/wKZwPK2wOk4H8TbvBf1cu
         ufVavqovVd1ooeHAgjQw8fFVoumnRbjOT5jqxIbOSq2QUQEZCQ6o9HhusYzK4jD/qv20
         QYa0TIdbfDgoozWBH12Qxz9nxKlp1nmS0Kr4Tr06eo8q4iWOKtchYAUZQH7qsQMeZNl7
         CzyA==
X-Forwarded-Encrypted: i=1; AJvYcCWk0K2YUzfSHAVbi5Jr5z32pkWYslgrJY049TYmXhqR0l6EwoJOjOVPK6EwxfET7x9flTJMgdnwtlRdMBuYdCN3shar
X-Gm-Message-State: AOJu0YzQHzooqMBW12ZT4RysZgt4QE8fzQoj1iXTBt44WkDXz33NIk25
	EsVQpFEue5jgAauGSlIRloJpaqCRff3C3JdUnbDDQcC+C8JP+hOiTgiYBWkyvErKEEh5Iu7UkfC
	r01EImAVwSmXgrBLe5FoNgIdcyd8D0A==
X-Google-Smtp-Source: AGHT+IFvgMIRmhizdZejxBamwlMszAbMx9Nun9A6qjPfqE7x3qbk8yFDFnDt5S5HhUStWDHhCB7LlYvgH2xvTegFZqw=
X-Received: by 2002:a05:6870:b68b:b0:22e:92d8:d2af with SMTP id
 cy11-20020a056870b68b00b0022e92d8d2afmr1403674oab.29.1712947778683; Fri, 12
 Apr 2024 11:49:38 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 12 Apr 2024 11:49:37 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqqwmp2lasu.fsf@gitster.g>
References: <20240330224623.579457-1-knayak@gitlab.com> <20240412095908.1134387-1-knayak@gitlab.com>
 <xmqqwmp2lasu.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 12 Apr 2024 11:49:37 -0700
Message-ID: <CAOLa=ZQsQr9MK=Tn3az9NZ+xQsSfw+8CTXYiO2r=WbtM=MhBwQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] update-ref: add symref oriented commands
To: Junio C Hamano <gitster@pobox.com>
Cc: chris.torek@gmail.com, git@vger.kernel.org, ps@pks.im
Content-Type: multipart/mixed; boundary="000000000000de2f1e0615eabb9c"

--000000000000de2f1e0615eabb9c
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> "make refs.sp" should have told you that you should not write NULL
> as just 0.  I'll queue a SQUASH??? fix-up on top before merging it
> into 'seen' for today's integration.
>
> diff --git c/refs.c w/refs.c
> index 010f426def..d578a2823b 100644
> --- c/refs.c
> +++ w/refs.c
> @@ -2758,7 +2758,7 @@ int refs_delete_refs(struct ref_store *refs, const char *logmsg,
>
>  	for_each_string_list_item(item, refnames) {
>  		ret = ref_transaction_delete(transaction, item->string,
> -					     NULL, flags, 0, msg, &err);
> +					     NULL, flags, NULL, msg, &err);
>  		if (ret) {
>  			warning(_("could not delete reference %s: %s"),
>  				item->string, err.buf);
>
>

Thanks Junio, I'll apply it locally too.

>
>
> Also there are quite many whitespace breakages.
>
> $ git am -s ./+kn7-v2-update-ref-symref
> Applying: refs: accept symref values in `ref_transaction[_add]_update`
> Applying: update-ref: add support for symref-verify
> .git/rebase-apply/patch:59: indent with spaces.
>         if (line_termination) {
> .git/rebase-apply/patch:60: indent with spaces.
>                 /* Without -z, consume SP and use next argument */
> .git/rebase-apply/patch:61: indent with spaces.
>                 if (!**next || **next == line_termination)
> .git/rebase-apply/patch:62: indent with spaces.
>                         return NULL;
> .git/rebase-apply/patch:63: indent with spaces.
>                 if (**next != ' ')
> warning: squelched 10 whitespace errors
> warning: 15 lines applied after fixing whitespace errors.
> Applying: update-ref: add support for symref-delete
> .git/rebase-apply/patch:95: indent with spaces.
>                 die("symref-delete: cannot operate with deref mode");
> .git/rebase-apply/patch:101: indent with spaces.
>         old_ref = parse_next_refname(&next);
> warning: 2 lines applied after fixing whitespace errors.
> Applying: files-backend: extract out `create_symref_lock`
> Applying: update-ref: add support for symref-create
> .git/rebase-apply/patch:81: indent with spaces.
>                 die("symref-create: cannot operate with deref mode");
> warning: 1 line applied after fixing whitespace errors.
> Applying: update-ref: add support for symref-update
> Applying: refs: support symrefs in 'reference-transaction' hook

Sigh. Even with editorconfig, this seems to be problematic for me on
Emacs. I'll just start applying locally from now before sending it.

As such I've applied this locally and will refrain from sending a new
version until a review happens.

1:  3269d0e91e = 1:  3269d0e91e refs: accept symref values in
`ref_transaction[_add]_update`
2:  a8cb0e0a1d ! 2:  2293b514a8 update-ref: add support for symref-verify
    @@ builtin/update-ref.c: static char *parse_refname(const char **next)
      	return strbuf_detach(&ref, NULL);
      }

    -+
    -+
     +/*
     + * Wrapper around parse_refname which skips the next delimiter.
     + */
     +static char *parse_next_refname(const char **next)
     +{
    -+        if (line_termination) {
    -+                /* Without -z, consume SP and use next argument */
    -+                if (!**next || **next == line_termination)
    -+                        return NULL;
    -+                if (**next != ' ')
    -+                        die("expected SP but got: %s", *next);
    -+        } else {
    -+                /* With -z, read the next NUL-terminated line */
    -+                if (**next)
    -+                        return NULL;
    -+        }
    -+        /* Skip the delimiter */
    -+        (*next)++;
    ++	if (line_termination) {
    ++		/* Without -z, consume SP and use next argument */
    ++		if (!**next || **next == line_termination)
    ++			return NULL;
    ++		if (**next != ' ')
    ++			die("expected SP but got: %s", *next);
    ++	} else {
    ++		/* With -z, read the next NUL-terminated line */
    ++		if (**next)
    ++			return NULL;
    ++	}
    ++	/* Skip the delimiter */
    ++	(*next)++;
     +
    -+        return parse_refname(next);
    ++	return parse_refname(next);
     +}
     +
      /*
    @@ builtin/update-ref.c: static void parse_cmd_verify(struct
ref_transaction *trans
     +}
     +
     +static void parse_cmd_symref_verify(struct ref_transaction *transaction,
    -+                                    const char *next, const char *end)
    ++				    const char *next, const char *end)
     +{
     +	struct strbuf err = STRBUF_INIT;
     +	struct object_id old_oid;
3:  37c3e006da ! 3:  62d05e7cb7 update-ref: add support for symref-delete
    @@ builtin/update-ref.c: static void parse_cmd_delete(struct
ref_transaction *trans
     +	char *refname, *old_ref;
     +
     +	if (!(update_flags & REF_NO_DEREF))
    -+                die("symref-delete: cannot operate with deref mode");
    ++		die("symref-delete: cannot operate with deref mode");
     +
     +	refname = parse_refname(&next);
     +	if (!refname)
     +		die("symref-delete: missing <ref>");
     +
    -+        old_ref = parse_next_refname(&next);
    ++	old_ref = parse_next_refname(&next);
     +	if (old_ref && read_ref(old_ref, NULL))
     +		die("symref-delete %s: invalid <old-ref>", refname);
     +
    @@ refs.c: int refs_delete_refs(struct ref_store *refs, const char *logmsg,
      	for_each_string_list_item(item, refnames) {
      		ret = ref_transaction_delete(transaction, item->string,
     -					     NULL, flags, msg, &err);
    -+					     NULL, flags, 0, msg, &err);
    ++					     NULL, flags, NULL, msg, &err);
      		if (ret) {
      			warning(_("could not delete reference %s: %s"),
      				item->string, err.buf);
4:  53fdb408ef = 4:  1bd39a38dc files-backend: extract out `create_symref_lock`
5:  8fa0151f94 ! 5:  732d31b43d update-ref: add support for symref-create
    @@ builtin/update-ref.c: static void parse_cmd_create(struct
ref_transaction *trans
     +	char *refname, *new_ref;
     +
     +	if (!(update_flags & REF_NO_DEREF))
    -+                die("symref-create: cannot operate with deref mode");
    ++		die("symref-create: cannot operate with deref mode");
     +
     +	refname = parse_refname(&next);
     +	if (!refname)
6:  714492ede3 = 6:  eb3d239b4b update-ref: add support for symref-update
7:  c483104562 = 7:  3cdfb9e528 refs: support symrefs in
'reference-transaction' hook

--000000000000de2f1e0615eabb9c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: a48b4ba593e085ce_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1ZWmdqOFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mejdiQy85RmNRMzFxNEJEcStWV2U1Tk9CUlhKWFhRegpQTTd5WUw3Y29Q
M3ArdkpXT21GV3EvREJLNCtoWUhUQXlqR1pYaXNpVkNoZ1hQblF2SE84YmZVcUlEQk1TaGhJCmtM
MTdPbHQ1QUZHbmd2SWhPWEI4bEVrTXROeXhweGhCSS9ENTl0ZDhUZnE3RFhiZmFPWEZRMFgvU3pC
L1pMazgKc2RVOC9FdXExajRRZG9UR1ZmQVhNYzdhT05mamVCYjBJVFVUT01FQndKZGxLYWpxb3Jq
czAyMG15ZkN3RU9uWApLWUxqcGhyK1RDcHlGcWoyWnJpWHhwbEc2a1BqcUZUaDlINnpvclRIRkw4
a1B3NXh6aElleTBWRmFwdlRHUmt6Cm9zd1hhcTAzU3hQazJmUFk4Nm9uUFlrZk96QXFkS0pSQVNE
OG95QWNvN2VIVTRGRUhUYmJTcjVJeVV3ZGlPOTcKQzN4bDdXN1dQTU5FQy9IK2VqMW9paWtyZXB0
VjJQSlFwZ3VybGRlTVdmNVRJYzRyMlpKaTFMSjF2VG5rM2lNMQpkVkRkbnQvOThWeHBycnBka1Jh
RC9Ca05lTnZjV0pteHlOYlNrQUZzK3V2WFVBallPMVVzc0hENW82RFJRZk9mCnNVckxnSEc0dHov
YkU2akNaeUJoR1R5RWJicERKRVRVYWlHZjE4QT0KPVBKalAKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000de2f1e0615eabb9c--
