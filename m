Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 677F9334C28
	for <git@vger.kernel.org>; Wed, 25 Mar 2026 18:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774464263; cv=pass; b=M73SmSfSVNAcxjkKMlByRqKJhu16VaeLSGLbKqZVA1Q2WKBwCeX6FL3zUYpGrtgYai0du7BxInNyeKiVpAojHm7dg4IBRiXhU7+nWi0F04umC1KmLK1dD9fG7/Bwzi7Ro8Zif0tD8VTY8blpmcdfGU+lKbCHHHuQ9H/AZ2Lfvj0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774464263; c=relaxed/simple;
	bh=uOmW4OFDIPRT2P0aT/Qdz3qBc+g0ezJ0rh7OiXixjUQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=f9gyDLZTQrS4e6WAp+9OAftmUFDvdzR/s/vhibWyrdifwKQvTrUjvu1Ce0+R3SPVrOvMYJ+Ih2oc1t2Idg8rJS4h4q0l1RaUKmQ9LpxgCi22HhjoQeTG6cZ8BwPgIFXa0vTd5WHcevS8xVY8XE6srq/hhASYYzdlHLTsRp8sE8w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=Rb3sTfNj; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="Rb3sTfNj"
ARC-Seal: i=1; a=rsa-sha256; t=1774464244; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=BkKIZF0nUk4jwmCyO9mL1uZ+JO2HQfH38iT7ERRMdHGDojG2+6kPKw0+oUbadyK1C9xcwxr/2HJJ5CSPsgBWTo8aGcDIzd/n8q6ib2OFqSUVZWK72/EIJE5Am0lBHdSnDl66mdq6cJ4dhRfKQFn8rEWjdV5IaY3x13nISLPuuKA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1774464244; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=WIQ4uICnAgYPOg/ByI7Min10Z9DBknZOrRJ1DVYRU1Q=; 
	b=Lefxn8i3Kx2skAIfR4SnnKMz8GTYOIanqSxl10wg8JVFKqmpIKXRaw41EMNGPXTHJaLQoxKN0iDemSRoH+a/wiLUX0+EGEWoHZqCWE+hW/z4RtmCjHCCE3iNAEGN34+EjR0SedAY2lf2dBt7KWqVjrWgkkX/JpzKWQweIQWCSdU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1774464244;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:In-Reply-To:References:Date:Date:Message-ID:MIME-Version:Content-Type:Message-Id:Reply-To;
	bh=WIQ4uICnAgYPOg/ByI7Min10Z9DBknZOrRJ1DVYRU1Q=;
	b=Rb3sTfNj8SnnVqjGdE9izc0Ihan8EXDi/jZzXbVwMTSYvtItlQ/EWFs9eXgm2mdv
	WVRk+nA75XVarQYEWU/3nTUOq4LjPaocfhTg1E+Fhlz9nDnWd7a+9QUrdTp8YhTocT1
	5WM4hDaYbZ5zolckH6hRWHN8qG5Gqn5Rq2df6Myg=
Received: by mx.zohomail.com with SMTPS id 1774464243007252.97616298935577;
	Wed, 25 Mar 2026 11:44:03 -0700 (PDT)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>, Emily Shaffer
 <emilyshaffer@google.com>, Junio C Hamano <gitster@pobox.com>, Josh
 Steadmon <steadmon@google.com>, Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>, "brian m . carlson"
 <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v4 9/9] hook: add hook.<event>.enabled switch
In-Reply-To: <acJUfVjby_QyZvj1@pks.im>
References: <20260204173328.1601807-1-adrian.ratiu@collabora.com>
 <20260320135311.331463-1-adrian.ratiu@collabora.com>
 <20260320135311.331463-10-adrian.ratiu@collabora.com>
 <acJUfVjby_QyZvj1@pks.im>
Date: Wed, 25 Mar 2026 20:43:58 +0200
Message-ID: <87mrzvda1d.fsf@gentoo.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ZohoMailClient: External

On Tue, 24 Mar 2026, Patrick Steinhardt <ps@pks.im> wrote:
> On Fri, Mar 20, 2026 at 03:53:11PM +0200, Adrian Ratiu wrote:
>> Add a hook.<event>.enabled config key that disables all hooks for
>> a given event, when set to false, acting as a high-level switch
>> above the existing per-hook hook.<friendly-name>.enabled.
>> 
>> Event-disabled hooks are shown in "git hook list" with an
>> "event-disabled" tab-separated prefix before the name:
>> 
>> $ git hook list test-hook
>> event-disabled  hook-1
>> event-disabled  hook-2
>> 
>> With --show-scope:
>> 
>> $ git hook list --show-scope test-hook
>> local   event-disabled  hook-1
>> 
>> When a hook is both per-hook disabled and event-disabled, only
>> "event-disabled" is shown: the event-level switch is the more
>> relevant piece of information, and the per-hook "disabled" status
>> will surface once the event is re-enabled.
>> 
>> Reuses is_friendly_name() from the previous commit to distinguish
>> event names from friendly-names when processing .enabled settings.
>
> I think having this makes sense in general. But what about the case
> where I have configured a hook where the friendly name matches the event
> name? Is that now forbidden, or would such a hook silently also disable
> all the other hooks?

In this current patch, if (friendly-name == event-name), then
hook.*.enabled = false only disables that one hook and there's no way to
disable the entire event... (see below)

>> diff --git a/Documentation/config/hook.adoc b/Documentation/config/hook.adoc
>> index d4fa29d936..0a9f04b154 100644
>> --- a/Documentation/config/hook.adoc
>> +++ b/Documentation/config/hook.adoc
>> @@ -33,6 +33,18 @@ hook.<friendly-name>.parallel::
>>  	found in the hooks directory do not need to, and run in parallel when
>>  	the effective job count is greater than 1. See linkgit:git-hook[1].
>>  
>> +hook.<event>.enabled::
>> +	Switch to enable or disable all hooks for the `<event>` hook event.
>> +	When set to `false`, no hooks fire for that event, regardless of any
>> +	per-hook `hook.<friendly-name>.enabled` settings. Defaults to `true`.
>> +	See linkgit:git-hook[1].
>> ++
>> +Note on naming: `<event>` must be the event name (e.g. `pre-commit`),
>> +not a hook friendly-name. A name that also carries `.command`, `.event`,
>> +or `.parallel` is treated as a friendly-name and its `.enabled` value
>> +applies only to that individual hook. See `hook.<friendly-name>.enabled`
>> +above.
>
> Ah, okay, so you've thought about that already. I wonder whether this
> behaviour is okay in general or whether it is going to be confusing. An
> alternative would be to disallow configuring hooks where the event name
> matches the friendly name, which would fix the ambiguity that we now
> have.

... It is rather confusing, yes.

I think disallowing the collision, as you suggested, is the better
approach, so I will do this in v5.

I think it can be done at parse time and rather easy to check because
we have hook.<name>.event = <value>, where name == value results in a
collision.

Or even simpler: reject if name is in hook_name_list! I already
implemented this check for the `--allow-unknown-hook-name` arg you
suggested in the other "cleanup" series.

Many thanks as always, your careful feedback is very valuable,
Adrian
