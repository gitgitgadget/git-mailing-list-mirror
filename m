Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D51633B5852
	for <git@vger.kernel.org>; Wed, 11 Mar 2026 11:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773227346; cv=pass; b=Ebx1XC7daNkVQVevX9b88oKzUpFk4Dhdmdlrw5609M/Dku/dXzTUP2E6Ps2/x/DU8p+Y7r5zJJxkd2s4SBEZZVJdG+8nOcFAvpp0Actw4p/S8fY4Kig4yEGHBOdHpJ61ZkbXyVxrhHtaoaf2idu8CnRHrL4HArv39FJUyd111Mk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773227346; c=relaxed/simple;
	bh=Staro78T5XnMV5Oef+TTb/vmQ7oOienb+BFAPl+s/wg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uRlCxVYwt5SfrqywNW9iPsC1MHTP9r0ntuW+dsYo5UIiRVBpjxAprpEpIEg1Domgj4gEN1iKOzuTva/nziM9Das77StEen0sT3PY8lru2/+letoW7123tUKQMrBYzaFdOSpOQmX/knoApkvQroPW+8txmAA5Z6sdo6U9k7W5n9w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=Q1saywec; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="Q1saywec"
ARC-Seal: i=1; a=rsa-sha256; t=1773227328; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=ZabKqePWSwp/SuSVSnQIdNGxLEXScobHHQ2s+jYke1l7bpXBer5ETNZKzD1l++A1DoXGPLEC9uh0w9u2S5wvGaZZu1nee185xGm8p1lui23JY/nQpe2hiNu6NQecaJH2B8cXISbdmoR2wLgf80AD5i6qCYBGrS1tAUU0V8pR0W4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1773227328; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=IayCKXb7dN9O86t6IofUg6uppD1/hvY5ZCzJAFF3WQc=; 
	b=LVcafHlmBiwD6zxVotydrrw/KR3qlmdQp0iIawnfR0LfpgQPxm7VauW+L2/vVsbRITtbnEzR16niL6Vfzw94SXKTPcAmj2iw0fkyDpKu5TWv4j8UsAt5o/R/TsY+j7MiXS+m2hHFP/1s/i6kos5gZFsS9XLAL+ytUgDNAv5ySxA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773227328;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:In-Reply-To:References:Date:Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=IayCKXb7dN9O86t6IofUg6uppD1/hvY5ZCzJAFF3WQc=;
	b=Q1saywecJ/8ojneS+Nlu0Dnaq3Gej7r4EJD4f7RHiTAKXhnEn2TydItrrAyhCBGI
	ag1WLP6+xtlJphAwi7Sxx6OHmyL7fA8xibi2wAHHpmnotozDaI6bgpkxNWKJcKCSdGa
	3zJ7k6GyDQ+TNThmV/8bSTIuiDKixfJDnh0k/mfw=
Received: by mx.zohomail.com with SMTPS id 1773227326049285.42387910517175;
	Wed, 11 Mar 2026 04:08:46 -0700 (PDT)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc: git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>, Junio C
 Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>, "brian m .
 carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 01/10] hook: move unsorted_string_list_remove() to
 string-list.[ch]
In-Reply-To: <abB3V4BcYDgMJo0x@szeder.dev>
References: <20260309005416.2760030-1-adrian.ratiu@collabora.com>
 <20260309005416.2760030-2-adrian.ratiu@collabora.com>
 <abB3V4BcYDgMJo0x@szeder.dev>
Date: Wed, 11 Mar 2026 13:08:42 +0200
Message-ID: <87ms0eaait.fsf@gentoo.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External

On Tue, 10 Mar 2026, SZEDER G=C3=A1bor <szeder.dev@gmail.com> wrote:
> On Mon, Mar 09, 2026 at 02:54:07AM +0200, Adrian Ratiu wrote:
>> Move the convenience wrapper from hook to string-list since
>> it's a more suitable place. Add a doc comment to the header.
>
> unsorted_string_list_remove() in string-list has a 'free_util'
> parameter that didn't exist in its original version in 'hook.c', but
> it's not mentioned in the commit message.
> Furthermore, none of the function's callsites are adjusted to the new
> parameter, and the build fails with:
>
>   hook.c: In function =E2=80=98hook_config_lookup_all=E2=80=99:
>   hook.c:151:33: error: too few arguments to function =E2=80=98unsorted_s=
tring_list_remove=E2=80=99
>     151 |                                 unsorted_string_list_remove(e->=
value, hook_name);
>         |                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>   In file included from hook.h:5,
>                    from hook.c:5:
>   string-list.h:273:6: note: declared here
>     273 | void unsorted_string_list_remove(struct string_list *list, cons=
t char *str,
>         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>   hook.c:163:25: error: too few arguments to function =E2=80=98unsorted_s=
tring_list_remove=E2=80=99
>     163 |                         unsorted_string_list_remove(hooks, hook=
_name);
>         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>   string-list.h:273:6: note: declared here
>     273 | void unsorted_string_list_remove(struct string_list *list, cons=
t char *str,
>         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>   hook.c:180:25: error: too few arguments to function =E2=80=98unsorted_s=
tring_list_remove=E2=80=99
>     180 |                         unsorted_string_list_remove(&data->disa=
bled_hooks,
>         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>   string-list.h:273:6: note: declared here
>     273 | void unsorted_string_list_remove(struct string_list *list, cons=
t char *str,
>         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>   make: *** [Makefile:2917: hook.o] Error 1

Excellent catch, thanks!

I have been moving a lot of code around for this series and I ended up
updating the call sites in a later commit, causing this breakage.

Will fix in v2 as well as document the introduction of the new parameter
in the commit message.
