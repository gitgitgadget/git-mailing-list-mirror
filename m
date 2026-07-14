Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 302FC364929
	for <git@vger.kernel.org>; Tue, 14 Jul 2026 10:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784024399; cv=pass; b=hxGsFPUB6KGSkI7Ya1ThwOt2lJsGYYAxxHb1s7vMCqkJ20QN7glh4mEDtGfFIirlubve16s2+pJ6ClEYjj3ulVuaJqMMYxQVwaMAeEiV4ZXDA7T0XQwbj7VkA1MZhQTf8/bo7VU4j+qWgiUIt4WayITbvK8O6MMhS1LrUyurvPY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784024399; c=relaxed/simple;
	bh=VldbfcUZiXyKgZUr+Sr93vILdy/FxIpkqW9DnVu06SM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZCD/05+D68RfOUsLu4atXIXjS5/BSEdGu4cceUTHKV6szgacLps1UHM7sBM0j428pxG4Ne5jdOEunBiAelIpR57ITcWTljZb2m+IQbhHyGzHrMXbBy/1223fqTg/ox7ocDz0OAemiS4JZnYGsOFwH0j3AhexH/cqq2//LJN56no=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iq7r6Nfl; arc=pass smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iq7r6Nfl"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6974a6e54dbso1061469a12.2
        for <git@vger.kernel.org>; Tue, 14 Jul 2026 03:19:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784024396; cv=none;
        d=google.com; s=arc-20260327;
        b=Y0Xx/gJW2mFa0QQTdOAXo9Y5WKfZPfyvDNL0fT5ekMNOkrSgvFMp45BUv3GPrwFUd+
         tHBF71mBE0Afv2iQrQpZbmiy98PhvT0ttDYQ9WL3ByqRM8ksNSEyrjjiEK2mO1GH72hR
         sm41AFz+oNFR0evHNdaEPsJDyDixqhpAx0W7uLBFiw31gy7UOupO6deBSRoPUtxqreI/
         Z1k7u5O+MQR9JmvJAV2pT5lR/UXouFxYli83X1Wss7fOXgI60/tUA4E4bDj38M8P5Xwx
         QsZa5Eu8O8TJOj8Ya+/IN6QR4qHo1bGrJLIVczfTr44r7sLUJNd9/q5OHl8mVK5wCr4s
         eE9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=aTMO6RfHBC7VmwrrxbW2xu+M7u7FA1josNJT0Bpg21o=;
        fh=zAYt8gZv0tqRwIi1hbEToHhKPxIDdbA67KdSJ84wYPQ=;
        b=hA303c5BPk8K53fHKcRyPMuK32qrqvs/7xhqxRKUAAnU5ANvQKkURlVoIMtuIMCW7w
         3WFe6t7g/cZsf4VtvL4X5djxD+ATLvlL1o5f14chLVmLP0WylSijAoaGxEcpQ37fcOXd
         P0d6e+Ha6Nsdl9+daOL2rDTG3VkQW3aIbwj/bmsU9Ox23jMpGk4I52Bd9HYMh8ZAI0u0
         Dcpi5/tffbb25RfCTOP1fuo5rs/s+YUm/moOpxVT0flwvtltAvw7XlonBf7Z5nW23mzW
         Taz3EyWhMxKTr82akv4gVJG61NkWgPjUBJ8K28+jjD7vA0oK2QrXPZEYaKX2CsQWw1u1
         3bdw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784024396; x=1784629196; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aTMO6RfHBC7VmwrrxbW2xu+M7u7FA1josNJT0Bpg21o=;
        b=iq7r6NfldrlJTMC8SJaJuqNj65JW4iq79uFq/R3o3w0ESLuQoBNGTvhXLubYJMJVNM
         umoicwmaVmFQrgmTSGc5EBz1Lq/VqXaqBsd1Pj6hbAh8zTV1yBN2/nNXevP3z3y4f35X
         Z0ijocwjrzj4/MqcwwGwCUGdK+kDQ6H2IS7zjmqf2bHeDJGYZgFRrBvHm6Ay2+jUjUAi
         a2xSZ7FDR00a8HZznEUft6Ccf50rUKIzybd2QqtL2f6Hk2oXmRVq2+Xfh0pcB8vHvv6v
         mbIXgrER02rVnGmGsY5PBq+jQVQlzSUV3SrLQvpkdOlAiu9gD2N7rA9bXWO5L6getbiF
         3REQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784024396; x=1784629196;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=aTMO6RfHBC7VmwrrxbW2xu+M7u7FA1josNJT0Bpg21o=;
        b=I2HA2FpYH6zUKmnCXIaJjZ8LN7IHS1PGre6qs8MSL6GrONoV0bh84m0TYdncfgc9vl
         cOJInSHSEy+k7BFUVE9JzmdVEczDWWZvTYEBCQAsXRddcMJdSchHRITW/Ty62WdkUwxf
         mNjBDrejdC7+bI4M78STdQaoDPyuPHP5onVFyPuqBVt5JYseyGevUjdbpoudpKrEn/TN
         TovkHIvRTxvsv+Wsc9ZFTRS4+Mqm1BIdzlcgDgH8/OHhSn1wNeCpSPPNXMg/GjnKsnst
         jaLiyT0IDLfVUgMIMgIpPhMpCTegwQ/kU44IONugPupEhMe5qfvuVRLzEm5gfSDfQgyM
         677w==
