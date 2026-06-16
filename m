Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9DC6305680
	for <git@vger.kernel.org>; Tue, 16 Jun 2026 21:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781645482; cv=none; b=fRlxD1iQi2rO/V3al1HGubN637XYXe/cHsG1V4EZxHD2mQCDkzlSk4buiEj1jDNW1yshf2juvCJoZcT8iwbjlaRboBebEGPm4R8CgC81AeomUmDv7pOP/EoVgu3Cxd07giFKFPe+ZWOK8TorbYQ3eXPW7l4KKxLOLkYQy/51rFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781645482; c=relaxed/simple;
	bh=zn2jYVGF39XynkfC5d9ZHAvJ9EpiZz+fJzWTkVIKk3c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ATb2PqvC8AdKEW0VE2m7M4koFqUeFb31Mq3da5RlJbecdv/+SvjzJA2vee2OrMR065lC+bNGFGY9fP/dK5RVngXjTzY7XpcixHvF/XrYAMserzfriKmhmQ+UVFWGtOVxoccM/loHwpDQOGbHWn9h26zAgBri9XHiLb5XG1whlbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=GfU1iwBy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eqM2PPp3; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="GfU1iwBy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eqM2PPp3"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 25276140017B;
	Tue, 16 Jun 2026 17:31:20 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Tue, 16 Jun 2026 17:31:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1781645480; x=1781731880; bh=8pDLEOL4xL
	s9gXiKEqKXK7EPKPYE5Ye9JqrwBguyQK0=; b=GfU1iwBy/xOg/qqKbZ0cT1AqRO
	vh40WlnbEGjwYd+M7EO9glAitS5upu5vvZMoAJecLNh4KYChhKcPM0WaVDrBo7c0
	M0+v3Lc+ETyhFl1Pu+edEN6OH8eJsaWVmAbK5j3m5FRatKl5sNDr6tQM6879wErY
	UgW8xm5WQ4ieqz0LLghv2fT85z/wxa70v4OQ+UQN8QEz2aJ9Gz796Z4kuhy6fCJo
	T7UAX98DqBqN9XYL4ovU53m8o8w90smOCFjSFy08bjaLI9y2XKxfMZ8cTfhBKMnH
	/f3iy0DFDPgLiSMsir7A8KUMefmUSPji8fAprqL8cjhF0YeCYbj9py15qhMw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781645480; x=1781731880; bh=8pDLEOL4xLs9gXiKEqKXK7EPKPYE5Ye9Jqr
	wBguyQK0=; b=eqM2PPp3qhZdWRyNavMPDQZyfTZrRXDlG0KU0c3M//rbDddYubP
	ZDoVVRfk7z85a0+bStnqXgKJit/c/VyMvim7l1DonKE/nvHrOgdQf9nXKNEwN2iI
	upXYfDk8NMnnlAfJHFkPmGcW1qsMUKgqR09a6bkK3XbSmBltrC21qeXTcCzHf1Fl
	WxKh1pL9g7U7dvdQDIUmcpyEOcx1dcxpeqtWnB/RQTpLd0C+SujLhlvvuD+33G+F
	XXfWfSqtj/Y59c/untK84YHhWOsPzXARz3mp3kJeAeRHWV9GgUHKelJEyZHX5t+H
	MVHRhGCs5YrQqehxOP56SrbXQrG3Vgo30HQ==
X-ME-Sender: <xms:p8Axamg_ola_vHLsRr94rtPCNf-hFH8cYXICZz6Ra_escVPlz1goTQ>
    <xme:p8AxaplPoH42TpIxpvY6oUNdsdYUEmYdvpkBKsPe0WnW_eVjitG8OGVv-nlHPIW9F
    BzaHDw6jy44Sc89w0aH_UR8Pc6Zz6wPderJc60QvRgTv6y9d7wQ>
X-ME-Received: <xmr:p8Axahsv74dXXSLX3x-tJN_u6ZiNYAXGKOH2Apdk8p4kiRcwznsRcXQK89-5OYLS_8diF5GUlYCC42lC4C8dT8oZRk3XMJlo73dp>
X-ME-Proxy-Cause: dmFkZTGsGZTJFr0iKVSKaunwnkK5wchh8nWTUSfUVG2RwaGHZBeJ3RSM2rUvOaErTBVGTE
    b3J5jIpWbTWMa1+CBFRtzxgXF27F30Fg3jGEDIxJIN9zT02bOS1I3HjQnLGOMc1odL8RFA
    7z88dCqMtEOHJx1MJaSRnV2cvp+vT7PpqC9TyvlZGLu4NQDT1PZA3QBqgQU8cI5lAH24OX
    tMC210RpJD4IfJkq0P+EV83LgmObMh+HZ9uMurT+j88iNkwq5pb1XTbVhfVyxbCamvdPNK
    /lBrCfDVo7kegpqLhaHKRn4zV5kduxcA7/cWBjLkO1rdsr4w5OVgtP+8oQ0Y8DSuKwh4BC
    ObTXsx0/7uaRMLEJsATVeGhEQm3kMbo9rec/ngo0fp8cBe6ZHNVu63EWZ+v2JGHQVFC3CT
    mzrLBfrdBKk3SErjgewJm2vXKDoWd7XEy929oxCdSxW6j7582ucwObsTKVGv5NIXeHf0E0
    Adj3SNZJVrFX1DJi9LuqXZNLtBkbyjbT4TC8mVxnJ9jNb/hmAfuR70W2MyzW9tDZrMJtgB
    VuPNgH3ui9COcrRGu5vnQIqkHSG4F3BzJtIlHBnDpFGl16NgiheEPk8TI1GqNhT0M6KEqU
    ZjOgkGHUgcPMX1kdoNeM2p0CTNjeyysvGYsi2e5yj8Rdv7/eXDg2YXIPcdKA
