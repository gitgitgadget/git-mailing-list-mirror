Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A2A339857
	for <git@vger.kernel.org>; Fri, 16 Jan 2026 17:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768586223; cv=none; b=nhRdGcZW9cJyitVf75ac/N5X+L5gvgyBbeTyeWpvzBnz6RXOzh/w2dabnXVVP1q93O11fbMyGUCpvoCVqKwnYKDOF+LT+lBj6VrNSURKFcz3hc7+aa6DfAwvR2jRmPzkQiFGtqrMhPtmhPMSBcwlegYiCYmrmOsk6qk3M5rgFIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768586223; c=relaxed/simple;
	bh=ioowF2L+ReN0yNgraQwUyzLgSkIa9M6wvQP6iZAG2RA=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UEv1YPNDXHUNDLqstZpNgE79mwvWif3RbhJs8EqBCpsHTwAb+yLhCoepBBbnXYvBz3X0RXmgivaVsfGSDRp77kdzEVGfcjklpsJu19SajcMBZmX23VBt0ZcrSKnfPh4GoeSA9qmaU27fF1AYq4VUZQ/LqmWDIWBKEAWrLUsb3lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SJZ5ZzQh; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SJZ5ZzQh"
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-5634feea416so1666578e0c.2
        for <git@vger.kernel.org>; Fri, 16 Jan 2026 09:57:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768586221; x=1769191021; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=AH9OvxEXkZQnU9Bk31tidadXuvtO5jnBrZ2cApdg9JA=;
        b=SJZ5ZzQhSn+LVEXp5Yt0TQ7/l8MXX+q33gUA8HKPu4SpfMpnkItKaO6W5KaZMgqHRS
         o4bhM94PsPPjODfP95ifyJwWOw6LJ/FNqAeeyLk9jv+40l+TxAWv/BK3GAAiwh7qAavR
         e0kH+zXQXLiqRznS59CAFndvCAxPtRHGixXdLjwW83EifXn3O8WJkI4xZnjEQAjl/cKa
         5i8Um6JqTF1ncuyHcMRoJjZe7jt9UHsoHxmD96GHzqdBFsMYtvr6F7eCJEDcjMJb4yxy
         r1lIKWSBJTvgCP97XF19Dl3682EG2qNweMGMlP60GGDjZvFCtbSamw4fEx6WVL2l/wS1
         anKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768586221; x=1769191021;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AH9OvxEXkZQnU9Bk31tidadXuvtO5jnBrZ2cApdg9JA=;
        b=Zg5zmUdGbycaw4sEUtwHqhFgoRw0IP0MiGQl9+nFCixRejOylTNkGrc7aINya3cAQe
         az+YhT35X723qZ3oTT8RyCBQQzRatabkv6TxOU6l9gST76C7TJLaMkrWE9ThIZO+zzZx
         JvWZ9iICjvDtNSxfEMi3HO2A0dDxv/MttmFQ8rT5ynf4d6eC5DOmirw9v1IzHfPsGzph
         cC0h5MQpX6+5EDBl0tZEqXPbCqk0pzbTY5BBhTvmH+g93XGvyILQKLGXd0WmJ6MwYPdD
         iWD+xC4C/69+Z5FpItvf59rUWVrBdIYEolqc6TFYeoUMrySVM4q1ynG6D67fcJnMFRKq
         l1IA==
X-Gm-Message-State: AOJu0YygCwfN3UBZjTHSmSqlKyi1eCyNXftf/saskBZTvEdpOVmB37yu
	XXaHLwhFo9V5U8lvxGfSDNsycG/wjEsMt3HrlMUzW0xoiJ0Hnbq5GPjr7MNlsIkNnqxE1a83AwA
	b0KSpBy8F9ZKznQow9ZKXgZg1kk08iB0=
X-Gm-Gg: AY/fxX7YvpdYtGPnOO6xqAC9h4quGgS7vwZOOy91IxrIKWRJijGS1QPJv2RnpM/tHng
	tjf4YwWc6vV5FxzPNic2xmyIDrD7VbLFI5jrK4NgrEOkpoc35d2QFI8teg4Mty99gwzBXyvyNbd
	ru5vY0oqDX5FkHnsfGtysOLLIQbT8bHmOYyb9oaEkER0k+tjbqihpOyaf05SLThPfh2ULP7xB9G
	+UkyhcE0KSe+B/ztcoSAq2P3FJR9kTTMeRdMv+MQKbL6OWYRr8BpsYdWTbfaO4+4f3voZ/rVQWl
	Qx/8bLBNgWh/rypuRThnqHTmPvmvUQ==
