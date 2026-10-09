Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F6D93CBE6D
	for <git@vger.kernel.org>; Fri,  9 Oct 2026 22:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791584206; cv=pass; b=nm/CRYGAR2G1mo2ATtRJ06Q7zY4kj5baD4ZcCryIk0x1+kH6+4oBDzhE8i1BesVjBHvNXwuc9pWYqw+DJr3Obnz+1tT1fj1RcrhYZrFFTSLF2O+ixaEZGzyZ0ltJuW2ce9JROy+LHku47GX1jM77n7dBLAGYNy6RYB3QL5m6wjo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791584206; c=relaxed/simple;
	bh=3tiO5IEptDbQh5QcytBsdrJM09A04XUZ/pK2mALN8SM=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=azzXD+g+C8YWG3GjYoLeSS1z6RbE+hSXNflpbWP5KFjXMWUqHyIcGxqLIR3lH58kAd+UXfNQnuak+EntLbDlgAqQdtka9LqLjHVIbVjUvXIlUUK2sFHYZYTqYsb4de5A4tnytBl9PKGsTsNXUwoepphgr4I7Fm0qWeIw8Nkxmrc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YcHn/Pw2; arc=pass smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YcHn/Pw2"
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-5e78346891fso160745e0c.1
        for <git@vger.kernel.org>; Fri, 09 Oct 2026 15:16:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791584204; cv=none;
        d=google.com; s=arc-20260327;
        b=gumQEgRGhrEWPVt7Sq1I6V+2JiNE4rEdqS0ee/W27hnp1SufL/5a4YISvCqdid02/f
         usdxXv2NTMcJvb7uBfCb3n1XkZNF3mV5m+fhgT8ev0kT2o16eVUA3CGNbOPRa7yq2IP/
         8skMDxasnAiZWOceUCaGVabGYqIFa1O89/Vh2gy/wtx6T7902H/EQPk6y6q70Bj7r8Fs
         OYgSjH4vCD+hJ+ccz2MVhyckTSLZudLaoFOso//Oso124DGkJO4AYGDLt4gf9lX0KeWi
         IhCCHESJ1R460No0v/XVk8+7TQu4vzCQ2IEsWKYB/a/mHqH2ftthrIUg27Xd86PTpfTv
         YPFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=7qYa3XZ1m9zRvy95tqytKxsWHhV7e50n6QJhFGxza7M=;
        fh=+kRAkb12Ma0Jt9TqX64HJGFo1HKzeZ9mtOnavejOXZA=;
        b=l6GQL51rxDWYV3HabwsxuYiWzNTAJDofZKFcULRBSVUcCAN+GeF314Ywh8s2muR7oq
         +bg5tw6viGov8LJ1H2GZDrOjBPpcsgMjIRrjks5tqOgNYUeKc2/Pvhrd81JkkeeFevdK
         fAGWbLB0jsSER6C9T6+4WmLeYf4pdOQ044snlremmYzpUhJBsCNMeJ/dC8ZWulmzS5Gc
         XdZgjVZDHfJeGPUAf/IF41YDkWZ0bhiL9mmfP6d5amuAGEYoPM8r8FPfWhVva1sxcIZM
         VwjPeeQydu7I2msE3oZGrzlHwU6/wJvjIfzG6nI4Ld4yp/6VjA1ovq9chBd/7sEMUGNy
         H/+w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791584204; x=1792189004; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7qYa3XZ1m9zRvy95tqytKxsWHhV7e50n6QJhFGxza7M=;
        b=YcHn/Pw2XhhymB+nzN7MeRBqKQpnL1dvFghz888F0VEUqAD3j2pEXd4RTYD27QcU9K
         8/ck9ibk0EJVeC55r1fnoKRXaut7O2io52WtLbKKIzZSwkP6ZKrR0+8YIg5znTlY5qQI
         RkgsWl46W/iaAQLKbt+OLkRDt7Bhq1aZ8A93wTZqJ1y2DUjgvfsEJnG5EEAoaJCR9hk7
         euKrxk0ojobbH9xeTRAqbCKjz+Wpv6Arp35ITzqDobe7eMF6I7iEKJnPQIZJAFaYF0mw
         go2fATWcyKqMkkClTJv+RFTvvVs7H9jlTw23NhlR4jgYalMnU50a9lXZSFTDs4KftcnR
         09+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791584204; x=1792189004;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7qYa3XZ1m9zRvy95tqytKxsWHhV7e50n6QJhFGxza7M=;
        b=zJ/H8pNyQp+SjHiW0K2SdTXPWPLI4hXd3qZPVs6J72VdOpKyrOszj1Q5dsq2xXqgvB
         F+aUEqC2vBD5UjDKLjjdJznn0nVpnFbYiUmczjrfeNSaUw+avSrNhl0xLqvG/3rcgn5m
         AZqV5ot2i19M581ACTfNI1SPN+9dEcfJwPCLlN8xlJxeQuHT+bJBehMZycMhiHkJ26ge
         VhnLLrA5yy69QjEVLeztiE0SlmBmqIELdo1CKtSoLico98pTMSBhOFXqzpt/jX+oe5OX
         oxtQ0AQOA7s1cHqAKBmaw7BQejxqXhfNJ61DYnhnCau+Cl1FrFTEbjg37HbPD1kWx4iv
         uH7g==
