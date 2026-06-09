Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EC58378D96
	for <git@vger.kernel.org>; Tue,  9 Jun 2026 15:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781019164; cv=pass; b=PHOlMl8e9godk4lzhDo1jYrDlW3i808Q2dhHwSa7pjRtuD/SQ3q6xH9qnGrwrIn8fwAOxdRgQFzF57NABsYgiSQSuvcnjILbXr//yU7coDUviSdTi3NR9gUP5YSsDzVkPU6DJ9Usp86AtZn585NRA8B60QIkAaG5QfRUKQGoHZo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781019164; c=relaxed/simple;
	bh=7+orbme5bdAZQEL6Hzb0wPMFZ6o6obiP3+OCE0VSd4g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cRZRqHbsnPuobCeBf2DPp5nleeW9PQpoafbYzwSA0nci/0XhKtMhFLg1azt+Pw+kiZanhkR1SJQhnV/eCmjh4FMfHU1of9CAIz9O1LlTKcqnFAjTesYqInvEhJvsCnudIvVSPLdKv2Aq/4wScnJjBEc87hQ0N1D8HL0Nix1s71M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ltw/DmwT; arc=pass smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ltw/DmwT"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-691c5776f35so3204194a12.3
        for <git@vger.kernel.org>; Tue, 09 Jun 2026 08:32:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781019161; cv=none;
        d=google.com; s=arc-20240605;
        b=bXNFdObouRTpqwg78Ut7KStNlmMxPowoGLl3Z+UPnL+1Ua9h52/Tp/oFmu/p6hpHwr
         u5vWtTOcMEQXfTzN9qqTRwywcuNvbSzvnw9OnqcqjO5j+iz7FmbPdfw3apytKnFzZyM1
         Ed2DKoDGaMjZVvPMtLtm+H4aLx4NGa/Zb1hk8YEKBFGhhAXqmllsLfi8CDqzrlTHC/XO
         PM6PHaSIvPpcs8zOJxsGeg9umZPhstHmIJJZLZ+DrNaoLSmO3zLumj+fJnif5uplzNM7
         SrgUOruHOJ69HSVuuLCXYhzeNv+NKOSuvA4sVFQ4iG2z3k7pclKKDoC5J5xt38RyoT/j
         t0/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Tq1zfh3jh6/8Y+u3qAznEIGIRoFPiUlJO7mtMFuLFOY=;
        fh=GHtdeWn6luo+P/JBwRnxu26cjJrl11aPT+E2FcLb5oE=;
        b=dZz9iP7L3OuBy/GxkSxR1gQXCL4vk/vU5S0Fw9X+/F5Vn2CZSztjdptHnP1p4ImwbP
         jUebsBNpjuWkv4Ln8K4MtZsxwzU08lflZieoLM94a4NCChCjmrUzE+BUYx3aoebATasO
         eGswDiheaJeO3VPtA9hSXESlMZVoFD5bm8eGeXalhHVZtLHVLB5k9wu8Bm8kXnCpuDMp
         UPt/3/RfCfpXOqEQBJrTduECh61pM71AT/3vBqvKsRJLDr7WfD7McxTBAG4oReHb07yj
         R7exnDfclfjC5/+q4iaGfZSSdCn2DoNRZhhloKVAsK79O5oVlKF8oZfccVhHY7pZ3tgF
         8TWQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781019161; x=1781623961; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Tq1zfh3jh6/8Y+u3qAznEIGIRoFPiUlJO7mtMFuLFOY=;
        b=Ltw/DmwTakGNQ23Kdw4hFBobTc27mBqxz8u6dGLy8IE6J0++EofFM5Ujh1DMmVgbjv
         vmPcipq6dDo4SIito6W0rff3wzhnQv5M8Ihh181Jf0hTgCixkqdjSfQ3IYi3eGDzBHI2
         VE9qt1KGuEpSSbWNx3N4vIv0mCV0sJbGbQyJF7QjmMYnk+C8ssIYYzAXmgo6IO8he9hZ
         Y9VudBoqzAOCILT4IFy4g/x9ElVepenehV9hDh6g9CCAd0RDq1ycn5ccEb/Npytz9VCI
         BFyzJsreUZMjX/3rDoBVLbUFN+VhTWL2uOjd7rsDKsnG+HtPEHfXSPc7H+gMSHI3Rc2y
         lQCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781019161; x=1781623961;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tq1zfh3jh6/8Y+u3qAznEIGIRoFPiUlJO7mtMFuLFOY=;
        b=M5lq1zVTPDfnfmZkTYfHTz57N5VBnFqjRzejwN2T8q/SfhiWnri3u/p5MpqxBkGVqu
         1jFVToBjP5Csz6uS0IYLRgRrGv3esGJSBF07ls4aWkK0VY0tcESFZLCCnD7L8ZTO9Oey
         woURRuP100gaWJUXWkX8omdGZ9pz8S+yiWdhra/D6mJbcUGAPOtH0yaSfheXlGjraim4
         dUcZdyH/VoslnpOjop2m2/jAGhmCILcsLZ78wv7iS4E++WozZ38cNN5CqxzAX1Fm7fGc
         Cwa2v+V/RF1IFxkUpTSe4OMYbArmKeqbJb/UIZcBiKjkQHQHSYRb5fV9bnEDUEkCAysN
         XxMg==
