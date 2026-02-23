Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B7034AAEA
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 08:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771833931; cv=pass; b=ef2JZBLyqtu46FkNRo3McCm6Zn0xaE+S2k/3xLJFfkmnrpCyTGcMfIrydx9dDhcfaMcNCZ5M/eNdj+B75t3rNDwX8J+FN/Yr/7rO5zduXJ5bpZPBrX4FNSub2dUy4IrG82/HeUEhfhNWWtPB4E9f+uJUhk4e7FtZEZ7JF6wAP80=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771833931; c=relaxed/simple;
	bh=0zqmlI/P0ix4UkzCaV2Zt5MMy0fCARuwpRwgQFPPQoc=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=G/V3/fiaYDnE4T3N9cvxONnb/LSjGCNtRuSb17lEi1urT8ybYKEBFonr9mqYwooD6JJ0yTmCQzVchBXAOYquHYhQa++/l9VUVGP+OssCnvCE2PcfNGnoObxtOT+xk8cPkob281V7JBo0HKCEkZyGM+UUhhFjKVjP7DkQLTZMK4I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mBlGx4tj; arc=pass smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mBlGx4tj"
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-567543b8989so1963888e0c.2
        for <git@vger.kernel.org>; Mon, 23 Feb 2026 00:05:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771833929; cv=none;
        d=google.com; s=arc-20240605;
        b=hDtiSCO7sTWhq8GovtAo/OTvFtyiu+x7G8RAqnlsdDzFNpgJTN6NyWp4xXn1Lk+RE9
         vLF+e5MlYLcUdxmQPdC9fzcs5febPXB5DtlneXk3nTfac82r6U2b9Ujreh9Rzvxq/l3Y
         V8ILOhbODxlhJPvDxp5y03OaekZ95PBTtzycbErVZ8Nxure0m0bbDVYy2ytqht6noc7i
         6kuZ2M6jAkODepsH2kgCXLUOXNm6P0Ejpl6SQENDnZnAKhkVPUMujGFwiv0HPL846N4B
         7GyL+M9tQmEXipQR+8QNuZoEuRDvmCXrqMGDtAtPQi8FvKjxKgiEERePOwd6WPCbOoNN
         rV3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :dkim-signature;
        bh=J970UrGZbjgA1pdBJ5iKj8CBKB7r2obVdzi4j/uOf34=;
        fh=wKs3cb0ELY3w62mZYdjpQqr/JQ2XGfhAI4Px9LX1hvo=;
        b=EZBgcEsjv9oQUVbT/3t67jqFzyqNCQ1BEFyJeqPoQLBgqsbwUGU/vPtVPsjGHaisLM
         Dy+A2nFSGkN+7gEc1mAYCwVxDK3yzQszvLrVOYI34E7HDLlpctOEYsUa92zQNjrHQHlJ
         nVb7PfNGcdzFzHcTyaNCd9jSaNG+Dg2Vn1G/mEWsnzrGZPlSP3C8ilE9O0M2iBInShyy
         V+ydoet0X+m8VvZK4P4lQknJun7q+IFJmvQo9yFEa9Lf5JdfXKK+V7KT1c8+2TFqkuWZ
         Q2m47DQuhoGZgsHQskni7trm7YDQrrIz4djWdRvhUq7wuZFTw5pbOTp22gQ+s7024lfk
         Ik1Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771833929; x=1772438729; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J970UrGZbjgA1pdBJ5iKj8CBKB7r2obVdzi4j/uOf34=;
        b=mBlGx4tjJdTre5GeK+7NB2GcqDIZVzT67n47/1+t5I3AJqDtBWetijd6ctu29JbfLZ
         XhLUKYaVTgeikWUDhDdgYGYwdDlXtv+hiZY78qD67IEEB5e4K0O//569BsHwpzjcdqKh
         osmmo6QcSxeOo8quEd/SFX6fgw8djjoSD76rwxVBDgZKRRXyWR9xBjaB1jeyBAV8HPQC
         Tz5eq15lbt6BsuNpipHzmdrdmm8Y3CSN9piKuXDsUFEvkI3uNkMssHElwVmaBr8NDHcr
         x5rR3jOefuN/60IclH2mkefWmhiVdIU9JSD35lVGMkA/S8JrPjztFWeSOGHDNTqQ5UtB
         3AtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771833929; x=1772438729;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J970UrGZbjgA1pdBJ5iKj8CBKB7r2obVdzi4j/uOf34=;
        b=Ws8qLsvB7XCOhy4ODtA6dqwYP3F5tTVG/Yqmdvi1+0sLFaZC/0DLlgAhFbuHPBaxnf
         IIZW4F6gNISbYu8AlKOtV39pLtnclXG4U8xP8dKfYgyOElIegETW+/pSjRI10N+qBKyc
         WSDWXAQz/0hEwsLYapCBATtIVR48iW0j8XEXGc6PqA/V2AzGmFCh3Fd9MgnpzhMtuHGq
         NjAUpZmHFFCeRAV1ew/R8uis9N7D5Yi8VigSo2xJ2ZbQ3+BrNqusXIa9WBsrd/ctPXp6
         rGFsXSVM4DPlRcebpDu3RzKgcVtmlUiSn3qycjFyLlp9r8pjTTiNidY1wXcDDRth65hN
         EJIA==