X-Received: by 2002:a05:6122:311c:b0:55a:63c3:f7a7 with SMTP id
 71dfb90a1353d-563b5c865eemr1256050e0c.14.1768586220803; Fri, 16 Jan 2026
 09:57:00 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 16 Jan 2026 09:56:59 -0800
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 16 Jan 2026 09:56:59 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260115202929.GC1053259@coredump.intra.peff.net>
References: <20260114-633-regression-lost-diagnostic-message-when-pushing-non-commit-objects-to-refs-heads-v1-0-f5f8b173c501@gmail.com>
 <20260114-633-regression-lost-diagnostic-message-when-pushing-non-commit-objects-to-refs-heads-v1-2-f5f8b173c501@gmail.com>
 <20260114174338.GE885771@coredump.intra.peff.net> <CAOLa=ZSyfkb8oe=ZtkOcsGo9Dk44GZSFiaye3Vw2kDs_XqS8=Q@mail.gmail.com>
 <20260115202929.GC1053259@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 16 Jan 2026 09:56:59 -0800
X-Gm-Features: AZwV_QjVIjh_BEbqQZT3eHLl24wDVUvRkR9x-98Gzyd80JY7riQwq1rCVCNLtXc
Message-ID: <CAOLa=ZRbYBJaoFV7eWPsMGhVjqMDj+5-KMcAUPzM6fyXwp3qtg@mail.gmail.com>
Subject: Re: [PATCH 2/6] refs: attach rejection details to updates
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, newren@gmail.com
Content-Type: multipart/mixed; boundary="000000000000723658064885114b"

--000000000000723658064885114b
Content-Type: text/plain; charset="UTF-8"

Jeff King <peff@peff.net> writes:

> On Thu, Jan 15, 2026 at 02:02:15AM -0800, Karthik Nayak wrote:
>
>> >> +	if (details)
>> >> +		transaction->updates[update_idx]->rejection_details = xstrdup(details);
>> >
>> > I guess this could use xstrdup_or_null(), but probably doesn't matter
>> > much either way. I do wonder if anybody actually passes a NULL value. I
>> > think in my hacky patch there were some spots that did, but here you're
>> > always setting the "err" buf (which is good, as we'll always have
>> > details then).
>>
>> That's correct, I did ensure that there were no NULLs passed through, we
>> could definitely drop the check. But I was being defensive. I think
>> `xstrdup_or_null()` is the better option here.
>
> I don't mind the extra defensiveness here, but I was wondering whether
> this would also mean that ref_transaction_for_each_rejected_update_fn
> callbacks could assume that "details" is always non-NULL. But maybe it
> is better to be defensive there, too.
>

Since I've moved to passing in the strbuf instead of the 'char *', this
is now removed!

>> > I notice that you "goto next" now instead of "continue". So I was
>> > curious what happens in "next" now, but...
>> >
>> >> +next:;
>> >>  	}
>> >
>> > ...the answer is nothing. ;) I guess maybe you were going to
>> > strbuf_reset() down here at one point? If the 'next' label remains
>> > empty, I think I'd prefer to keep these as 'continue'. But maybe you use
>> > it later in the series. I'll read on.
>>
>> I should have explained this, there are two loops here in play. An outer
>> loop going through refnames to check availability for. An inner loop to
>> breakdown the path of each refname to check for path conflicts.
>>
>> With continue, we'd skip the inner loop, but would still perform other
>> checks for the refname, this can lead to error details being overridden.
>> So while we could replace s/goto next/continue for the code in the outer
>> loop, it would still be needed for the inner loop.
>
> Ah, thanks, I totally missed that it was jumping to the outer loop.
>
> It's curious that the original did a "continue" from that inner loop,
> rather than a "break". Once we see that "refs/heads/foo" is a conflict
> for a particular update and mark it as failed, there is no point in
> looking at "refs/heads/foo/bar" at all. So I suspect we were wasting
> a tiny bit of processing in this error case before, but never doing the
> wrong thing.
>

With the previous situation of not resetting strbuf after rejecting an
update, we ended up adding more errors to the same strbuf and since we
kept rejecting the same reference again and again, this causes the last
rejection with multiple messages appended to the strbuf to be displayed
to the user.

This is moot now, considering we reset the strbuf, but that's how I
noticed it.

