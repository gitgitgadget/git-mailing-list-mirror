Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3A61DF74F
	for <git@vger.kernel.org>; Wed, 11 Mar 2026 11:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773229698; cv=pass; b=Wx/cnOSoby8ELYf8A1mJ+Uejt/hPEcYE1sw/TnMKgZu3/jF6wxg1a19O5qK/8BuV3MYsXthGT0Ydee7vaiRNVkoEhkg+cfpi3rD0T6o1xCCDNlfY741mvLb8f08uRKfvyw/7HGxPbj1ct0LI44YUwGn4IlYRZomBhtSzOs8Scgg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773229698; c=relaxed/simple;
	bh=jxxZYMFzay4URyKeNzYEZYTzZJux/SQ4R1LuYAn7oq0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=u1T87VUEQ7H88YiGYAh+zA1C/zjI9eY1Wk3d7fquqg6k2DhfauSFzgha3icQtf+JjOrP9+0lnoipao8JJ1nw7HavwE59pJrAPsQmuHhumX36qA0UAg8t+piRliwGZodUQ9VJp/MG0leC0wWX5zoT+9SOyqSAp0GDPY5H9rr5AnA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=FgWsDHFh; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="FgWsDHFh"
ARC-Seal: i=1; a=rsa-sha256; t=1773229684; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=DH/dlUmOdeP/w5ef/AZvXh9yFpSG5eRqXUoLDOtx4p3IGLJNw+YHHOsLGu8N7R6tta/TQunfw8cQq5/jBzha32lYHlJKsruPMwXVbKE4j4iXEptRZ3JmEPDmhIeElhQHU02j0tgbOp5Qthk1b2+wP+Il1oR2F4PtuYu+ii6v8Ek=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1773229684; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=zMq2+iK+TMFpOXv/NWqKXlC7QUZAAWbInc76fX8OBM0=; 
	b=SS8Tbg5i+WBrVvtbYgyPVWhc7GiFxGWzPiPptZdX6H2KKHu25DeXpL5I0FB8k21uIut1OvX9DdzxVOmJ8ELJjMeV8sLCv+1yj4bXxyFMtK7jtpPpAEhzO58OkrBiDKBKx4MYid2nIqdf0TyPYnRUbSxCDTKefWLh72KipOEcuZg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773229684;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:In-Reply-To:References:Date:Date:Message-ID:MIME-Version:Content-Type:Message-Id:Reply-To;
	bh=zMq2+iK+TMFpOXv/NWqKXlC7QUZAAWbInc76fX8OBM0=;
	b=FgWsDHFhqhmDnSngb3GwpRAQfLPMspPux0lhYX91Yi1+4KCwvkhjsTJ2Q2tbxlgQ
	e1kwqifTUrCeHv98CaDNYVrD6ckTFE1wqJY/lfSXy4DlrPhM5CrmjncccV+EAF4NrWL
	cm/oUiPsx8tFZ4tz6NwI70WRFuj3gece6uZBLTmU=
Received: by mx.zohomail.com with SMTPS id 1773229681875167.59584514925905;
	Wed, 11 Mar 2026 04:48:01 -0700 (PDT)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>, Junio C
 Hamano <gitster@pobox.com>, "brian m . carlson"
 <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 09/10] hook: show config scope in git hook list
In-Reply-To: <abFC4uLP-JwDoKde@pks.im>
References: <20260309005416.2760030-1-adrian.ratiu@collabora.com>
 <20260309005416.2760030-10-adrian.ratiu@collabora.com>
 <abFC4uLP-JwDoKde@pks.im>
Date: Wed, 11 Mar 2026 13:47:57 +0200
Message-ID: <87h5qma8pe.fsf@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ZohoMailClient: External

On Wed, 11 Mar 2026, Patrick Steinhardt <ps@pks.im> wrote:
> On Mon, Mar 09, 2026 at 02:54:15AM +0200, Adrian Ratiu wrote:
>> diff --git a/builtin/hook.c b/builtin/hook.c
>> index 8fc647a4de..c806640361 100644
>> --- a/builtin/hook.c
>> +++ b/builtin/hook.c
>> @@ -70,7 +73,14 @@ static int list(int argc, const char **argv, const char *prefix,
>>  			printf("%s%c", _("hook from hookdir"), line_terminator);
>>  			break;
>>  		case HOOK_CONFIGURED:
>> -			printf("%s%c", h->u.configured.friendly_name, line_terminator);
>> +			if (show_scope)
>> +				printf("%s (%s)%c",
>> +				       h->u.configured.friendly_name,
>> +				       config_scope_name(h->u.configured.scope),
>> +				       line_terminator);
>
> Are we sure that this is always unambiguous? Can the friendly name for
> example contain a space itself, or is it possible that the scope gets
> extended eventually so that parsing becomes ambiguous?

Indeed, good catch, yes, friendly-name can contain a space and the scope
can also be extended, so this is not very parseable as Junio also
pointed out in the other message.

We need to come up with something better. :)

> I'm not sure about this myself, but that may indicate that we should
> maybe also separate the name and scope with a NUL byte.

Looking closer at how git config --show-scope does it, I think we could
mirror that, i.e. print the scope as a tab separated prefix.

That would also avoid an awkward intra-line NUL separator, since NUL is
already used for line termination with -z.

I have no strong opinions on this btw and am very open to suggestions.

>> +			if (!ctx->kvi)
>> +				BUG("hook config callback called without key-value info");
>> +
>> +			/*
>> +			 * Stash the config scope in the util pointer for
>> +			 * later retrieval in build_hook_config_map(). This
>> +			 * intermediate struct is transient and never leaves
>> +			 * that function, so we pack the enum value into the
>> +			 * pointer rather than heap-allocating a wrapper.
>> +			 */
>> +			string_list_append(hooks, hook_name)->util =
>> +				(void *)(uintptr_t)ctx->kvi->scope;
>>  		}
>>  	} else if (!strcmp(subkey, "command")) {
>>  		/* Store command overwriting the old value */
>
> Okay. This is a bit ugly, but I guess it should work in practice? The
> alternative would be to allocate the scope and store the pointer here.

Yes, I just tried the simplest thing and it worked. If we need more than
just the scope, then we could heap-allocate a struct wrapper and deal
with the associated memory management complexity.
