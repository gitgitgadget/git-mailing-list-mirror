Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3C81F09A8
	for <git@vger.kernel.org>; Sun, 21 Jun 2026 06:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782021707; cv=pass; b=HHBhZ6rh8DSUt5bKvmoTY4WbDSN/Ojz8fglUwN36Zbbmuh0xQjs6+0aEc34yIzjpD2nMq7qhkG+WUxP14jTu9Ga8MzswSaHZT3iMe0yxM+pjC3tqOwhICsbEjC0gVJx1DAATwR2RYpILweMZalo/31YgvhkWnq9e1CDMPqQv8Mg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782021707; c=relaxed/simple;
	bh=d9a9Z9jM66Ni/JY4P5hKjSPJ8Y4BlD650NGoCLVy/AM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mCY84qKPp5RTN7WBHvXVzuwNPk1dX5G2yR7nEViMswnrb3tMz9YvQf6RT9MFKprSumsIM7NZ5c5SslB0jI9SixO2sEDqDJAYKq5Zv/1rHggjU4cVrct0r0Z1kkyDF8pUFWspq2a9t9kfR4EoKoXl91Mrtx2OGfPAUEbuZHBnWBI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QYM+WlF3; arc=pass smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QYM+WlF3"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-69767cb5d4aso2676977a12.3
        for <git@vger.kernel.org>; Sat, 20 Jun 2026 23:01:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782021704; cv=none;
        d=google.com; s=arc-20240605;
        b=AmtYIp2w2NJScIepbGoO5GcxzZo3hBxX56zMZbNqMTiD3QNK+V3A9cHB+4zTdKwDBD
         /sHJ/pdMZsaMXPR+tPo92WUDacX4iTI/J+NLPnfdLQY8oaCX9H8+nsonpXEUL7Z6/V/1
         /CbtYhM6929FwCi+1dVR3HKtXU1UcCv9T/piCyPHMdiEo+q/UI44zev8LUaVlUwDgVtW
         oQHNxB96nQ3cVP3gJrIjZRWHb6LVJV0qQrmsiNIXDZEoQRjLMrXo2W1eQAlIfSuv13j8
         K5ctmDUqkfqU1QTOv77vBEoZAHMcRdV8j1qU+jGbBLH3KNlKDRl6+DF+L12RN9v1C3ZO
         lA0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=+z3VRRX4fvOjRK55PRhYNelRPn6uKxUJLh7DLKA0xFg=;
        fh=HTnbRoPLCu53lVQ71fNOquEcHDW1BNnCIIw7j9bBi0A=;
        b=Ucr8WoBjMXzehD42lwvwxYDdP6iP6bt2j8bU6Ab/VTs52uJivPe43z7EBTqTDTeHTT
         YKJEu18CK/uyl3kOc+4lnilPAfL2/WAt+QblJLZcnSLrjMGlIQv4JldOCFBNJ/s2phIN
         esSSl4Re348uRA6yj8JN4eg8+nRLDeYhg/+XhSzc4qX/tYOhVCObOfmHeslMWaewaybL
         PSRMXWbB8P2mxhgflNGs17UrqKbOKUBQTEcM8mQTPTrbFA6mlK3FlSEM0/+EpBVpPg6w
         PKOMOWJBUQHAXFCiJwsga8Nd5o4b0FV7pEMjtbjJmHtWvCzLf1VfmSA/K35ikA0b43ri
         pPUA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782021704; x=1782626504; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+z3VRRX4fvOjRK55PRhYNelRPn6uKxUJLh7DLKA0xFg=;
        b=QYM+WlF345afi2/1bO843Do75X3Icc6HVduo4RbG/FLTr1F5IIR3CW/sgoWxT9vIQg
         hHnDliQwxy9ib1k6vUVuXLmijbC3dn+nb4nTq19xgGSSJpKaifsyiw/ohWoBmU/esYRe
         X56CqZCfcP+sRgXAxVNdAJzk5X5QalgxeAp0sSsuWa2CEfWGU3bTYM+FT1fqOV0LlLSp
         SGvU79VWYTcxupAsjrwtPOY6dh2FuO9RI1OMuFvQ5MenS5IOPBrhAELzJFGdlmFo9W44
         zzaGQ50FWWBQ50vooS2Bug8uYW+JcrVqVRKjV9OP+JMYOW+tiJdBj5Mcn8HgTL81SFAK
         Fkcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782021704; x=1782626504;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+z3VRRX4fvOjRK55PRhYNelRPn6uKxUJLh7DLKA0xFg=;
        b=AF126UPBr5Lg0VlKJ9hRQ5lypCEt6xAHeRywyFartcEmc8HXIXRDocUJ9RKW8wvd4G
         J2lDUxWgOwzeWMXmnW7EFA6Tgi9xga1xyBaBo6FbEmQgyCgijRyk1emm6PVVHyRRvqNX
         moQFrf/9VwfH/aRXkNZVcD+j53EGrYNh/65Ya5BUlvpxBpXb1iQajlrW2tO/rhwMYwhh
         wvZWDFpbiPR9hxviC+BfVl3bh9ylNSy3GLV/a+eaZX7sdhoAMAgPTZkcs28DJpsrLjaJ
         sI5Uj/jquvTdWVN7uAe/xqkk0aAhZGUYH6zSKudypCF+atcjVNXgk/NMK2NoQPcxfQlE
         P2Kg==