X-Gm-Message-State: AOJu0YzsWMHFymYaEzz3uz6q1Dc1ailKSTkTA8bqLW90FesZYljMz17O
	+K9UF9PIm8EB+Itr4HF+LZPSmHGJan7xXdQZlUxpvgT+XebX2F5DUC2d+t0GwiTe08WJPP8HGKY
	FDlkT9KHEDP1lLuOQsqmjgH7pUJr+Cb0=
X-Gm-Gg: AfdE7ckLScchNSfPjTSYmVhkeGGNiWJPRx1dQOeFFPhQgae4gMcHYXipLEmcSkKJFYz
	/9w4uyCO+1aep1hB/43sjZgrlKGH57yV4N/B5hgWAGsTHcBQwCO1uBl+n9NbOAJziqqcdcmS+Nu
	muyUhebm21aPL6gHL+zN86xWXkunnWaxJQ61gVNtLs4oTgMQEEgOUAqWhWU3eS7qBn/01J1B6x2
	b+b3/mYEsHaDJeZfdJ3poI8C06/D0EIxS49VliQP6IsW0wbcgBMZFNmQlngYg6LPddHnMZcEMjj
	aTMgL6rJINlYjdhuiYD/r4UvDu/aIoofhiv/d1KbtL34aOL0/jQGfYOR1XVdCJS1NpM+MwFnpna
	EZ78Dltvj588=
X-Received: by 2002:a05:6402:158c:b0:687:7fa4:faa0 with SMTP id
 4fb4d7f45d1cf-69c5f104089mr5994377a12.23.1784024396020; Tue, 14 Jul 2026
 03:19:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260713-ps-pre-commit-indent-v10-0-82ddab26bc96@gmail.com>
 <20260713-ps-pre-commit-indent-v11-0-dcb65bc4ba99@gmail.com> <20260713-ps-pre-commit-indent-v11-7-dcb65bc4ba99@gmail.com>
In-Reply-To: <20260713-ps-pre-commit-indent-v11-7-dcb65bc4ba99@gmail.com>
From: Chandra Pratap <chandrapratap3519@gmail.com>
Date: Tue, 14 Jul 2026 15:49:28 +0530
X-Gm-Features: AUfX_mxNCh1HIO9-j1tK3WNzOaRB-Nky68Cc1yijV-P2cwy7qp8BBbI0P3TbGfU
Message-ID: <CA+J6zkRXbW=bLQ8nDcbPwocetdi2JpyM_R5Gff6sMK-Gb_JGhw@mail.gmail.com>
Subject: Re: [PATCH v11 7/7] graph: add --[no-]graph-indent and log.graphIndent
To: Pablo Sabater <pabloosabaterr@gmail.com>
Cc: git@vger.kernel.org, ayu.chandekar@gmail.com, christian.couder@gmail.com, 
	gitster@pobox.com, jltobler@gmail.com, karthik.188@gmail.com, 
	krka@spotify.com, mroik@delayed.space, peff@peff.net, 
	phillip.wood@dunelm.org.uk, siddharthasthana31@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 13 Jul 2026 at 22:14, Pablo Sabater <pabloosabaterr@gmail.com> wrote:
>
> Some users may prefer to not have graph indentation.
>
> Add "log.graphIndent" config variable to graph_read_config() to read the
> default preference. By default is graph indentation is true.
>
> Add --graph-indent and --no-graph-indent options to overwrite the
> default preference.
>
> Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
> ---
>  Documentation/config/log.adoc       |  4 +++
>  Documentation/rev-list-options.adoc |  8 ++++++
>  graph.c                             | 10 +++++--
>  revision.c                          |  9 +++++++
>  revision.h                          |  2 ++
>  t/t4218-log-graph-indentation.sh    | 52 +++++++++++++++++++++++++++++++++++++
>  6 files changed, 83 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/config/log.adoc b/Documentation/config/log.adoc
> index 757a7be196..f7dfce69b5 100644
> --- a/Documentation/config/log.adoc
> +++ b/Documentation/config/log.adoc
> @@ -59,6 +59,10 @@ This is the same as the `--decorate` option of the `git log`.
>         A list of colors, separated by commas, that can be used to draw
>         history lines in `git log --graph`.
>
> +`log.graphIndent`::
> +       If `true`, indent visual roots when rendering the graphs with `--graph`.
> +       Set true by default. It can be overriden with `--[no-]graph-indent`.
> +
>  `log.showRoot`::
>         If true, the initial commit will be shown as a big creation event.
>         This is equivalent to a diff against an empty tree.
> diff --git a/Documentation/rev-list-options.adoc b/Documentation/rev-list-options.adoc
> index eaee6ee839..af74f10bb4 100644
> --- a/Documentation/rev-list-options.adoc
> +++ b/Documentation/rev-list-options.adoc
> @@ -1269,6 +1269,14 @@ This implies the `--topo-order` option by default, but the
>         By default it is set to 0 (no limit), zero and negative values
>         are ignored and treated as no limit.
>
> +`--no-graph-indent`::
> +`--graph-indent`::
> +       When used with `--graph`, indent visual roots (commits with no parents
> +       or whose parents are not shown) to differentiate them from commits that
> +       are vertically adjacent but unrelated. Enabled by default. Use
> +       `--no-graph-indent` to disable or set `graph.indent` to set a deafault

s/deafault/default

Also, I think you meant log.graphIndent instead of graph.indent here.

[snip]
> +test_expect_success '--no-graph-indent disables indentation' '
> +       lib_test_check_graph --no-graph-indent _58 _59 _60 _61 _62 _63 _64 _65 _66 _67 <<-\EOF
> +       * 67_A
> +       * 66_A
> +       * 65_A
> +       * 64_A
> +       * 63_A
> +       * 62_A
> +       * 61_A
> +       * 60_A
> +       * 59_A
> +       * 58_B
> +       * 58_A
> +       EOF
> +'
> +
> +test_expect_success 'log.graphIndent config disables indentation' '
> +       test_config log.graphIndent false &&
> +       lib_test_check_graph _58 _59 _60 _61 _62 _63 _64 _65 _66 _67 <<-\EOF
> +       * 67_A
> +       * 66_A
> +       * 65_A
> +       * 64_A
> +       * 63_A
> +       * 62_A
> +       * 61_A
> +       * 60_A
> +       * 59_A
> +       * 58_B
> +       * 58_A
> +       EOF
> +'
> +
> +test_expect_success '--graph-indent forces indentation when graph.indent is unset' '
> +       test_config log.graphIndent false &&
> +       lib_test_check_graph --graph-indent _58 _59 _60 _61 _62 _63 _64 _65 _66 _67 <<-\EOF
> +       * 67_A
> +         * 66_A
> +           * 65_A
> +             * 64_A
> +       * 63_A
> +         * 62_A
> +           * 61_A
> +             * 60_A
> +         * 59_A
> +       * 58_B
> +       * 58_A
> +       EOF
> +'
> +
> +# graph.indent true and no --option is the default state.

Same thing here.
