Received: from mail-ua2-f12.google.com (mail-ua2-f12.google.com [74.125.226.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C0673DEFF3
	for <git@vger.kernel.org>; Thu, 10 Sep 2026 09:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.226.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789033058; cv=pass; b=T2LH7kVJ2EZR5cYHsMXmopZzRlgIxUuuZH7OnAgy1KprXC8b50qn322EvtbX8Owu6JW1UP9R9yYVFYXkhbocmGQ45+JsR7hqgO0aTfAj4R80yo9DW29JSLOZG6RfuoKCWVQOS/rxZX8UaI+TMPpg1gLhd2PbuRoBH25D+yxl4o4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789033058; c=relaxed/simple;
	bh=ggcr7d9P1DAgBTRLx+V2lyD1x5iHcVKQrVbRkfY8mk8=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CocZeW1i62EBzEbYTZga/DdNXYsp6o795AnIo65q/1sQo5GP5jt35ml39txdJHuiVJqlttweCBbAY6OvIiNVbqlsy9k7sJEdUSOpcdSL6bNaAAPr4uUT2khGEIkaPv6SDZhDGziSkwwcCrpoegYjZC04ry2ON8Dl4ud/nlEQy4I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oLKZRYqX; arc=pass smtp.client-ip=74.125.226.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oLKZRYqX"
Received: by mail-ua2-f12.google.com with SMTP id a1e0cc1a2514c-97ea5bd53b4so380141241.0
        for <git@vger.kernel.org>; Thu, 10 Sep 2026 02:37:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789033055; cv=none;
        d=google.com; s=arc-20260327;
        b=glCAWehlsjAQu52OEVmpjb2cAuvaOFbKrVj8TjHptJoO96cd2HHO5XcqWSXNQ16nAP
         U+TTN6hMITkbPaVAveX2kxMgn0sHMD6TH7ag0TkRcWFnr+YQhP5c6v8Tv4RUicnlBO0A
         vHkd/U6xbHwxDJ+zoyPt/Pr2xKJHl+4oO89Pwkopt8GzuQTqwP3cbOhvl78CvU7NT7tY
         K3QhJCyHef/Xq/KUtLed7RsoLx5WZM6PvqfaZ+cSSfLM4dyNEI2lo/fnIGWAixO/FsLG
         /8oTA/QB+wgpzit+HVg49jbAI+b6+mOlF9AUx1PBjSohyCsz9LzDIJC5+RZbyWDB773h
         FeNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=mGMcPWCGTGBAijVomAKNSMV/rOa5Ol/sMH/QFPyWP1A=;
        fh=fjnkeDnAQxmvocQaqLaybtkEEUABvCj10SE/HXo+vHM=;
        b=sgUeQaS2bCeLxJ1MlgXFhiZAHP3AYTLUJZJ3oq9zUsITG3Lf0gldDx0OJ2lhvrPpqO
         ks5fyutN4zjoqXX2ZIewhAE/NWQoyHe15/Ij0sOSKP40CD0rZKcww5YFM/hOoq7IpAqn
         sSKdzygD+6kkglU1Z6GZASGroy+2HZ+xfL3X9AroJOZy7VAyn0lPcAWDPnWZZkOqn68K
         ZwNtChvhKK0N4eiotVah4Io0+6MqhNC1s3KCzlhcLZxQks6EDNSA8GMzEH7j0QIG6QVe
         WqvniyIjaOI+Ml9inrwgwSCquCVgjKfRiMWxqQSlGrOUo0W1JG4s6jStm7iLrw5x4Bmy
         H0tQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789033055; x=1789637855; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mGMcPWCGTGBAijVomAKNSMV/rOa5Ol/sMH/QFPyWP1A=;
        b=oLKZRYqXbNJa7fTtY1959CJ6fvC4KocaKG9uV1B0GwXaT1EB+GCM3zgyitjlmQ2Qy/
         9WqmZ3rCZ8n1og69VWqApKGPIj+/yx1E/UPiZPWkAQrEHBxlW1ossP03i2smrlPR793D
         IlDhqM9U4wAXhzRVcM8TpSOGbXfkXt+yPQrMW4VzRsqC+mb2d0xtGftyoxiNzvY98kPL
         Vs3Wy1YKCDfXZT4b2pKUwgS8HyK99h9iB3c5Ci37ktkDuKpk114iJROlmzIVqvHJhTWu
         s4IfpxF/ixfXTNGb8a/wfNBUUBdCqJOoX9Dx1FyRCYnTMhEDrOPuCB0YIoccF2YR4RMB
         oayQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789033055; x=1789637855;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mGMcPWCGTGBAijVomAKNSMV/rOa5Ol/sMH/QFPyWP1A=;
        b=EWDZz0FhC7PqGHUeUAns9LHYZN8XJTNcSnbdHOl4FR4NZHL0hD7oYGxCAus8OtvpEw
         p1nC0NDlyw0zij6pWdf4xNj3mBmx7QOS2aX8R72Nvh/vrNqJUoqqVM6quXOtQo4XsdWC
         R1hGSbY3z1HMzgpSG9RYSk4Hkr/uzJgsvfjAkoZfe/9ifjJQm6Dkv6QL2Fr5ktXjomIf
         vxRy8xiow939j7PCftZoIp++CgBIgQZn/HmxoD5aOmOTQza70BdNuIgwPWqN9sHvrJaS
         MJ9ImD5wL8ImBtfOv5twFg90agKNvPpOMmAPxhqwOwK7A1hP3PKIfMDqFS38JvT3SEne
         +G6Q==
X-Forwarded-Encrypted: i=1; AKwUvBySuI9IinItqiGhYkAv2kfmDFo/CNhY962+utBudZZO3/wHJMTokTt1O5vviteoMcTdlAg=@vger.kernel.org
X-Gm-Message-State: AFuF++miZ+ECH8dQtmuyzUhgk1rP5iYsEVzllZ1M7q2tSPWp40RMO8jr
	IR+5EFDNjb7z1GYxNjVvfhVAoqZbNvmKyNSlpKtuimcFL/tlbmCUAmz62of6cWIuNULy7LTeuaa
	Ys+q8hcJI8B0mqdXD0BSHXqDIh/OtIBs=
X-Gm-Gg: AYBFou09kz8x2YHO7Q6IefWR/wvLeQLY/cypUS2ralrLDQAvxaKlYto+J8nNQoq/OxJ
	VPYPY8VgbSlegUKBV4VMAYOv/Zin1yqaI0n0rlR6+NJwL+kvURCTowhYR+Rs9jKk39SJmAM9xEJ
	jfl4kXjT+Ct157pd+Z9/7vSagOByqdY53Td67/QfZantarrZ6+bGyiRYzx07ZzJPr8KQEnjmn/4
	UUN5qyOVKj+29WwhwOJPJ990FWcZ48LQTfCZMqIUkt9TEl2UW2F92+/So7W6+fvZm41BTotua5m
	MRAbeBz4HFaRJHbvMrbTSqrIzxQ4fBwYoh6oXjz3qtczpNi50xbUelj9fT5h+DViUq7sifudWDm
	2gkqGF+dAPgmNgNr37B0+Vu6TFt9rFkoPWCC+ZFdvAJsxsne5V7veOXg=
X-Received: by 2002:a05:6102:4191:b0:76f:eaa2:6fa7 with SMTP id
 ada2fe7eead31-79075874992mr4035085137.2.1789033052933; Thu, 10 Sep 2026
 02:37:32 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 10 Sep 2026 02:37:31 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 10 Sep 2026 02:37:31 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260909-pks-odb-write-alternates-at-creation-time-v4-4-d8a78ffc32e4@pks.im>
References: <20260909-pks-odb-write-alternates-at-creation-time-v4-0-d8a78ffc32e4@pks.im>
 <20260909-pks-odb-write-alternates-at-creation-time-v4-4-d8a78ffc32e4@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 10 Sep 2026 02:37:31 -0700
X-Gm-Features: AcwNN1UjI7vpjerb8_kseAsOiSEcSXf_HlORq5hkgFKYxCoki_UAQMrE-Xmk1T8
Message-ID: <CAOLa=ZQf3XcX_G1H+vNSQtpU-Oj56pda0WcJAORw-kQMEPvTTw@mail.gmail.com>
Subject: Re: [PATCH v4 4/9] builtin/clone: refactor handling of "--reference{,-if-able}"
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Toon Claes <toon@iotcl.com>, Junio C Hamano <gitster@pobox.com>, 
	Justin Tobler <jltobler@gmail.com>
Content-Type: multipart/mixed; boundary="0000000000009cb9b7065b1db7bc"

--0000000000009cb9b7065b1db7bc
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> Users can pass "--reference{,-if-able}" to git-clone(1) to instruct it
> to set up alternates for the newly created repository. This allows it to
> reuse objects from the source repository so that in the best case we
> don't have to clone all objects over.
>
> Those options are handled by the confusingly named `setup_reference()`
> function -- without the above context, one might rightfully believe that
> it was about refs, not about alternates. The function itself is rather
> simple: we loop through all provided alternate paths and then, if such
> an alternate is valid, we write it to the object database.
>
> In subsequent commits we're about to consolidate the complete setup of
> alternates into this function, and furthermore we'll refactor the setup
> of the object database to handle doing this for us instead of writing
> the alternates into it one by one.
>
> Prepare for this refactoring by collecting the alternates into a strvec.
> Rename the function to `collect_alternates()` to clarify its scope.
>

Yay!

> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  builtin/clone.c | 44 ++++++++++++++++++++++++++++----------------
>  1 file changed, 28 insertions(+), 16 deletions(-)
>
> diff --git a/builtin/clone.c b/builtin/clone.c
> index ac5843d7b9..8786a49332 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -154,24 +154,26 @@ static char *get_repo_path(const char *repo, int *is_bundle)
>  	return canon;
>  }
>
> -static int add_one_reference(struct string_list_item *item, void *cb_data)
> +struct add_one_alternate_data {

So this is `add_one_alternate()`'s data, was a bit confusing cause I
first read that this was information regarding a single alternate, but
then it also has a field called `alternates`.

> +	struct strvec *alternates;
> +	int required;

Question: here and other places, I see some of the boolean-ish fields
being declared as `int`. It doesn't matter, but is there a reason?

> +};
> +
> +static int add_one_alternate(struct string_list_item *item, void *cb_data)
>  {
> +	struct add_one_alternate_data *data = cb_data;
>  	struct strbuf err = STRBUF_INIT;
> -	int *required = cb_data;
>  	char *ref_git = compute_alternate_path(item->string, &err);
>
>  	if (!ref_git) {
> -		if (*required)
> +		if (data->required)
>  			die("%s", err.buf);
>  		else
>  			fprintf(stderr,
>  				_("info: Could not add alternate for '%s': %s\n"),
>  				item->string, err.buf);
>  	} else {
> -		struct strbuf sb = STRBUF_INIT;
> -		strbuf_addf(&sb, "%s/objects", ref_git);
> -		odb_add_to_alternates_file(the_repository->objects, sb.buf);
> -		strbuf_release(&sb);
> +		strvec_pushf(data->alternates, "%s/objects", ref_git);
>  	}
>
>  	strbuf_release(&err);
> @@ -218,14 +220,20 @@ static void copy_alternates(struct strbuf *src, const char *src_repo)
>  	fclose(in);
>  }
>
> -static void setup_reference(void)
> +static void collect_alternates(struct strvec *alternates)
>  {
> -	int required = 1;
> -	for_each_string_list(&option_required_reference,
> -			     add_one_reference, &required);
> -	required = 0;
> -	for_each_string_list(&option_optional_reference,
> -			     add_one_reference, &required);
> +	if (option_required_reference.nr || option_optional_reference.nr) {
> +		struct add_one_alternate_data data = {
> +			.alternates = alternates,
> +			.required = 1,
> +		};
> +
> +		for_each_string_list(&option_required_reference,
> +				     add_one_alternate, &data);
> +		data.required = 0;
> +		for_each_string_list(&option_optional_reference,
> +				     add_one_alternate, &data);
> +	}

Nit: might be nicer to read

     if (!option_required_reference.nr && !option_optional_reference.nr)
        return;

The rest of it doesn't have to be in the `if` block.

>  }
>
>  static void mkdir_if_missing(const char *pathname, mode_t mode)
> @@ -999,6 +1007,7 @@ int cmd_clone(int argc,
>  			   N_("uri"), N_("a URI for downloading bundles before fetching from origin remote")),
>  		OPT_END()
>  	};
> +	struct strvec alternates = STRVEC_INIT;
>
>  	const char * const builtin_clone_usage[] = {
>  		N_("git clone [<options>] [--] <repo> [<dir>]"),
> @@ -1339,8 +1348,10 @@ int cmd_clone(int argc,
>  		warning(_("--local is ignored"));
>
>  	create_object_database(the_repository);
> -	if (option_required_reference.nr || option_optional_reference.nr)
> -		setup_reference();
> +	collect_alternates(&alternates);
> +
> +	for (size_t i = 0; i < alternates.nr; i++)
> +		odb_add_to_alternates_file(the_repository->objects, alternates.v[i]);
>

So now adding the alternates is moved out of `collect_alternates()`.
Nit: might be nice to mention this in the commit message.

>  	transport = transport_get(remote, path ? path : remote->url.v[0]);
>  	transport_set_verbosity(transport, option_verbosity, option_progress);
> @@ -1638,6 +1649,7 @@ int cmd_clone(int argc,
>  	string_list_clear(&option_not, 0);
>  	string_list_clear(&option_config, 0);
>  	string_list_clear(&server_options, 0);
> +	strvec_clear(&alternates);
>
>  	free(remote_name);
>  	strbuf_release(&reflog_msg);
>
> --
> 2.55.0.1074.ge7621b4bad.dirty

--0000000000009cb9b7065b1db7bc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: e4dbfd40260c6867_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1xaWVsb1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mLzQ4REFDaU5EUUthRkN2YnNwRFY1dEY2MXcrQXdrTgo0Zmsrb2YzSURu
ek9VVnpyYUZDVzJ5bnE2eDVBQ1Q2OVR1S29jdG9hQUxOVWUrY2hNWEVFS1EyNEJqUnp1a0d6Cm9m
Yk0xOUZzNWJIM0N0NWt2RjJ2U3E5V3VSVE9WS3YxTnR5aWZtYWVqL1Y0ZzJFejdLdllLYTdWdWtL
cFMxNHIKWmxwb09xYVQxYjZqeDhmVnBXUWtzaUV0SW1YTGlvaW56M0xiaDhkSWt3ZGx3TXBkUm1n
UUU3ZHJFTU14ZXNMOQpGeHBvdnBQRUlHRE1CT1R6SmkwQ0JkczZQbmNIUlVvWkJWbW1tclY5eTIz
anZLbTQ2Q3JGY2wrMjhJemw3bjFCCkhzOGpBMmNrVXpnVmY1eWRyUWVaVHA2SE5acS9NSjg2dFIz
T2hWbFUxUmY5MVJKRENCTk9KaFVMMUZDWUF0Nk8KWkVLR0NhMHRGMmZNbFFreEdsNHpzVHFrYXRl
MHJWd3padzRBajIxVUZUcGtod1UyNlVKUkRUNXYxV1dTMjI3Ngo5b1M3RVpDWmtMa0JGaWx0T2ZK
ZTA2V0JIMmhlWmRTVkdqWWxZbVRnTGdzQVp6R1UvNkNKckxMdWszRUVER3hvCkdSdXBjMVhVRmc1
OUUxaTJQT3FLRmZiblo2cktZSk9yU3NaQUthND0KPTJRcjcKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000009cb9b7065b1db7bc--
