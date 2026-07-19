Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6EF2DB794;
	Sun, 19 Jul 2026 17:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784480686; cv=none; b=L1tBCa4z7M2uJJ09CleUrDLYltfHpojz9PRWhNVxu4E7VmbpBGo6GhZ8KFf1/vfwCvLb58B7pD9+W7YyyelsTr5Itx83DVQlhXrx624pE7PUCsODVY7pXia8dwbGa8isl12lzG1OZIy8dxwAvSXkTfpBprdgoXQLM0VamNpF5Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784480686; c=relaxed/simple;
	bh=LDMvXpITk8fyzYZUSvXoH0pkZOiI7+cBGBOo7M50eFI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SUHbiEGV9Yw8nFnwIz4VrDykwCNoU8rQdIf0zcPC4FeWOgpDTvZ//isOhwz1Y6XeTxJIbVWQs/U546MMoBCZgZb+FeXgcdVBkDc4IUl1iZyNT4kutuzhiGj7Y8JcGrEixrINSI3GGfUQLgqpyuvQsiDb7Xc7mgCUma4P1Dv0k1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=YmVCHISS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=brPN5hWd; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="YmVCHISS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="brPN5hWd"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 85F17140003F;
	Sun, 19 Jul 2026 13:04:43 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Sun, 19 Jul 2026 13:04:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1784480683; x=1784567083; bh=cTvw/tRsE6
	VT+cLfVt5gjDER0cyPiOf9zuq+J7IEXIw=; b=YmVCHISS1w8o/fnCqLW94XQe3F
	g096RD2oV4OqfT1YcuepQr7ydxJdTXS9M2E/76P0JT6engs4NMiXFzPp0Rdnoiyd
	sIba5+Zf3qwUe0+7RtWBP826KXbHXVfyznwujpcnDb/cZy0MI/HH0zCZOX8a3+Qc
	Pl+ZiaEreFgDIBnRsktdsbcBnWr+Xj3wOxbFLXAJkVbs7GRUoSXjvPR6sQmDmCV4
	6+l41mGftwlUCUuif5h842Hj5EfB6ZtsMFoF2DJRG4N2ULTGBBgMJ/LFgSjLgqX5
	XDtO/F1+ix0JkBs9myoNzWnH2oQwDSwTCdMAQiyo6nJ1JB2f5VQcJ3q40XHg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784480683; x=1784567083; bh=cTvw/tRsE6VT+cLfVt5gjDER0cyPiOf9zuq
	+J7IEXIw=; b=brPN5hWd+P0y8JREifIlDgryaY0BrW2REa9+lQJ3vCRFUA+hPBN
	LnZXV9o9JDdUIXTLpNDLdunzvgd0Vy1h2X2dARK7rvaig0QifbvO+TAA+DNNSje2
	SBxxLpH5YJuL2xpRhCs80je4cRduuIjDpvl/HWBLT51AWw+r1jXHNHbkdg9lsp2H
	xfo0op74zhExDsg/NNjaA9OZChKrwltTJV6Ejxwav52bw0Jzgid9SQWhMFOeZWSa
	B03mLMH3mm2JEd9BOuvACazJWGeDnZR3Bfeqm5KfzOwRWRsplgEn688ULK6yLh3L
	edMIq43YhnKlFU8ex7u22sUlLmnYCMLbnLA==
X-ME-Sender: <xms:qwNdagAJGltOqNKktbY8LwUpU3KKIsMRbaop0qBhrq7nXEyxatijhQ>
    <xme:qwNdaneKuIf6nnjnGlM49CzLtMBDNGzrsIOS8lURBd9ylH8EhMJqLWKnNblyYjsuQ
    IFxTDMj6C3vkB89wPvHTMa2s7SnUw5XEnOeHv9SETrhmGthq8gcUHY>
X-ME-Received: <xmr:qwNdan0OLu8kUkxvLUa08-YlfKzO_g24KexPcCweCTvjoO5rWEjvfX7LTF8sofY7S3_N4O4nQGhOdRcIBIoSzli3bhh-fW2_lg>
X-ME-Proxy-Cause: dmFkZTFQdwv5mOcHkhQlvUaZ4PmcyFObBeWlz4wHi7zxkUN/hFgfmKYfC0jQaH7nHp2r9s
    tXDcxNNXsZyLLKpyuXQ4GGbOt4yQPo2DhUTr6qByAJ/aWx99klkUrOgEq41Pyc5Pyv9Qpx
    sTj2GrOUGl7ylo4y0pwM9TUVQU5mKoHu31Si1TkXrbJkCRscK9tUo+bM4KBZLKs5EfInPX
    7ZgXeUqeCXEXoKCjeWZOnGIZhZ8XFU0PoEfYPqKA9NKEm4mI3+gm9lR1hCRXKwSBMi+QK5
    xCL7sZHpXAQHgs0ZVXMdWEMvHf6iU/jazJcLGBNYUFVCZ8vgc54GLpnaEIgUXLRf1oUXsL
    QsiJgtsnBekuBkI96Hzbt1P07K0cYAQ/RjC5WfbnkDkdUvZQAIZkZ7hpI21mwURyWq4lzX
    vQQsYVTmCzs90r6aWq5Xc12ZnTZFcfIrYixXVHOvUBRRbAw5oEICTqHAQ+XB8gpOt3tF4F
    +CEi31feQHom3wWo5wsg2Xwt05Al+JofnNxQrvUO0+Y9KwIkWd4yze/60+ExqtRlc9ylJy
    OZGvtASXsS6WUmXoc5liqq2GXON8xhqUlOySeO/bDvfKDKakAfoC1+TZN8JJ7uv3N4zEXi
    +RYw2YbEwvsPh7O9/Q4CvV1Bs/g7ZfMXx+betSQO5GoOsUnWJRu7uGFcHq9g