X-Forwarded-Encrypted: i=1; AJvYcCXpR2oZzgtrvA5EQIxZthSYmAxyf6jR6xA9KV5++LXijpXb02OwxMf8G+ZbKIDRqQsR5Ds=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywh3D1MIA9nP1QESiTRBKomVOOP7DCYNVWMBB7IfrKbfZsU2YqI
	oOgW97/HWh1RremyTO+ZAbWO5cricRU9q3PmfjkW5f/VIPL+xNWVPX82DPtInIR5ng92Hsk44NU
	DpUaGFAos9dffMqZ1mszaFzgga8TJNDOmDpk6
X-Gm-Gg: AZuq6aJneDb6o5XF9cV1ZQWRxkqkqPxEtHQ6hvt3Q7Xc+d55jJZDbJtwhgxSE5Ixtnq
	Jb1gKggnQqI+Dkazf8+BCgfFbMPqMqV3x7nEjbk/K6WZ8FjTGEt8mu4atsACW8F7KQ3GiuV27vE
	ds/FJzKwwYx8fbBJdAH4oS1okp3nqxM+17uySfa4A57UWbh/o5W1PBj6QKfj5iDnMg4y+0AJrTY
	bfieOTeTM/gKfBRufitmF4Hb57mnHcsRShix5sM15Ai2DLDAU64aaRwPeV9lbt+WKyzfcf0KTPg
	Pxqm2gmRRGMzisVAtRk2l5ijM1LN1g77c9pwSK9crA==
X-Received: by 2002:a05:6122:182a:b0:54a:1e96:e958 with SMTP id
 71dfb90a1353d-568e4560d94mr2735195e0c.0.1771833928618; Mon, 23 Feb 2026
 00:05:28 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 23 Feb 2026 03:05:27 -0500
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 23 Feb 2026 03:05:27 -0500
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260220-pks-refs-for-each-unification-v1-1-17170bd99de1@pks.im>
References: <20260220-pks-refs-for-each-unification-v1-0-17170bd99de1@pks.im> <20260220-pks-refs-for-each-unification-v1-1-17170bd99de1@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 23 Feb 2026 03:05:27 -0500
X-Gm-Features: AaiRm50IKlI0N9doOHk8cWu26OPH-mdIFGOzsv6Gdfg_V0K-N7IvA3g8ZpQefbU
Message-ID: <CAOLa=ZRLeTmGQJF3Wo0SHaQDgy+0G4L6=zciEMtwMPoYqpPM1A@mail.gmail.com>
Subject: Re: [PATCH 01/17] refs: move `refs_head_ref_namespaced()`
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000eab215064b793b14"