> Likewise, if we did "break" from the loop, shouldn't we "continue" to
> the next ref immediately? There is no need to do further checks.
>
> Your new goto solves both of those; it's just subtle. So two possible
> suggestions for making this more clear:
>

Yes, I agree with it not being explicit.

>   - if we are going to use a label, call it next_ref or something, to
>     make it clear we are jumping to the outer loop over the refs.
>

This is a good suggestion, makes it much nicer to comprehend.

>   - switch to the goto as a preparatory patch. It's the right thing even
>     before changing the "err" handling, and the change will be more
>     obvious that way.
>

This is a fair point too, I'll do this.

> There is another way of writing it, which is to break out of the inner
> loop, and then notice that we did so. Either with an explicit flag, or
> in this case we can do it by checking slash. Like this:
>

This is an interesting approach, but it is very a bit harder to read in
my opinion since the final logic is collation of 'break' + 'continue if
slash'.

> diff --git a/refs.c b/refs.c
> index 965b232a06..a3dafdb58b 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -2663,7 +2663,7 @@ enum ref_transaction_error refs_verify_refnames_available(struct ref_store *refs
>  					    REF_TRANSACTION_ERROR_NAME_CONFLICT)) {
>  					strset_remove(&dirnames, dirname.buf);
>  					strset_add(&conflicting_dirnames, dirname.buf);
> -					continue;
> +					break;
>  				}
>
>  				strbuf_addf(err, _("'%s' exists; cannot create '%s'"),
> @@ -2676,7 +2676,7 @@ enum ref_transaction_error refs_verify_refnames_available(struct ref_store *refs
>  					    transaction, *update_idx,
>  					    REF_TRANSACTION_ERROR_NAME_CONFLICT)) {
>  					strset_remove(&dirnames, dirname.buf);
> -					continue;
> +					break;
>  				}
>
>  				strbuf_addf(err, _("cannot process '%s' and '%s' at the same time"),
> @@ -2685,6 +2685,13 @@ enum ref_transaction_error refs_verify_refnames_available(struct ref_store *refs
>  			}
>  		}
>
> +		/*
> +		 * We didn't finish our loop over the components, which means
> +		 * we hit a conflict. Bail to the next ref now.
> +		 */
> +		if (slash)
> +			continue;
> +
>  		/*
>  		 * We are at the leaf of our refname (e.g., "refs/foo/bar").
>  		 * There is no point in searching for a reference with that
>
>
> That's more "structured" in that we avoid the goto. But I'm not sure it
> is any easier to understand than a "next_ref" label. So I'm happy with
> either approach. ;)
>
> -Peff

I think the 'next_ref' approach with a separate commit chalked out for
it, seems like the best approach. Thanks

--000000000000723658064885114b
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: e00a33ae3bb52911_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1scWUra1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNW1nREFDS29ldlUxc0kzZUhDRHBBazd0ZEpXSzd3SQoxR2FhTWF4ZTRC
L0xySkVEZjJ6SmIrSUFaU1NKTXh4VGxaSk5FY01SdkdyZVFaMUpUdytMM3grS0o5ZlVDL2hoCjli
bWdYdVlGWnNac01qc0JacmxDbFBGMXBUNVJzeWFjQ2Y2T2J3a2ZtNUg0dGVET3hjM2U1c2F0elVT
Rk13Z28KVUxnUmgvUTBkcjNpaENUSnhjS3NRdU56TzhNbklFcHZCUUljWHZQakErcUZjYi95cndp
aS94N3cvSkNxSm91UgpFWXAwQm9yU2c3VkdicEJIdHdPNnA2bzdPR1Rxc0J4Z1pYQ3E3WUhRSlYx
L2g0MlpmMWZydmRPZVNROERYUVJtCi9hTVdEWlRHVVBtSWsxN0VvOVVlWG04TXQ4N0Z4LzVnNzU3
WmwyVzJRTVRiOERVUTVqZGJMcHF4ZjRwTHJUdWsKVm9BeURCS25ReEwwYVpMTlJXR2orRWkvaTJ1
WjEyZ2ZqSFBveVpYdlg1alk4T3RKbDhoTWtqVEQxZkljLzYraApHdnRBQTU5RWxpejAwaDVZcFZY
ZlBrL1l4MENuVGh5UzV3UmdDQ1djVkFaYm5zMkhFd3FsaGgwdUFJSEN0RW5hCnplWjlqYk95VGFM
S2lteGIzRW5LVHdvcGQ4YWpZbEo1QnlFd1NlND0KPUFvK3YKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000723658064885114b--
