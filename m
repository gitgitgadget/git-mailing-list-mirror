Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ECA933C8
	for <git@vger.kernel.org>; Mon, 23 Oct 2023 16:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="E1ykdK9B"
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF3B093
	for <git@vger.kernel.org>; Mon, 23 Oct 2023 09:42:14 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id af79cd13be357-778a20df8c3so248469885a.3
        for <git@vger.kernel.org>; Mon, 23 Oct 2023 09:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1698079334; x=1698684134; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JSsOJHnNwysHiG20BGnNHzQdvBsRvnmZt382BQ3Aqgk=;
        b=E1ykdK9BjxskX0gdlBKDzm/xCcFiOWBL3TcnypnPelNXgazBeEnjyjZgqIMbhViJBL
         mGRC/6PjTocD1YoMbjGhOhYOfWOdloL23t0/UBp9HIymw05T9mGemtMwzBxYGRZw+7qA
         lFo6/QgwqAAVeIYnV8KR9POq7Sb0PueGdeb/DAiaUxemT7QeI4wytbElBdgBFUccrRWn
         q3lD15Ef8Ysxu4CqH+Smh2au68dWwpe6EXpGGIWF3/2lf1HG47VCktavXFwNNzEJwtoX
         LqTnXoRUgvVZ1RSgaA5F0Z74/k83LjlI5DYeeSBMpCSWSqXIZX8mlrT3PXwgkMCb3Da6
         urug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698079334; x=1698684134;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JSsOJHnNwysHiG20BGnNHzQdvBsRvnmZt382BQ3Aqgk=;
        b=GgCk2bErCcruvv2QLTiL/RZLlMEfxgZlNv4jmQmiALh+qTAoBole9jnokEQw6D4S4S
         5tjOdqZENhpUpmHymlkqP6gd1L4dy5rKRVYb7YkQwrPOnQ0KxeyoFYvQ3lyxVGFaaiwT
         3jeK+bb/2Gbyju4mZBcvlwyhkzFYDFeAdHJy6GLPXIyI88p9vfsbn5okvyXEuD2Io1ax
         q3aE0SeUfLQeJ1/l/TMrbk8d7I4K2nrwu8WIM4ECTKvaUoe8cx5rCPh7YVP1opW9kFpw
         Xy828N1Zqx7BctFL+5wJEh1cJQ2qrB+EFfKxSjx5gAEdSo4N8RovVlbaaNoB7j2c94NL
         A6Xw==
X-Gm-Message-State: AOJu0YyU716MhhWgBNxUyI5ZXgC61vRl7ZiAR9pHLiv5R/PFoPgf1skR
	Bb7bHtk6CGcFYAODVi6YWsIetQ==
X-Google-Smtp-Source: AGHT+IFjERpguxKptNO1Td+/2RuAkDzKvMcJDGlj3LROKw3Bybk/LzaBrVvIs/p3C+k3ItA2fTBJfQ==
X-Received: by 2002:a05:620a:2909:b0:779:e02b:26e2 with SMTP id m9-20020a05620a290900b00779e02b26e2mr2158911qkp.25.1698079333919;
        Mon, 23 Oct 2023 09:42:13 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id z13-20020ae9e60d000000b00774652483b7sm2812351qkf.33.2023.10.23.09.42.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 09:42:13 -0700 (PDT)
Date: Mon, 23 Oct 2023 12:42:08 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH 08/11] t4207: delete replace references via
 git-update-ref(1)
Message-ID: <ZTaiYEyhKT/yZwHZ@nand.local>
References: <cover.1697607222.git.ps@pks.im>
 <c4d09e3e5dbd11221cc4d229b815434d441cdb4d.1697607222.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c4d09e3e5dbd11221cc4d229b815434d441cdb4d.1697607222.git.ps@pks.im>

On Wed, Oct 18, 2023 at 07:35:37AM +0200, Patrick Steinhardt wrote:
> In t4207 we set up a set of replace objects via git-replace(1). Because
> these references should not be impacting subsequent tests we also set up
> some cleanup logic that deletes the replacement references via a call to
> `rm -rf`. This reaches into the internal implementation details of the
> reference backend and will thus break when we grow an alternative refdb
> implementation.
>
> Refactor the tests to delete the replacement refs via Git commands so
> that we become independent of the actual refdb that's in use. As we
> don't have a nice way to delete all replacements or all references in a
> certain namespace, we opt for a combination of git-for-each-ref(1) and
> git-update-ref(1)'s `--stdin` mode.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  t/t4207-log-decoration-colors.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/t/t4207-log-decoration-colors.sh b/t/t4207-log-decoration-colors.sh
> index 21986a866df..d138e513a04 100755
> --- a/t/t4207-log-decoration-colors.sh
> +++ b/t/t4207-log-decoration-colors.sh
> @@ -71,7 +71,7 @@ ${c_tag}tag: ${c_reset}${c_tag}A${c_reset}${c_commit})${c_reset} A
>  '
>
>  test_expect_success 'test coloring with replace-objects' '
> -	test_when_finished rm -rf .git/refs/replace* &&
> +	test_when_finished "git for-each-ref refs/replace*/** --format=${SQ}delete %(refname)${SQ} | git update-ref --stdin" &&

Here and below, should we avoid the for-each-ref showing up on the
left-hand side of the pipe? I'd think we want something closer to:

    test_when_finished "git for-each-ref refs/replace*/** --format=${SQ}delete %(refname)${SQ} >in && git update-ref --stdin <in" &&

But having to quote the --format argument with "${SQ}"s makes the whole
thing a little awkward to read and parse.

Do you think that something like the below would be a readability
improvement?

diff --git a/t/t4207-log-decoration-colors.sh b/t/t4207-log-decoration-colors.sh
index d138e513a0..de8f6638cb 100755
--- a/t/t4207-log-decoration-colors.sh
+++ b/t/t4207-log-decoration-colors.sh
@@ -70,8 +70,13 @@ ${c_tag}tag: ${c_reset}${c_tag}A${c_reset}${c_commit})${c_reset} A
 	cmp_filtered_decorations
 '

--- >8 ---
+remove_replace_refs () {
+	git for-each-ref 'refs/replace*/**' --format='delete %(refname)' >in &&
+	git update-ref --stdin <in
+}
+
 test_expect_success 'test coloring with replace-objects' '
-	test_when_finished "git for-each-ref refs/replace*/** --format=${SQ}delete %(refname)${SQ} | git update-ref --stdin" &&
+	test_when_finished remove_replace_refs &&
 	test_commit C &&
 	test_commit D &&

@@ -99,7 +104,7 @@ EOF
 '

 test_expect_success 'test coloring with grafted commit' '
-	test_when_finished "git for-each-ref refs/replace*/** --format=${SQ}delete %(refname)${SQ} | git update-ref --stdin" &&
+	test_when_finished remove_replace_refs &&

 	git replace --graft HEAD HEAD~2 &&
--- 8< ---

Thanks,
Taylor