X-Forwarded-Encrypted: i=1; AFNElJ+BVNXIJCuXv1M67PFDTUdvo/qrKHldNcSRW1dd6AD8YPRjzGDAvIYk6YbeDwsxqZI9a+Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrCQXdehOgX9NmI49T/m3ySnmFYzIRIUR/8dev3hLAD8Dy12qh
	u2Hnupqyq4hzHYD4EcKBOn08N9uWZPB0lKCJ1qBlKUuSqE2T27MQIR+wVurF8u7daxbiPFOGQ5u
	/snOSLJyx6vG/At+GmNs4/yhZpSqqqac=
X-Gm-Gg: Acq92OGbIYaeRnjMsgu8eQ4Z1i8HTWk6Nu9TZRZyQYE2zQ2skVbVFHbqg9L0cXlstbv
	VxX5xuH7Q4tRVqt2h4Trag1++Wo7piubLegijrNznHfPM7+uEpfoOfrYIp3KiQ1jueSRW/iL296
	WcTIyMCM4RRQTWJ9ne3RnVNbpH4rmY+ZLExI0seLIyM5KYEPUx/Gx9n6PZX/KWwXOg4hpmuy44Q
	s0XFFht5L4MdaOEohvvv2tY5ezobnwXcARnlPDPaK/9B8Chh1oxCsUD8lOSwz8k1NLRi5q63DxJ
	gnDOGwX1zK0Y0pdkxCMz2NFriLiX91GlZQKN4cxHFsn76v/bORh4eA5vCAl13KiSWN+vxTVs36m
	r20WgUlWkpk7jErmU74Z/S/x+JGGKrMUP
X-Received: by 2002:a05:6402:528c:b0:68d:623a:bc77 with SMTP id
 4fb4d7f45d1cf-68fa4c250c9mr9229040a12.8.1781019161155; Tue, 09 Jun 2026
 08:32:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250221190451.12536-1-eric.peijian@gmail.com>
 <20260608-ps-eric-work-rebase-v12-0-5338b766e658@gmail.com> <20260608-ps-eric-work-rebase-v12-12-5338b766e658@gmail.com>
In-Reply-To: <20260608-ps-eric-work-rebase-v12-12-5338b766e658@gmail.com>
From: Chandra Pratap <chandrapratap3519@gmail.com>
Date: Tue, 9 Jun 2026 21:02:13 +0530
X-Gm-Features: AVVi8CfKbWC1ifCtSeKTUMey6SDZFuGAI6GTGIWoYGjcDYAvP6XW3pBroIn7sKc
Message-ID: <CA+J6zkQ22en2HgH03EedKOfC+jLcHH2UbwpH0h_bDEAHR6B2pg@mail.gmail.com>
Subject: Re: [PATCH GSoC RFC v12 12/12] cat-file: make remote-object-info
 allow-list dynamic
To: Pablo Sabater <pabloosabaterr@gmail.com>
Cc: eric.peijian@gmail.com, calvinwan@google.com, chriscool@tuxfamily.org, 
	git@vger.kernel.org, jltobler@gmail.com, jonathantanmy@google.com, 
	karthik.188@gmail.com, toon@iotcl.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 8 Jun 2026 at 15:45, Pablo Sabater <pabloosabaterr@gmail.com> wrote:
>
> The static allow-list in expand_atom() is hardcoded to only allow
> "objectname" and "objectsize" for remote queries. This works because
> up to this point all servers will either support object-info with name
> and size or they do not support them at all, but we cannot expect that
> in a future different servers with different git versions to have the
> same object-info capabilities. Therefore, the allow_list needs to be
> dynamic depending on what does the server advertise.
>
> The client will now:
>
> 1. Request the protocol option that the placeholder refers to (i.e.
>    "size" when "%(objectsize)").
>
> 2. Filters the request in fetch_object_info() dropping any option that
>    the server does not advertise.
>
> 3. After the fetching, the options that haven't been dropped are the ones
>    fetched and supported by the server, these supported options are
>    mapped and remote_allowed_atoms is populated with the placeholders.
>
> 4. expand_atom() checks remote_allowed_atoms with the same behaviour as
>    the static allow_list had.
>
> Move object_info_options out of get_remote_info so the caller which has
> data can select what options will be requested instead of requesting
> always size.
> Move batch_object_write() out so there will always be an output even if
> all the placeholders are not supported by the server (returns an empty
> line).
>
> Include "type" in the object_info_options so once the server supports
> it, the clients know already how to request it.
>
> Mentored-by: Karthik Nayak <karthik.188@gmail.com>
> Mentored-by: Chandra Pratap <chandrapratap3519@gmail.com>
> Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
> ---
>  builtin/cat-file.c  | 85 ++++++++++++++++++++++++++++++++---------------------
>  fetch-object-info.c |  6 ++++
>  2 files changed, 58 insertions(+), 33 deletions(-)
>
> diff --git a/builtin/cat-file.c b/builtin/cat-file.c
> index 1166a046b4..055991b5af 100644
> --- a/builtin/cat-file.c
> +++ b/builtin/cat-file.c
> @@ -341,13 +341,10 @@ struct expand_data {
>          * Flags about when an object info is being fetched from remote.
>          */
>         unsigned is_remote:1;
> -};
> -#define EXPAND_DATA_INIT  { .mode = S_IFINVALID, .type = OBJ_BAD }
>
> -static const char *remote_object_info_atoms[] = {
> -       "objectname",
> -       "objectsize",
> +       struct string_list remote_allowed_atoms;
>  };
> +#define EXPAND_DATA_INIT  { .mode = S_IFINVALID, .type = OBJ_BAD, .remote_allowed_atoms = STRING_LIST_INIT_NODUP }
>
>  static int is_atom(const char *atom, const char *s, int slen)
>  {
> @@ -359,17 +356,11 @@ static int expand_atom(struct strbuf *sb, const char *atom, int len,
>                        struct expand_data *data)
>  {
>         if (data->is_remote) {
> -               size_t i, allowed_nr = ARRAY_SIZE(remote_object_info_atoms);
> -               for (i = 0; i < allowed_nr; i++)
> -                       if (is_atom(remote_object_info_atoms[i], atom, len))
> +               size_t i;
> +               for (i = 0; i < data->remote_allowed_atoms.nr; i++)
> +                       if (is_atom(data->remote_allowed_atoms.items[i].string, atom, len))
>                                 break;
> -
> -               /*
> -                * On remote, skip unsupported atoms returning an empty sb,
> -                * honoring how for-each-ref handles known but inapplicable
> -                * atoms (e.g. %(tagger)).
> -                */
> -               if (i == allowed_nr)
> +               if (i == data->remote_allowed_atoms.nr)
>                         return 1;
>         }
>
> @@ -686,12 +677,12 @@ static int get_remote_info(struct batch_options *opt,
>                            int argc,
>                            const char **argv,
>                            struct object_info **remote_object_info,
> -                          struct oid_array *object_info_oids)
> +                          struct oid_array *object_info_oids,
> +                          struct string_list *object_info_options)
>  {
>         int retval = 0;
>         struct remote *remote = NULL;
>         struct object_id oid;
> -       struct string_list object_info_options = STRING_LIST_INIT_NODUP;
>         static struct transport *gtransport;
>
>         /*
> @@ -726,15 +717,12 @@ static int get_remote_info(struct batch_options *opt,
>         gtransport->smart_options->object_info = 1;
>         gtransport->smart_options->object_info_oids = object_info_oids;
>
> -       string_list_append(&object_info_options, "size");
> -
> -       if (object_info_options.nr > 0) {
> -               gtransport->smart_options->object_info_options = &object_info_options;
> +       if (object_info_options->nr > 0) {
> +               gtransport->smart_options->object_info_options = object_info_options;
>                 gtransport->smart_options->object_info_data = *remote_object_info;
>                 retval = transport_fetch_refs(gtransport, NULL);
>         }
>  cleanup:
> -       string_list_clear(&object_info_options, 0);
>         transport_disconnect(gtransport);
>         return retval;
>  }
> @@ -820,6 +808,21 @@ static void parse_cmd_mailmap(struct batch_options *opt UNUSED,
>                 load_mailmap();
>  }
>
> +struct protocol_placeholder_entry {
> +       const char *option;
> +       const char *atom;
> +};
> +
> +static const struct protocol_placeholder_entry remote_atom_map[] = {
> +       {"size", "objectsize"},
> +       {"type", "objecttype"},
> +       /*
> +        * Add new protocol options here. Even if the server doesn't support
> +        * them the allow_list will drop them if the server doesn't advertise
> +        * them.
> +        */
> +};
> +
>  static void parse_cmd_remote_object_info(struct batch_options *opt,
>                                          const char *line, struct strbuf *output,
>                                          struct expand_data *data)
> @@ -829,6 +832,7 @@ static void parse_cmd_remote_object_info(struct batch_options *opt,
>         char *line_to_split;
>         static struct object_info *remote_object_info;
>         static struct oid_array object_info_oids = OID_ARRAY_INIT;
> +       struct string_list object_info_options = STRING_LIST_INIT_NODUP;
>
>         if (strlen(line) >= MAX_REMOTE_OBJ_INFO_LINE)
>                 die(_("remote-object-info command too long"));
> @@ -841,30 +845,44 @@ static void parse_cmd_remote_object_info(struct batch_options *opt,
>                 die(_("remote-object-info supports at most %d objects"),
>                     MAX_ALLOWED_OBJ_LIMIT);
>
> +       if (data->info.sizep)
> +               string_list_append(&object_info_options, "size");
> +       if (data->info.typep)
> +               string_list_append(&object_info_options, "type");
> +
>         if (get_remote_info(opt, count, argv, &remote_object_info,
> -                           &object_info_oids))
> +                           &object_info_oids, &object_info_options))
>                 goto cleanup;
>
> +       string_list_clear(&data->remote_allowed_atoms, 0);
> +       string_list_append(&data->remote_allowed_atoms, "objectname");
> +       for (size_t i = 0; i < ARRAY_SIZE(remote_atom_map); i++)
> +               if (unsorted_string_list_has_string(&object_info_options, remote_atom_map[i].option))
> +                       string_list_append(&data->remote_allowed_atoms,
> +                                          remote_atom_map[i].atom);
> +
>         data->skip_object_info = 1;
>         for (size_t i = 0; i < object_info_oids.nr; i++) {
>                 data->oid = object_info_oids.oid[i];
> -               if (remote_object_info[i].sizep) {
> -                       /*
> -                        * When reaching here, it means remote-object-info can retrieve
> -                        * information from server without downloading them.
> -                        */
> +               /*
> +                * When reaching here, it means remote-object-info can retrieve
> +                * information from server without downloading them.
> +                */
> +               if (remote_object_info[i].sizep)
>                         data->size = *remote_object_info[i].sizep;
> -                       opt->batch_mode = BATCH_MODE_INFO;
> -                       data->is_remote = 1;
> -                       batch_object_write(argv[i + 1], output, opt, data, NULL, 0);
> -                       data->is_remote = 0;
> -               }
> +               if (remote_object_info[i].typep)
> +                       data->type = *remote_object_info[i].typep;
> +               opt->batch_mode = BATCH_MODE_INFO;
> +               data->is_remote = 1;
> +               batch_object_write(argv[i + 1], output, opt, data, NULL, 0);
> +               data->is_remote = 0;
>         }
>         data->skip_object_info = 0;
>
>  cleanup:
>         for (size_t i = 0; i < object_info_oids.nr; i++)
>                 free_object_info_contents(&remote_object_info[i]);
> +       string_list_clear(&object_info_options, 0);
>         free(line_to_split);
>         free(argv);
>         free(remote_object_info);
> @@ -1177,6 +1195,7 @@ static int batch_objects(struct batch_options *opt)
>   cleanup:
>         strbuf_release(&input);
>         strbuf_release(&output);
> +       string_list_clear(&data.remote_allowed_atoms, 0);
>         warn_on_object_refname_ambiguity = save_warning;
>         return retval;
>  }
> diff --git a/fetch-object-info.c b/fetch-object-info.c
> index 51a898430d..425929a269 100644
> --- a/fetch-object-info.c
> +++ b/fetch-object-info.c
> @@ -39,6 +39,12 @@ int fetch_object_info(const enum protocol_version version, struct object_info_ar
>         case protocol_v2:
>                 if (!server_supports_v2("object-info"))
>                         die(_("object-info capability is not enabled on the server"));
> +
> +               for (int i = args->object_info_options->nr - 1; i >= 0; i--)

Isn't args->object_info_options->nr of type size_t? We should probably
do something
like:

for (size_t i = 0; i < args->args->object_info_options->nr; i++)

instead.

> +                       if (!server_supports_feature("object-info",
> +                                                    args->object_info_options->items[i].string, 0))
> +                               unsorted_string_list_delete_item(args->object_info_options, i, 0);
> +
>                 send_object_info_request(fd_out, args);
>                 break;
>         case protocol_v1:
>
> --
> 2.54.0

Other than these, the patch series LGTM for now.

Thanks,
Chandra.