X-ME-Proxy: <xmx:qwNdamgvfgpxxEcte-DdVr7O77aB2WZIWMYNWZMT47BA_2U-VmjVRQ>
    <xmx:qwNdaombOIN383Z6PQ30K0xbRKSfGFUwNPct-RSp6olmHs5cBDl3AQ>
    <xmx:qwNdakY272JVOcgvyPQTVFEYLT4gYfgEbwg3qcxYo2Jyb-9y90nHJg>
    <xmx:qwNdarE4yzrXkQ4pkO6izjXIBhFst26g83dVXQ-kvWWmdfJUE1VhRw>
    <xmx:qwNdaj4K3wEx24STQ8ByrZogMV8oWFI5BcdYhl6dj1rZaipPw66BEyAD>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 19 Jul 2026 13:04:42 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>
Cc: git@vger.kernel.org,  Thiago Perrotta <tbperrotta@gmail.com>,  Philippe
 Blain <levraiphilippeblain@gmail.com>,  =?utf-8?Q?Rub=C3=A9n?= Justo
 <rjusto@gmail.com>,
  Yury Norov <ynorov@nvidia.com>,  linux-kernel@vger.kernel.org,  Codex
 <codex@openai.com>
Subject: Re: [PATCH] completion: complete paths for git send-email
In-Reply-To: <20260719134447.381835-1-yury.norov@gmail.com> (Yury Norov's
	message of "Sun, 19 Jul 2026 09:44:47 -0400")
References: <20260719134447.381835-1-yury.norov@gmail.com>
Date: Sun, 19 Jul 2026 10:04:41 -0700
Message-ID: <xmqqwluqnc5y.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Yury Norov (NVIDIA)" <yury.norov@gmail.com> writes:

> From: Yury Norov <ynorov@nvidia.com>
>
> git send-email accepts either revisions or paths to patch files, but its
> Bash completion only offers revisions. This prevents patch files from
> being completed. It can also make a prefix such as "0" expand to an
> unrelated hexadecimal ref even when matching 0001-*.patch files exist.
>
> In my Linux tree, an attempt to autocomplete the standard-named patch
> brings a random hashtag:
>
>  $ ls 0*
>  0001-bitmap-drop-bitmap_next_set_region.patch
>  $ git send-email 0<Tab>
>  $ git send-email 05c69d298c96703741cac9a5cbbf6c53bd55a6e2

Wow.  Even though I use nothing but 'git send-email' when sending my
own patches, I have never noticed this behavior.  I guess that is
primarily because I only use the command via my own wrapper script,
so the usual bash completion kicks in only for filenames in my
workflow.  Since I store my patches two levels deep in my working
tree (for example, '+outgo/topic/0000-cover-letter.txt'), I suspect
that even if I got rid of my wrapper, I would not suffer from this
issue.  An attempt to run 'git send-email +outgo/contrib-doc/0<TAB>'
expanding the trailing '0' into a hexadecimal object name would
indeed be quite annoying.

Good find.

> Introduce an append variant of __gitcomp_file() and use it to add
> filesystem candidates after the existing revision candidates.  Keep the
> latter because revisions remain valid send-email arguments.

OK.  I will need help from those who are more familiar with our
completion code than I am to properly assess this change.  Any
assistance in reviewing this would be appreciated.

> diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
> index 55dc9eabf..e87827f21 100755
> --- a/t/t9902-completion.sh
> +++ b/t/t9902-completion.sh
> @@ -2777,7 +2777,17 @@ test_expect_success PERL 'send-email' '
>  	test_completion "git send-email --val" <<-\EOF &&
>  	--validate Z
>  	EOF
> -	test_completion "git send-email ma" "main "
> +	test_completion "git send-email ma" "main " &&
> +
> +	git tag 05c69d298c96703741cac9a5cbbf6c53bd55a6e2 &&
> +	test_when_finished "git tag -d 05c69d298c96703741cac9a5cbbf6c53bd55a6e2 &&
> +		rm -f 0001-example.patch 0002-example.patch" &&

If the initial 'git tag' fails, 'test_when_finished' is never
registered, and we end up failing to remove the '000?-example.patch'
files.  The usual way to write this is:

 - set up 'test_when_finished' with a body that is written to
   succeed even if the clean-up target is not present (your '-f' in
   'rm -f' is good, as it prevents 'rm' from failing even if
   '0001-example.patch' does not get created); then

 - write the test code that dirties the state (requiring clean-up)
   after registering the 'test_when_finished' handler.

That is, "Prepare the clean-up first, and then you do not have to
worry about making a mess."

By the way, the use of a purely hexadecimal string as a tag or
branch name is highly misleading.  What happens if an object exists
whose name is identical to that tag?  Git offers ways to
disambiguate if you really want to, but I do not see any reason for
a sensible person or workflow to deliberately place oneself in a
situation where such disambiguation becomes necessary.

Of course, that is no excuse for the bug.  Our completion script
should not misbehave, even when confronted with a workflow that uses
funny-looking tags.