X-Forwarded-Encrypted: i=1; AFNElJ95piJWpypCe4v0oV8jcxWqpEg6XFEWAGinlVN9dzhGhOY8ZRIvFdZV+uQoneKX/PXiWQg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxm7Kch5bJ/fDiFzUGaRlkxHDnURaBQuIohfFfbhaNJwAuWZ8DJ
	8B/LwSGnI6A60yYEi29AGqtp6lYSSMKzzektXWi245UNqnxxuU3eHsTkcdhVzVmHzFYaONWVGGb
	K9jbnX4bxPXi58+RL1H9wuMwJNk8sTU8=
X-Gm-Gg: AfdE7cm5EmAOdbuklRWsa2e5YspAhY0cuNqSS03cc8727uNy+X6b3DHZnzGFfLplH/M
	239yIDAXA66C3TjZHPHMECM/ff2x3aDcWhBkKrIH+TpwlAb+kPEv4azoixHZSolbJ8x1tH7pFny
	z7S/nRghd7aHvPbl9RI2jUF5suf9GGMEDnYTk7r6QzrE0k6FYJ9vrkBzehk4I3xeaxzVHKK+2nY
	3DkAPv6urh/6E6QRGo7TopDLTMZ9Z44hn1qGKWOAJPLTLTxEU0IrIpGnnXnSgP6Q+4e/gl5kWI0
	C1qtvWgZH1soa/YHMtnPmGaWZu+/pbkK06DbUzvfv+FgddstM4qyo3TBTmls0rudcYXv/kwyYR8
	lNg11SDpdQQ==
X-Received: by 2002:a17:907:6d03:b0:c04:fc6:d6bc with SMTP id
 a640c23a62f3a-c097cbca4f7mr483973666b.36.1782021703911; Sat, 20 Jun 2026
 23:01:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260608-ps-eric-work-rebase-v12-0-5338b766e658@gmail.com>
 <20260619-ps-eric-work-rebase-v13-0-3d4c7315d2f8@gmail.com> <20260619-ps-eric-work-rebase-v13-10-3d4c7315d2f8@gmail.com>
In-Reply-To: <20260619-ps-eric-work-rebase-v13-10-3d4c7315d2f8@gmail.com>
From: Chandra Pratap <chandrapratap3519@gmail.com>
Date: Sun, 21 Jun 2026 11:31:16 +0530
X-Gm-Features: AVVi8CfAPedaAoh02_jQGd_MwZV7ZnJmzxfzHfZCwa7rC23gYSZf3ed16-dAHpc
Message-ID: <CA+J6zkTjgHAWtJwxY8jo0i9zDtxwj9uUsKAtLS3z1=WxZfr8Zw@mail.gmail.com>
Subject: Re: [PATCH GSoC RFC v13 10/12] cat-file: add remote-object-info to batch-command
To: Pablo Sabater <pabloosabaterr@gmail.com>
Cc: gitster@pobox.com, peff@peff.net, eric.peijian@gmail.com, 
	chriscool@tuxfamily.org, git@vger.kernel.org, jltobler@gmail.com, 
	karthik.188@gmail.com, toon@iotcl.com, 
	Jonathan Tan <jonathantanmy@google.com>, Calvin Wan <calvinwan@google.com>
Content-Type: text/plain; charset="UTF-8"

[snip]
> +static void parse_cmd_remote_object_info(struct batch_options *opt,
> +                                        const char *line, struct strbuf *output,
> +                                        struct expand_data *data)
> +{
> +       int count;
> +       const char **argv;
> +       char *line_to_split;
> +       static struct object_info *remote_object_info;
> +       static struct oid_array object_info_oids = OID_ARRAY_INIT;

I don't get the point of remote_object_info and object_info_oids
being static here? These variables are allocated, utilized, and
completely freed/disconnected within a single command cycle.

Making them static gives me the false impression that state
needs to persist between calls.

> +       if (strlen(line) >= MAX_REMOTE_OBJ_INFO_LINE)
> +               die(_("remote-object-info command too long"));
> +
> +       line_to_split = xstrdup(line);
> +       count = split_cmdline(line_to_split, &argv);
> +       if (count < 0)
> +               die(_("split remote-object-info command"));
> +       if (count - 1 > MAX_ALLOWED_OBJ_LIMIT)
> +               die(_("remote-object-info supports at most %d objects"),
> +                   MAX_ALLOWED_OBJ_LIMIT);
> +
> +       if (get_remote_info(opt, count, argv, &remote_object_info,
> +                           &object_info_oids))
> +               goto cleanup;
> +
> +       data->skip_object_info = 1;
> +       for (size_t i = 0; i < object_info_oids.nr; i++) {
> +               data->oid = object_info_oids.oid[i];
> +               if (remote_object_info[i].sizep) {
> +                       /*
> +                        * When reaching here, it means remote-object-info can retrieve
> +                        * information from server without downloading them.
> +                        */
> +                       data->size = *remote_object_info[i].sizep;
> +                       opt->batch_mode = BATCH_MODE_INFO;
> +                       batch_object_write(argv[i + 1], output, opt, data, NULL, 0);
> +               } else {
> +                       report_object_status(opt, oid_to_hex(&data->oid), &data->oid, "missing");
> +               }
> +       }
> +       data->skip_object_info = 0;
> +
> +cleanup:
> +       for (size_t i = 0; i < object_info_oids.nr; i++)
> +               free_object_info_contents(&remote_object_info[i]);
> +       free(line_to_split);
> +       free(argv);
> +       free(remote_object_info);
> +}
> +
[snip]
