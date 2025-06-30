Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F08CE72609
	for <git@vger.kernel.org>; Mon, 30 Jun 2025 13:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751291199; cv=none; b=Hqg1eaISCemTnzI6ZVsU9jCp88qk5abCLaEzAHGKi/RR+WUW8NF/qa93vmM5LcJdgf3Dmc52EUc0fiTtf1cHkwm6XhFUoSiyBX1PmQNCYUwhp48DZK4XLJnfIQ/suyCjnZVK34fn5S3f3D4n2KekuH+2MNFfhz2qzgISdMSDkeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751291199; c=relaxed/simple;
	bh=Qv9Y2/xhfWnXGhSyVFK3qp5ZDWtHsAiwqbwgQnWSGrA=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rw1l3bjMaGJfhTtVgHiHC3s520S8tZ/wSdyituyaulkw16U3yYnSTiNol8CW/6wkDVflDQiTdehHOa3M57cXDmYyC1KS4cs25KK5pvyfxZ1l5ZhFUIchrk8veCFQm0N7wZ9qd894OkcYmn64TjDE0MdlfxHKAGxUws8d2k9R6cA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eiI6w6Sd; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eiI6w6Sd"
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-87edd8f4e9fso1081016241.0
        for <git@vger.kernel.org>; Mon, 30 Jun 2025 06:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751291197; x=1751895997; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ChTU8L9e7ltAgDQ4m+uqFJYjsFoDmLWpZFCLXChwSjI=;
        b=eiI6w6SdvoPp+sEuWJNsN9wiO7NmOhB3sPUaMcBUIa1V2fVUX0opJoaazh92WnPdjr
         n9mDUQtyODXoMcnFh5Rb4sGyndcmT9JDPBkkRNyp0AkzJ7s1OP+7c0iO2DZhpBQvEiYh
         fBGoItP/W0lr89ZqsrMKMSb8PUGYrRetMpIlDpMueTfjBBOqfvOYO7xDeiPnnthYMkp6
         ryv/lJZuLR24rotIGXjDdE0nz202URRLS2OCyoqH7+S/uVof8N2MmSjLl439J/D1PJZa
         /nXOBw/AslPHqkO0kNp4zPL98tJzPBJSVjfgLY8ATylw9nBN1jTdOOmpoF0slhBIHEko
         j9dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751291197; x=1751895997;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ChTU8L9e7ltAgDQ4m+uqFJYjsFoDmLWpZFCLXChwSjI=;
        b=BTMPwEfur6T+xfk59/xztFA/EbJKtaQ7TchURFtVfoBNCNZmi0mx4sZpnPz66F8Dw2
         tfulZUpcjIKN5N6R4kcLlz15CzU1ORXCk3dM3CUHnceC4WjBaM5zDMTQ/SsP/oVNfoZc
         G57AQhQ84S2eXqtWqoqEPZ5cXBTcaIEN6IMgym9iUCf+ytkJS/cOf6psTEsuWeDlh4Hk
         vDQxzaev3Npst2KE+hZhcaeogX5keZt2q8SRo2lkLbCOD+WEKzh6HhLLxt1KgjnoPItr
         f+85dCJN13VZhCd/42Ybi8NuhnSoerFejEOnA3VQbAt7NGI1cPTvPQKDktiM8rDUXkC+
         DQsw==
X-Gm-Message-State: AOJu0Yx+vsisrhVLCpR4fySCoGOixyzHjdmza/KdirBhf6gwuj8XK2My
	VwYJ+r3ljSU6KC+EKHc/vW17Ycjccv9d8go7Dtk0FeF1rujwW3rV3SRu1+iD7tFJ4d8sXOY6dua
	A38D2maQSveZsfkG4XlwTMU6mjRz7y6N8FPxt
X-Gm-Gg: ASbGncucbcexRIbTxq03f9QzV6AQHmxBIJd7URPXvvy5ISnDU0f0xrC7blBEI68ZF1c
	zxeFiv/scNn1uKIpY0Ql+gRahfIi8XFR70Mb8G2UmcaAi4fQSJKW9+J9iMrnKyxneh1QfCzjoob
	J0Geg4ToXrwD0S5h9De5iz7PlhJV6XA42CxiRsYIpO15WuQSYzyF5oqqMS3jM2BrVuhoecSN+5F
	ZUE1w==
X-Google-Smtp-Source: AGHT+IFMtdX36x3DRN6b/3xlwU8ZnrVCWCvy9w3Kx2awgSn0qdBvM22/XH+hizN2zh99/zrY3YEddJ0cb4H0O5k8GIE=
X-Received: by 2002:a05:6102:38c9:b0:4de:d08f:6727 with SMTP id
 ada2fe7eead31-4ee4f790b0fmr7155542137.13.1751291196590; Mon, 30 Jun 2025
 06:46:36 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 30 Jun 2025 06:46:35 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20250625141849.78834-1-jayatheerthkulkarni2005@gmail.com>
References: <CAKkAvaw0sZ0sW9o_0NZdnZknS8M34UST3PetaPBQj5wwvJyjBA@mail.gmail.com>
 <20250625141849.78834-1-jayatheerthkulkarni2005@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 30 Jun 2025 06:46:35 -0700
