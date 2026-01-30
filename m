Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1AE721FF49
	for <git@vger.kernel.org>; Fri, 30 Jan 2026 00:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769733009; cv=pass; b=MPLmec7iWeEg3gz2M8gTQ/MyQk6QsEzBCLMy4z+6/Us917ry/0XeCjcTq1FloNV94n7PeASnjGxjNabo80d3a7D3bGUg4O+OumgPes95F4adAqL4xta7eK3oIRGIb8J9oL+WIFqd/jtsqf2k43SCaQgwiN+wgVRK4yN8eZ3eshE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769733009; c=relaxed/simple;
	bh=nMCNHLgLZFjqAXrqbhEh0sGe4TVqwukoGqxfkAFiqIM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lbzglh28tH4VmUvi2wB02OVOux6+tKJG7V5om3MpI3XByHD/ZeWOe3dKWtAULWKg90wkAsKofvsp3mtghAZvrDaEcrG+mKrCVAH3xhH6j1Phb8fnzxj/8GW7WJy2sHElcwagUAZyAEhFf9yG5LxCGLiVi7rEjs0pTi8O7fCFIM8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=pass smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-2b1769fda0eso8342eec.3
        for <git@vger.kernel.org>; Thu, 29 Jan 2026 16:30:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769733006; cv=none;
        d=google.com; s=arc-20240605;
        b=JDb5eJ0GyJ6II7gPLeU0BW8YBqOE7fenNKVCukIX/UufeHN/C7AgrDstNA6gFVYQU7
         GJ3ww3mJC0bBaJn1jXAAgGwgYfV9Jh0XhXwO0oe5R3SrK4W4HSg/QoVlzOOVviQ1638u
         AnzAeIIRK3AH1D7ZmTDa7w2ZjrbfE8B7xE5+gpnfPChq4NoyMV+AGkLHiZxQbmvpFXfv
         B6Ab9KIQRbjA7uMbIK2aDMVQoGnQZ7a+Wm5UfxBSYgVLJoT1T2G2Y/SmWq2P8zgnMfuy
         VguA9PiLdAxPKb44QLYJmxo1m98JLkL7u7mVdyxD06LioIstXmHwazwgpx4OGIL6ZC4P
         mPXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=Xyzbzzq3BpiuK9j23lzre+b6qDf2oIrRtVU9ZOq0BUw=;
        fh=D6OvNID0dZHG2kn7+Sht5RAr72s3bxcZr0mI+UFw7rQ=;
        b=IGU7Nqw9P6nVGaD7kjdquQy84H2Tw0CunHOXd/jNegIl7Kvkb8N1E8cjjiVadGRVVr
         QR+VUIelvLfTgmBV8p+2cZIjsaHMbxr3R5IS5gA64Isgo3b78l+FVSIA71nS7KRcIRwh
         PaA62pwKl6b71gesKRt+iXJkIBGcpDTJyK3I1r0/HZh7ccEx0+RF7H+dN35hvgPJeqyM
         LIuf6CuKC6VQ8HpT0UzwcOMlMaSOBPreXmQ7gqm07lXmTJVWnvO+A+7UrEIJZ2I42JA6
         lqeaeq7agcG/Y8qEWmXL/tbvlFoEFEdm+JYNxr0BN2g4YjFoG+ok4CB2/vZBRDAQsWak
         /xAg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769733006; x=1770337806;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Xyzbzzq3BpiuK9j23lzre+b6qDf2oIrRtVU9ZOq0BUw=;
        b=H4yb4Sg0XsoAiIurdHAyYkyIr3bcb112xhtSb1apSISQ/XZ/SXhoRY3+KVETCFjd0a
         SkxS+1LS1pMfSis/TKlFYova2rFzbVE4hGbhklhMd5J4bUPf49iHBJjZkRSqxfOgo4f/
         xB92S8KZbr/vKte8TqbgEknqFJqM+JZcLKk0uJmq1wTML9ThI54zoax1ZrOVGG2BgGEP
         xAPWVfhbWlyUkgsf2stNTS0Kk+EzVnDelNJ3UjhqKj4nRWRYY2YXrYVGAMlrf6LF0yRt
         t+sVLOlEPR7XC3jlWwMAGCv59D35pROFjm0CFjGkJzjZY9LtuDquACw5BKXGzKiJXUHF
         AIvQ==
X-Gm-Message-State: AOJu0YzLBP5DfjJ7dPGT4SnWuOOWQR12b/ULLp5pM8xIojhuxnPRIiz8
	BdSjhASnJQqqLA4JMDvPqhAay8McpGXlgdjxACFm8nUt0xHgaCrYDHU6z05t3uVKmkckRTnhokc
	eLAW9YA6xCqQdzy7Esg904gg7vTnLh8A=
X-Gm-Gg: AZuq6aI0VK5uDWnzs+/TrQoKeiwKYGKyXYmDd/8v7dJ6e/XtSjBD385KAD8HEtfX9mN
	wPLDH8YVSyEk6aQ719gW7O3JRCOQwCy/H5V2+I/n2dJEQL5U5PbOFQJBTUEL0n8c5XVjzVrxf46
	76ZRsEXlOLcfZLP/Wp15JpOhRaRztokydSojqiCwTVVcP8q85oxiqACzyNA1Y1ss4w11uAsMAtf
	PbFTKtQ2qtya/lHpP1ogp3f/sRyz3W6O4fgZuRtPof/SPgeyaRaLRud5R4qkfPCo3Ztpu8mLA==
X-Received: by 2002:a05:7301:3d15:b0:2b6:f2d5:2923 with SMTP id
 5a478bee46e88-2b7c88eae8dmr348378eec.7.1769733006466; Thu, 29 Jan 2026
 16:30:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2135.v2.git.git.1766168169.gitgitgadget@gmail.com> <pull.2135.v3.git.git.1769578785381.gitgitgadget@gmail.com>
In-Reply-To: <pull.2135.v3.git.git.1769578785381.gitgitgadget@gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Thu, 29 Jan 2026 19:29:55 -0500
X-Gm-Features: AZwV_Qhah31scU4EpO6hEmF2eIHf-8mrbpMpkuLGl8AaTuS3t7Ild7zAakYSIJU
Message-ID: <CAPig+cQ+HWZDb5ArGBq8PkXu1X6Dwe79w0sVjX9uRm7PcEwyNQ@mail.gmail.com>
Subject: Re: [PATCH v3] worktree: clarify that --expire only affects missing worktrees
To: Sam Bostock via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Sam Bostock <sam.bostock@shopify.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 28, 2026 at 12:39=E2=80=AFAM Sam Bostock via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> The --expire option for "git worktree list" and "git worktree prune"
> only affects worktrees whose working directory path no longer exists.
> The help text did not make this clear, and the documentation
> inconsistently used "unused" for prune but "missing" for list.
>
> Update the help text and documentation to consistently describe these
> as "missing worktrees", and use "prune" instead of "expire" when
> describing the effect on missing worktrees since the terminology is
> clearer.
>
> While at it, expand the description of the "prune" subcommand itself
> to better explain what it does and when to use it, as suggested by
> Junio.
>
> Signed-off-by: Sam Bostock <sam@sambostock.ca>
> ---
>     Changes from v2:
>      * Squash into a single commit
>      * Expand the prune subcommand description per Junio's suggestion

Thanks for re-rolling this patch. I think this version addresses all
the review comments from Junio and myself and is ready to be merged to
"next".