X-Gm-Message-State: AFq9FYL1U7Jqtvqu7sGV0qQdhkX1km8/7uYnHUZeb9QpyoLrE3sJ5p/0
	fe8oXuKIiV6i1oh1pYBa7kEOXsAVZh6F4Rllm9UhqSK18cTV/rXnUiEWCO5l6PvegZgqwk/j3yY
	Rg/Iz/VQAmK5jr2X5LcAxC81HQF8tvGU=
X-Gm-Gg: AYBFou2hm5xEwGpTu7/avWJn1JBu9gpzx3t7k7SW8Syb/UlzSWSvD6k0u1+SD5PZD8Y
	ZWW7WcjCGfePO2wQVFQH5mx+GoxSs6R5scIIO/vLU/3otsbtdE7F4s1sGWT7NzLbUQTCJY7EMOy
	4lI4/Y6dsetyxrwS5oN1W8P5c7YuAiQOTSDVRIJ5W8nn/I3gV3WcBSyT9nzHLDePqWph48nMstb
	0m+Rk1Kbuu7CnZGLhsmApUgy46KlVTuZkdooFZ24fzr17iBMskU8+9ceW0eAF3DV+gB5llk04QS
	r6ZoPyDwYXjePTsXlOQL7fQ1yM2ZOnJv3/6DgYhh+WGqIJ3JELv04PVHO6DxPgwXjQ1iVLFFxBo
	bkWUylzsMj3ckc+58vsAWN1ZIjrfGDaeXJYjmjWzuZarTAg==
X-Received: by 2002:a05:6122:468d:b0:5c9:c26b:528e with SMTP id
 71dfb90a1353d-5e91f4e235amr1273829e0c.20.1791584203985; Fri, 09 Oct 2026
 15:16:43 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 9 Oct 2026 18:16:42 -0400
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 9 Oct 2026 18:16:42 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <askY2aq8--2I2lEN@denethor>
References: <20261009-799-shallow-fetch-with-tags-v1-1-379d61504af5@gmail.com>
 <asjPWXAO3Cwpkerk@pks.im> <askY2aq8--2I2lEN@denethor>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 9 Oct 2026 18:16:42 -0400
X-Gm-Features: AclHuK8wYcgWKQazvG3ItwG013hxKsDl3VxvCL5qWCUQjgVvu_G1waSLImPqFZo
Message-ID: <CAOLa=ZRML58095JPz1kzOyDTFwsdcoVx9jyxyf4gRppX1h8tVw@mail.gmail.com>
Subject: Re: [PATCH] fetch: commit references fetched before backfilling tags
To: Justin Tobler <jltobler@gmail.com>, Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, =?UTF-8?Q?Mitja_Bezen=C5=A1ek?= <mitja.bezensek@login5.org>
Content-Type: multipart/mixed; boundary="0000000000001086a0065d6fb4e4"

--0000000000001086a0065d6fb4e4
Content-Type: text/plain; charset="UTF-8"

