Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8476C23F42D
	for <git@vger.kernel.org>; Tue, 27 Jan 2026 01:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769477250; cv=pass; b=EpArrIsUYreej4iRtkwuJIPdFywNAar96b1zXyoAc6GwNWzjrg4LYI8R1H9wQQDxXk9qEd9P2zdRyC1NCfVfuysJrt5vsdCI4ksa82/wgByCtEmI+fmo8CfarUkKy820aVw7NQkPoBI7Ff324+6K4HqIwhR1bRzSPUehjNoHCek=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769477250; c=relaxed/simple;
	bh=EOTVFQ1jPxZl6FW05SmHXNao0F69PCuuzIuTQUuZJk0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NlIatuWvhI2JOL+XPuDfiohHzx2Q3JU/fqx9RCRYjZQUf9gre1d9Nde3OoL60owyZCEpRRLC0CXoYvAJyTxLOf5JUOz45pNSoMX+8lwQEP0+wjfK4YrsnEN+E8GLOUGQE8/jm4myEs3j1uOKPtJrgdjrI5yfI6On1k+Fzsq+e2M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e7z72Ehw; arc=pass smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e7z72Ehw"
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-649605d3664so3485572d50.3
        for <git@vger.kernel.org>; Mon, 26 Jan 2026 17:27:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769477247; cv=none;
        d=google.com; s=arc-20240605;
        b=faMqx+8fI29Ae/a8q56/zIRPMzbUASz9c5vHU3fPo+Jw4wIWb2bxxe/S00ScXBPDdr
         D0MM7v9vFwJfI3lAKBedMJUHS8ibA1kK6kTDWtDQwtM7to6FBpZ85tn6WKZvAlU+7wTR
         9YZJg+7mHNGI4b7KGSCPle5KkOjYjEPULr+Q1TALm+BRv6cHiOcpKkAX8cSlOPoG8hKP
         uipwb5VwMvFPzrp1I4IGFaBsusD87KSDxo69Vxz5/WImSHeJCQe6ly/WDVH3xi+aTF5H
         ytV880/4Tvt9aVBknLGN9HDX6jOVTMEqJNapGqvx4Yx5lXiO2nQssVY2BTLyYzY2gX1I
         BLdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=YKagQtSZSNrLQVBN9wX7Jyz8OUWZY1lWus7bZgLhLZE=;
        fh=HWyAIkdrobpCAvaSiR+nhPRDu/DGOsKx7ldMDWy/i7M=;
        b=O2e4hrwawFlsJM4dYmsl7YmTcB2xygvCviqD/Dx0uWboX15TeYEGj92ys0se0cs5bW
         cON2GDaiUR+YxsFXjoBireu09jAs6l8UBIDnECxx4vJqCqTkYaccPbW88kpR9GG2o7Im
         wXrJ74So6VFTHjsYexM0gOL8IxD7yq8oGtnfhpGDJvj6dq4Tt2NPK2FDAfaPfDImdpdH
         OFxOZ/6iqTljTgSmy8CKkmaNCRSKh4YEgpvEXQVYTos9GHjbTfv2n0j71psCpHIc/7BX
         3sx6RiAPDJllTmHqzZKS9fRjKFIbhoVJxOJuGVA7cKmgSSX0YKly1MPpEf0ZcD97x0wV
         eh3w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769477247; x=1770082047; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YKagQtSZSNrLQVBN9wX7Jyz8OUWZY1lWus7bZgLhLZE=;
        b=e7z72Ehw2W/HubuIkllLdNWaW25S/pzLZljLGsQdec3exJkTCx1HzT59ChewwBKe+r
         VJOGCRbZ371w3LW9KUs4E9nmd3VTiemodRlCDVfurzrqzmjFcT6mdTQssEBa9JRidJAA
         xOeLBRQPEvTyQ1a8EMvOQ8QEjGum8cjGEgnnLGkWaLoXTrK5xEKIRzoGbTq0GdIdLYT/
         ErsEvFMGBgxmTJ6a2x50P/xSnBKTwqLVvdF3vnZvkeDMQ7vrYIK5ck1Y8uY0f0j1WSKD
         IBzEHNyTQvNu4AGwzOAZu27xajOXvAjLbyUbdYyZdz3GdXieTVeQCfgMHfbIafK2I3fR
         zCYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769477247; x=1770082047;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YKagQtSZSNrLQVBN9wX7Jyz8OUWZY1lWus7bZgLhLZE=;
        b=OGP6rAsE+GSdRlEBvCpMkRe7/f4g52puY6fx7lKkSTPJEfn7DDQN1clANGcIoKYTaC
         O9u2c58T5yeeMJY+RKPFEbgZOA2skKGyrRsu/uzbUv2ealTOJhympWZOv4ub+V20W6JS
         JAcLQsKofAp9FpDxD6pq3eWkR/HwNUqfE11UEar0HnwZIUrtStT5kPpJS+XX0JqwO8n7
         /aJcqLMrsXoApKRpRIA6d7U44XEaQzOEfxMtUqPpTe7cgOcRQyjOZ/x2yas8EdeiifmV
         W0N1fvR6OMYcHSoCYgPOfHvtV/q5ZWu2yEEIW3gmp+I7acFRniwUqgPKsFkBdwAQ7xxS
         F6NQ==
X-Gm-Message-State: AOJu0Yzi/8N+TpUxoxYvKWoPlfpeEklcuz/DbjJ3pQNjvR2svxPwrntf
	gC6coOiSFSfk+8yTTgnV/bbfejYiuqxpqK/C62p45D03nZU7iz85YQgJ3FazPMIztj9IO4jFtle
	sNWyEMKpYKC/99uCH6bQtTQ3K9bdeNxPyzG+2