X-ME-Proxy: <xmx:p8AxavYFmqliZ-Qq03BNytl7xCm_KVW04eg9v4rBbkzFjsH7KhInuQ>
    <xmx:p8AxapC9N-yz1_UmQPWL2yoIFCNkoXoWX8VVZegWWj_7Y9kGVxSJ3A>
    <xmx:p8Axan_MbFp6tWvXgqTMLMJCNyltExPfef1W8chb0f4Tc5CNz8N7YQ>
    <xmx:p8AxalQoKLD3tA03hItLP7lB8wd1kh5jWBAsgbu9R3i1MOMQ2vukxg>
    <xmx:qMAxaseffaYUPG7UQUoK0OpVUBg0U-7GC2mOnqwS-GpcdpZDyT9jEXZh>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 16 Jun 2026 17:31:19 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Pablo Sabater <pabloosabaterr@gmail.com>
Cc: eric.peijian@gmail.com,  chriscool@tuxfamily.org,  git@vger.kernel.org,
  jltobler@gmail.com,  karthik.188@gmail.com,  toon@iotcl.com,
  chandrapratap3519@gmail.com
Subject: Re: [PATCH GSoC RFC v12 09/12] transport: add client support for
 object-info
In-Reply-To: <xmqq1pe62pgo.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
	16 Jun 2026 13:35:35 -0700")
References: <20250221190451.12536-1-eric.peijian@gmail.com>
	<20260608-ps-eric-work-rebase-v12-0-5338b766e658@gmail.com>
	<20260608-ps-eric-work-rebase-v12-9-5338b766e658@gmail.com>
	<xmqq1pe62pgo.fsf@gitster.g>
Date: Tue, 16 Jun 2026 14:31:17 -0700
Message-ID: <xmqqse6m18be.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> Pablo Sabater <pabloosabaterr@gmail.com> writes:
>
> [jc: removed recipients from Cc: list whose addresses bounce]
>
>> From: Calvin Wan <calvinwan@google.com>
>>
>> Sometimes, it is beneficial to retrieve information about an object
>> without downloading it entirely. The server-side logic for this
>> functionality was implemented in commit "a2ba162cda (object-info:
>> ...
>> diff --git a/fetch-object-info.c b/fetch-object-info.c
>> ...
>> +int fetch_object_info(const enum protocol_version version, struct object_info_args *args,
>> +		      struct packet_reader *reader, struct object_info *object_info_data,
>> +		      const int stateless_rpc, const int fd_out)
>> +{
>> ...
>> +	for (size_t i = 0; packet_reader_read(reader) == PACKET_READ_NORMAL && i < args->oids->nr; i++) {
>> +		struct string_list object_info_values = STRING_LIST_INIT_DUP;
>> +
>> +		string_list_split(&object_info_values, reader->line, " ", -1);
>> +		if (0 <= size_index) {
>> +			if (!strcmp(object_info_values.items[1 + size_index].string, ""))
>> +				die("object-info: server does not recognize object %s",
>> +				    object_info_values.items[0].string);
>> +
>> +			if (strtoul_ul(object_info_values.items[1 + size_index].string, 10, object_info_data[i].sizep))
>
>
> Overly long lines need to be fixed, by using a shorter and crisper
> variable name in such a short scope, and line wrapping if needed.
>
> More importantly, on this line (wrapped):
>
> 			if (strtoul_ul(object_info_values.items[1 + size_index].string,
> 				       10, object_info_data[i].sizep))
>
> we notice object_info_data[i] is of type "struct object_info", which
> is 
>
>     struct object_info {
>             /* Request */
>             enum object_type *typep;
>             size_t *sizep;
>             off_t *disk_sizep;
> 	    ...
>
> but the last parameter strtoul_ul() takes is unsurprisingly a
> pointer to "unsigned long", not a pointer to "size_t".
>
> Which will break on 32-bit boxes where size_t is "unsigned int"
> that is 32-bit and different from "unsigned long".
>
> Perhaps something along this line?


Not quite.  This "size_t *sizep" has been very recently introduced
by Dscho in a topic that is in-flight.

The ps/cat-file-remote-object-info topic alone does not have this
type-mismatch problem.  Below needs to be addressed as an evil merge
at the integration side, so you have nothing to do.  I'll have to
tweak the merges.

Sorry for a false alarm.



> diff --git a/fetch-object-info.c b/fetch-object-info.c
> index 425929a269..5210e7d954 100644
> --- a/fetch-object-info.c
> +++ b/fetch-object-info.c
> @@ -75,14 +75,17 @@ int fetch_object_info(const enum protocol_version version, struct object_info_ar
>  
>  		string_list_split(&object_info_values, reader->line, " ", -1);
>  		if (0 <= size_index) {
> +			unsigned long sz;
>  			if (!strcmp(object_info_values.items[1 + size_index].string, ""))
>  				die("object-info: server does not recognize object %s",
>  				    object_info_values.items[0].string);
>  
> -			if (strtoul_ul(object_info_values.items[1 + size_index].string, 10, object_info_data[i].sizep))
> +			if (strtoul_ul(object_info_values.items[1 + size_index].string,
> +				       10, &sz))
>  				die("object-info: ref %s has invalid size %s",
>  				    object_info_values.items[0].string,
>  				    object_info_values.items[1 + size_index].string);
> +			*object_info_data[i].sizep = sz;
>  		}
>  
>  		string_list_clear(&object_info_values, 0);