Justin Tobler <jltobler@gmail.com> writes:

> On 26/10/09 01:26PM, Patrick Steinhardt wrote:
>> On Fri, Oct 09, 2026 at 12:10:37AM +0200, Karthik Nayak wrote:
>> > In 0e358de64a (fetch: use batched reference updates, 2025-05-19), the
>> > fetch code was modified to use batched updates to provide a good
>> > performance improvement. Wherein batched updates were used to fetch both
>> > references and backfill tags.
>> >
>> > When using batched updates, the references aren't yet committed to disk
>> > when we start backfilling tags. This means in situations such as shallow
>> > fetching the negotiation during backfilling tags, the client doesn't
>> > have any references to report in the 'have' section. Since backfilling
>> > doesn't use a depth limit, this can cause the server to send all the
>> > objects present in the repository.
>>
>> So in my own words: the server sends the reference, we queue them in a
>> transaction, but don't commit it yet. We then try to backfill tags, and
>> because we don't have the refs committed yet the backfill will think we
>> don't have any of the relevant commits that those tags point to.
>> Consequently, the packfile negotiation will result in way more objects
>> being fetched than necessary.
>>
>> This makes me wonder why we even do a proper fetch. In theory, we could
>> basically just ask the server for the individual tagged objects without
>> performing any negotiation, right?
>>
>> Or... well, would that work with nested annotated tags? No idea.
>
> IIUC, when we backfill tags, we only fetch tags that reference objects
> that we have locally. The server advertises the tag reference OID and
> its recursively peeled non-tag OID so the client can figure this out:
>
>   efe1aaafb77990c4f023cec81b198e0af55bbfb5	refs/tags/foo
>   c8dd1e3bb1152844983558802a52c9e4c17652b4	refs/tags/foo^{}
>
> So because there could be nested annontated tags, I think we would need
> to fetch to get the intermediate objects.
>
> -Justin

Yup exactly this. Afaik the protocol also works by transferring the set
of objects that form the closure of between have <> want.

So for:

   foo -> [tag A] -> [tag B] -> [commit C]

We cannot simply request for A without saying we have C. We have C and
we know it, but the haves are obtained from the committed refs, so
until refs are written to disk we never advertise C.

--0000000000001086a0065d6fb4e4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 8db4cb6d457dd9b5_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1ySlo4Z1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMktBQy85bUhjdlBPaVhoSmJRUzJGMDhQdGtkeEpvcgpPVS9WWW40SWNQ
VjE4YnJGcDBpS0hYVlMxYnpMV2dtL1hLSWxGMWM0dHk1NEs2RnZ3eFlkRmNoTDMxQ1psL2N2CkY4
TEVMU2cxYzFWcWVLUlBXZHJVTUJOb0U4bjhMZ1NCRFFnN0lRS2dBTlRweHdzTjI4QmFQd3V0RUpG
ak5zSXMKOFVHUFZ3RmNXOUxQbWNOK3RmUzVmSzZXVXVQOFZpZElUakFUc3k5bHRqWVlFY0w5bTNw
dGlXaW5FUFBzU3FxagpTQzFGYzFtQ1phTTJzemcxMk9naVpQbFBqWDBubzFBd0pUVjlEMytRdkZj
c3RobEo1ck5iWUVEaDJZNmdqY3FKCkFYeG45VHhmQ0dmOGJsejhQQnRJRTRKYThxaUdsKzNNQnRX
Rm9ZM05KWGY2U2QyTWZQK0RIbWVIeDdxRkRaK3AKSnhqc21aYjJTSjV5STRZTzZybXR3NlQ0Mm5C
SU9iVzNIMm1Qak5pRVlWRWFnV2ZIWEp2OU41MjBLdlU3aFRQcgpuemM2QUxoWGUzczV6STVsdElF
V1QvTFF1TlZRSUZIb0JEVVZraVIxVlVCL25vN3JKVUcxamR2VUFkZm0xQnJRCnJuRUVrUGQvdXo3
S2FXVENsZDVqRE1wdHJ0c3RVczBKSTRBYmtQST0KPVJuMHAKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000001086a0065d6fb4e4--