X-Gm-Gg: AZuq6aIsvNN7EDKdbsGVqYKMcn3HC5AuPd8HgGYDBLjhKKtSFLxJo9xe/Hykqc3Y813
	Lq/qLwebpt4FjfWYwxGVyqoydgDsM8Qa7q1XpgUKa1NrPh5FPKKNT4GyTYG283mPgwS+Yuh+K11
	+Jbei91bUGNdFRwXE9EwX3WRvs0y7E2f72LUXayHdZqv0BJPXS0KnKZViMoGRfucTvkpohNOXVN
	kDv60M0NfVf7Z9APuf5brOMdQSOPntPrDYgmvOc31XQVC7C/PQTlhpO4O3gdIvSm72oOGF9WlmX
	8C4xEELvDkLesDiv76U/tayMFcOX
X-Received: by 2002:a05:690e:1405:b0:649:4677:b41 with SMTP id
 956f58d0204a3-64970b50311mr5670912d50.20.1769477247479; Mon, 26 Jan 2026
 17:27:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260122171523.94234-1-amishhhaaaa@gmail.com> <20260126185604.90089-1-amishhhaaaa@gmail.com>
 <20260126185604.90089-2-amishhhaaaa@gmail.com> <xmqq1pjci16l.fsf@gitster.g>
In-Reply-To: <xmqq1pjci16l.fsf@gitster.g>
From: Amisha Chhajed <amishhhaaaa@gmail.com>
Date: Tue, 27 Jan 2026 06:57:16 +0530
X-Gm-Features: AZwV_QhsuAGGINf7aIVQ2MmQ9qotz1S397opqCRQIDbZBcj_OrZUbHVBrujUeyg
Message-ID: <CAPvEtrfEZXHxcDf=z60ODfUA8cS81rhF1y7KEZApEBby7aCa1A@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] string-list: add string_list_sort_u() that mimics
 "sort -u"
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>, Elijah Newren <newren@gmail.com>, 
	Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"

> The one in builtin/fetch.c::cmd_fetch() smells somewhat fishy.  It
> prepares a string_list "list", populates it with for_each_remote()
> by appending remotes found in the configuration when asked to do
> "--all", or append named ones with "--multiple", and then calls
> "remove duplicates" without sorting the resulting list first.
>
>  - A test should be able to demonstrate that the call to
>    string_list_remove_duplicates() is not operating on a sorted
>    string list.
>
>  - Once a breakage is demonstrated, we need to devise a fix.
>    Sorting the string list before removing would certainly fix the
>    duplicates removal, but it will change the order in which the
>    remotes are consulted.  I think it is currently "whatever order
>    these remotes appear in your configuration file(s)", but that
>    does not mean it is a random order.  It is very likely that they
>    are in the order the user has learned to expect the remotes are
>    to be consulted, so "sort and then dedup" might appear as a
>    regression in behaviour.  I dunno.

was able to make the behavior fail on test,
from file t5506-remote-groups.sh,

test_expect_success 'group with non-adjacent duplicate remotes causes
duplicate fetches (expected-to-fail)' '
mark fetch-dup &&
update_repos &&
git config --add remotes.dup one &&
git config --add remotes.dup two &&
git config --add remotes.dup one &&
rm -f .git/FETCH_HEAD &&
git -c fetch.parallel=3 remote update dup &&
repo_fetched two
'
gave log with command,
make -C t T=t5506-remote-groups.sh GIT_TEST_OPTS="-v"
from git/,

Fetching one
Fetching two
Fetching one
From one
   d1132c8..cceba7b  main       -> one/main
From two
   72c2514..57c13f4  main       -> two/main
From one
   d1132c8..cceba7b  main       -> one/main

error: fetching ref refs/remotes/one/main failed: incorrect old value provided
could not fetch 'one' (exit code: 1)

Did not see any test failures post replacing this call with string_list_sort_u()
but from the code, order of the list matters, and i think the expected
behaviour is
if any duplicate the first call of the item should only remain but i
am unsure if it is
achievable with the current sort and remove duplicate methods this is more of a,
if current_item in seen_set:
   pass
else:
   add(list, current_item)
   add(seen_set, current_item)
this preserves the order and maintains the time complexity and only
keeps the first occurence.


> The one in builtin/help.c::list_config_help() is somewhat fishy as
> well.  I didn't read it too carefully, but it walks over keys which
> is in sorted string_list, and sometimes pushes the key intact to
> keys_uniq, and some other times munges the key and pushes the result
> to keys_uniq.  I do not know if presence of these these munged keys
> in the keys_uniq string list breaks the sortedness of keys_uniq.
> If keys_uniq is *not* sorted, then running "remove duplicates" would
> be broken, of course.  Again, a test should be able to demonstrate
> if this is the case, and we should fix it as well if it is broken.

This one is a bit more complex,
there is a very specific case that would result in un-sorted behaviour
of the string-list
that is of form,
sorted: [aa*., aa.b]
post processing in &keys_uniq: [aa*, aa] (this is unsorted)
because ASCII value of * < . and the precedence in our code is . < * [1]
but this still works as remove_duplicates does not depend strictly on the sorted
property as we remove adjacent similar elements which would also work if similar
items are somehow grouped together, which they are under the conditions
of our code.

but sorted(x) != sorted(f(x)), and the processing we are doing also
does not depend
on the order of the elements so maybe shifting the sort below with
remove_duplicates
might work as a solution and would make the behaviour deterministic,
saw no failures
post shifting the sort down with it.

[1] Snippet from fetch.c
if (dot)
   cut = dot;
else if (wildcard && !tag)
   cut = wildcard;
else if (!wildcard && tag)
   cut = tag;
else
   cut = wildcard < tag ? wildcard : tag;
