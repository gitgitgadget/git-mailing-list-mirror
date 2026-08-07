Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98819246770
	for <git@vger.kernel.org>; Fri,  7 Aug 2026 03:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786071655; cv=pass; b=A/YgbgE5LrHab4ImZFJ1ilFGkQE8aZtoTwE9Si7D5LXv+x2BjCLZvhrfNE9fIlE3BQYFYzAmSxcsG1iJCIPZMQw7mBSxdr19l/N+Jo1O4y5nc+1Zeqi5BaR+V0VCFUUHRzI2Fqr4zoCAFzmYMSaujC17IsI+ituvuHvFZQ+SMBM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786071655; c=relaxed/simple;
	bh=6awdshfsZBUoR11gJUrNbAJFsnKMfdzlzwCr/GXyX0o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ND8gIZlHThg4mwaDXIyBSe16thcue82oY1tllVqI9AVfARpEPnp4x9z1xiHNn29Aul+B0Ni5jSBi2S6rL+eDVgVKsT/vu6h+K9x3mPu7/ud4fXeQB9OhwR6okRHkNV0LDasqreKcBX/OJOKbZH8HwDzrElE1dzJijQwqCIFgM1M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MhNmvDK4; arc=pass smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MhNmvDK4"
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-6ae8c4b9822so1287644eaf.1
        for <git@vger.kernel.org>; Thu, 06 Aug 2026 20:00:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786071652; cv=none;
        d=google.com; s=arc-20260327;
        b=YLqUz52wMW0gQqzaa/jtzLm6INbiSNs3gAe32rBYvbY1TuIfcqXxDPY8W2l1lQkm5M
         2eAX7GtzVq3m+/8aKHZ1ezWjO9+YgP2q0LqtCOe+uznICPKEyL01kA8b85P7/vttCmSK
         a+qSg6eInPaBkMGiZaH8Mk5pg/x2xS2Fdu2HeOSGlLkL2T4Uo+JB2+W7odp41pCEn8sK
         1QdZ9fosUTgYolZ4Gr3Ao9/yDnSRxOLxnKi5oHinGTQoB2dXBvCAsjIGCgKUaZNiKvfW
         Gm36hfT3joicMOnUWo5kFHR7bt0mAn7Fc5JGQGc6a5PQ3/0+ShpBY5GMcAsrdTOsVoUD
         CU/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tBwasWS2MM2jZOyIoqxULGXHrv2qo1JacCuWVYVaNLk=;
        fh=PdGuLsJN9JVZy5BHY9bPXqzeWCeYFKwbJ2iGslXTO1Q=;
        b=jE5+5xDjec9DP4YlXPy/ypdb/b7QbMSnbGtY1cqL54u07w5ACByxR6akGba6LrLJat
         pZMZ0Fql0sYwNaBxrXig+nbeNVZIcKEYJrgZToc/JcEG6MkwCJkjlxXMo4TR9Hr5KJ6S
         2+SavluPC99JsCcLgUAbXiJTCttdH9LUrUq6b0DV38JRWICtvuLrTBFg5QlYVHAZx7DK
         ko0jraJnFnzemegAElsByaO36zC05c1aR9qbyuka4r7QQlQrCwlq+RY3S78SgVfasiTX
         2v/9grJeqhxbTART2yuBaR4WkK8cHDKcGIUUebZ91CW3uEpCtIYmYRwvtHg5CBWcbOU0
         oDqA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786071652; x=1786676452; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tBwasWS2MM2jZOyIoqxULGXHrv2qo1JacCuWVYVaNLk=;
        b=MhNmvDK4R4CDpimNs0tP5IMHMyLjKVtU4wqaKOezOIpCGTMlEbR5UmP2q9GBuyT3JV
         r0w6/owmb5p8hUOy8f3HeQ4AUljYLa+hxwswHYX0Pd8W75xFhlu81mKmYZS2Q4SfaVL3
         OMcHm7UdJCPjngOlVfXZMiwWmCQs+tLzf8oNHn7V1vHaOMrueFvBb+D3MDYtUTmS05fs
         uF8c3NP+QTaroCeleiHyZHCEw6LDN4qNABtUIoNhFdDiEkd4sblrX1fGxPdXNrhlLZDx
         ywITNsh+SHAWmw9PC0qNGKoUviVb1VrMHrk2JTcGYHTJRUe7VC5xH8Cu7IOXu944Yy+h
         xLWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786071652; x=1786676452;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tBwasWS2MM2jZOyIoqxULGXHrv2qo1JacCuWVYVaNLk=;
        b=Y2eQzvT3I1JF0SVMZj+0nbcI8ozDoPlDjo4yOXj155zHuNQRRtaZA5bj5az7HvjdBH
         n6rn68l2vRnBys7q/E73gJi760mBC0nFRX7bgilBiS/dVKzGeMiedTLvOsPJRA/8815c
         JZiKqsmMSlr0hGcISsAPNxxfFQniextMXApr2vSszDSyGMsoN8GTgJqQ3CP9BgNtia0w
         KhvyTfvSBoaxkZG/6FKZ/hmDRaqO/Fvrjgd+ek6jfWSzzg1ezQtDqCgITVCIPfsuUJ9R
         CdeosR8JW7Addda753I24sGisHhv+u1fLP3jZxVRkdpI34IJ1kWGkhTosKMRhPYAHzfV
         0Hgw==