X-Gm-Features: Ac12FXxV4ilczIWrDDwzAplKGOIZwAF9N1yuz7klpgFkqUFSCEp4HxUYnmFWn0c
Message-ID: <CAOLa=ZSA273KGPnwZ2aRBU_ybcCTYogBHvUwpa+5CfDOc2bEWg@mail.gmail.com>
Subject: Re: Re [bug] pull --prune could not delete references due to lock
 file already exists error
To: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>, ryenus@gmail.com
Cc: git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000abefae0638ca41ac"

--000000000000abefae0638ca41ac
Content-Type: text/plain; charset="UTF-8"

K Jayatheerth <jayatheerthkulkarni2005@gmail.com> writes:

[snip]

> The original implementation:
> Starts a single transaction using ref_store_transaction_begin().
> Adds all deletions to that transaction.
> Commits the transaction.
> If any deletion fails, the entire transaction is aborted.
> On case-insensitive file systems, two refs like:
> may conflict at the file system level (e.g. both mapped to the same file or directory).
> If Git tries to delete both in one go, the transaction fails due to a lock file or unlink error.
> (Above are my assumptions till now).
>
> What has changed is:
> Deletes each reference in its own transaction
> struct ref_transaction *transaction = ref_store_transaction_begin(...);
> ref_transaction_delete(transaction, ...);
> ref_transaction_commit(transaction, ...);
> ref_transaction_free(transaction);
> If one deletion fails due to a case conflict, the others still proceed.
> It avoids rolling back the entire prune operation just because of a single failure.
> Keeps failure count and returns appropriately
> Signals that something went wrong, but Git can now give partial success feedback.
>
>
> The question I have is
> If this approach seems viable or perhaps any solution,
> would it be possible to write a test case for this scenario?
>

You analysis is right. With 'kn/fetch-push-bulk-ref-update' in the works
(possibly be merged to next soon), we will start using batched updates
in git-fetch(1) too. Batched updates allow individual updates to fail,
while allowing the transaction as a whole to succeed.

Unfortunately, because our transaction mechanism doesn't handle
conflicts, we separate out pruning as a pre-step. So this bug would
still be present there.

The issue with the fix you're suggesting is a huge performance drop,
since creating individual transaction for each deletion has a lot of
overhead and the reftable backend would perform a lot worse in such
situations.

I can see few solutions overall (including the one you suggested).

One solution is to drop duplicates in case insensitive systems, this is
the shortest and easiest fix for now.

Perhaps something like (untested back of the hand code):

diff --git a/builtin/fetch.c b/builtin/fetch.c
index cc0a3deb61..bc79d74b82 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1352,10 +1352,16 @@ static int prune_refs(struct display_state
*display_state,
 					goto cleanup;
 			}
 		} else {
+			const char *prev;
 			struct string_list refnames = STRING_LIST_INIT_NODUP;

-			for (ref = stale_refs; ref; ref = ref->next)
+			for (ref = stale_refs; ref; ref = ref->next) {
+				if (ignore_case && prev && !strcasecmp(ref->next, prev))
+					continue;
+
 				string_list_append(&refnames, ref->name);
+				prev = ref->name;
+			}

 			result = refs_delete_refs(get_main_ref_store(the_repository),
 						  "fetch: prune", &refnames,


A bigger and eventual goal is to simply introduce conflict resolution in
reference transactions. This would allow us to use batched transaction
together for pruning and updating of refs, and using batched
transactions would ensure that single reference changes can fail without
failing the entire batch.

- Karthik

--000000000000abefae0638ca41ac
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 565398dcefa2006b_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1oaWxUa1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMVBLREFDWFVhUDJHY0RmeHBqQTBLVGZCUE5qbUZBRwpXc09LOHRJUVZm
MGVGS1R1WEIxL1RXcGtsZmhhNklrdG5INzZadkd6TTIxbURDZC9zYW9OZFhCcm1yNXJEWXQ0CmRz
MWpaakVBQi80eHF0Ull3L1lBQUNsS0NXcUoxaXNOZ1JBUVhHdXFTNjZ6WU9BTXZtWWdIVTA0eDFT
WVA2cG8KMktYdzRUZzhQbUc5MnZRSURsRTdwUHAwZ0ZZNnBzU2xodmpzQXZObTVMUThoL1RnSTdV
S05ETjAzdnBNS0pXLwpsYVk0blI4dUdtU3piRVFxSlpmeTVrYXJzMXIrS1RZRU1FbndmdFFWOTkw
TituNGEvQ3RwZG42QmU5WEcvZXRFCjRaaituVDZBMmJ1aE85UGIzTExiM2YxQXJ2cVVYTkRoTWJL
djVsNW9BcFJJbHJDdVVJQm10aWFzQ0U2eWcrbHkKWjZDK05qRWYrbGNweXk5WHZacTFvb3BBdWNr
QU1DS3Z1ZjQ2OHlJSXE0OEp1eHk5YVA0V0NpOG5XcFAvTkJnQQp6K0p3STArc0h6RXU3cUFQWXh5
V2hTaHNlOWpITkk1cjNzOElPY3ZUbWhrSE9DWVRZY0FUV3dlQStodXNDTW9qCnNqMHdsdG8rRm0v
azhqOHZ3K0NrM0NCeHlESFlvcnNld1Z1aWQwZz0KPTFvaEIKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000abefae0638ca41ac--