--000000000000eab215064b793b14
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> The function `refs_head_ref_namespaced()` is somewhat special when
> compared to most of the other functions that take a callback function:
> while `refs_for_each_*()` functions yield multiple refs, we only yield

Perhaps swap s/we/refs_head_ref_namespaced() will/

> at most the HEAD ref of the current function. As such, the function is

Should this be s/function/namespace?

> related to `refs_head_ref()` and not to the for-each functions.
>
> Move the function to be located next to `refs_head_ref()` to clarify.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  refs.h | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/refs.h b/refs.h
> index f16b1b697b..62e8ef61e7 100644
> --- a/refs.h
> +++ b/refs.h
> @@ -413,6 +413,9 @@ typedef int each_ref_fn(const struct reference *ref, void *cb_data);
>   */
>  int refs_head_ref(struct ref_store *refs,
>  		  each_ref_fn fn, void *cb_data);
> +int refs_head_ref_namespaced(struct ref_store *refs,
> +			     each_ref_fn fn, void *cb_data);
> +
>  int refs_for_each_ref(struct ref_store *refs,
>  		      each_ref_fn fn, void *cb_data);
>  int refs_for_each_ref_in(struct ref_store *refs, const char *prefix,
> @@ -456,8 +459,6 @@ int refs_for_each_glob_ref(struct ref_store *refs, each_ref_fn fn,
>  int refs_for_each_glob_ref_in(struct ref_store *refs, each_ref_fn fn,
>  			      const char *pattern, const char *prefix, void *cb_data);
>
> -int refs_head_ref_namespaced(struct ref_store *refs, each_ref_fn fn, void *cb_data);
> -
>  /*
>   * references matching any pattern in "exclude_patterns" are omitted from the
>   * result set on a best-effort basis.
>
> --
> 2.53.0.414.gf7e9f6c205.dirty

--000000000000eab215064b793b14
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 3a3fc3178cf2e0dd_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1tY0NrWVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1memc3Qy85K3hsWmtIZlNMbUdWdmhtaWlGMGpaUDhLcQpUT2pHWUdISXhk
T2IyLzd0cmZvSmZMOHFrRVJhRG8rdlVxWjZoN0p2WDFuaTVES2h3YlhoOGhMQjNqbGQ4QW9UCm55
ZXhWV3Bqb1F1NDVNa2R6N2ptL2d0U1FOUVhUTnBPVmg4QllNaDA4ME1KN3lJRnBYV1l5UTRsbE96
MTIzSmcKb05vcUhJQVlkcmZpVzh4UU1CRC90R2JvK3lLQ0JWcXNKZk9lc2E0R2oxb2R2VlVzTWxk
eEV5dUgrQlRWWDYxdwpJajMwN09DZXlaQ3dPSmZZellGNjhVZXUrKzVVdEpjYXJnMVhwbnZ6ZkJQ
dXUwWkVwc1h5QnNhZmxDUDB0TmUvCnV2S0NReEpWeTJ0Qjd3Y25iY3Y5dnBtUXI0OHV0QUtzdmps
eFgycWp1UkNGbTkxeURuM2hScXF6dWdPUHdXc0MKSjhsZkl5V3lvQWtIWDRVSXdWTE9hZmpwYUdC
TXR6TWtoY3QvSjZJNGFDbHZUZVl2R3grdTVUYUlVVkxzSE5NRgo0NHZVVExwVUlPSktrajRjaW5r
WmNSaVdSa3ZSMWR6VStuQy9FU0ZGdklXZDQva21hbTVjL0xxd0Zub0lLak5LCkVSSzZzN2QzOERI
YUNZNTBzQ053TmtxeHlqVTNJNXVsNnpGbU9rWT0KPTlkSU0KLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000eab215064b793b14--