X-Gm-Message-State: AOJu0YxUHbFjNaE8A5DXe0hH2rePKA77D8xUtXV8aG0wMPz825QLJheC
	PCPzsziH3fOsDQAxbM7Jng0zql8GpNdTwVtQnT851sP116Q+r8e+eY8+R6JlBJiQ42XkdqemudC
	fRg37ElG2uOUX9K0U/1h4NlW5HzJyXKw=
X-Gm-Gg: AR+sD12gGWtGu7BAeBClKKD9qvuuUU9ttwvReqPbDi2uF72+sQU1ghnDZnLKzsz6Cyd
	4zt/A2WNcBYuWsDuVAhKkJ9EVwMESJ7bzGT/Bh34TiDEdBrUauqzGz3e+2nXvcGQ+GHhH3Fkcf7
	VPmAtb0KknAVNKKiQFRMl5J8x9LIpOyEQNiupwQ0GPmFDt4ferI4/7ctcVjjRdSo9UpXPpVQr8n
	ML6NGsfBUAWlf+yWvNXK80kOOYndmpuqx9CTQxV3KTXOfoyZKCtmUfajDZuQnyh9/xW5p40zNxk
	LWheAPHcJdKpTf0vuQggvX7FEQT+djWfuVxWToOvZZHSkrrUkvfnRKo/keXtbwgMoPQQCar/DgD
	GBsYtQ+hfsadDP0LP48gjcF4aLAkUQHc3PQRPr0/ifuBT8LKtjmlHYtuVcTtgMg==
X-Received: by 2002:a05:6820:2083:b0:6aa:da04:b56f with SMTP id
 006d021491bc7-6ae96c10163mr10087769eaf.3.1786071652371; Thu, 06 Aug 2026
 20:00:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2149.git.1781951820.gitgitgadget@gmail.com>
 <pull.2149.v7.git.1786013982.gitgitgadget@gmail.com> <57ecc0b18a53ac567c24d90288d75aee16eefc01.1786013982.git.gitgitgadget@gmail.com>
In-Reply-To: <57ecc0b18a53ac567c24d90288d75aee16eefc01.1786013982.git.gitgitgadget@gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Thu, 6 Aug 2026 20:00:41 -0700
X-Gm-Features: AUfX_mxxpZlMgutoNamN2GZTmXLiKLBIirSBrO252dfGDwb3RX6kDwAat2PZ3y0
Message-ID: <CABPp-BFKNkXB0gBDVhS1szqkSv0pOYepZ-hJhxQro-ViphDPTg@mail.gmail.com>
Subject: Re: [PATCH v7 02/10] test-lib-functions: improve diagnostic output
 for trace2 data assertions
To: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Kristofer Karlsson <krka@spotify.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 6, 2026 at 4:04=E2=80=AFAM Kristofer Karlsson via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Kristofer Karlsson <krka@spotify.com>
>
> test_trace2_data is a bare grep that silently exits on failure.
> Add a more informative variant that verifies the event appears
> exactly once and reports what went wrong: key not found, multiple
> entries, or value mismatch. Diagnostics go to FD 4 like test_grep.
>
> Before (value mismatch):
>
>   $ test_trace2_data status count/changed 999 <trace2.txt
>   $ echo $?
>   1
>   (no output)
>
> After:
>
>   $ test_trace2_data_singular status count/changed 999 <trace2.txt
>   error: trace2 data 'status/count/changed'
>     expected: 999
>     actual:   0

Nice.

> Signed-off-by: Kristofer Karlsson <krka@spotify.com>
> ---
>  t/test-lib-functions.sh | 35 +++++++++++++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
>
> diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
> index 809c662124..8c6d327b03 100644
> --- a/t/test-lib-functions.sh
> +++ b/t/test-lib-functions.sh
> @@ -1996,6 +1996,41 @@ test_trace2_data () {
>         grep -e '"category":"'"$1"'","key":"'"$2"'","value":"'"$3"'"'
>  }
>
> +# Check that the given trace2 data event has the expected value and
> +# appears exactly once.  Produces a diagnostic on failure.
> +#
> +#      test_trace2_data_singular <category> <key> <value> [<label>]
> +test_trace2_data_singular () {
> +       local category=3D"$1" key=3D"$2" expect_val=3D"$3"
> +       local label_suffix=3D"${4:+ [$4]}"
> +       local kv_pattern=3D'"category":"'"$category"'","key":"'"$key"'","=
value":"\([^"]*\)"'
> +       local actual
> +
> +       actual=3D$(sed -n "s|.*${kv_pattern}.*|\1|p") &&
> +
> +       if test -z "$actual"
> +       then
> +               echo >&4 "error: trace2 data '$category/$key'$label_suffi=
x not found"
> +               return 1
> +       fi &&
> +
> +       case "$actual" in
> +       *"$LF"*)

Ah, you've got Rene's suggestion from v6 included as well; nice.

> +               echo >&4 "error: trace2 data '$category/$key'$label_suffi=
x has multiple entries, expected 1"
> +               printf '%s\n' "$actual" | sed 's/^/  actual:   /' >&4
> +               return 1
> +               ;;
> +       esac &&
> +
> +       if test "$actual" !=3D "$expect_val"
> +       then
> +               echo >&4 "error: trace2 data '$category/$key'$label_suffi=
x"
> +               echo >&4 "  expected: $expect_val"
> +               echo >&4 "  actual:   $actual"
> +               return 1
> +       fi
> +}
> +

Function appears to match the comment above it and the commit message.
It looks like a nice usability addition.
