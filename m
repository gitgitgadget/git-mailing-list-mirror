Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1DF922EE8
	for <git@vger.kernel.org>; Thu, 29 Aug 2024 01:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724896749; cv=none; b=X5voqU5j30SK3IXrP+gkwU3p6KMWzy+2wGj/Nw/fHI0Ix0U1BUfjr4w8N3rWiFUxaoHWSP/X/mjNP2hiB+bSBNbwkwdry6G3pHyvgH+IFGxCes60gRxfPwIQCSLfS8rOaQ6Ebe07yLbgfeV0hYBpxx7kAVllzuHIPCH5yFIDzRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724896749; c=relaxed/simple;
	bh=Qo2wExlEt7JTEiS4zR33Q+nSPe8J7fcgPj1QUknPLiM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WtE5esaUaWkWMGgaWXNe0gi3okDPLLOu1AC2yvEWRB6T62drv7xziu8/puPGS4m7quDPKW9SNPkINpSxxNxhn0RzTgHUZsiihF9Pj1WKIr0FYw0pYg5SloNg5sfYVksSo1pPYg+JHuj/6KYL8DK2x06xgDtkPGW2s0z6u2OxTDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K8n347q1; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K8n347q1"
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-27018df4ff3so95904fac.1
        for <git@vger.kernel.org>; Wed, 28 Aug 2024 18:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724896747; x=1725501547; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v6XupRR78NJO+koigyjk0XxPT1quZFO/zPsGOh3L9YQ=;
        b=K8n347q1uJPgsjm5gPicmdffTfpoppMNE5JzYo3FA8+8q10i1+2aYTesJEsglaufLy
         AvWbhrHfMgyrR9j4AFoxTdeQIvtR7xb83/QtlKdS9gKeLOCy6eD14ieo7zp0EuBcUfJy
         UhmuUfRJ9N7iVtGpt5k+HxqzK77EgOlZ43UFE6AP0cKCIGVwFJqUgPAbJxDghhko7GuH
         RKO/mDzv6uiwjq7Z1lzhyIOKnOhN8l148er76HK0vNNCxJKdAf/jYZPV1SCR9/L6rpaR
         CjUxHXKdQ8GGretICUjNR43orLaadRmQ2aXwb1tAGLeadjz+F5/KfKQuNNumgkzxzbaa
         K89Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724896747; x=1725501547;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v6XupRR78NJO+koigyjk0XxPT1quZFO/zPsGOh3L9YQ=;
        b=Qpx6hELpj4+TpMwHYzj+Y+5NDdiKC7LXmjYzJqDNh4T7ZQ/KTRW0PZzb1tYWa0MJCV
         1rVHdvfOT+JWmmUUmdWWqqU8p41EtF3AdARUngiZpdlxz8Ki0SkQ2r1M1sOYQszDHs97
         c4i+deBSzvY87roZu2iCQeWWcndEF7/xTv9uKUfZ/0EBi5F5h9KvKA+4tdecrVeyiNwx
         gRyLnjHwGPf6RvemU5/Cfpw536dsw9TlkLHkgu8Xa9sLeIrfv1XdJD3UYYWfaxGTNtEI
         QU+nFYTvVpymkaY4/grhZw8A5FqAlVAR8bcc9gP5/izeufBHF5bXW9SrmfqUq35ndnNi
         QDZA==
X-Forwarded-Encrypted: i=1; AJvYcCV77HHFAOeIC5Z7B2Oxj8JJ127eqs77Xbp0rqBa2Vp0AChJ9ChKEUk2q16TYHFMxY+2cnc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyf8d+TC6W2HA+iokzKSBHjoUSuQJZxslUDzQjaFlcKhS7a49/Y
	IonPNrNoAb3a/NLbGMJvIs7EDUrqVsvHNMuxLLPBOB4UpPT9Wa9TnEF0BEt3
X-Google-Smtp-Source: AGHT+IFZGpd7YnWiSeeIFTu7/Lj9DUSqTeTgrPcWeeIr2C7PfvIAhvzAoV+CEGGTY+vg717K5cPjIg==
X-Received: by 2002:a05:6870:1652:b0:270:130f:cee8 with SMTP id 586e51a60fabf-277900755e0mr1743927fac.6.1724896746704;
        Wed, 28 Aug 2024 18:59:06 -0700 (PDT)
Received: from ?IPV6:2600:1700:60ba:9810:874:83ce:907c:8496? ([2600:1700:60ba:9810:874:83ce:907c:8496])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d22e9be380sm158402a12.60.2024.08.28.18.59.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Aug 2024 18:59:06 -0700 (PDT)
Message-ID: <31e9a542-c02b-4245-b3ad-8e1ade2211c6@gmail.com>
Date: Wed, 28 Aug 2024 21:59:04 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Mark `cat-file` sparse-index compatible
To: Kevin Lyles via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc: Kevin Lyles <klyles+github@epic.com>
References: <pull.1770.git.git.1724695732305.gitgitgadget@gmail.com>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <pull.1770.git.git.1724695732305.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/26/24 2:08 PM, Kevin Lyles via GitGitGadget wrote:
 > From: Kevin Lyles <klyles+github@epic.com>
Hi, Kevin! Thanks for looking into this.
 > `cat-file` will expand a sparse index to a full index when needed, but

hyper-nit: For commit messages we would usually use 'git cat-file'.
(This recommends both using the full command and single ticks instead
of back-ticks.)

 > is currently marked as needing a full index (or rather, not marked as
 > not needing a full index). This results in much slower `cat-file`
 > operations when working within the sparse index, since we expand the
 > index whether it's needed or not.

I was surprised at first that 'git cat-file' would need it at all,
but it is important when referencing objects with ":<path>" as that
refers to a path in the index instead of at any revision. It could be
helpful to bring this observation to the forefront of your commit
message.

 > Mark `cat-file` as not needing a full index, so that you only pay the
 > cost of expanding the sparse index to a full index when you request a
 > file outside of the sparse index.
 >
 > Add tests to ensure both that:
 > - `cat-file` returns the correct file contents whether or not the file
 >    is in the sparse index
 > - `cat-file` warns about expanding to the full index any time you
 >    request something outside of the sparse index

The "ensure_expanded" test works without the advice warning about the
larger request. It uses the trace2 mechanism to look for the expansion
happening under the hood.

(In fact, when I contributed the advice message, it became disabled in
these tests using config values during setup.)

 > Signed-off-by: Kevin Lyles <klyles+github@epic.com>
 > ---
 >      Mark cat-file sparse-index compatible
 >
 >      Please note that this is my first contribution to git. I've tried to
 >      follow the instructions about how to correctly submit a patch (I'm using
 >      GitGitGadget as getting Outlook to do plain text e-mail correctly seems
 >      impossible), but please let me know if I've missed something.
 >
 >      I've worded the commit message itself as though I'm definitely correct
 >      about how cat-file behaves, since I assume we want the final commit
 >      message to be definite. However, this change felt a little too easy and
 >      I can't help but feel that I might have missed something. So, even
 >      though this is just one commit, I'm also including this cover letter
 >      going into more detail about the parts that don't need to be part of the
 >      commit history.
 >
 >      My motivation for making this change is purely performance. We have a
 >      large repository that we enable the sparse index for, and I am
 >      developing a pre-commit hook that (among other things) uses git cat-file
 >      to get the staged contents of certain files. Without this change,
 >      getting the contents of a single small file from the index can take
 >      upwards of 10 seconds due to the index expansion. After this change, it
 >      only takes ~0.3 seconds unless the file is outside of the sparse index.
 >
 > Published-As: 
https://github.com/gitgitgadget/git/releases/tag/pr-git-1770%2Fklylesatepic%2Fkl%2Fmark-cat-file-sparse-index-compatible-v1
 > Fetch-It-Via: git fetch https://github.com/gitgitgadget/git 
pr-git-1770/klylesatepic/kl/mark-cat-file-sparse-index-compatible-v1
 > Pull-Request: https://github.com/git/git/pull/1770
 >
 >   builtin/cat-file.c                       |  3 +
 >   t/t1092-sparse-checkout-compatibility.sh | 71 ++++++++++++++++++++++--
 >   2 files changed, 69 insertions(+), 5 deletions(-)
 >
 > diff --git a/builtin/cat-file.c b/builtin/cat-file.c
 > index 18fe58d6b8b..1afdfb5cbae 100644
 > --- a/builtin/cat-file.c
 > +++ b/builtin/cat-file.c
 > @@ -1047,6 +1047,9 @@ int cmd_cat_file(int argc, const char **argv, const 
char *prefix)
 >   	if (batch.buffer_output < 0)
 >   		batch.buffer_output = batch.all_objects;
 >
 > +	prepare_repo_settings(the_repository);
 > +	the_repository->settings.command_requires_full_index = 0;
 > +
 >   	/* Return early if we're in batch mode? */
 >   	if (batch.enabled) {
 >   		if (opt_cw)
 > diff --git a/t/t1092-sparse-checkout-compatibility.sh 
b/t/t1092-sparse-checkout-compatibility.sh
 > index a2c0e1b4dcc..0f36246ae84 100755
 > --- a/t/t1092-sparse-checkout-compatibility.sh
 > +++ b/t/t1092-sparse-checkout-compatibility.sh
 > @@ -179,22 +179,26 @@ init_repos_as_submodules () {
 >   }
 >
 >   run_on_sparse () {
 > +	tee run_on_sparse-checkout run_on_sparse-index &&> +

This is an interesting update to this helper method, which takes stdin
and copies it to these two files for consumption by the two calls below.
It really only needs to go to one file and then have that file be
consumed twice. This diff seems to accomplish what you want:

--- >8 ---

diff --git a/t/t1092-sparse-checkout-compatibility.sh 
b/t/t1092-sparse-checkout-compatibility.sh
index 1954bf6332d..9902190eec4 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -180,22 +180,24 @@ init_repos_as_submodules () {
  }

  run_on_sparse () {
+	cat >in &&
  	(
  		cd sparse-checkout &&
  		GIT_PROGRESS_DELAY=100000 "$@" >../sparse-checkout-out 2>../sparse-checkout-err
-	) &&
+	) <in &&
  	(
  		cd sparse-index &&
  		GIT_PROGRESS_DELAY=100000 "$@" >../sparse-index-out 2>../sparse-index-err
-	)
+	) <in
  }

  run_on_all () {
+	cat >in &&
  	(
  		cd full-checkout &&
  		GIT_PROGRESS_DELAY=100000 "$@" >../full-checkout-out 2>../full-checkout-err
-	) &&
-	run_on_sparse "$@"
+	) <in &&
+	run_on_sparse "$@" <in
  }

  test_all_match () {


--- >8 ---

Whatever happens, this subtlety seems valuable to add to the commit
message to help readers to expect it.

 > -# Usage: test_sprase_checkout_set "<c1> ... <cN>" "<s1> ... <sM>"
 > +# Usage: test_sparse_checkout_set "<c1> ... <cN>" "<s1> ... <sM>"

Thanks for fixing this typo.

 > +test_expect_success 'cat-file -p' '
 > +	init_repos &&
 > +	echo "new content" >>full-checkout/deep/a &&
 > +	echo "new content" >>sparse-checkout/deep/a &&
 > +	echo "new content" >>sparse-index/deep/a &&
 > +	run_on_all git add deep/a &&
 > +
 > +	test_all_match git cat-file -p HEAD:deep/a &&
 > +	ensure_not_expanded cat-file -p HEAD:deep/a &&
 > +	test_all_match git cat-file -p HEAD:folder1/a &&
 > +	ensure_not_expanded cat-file -p HEAD:folder1/a &&

These commands shouldn't touch the index at all, as they are loading the
object ID the same as 'git rev-parse'.

 > +
 > +	test_all_match git cat-file -p :deep/a &&
 > +	ensure_not_expanded cat-file -p :deep/a &&
 > +	run_on_all git cat-file -p :folder1/a &&

These are the interesting cases.

 > +	test_cmp full-checkout-out sparse-checkout-out &&
 > +	test_cmp full-checkout-out sparse-index-out &&
 > +	test_cmp full-checkout-err sparse-checkout-err &&

I figure that you have decided to use run_on_all and not test_all_match
because of an error message that doesn't match. Across the full and
sparse cases. This would be a good time to focus on what is different
about them, perhaps with something like

	grep "error message contents" sparse-index-err

The difference shouldn't be the new advice message due to the mentioned
change to the config of these repos. If that was the case, then the
following would work, but shouldn't be necessary:

	GIT_ADVICE=0 test_all_match git cat-file -p :folder1/a &&

What is the reason for there being a difference in stderr in the
sparse index case? We should drill down here to make sure the behavior
is appropriate.

 > +	ensure_expanded cat-file -p :folder1/a'
 > +
 > +test_expect_success 'cat-file --batch' '
 > +	init_repos &&
 > +	echo "new content" >>full-checkout/deep/a &&
 > +	echo "new content" >>sparse-checkout/deep/a &&
 > +	echo "new content" >>sparse-index/deep/a &&
 > +	run_on_all git add deep/a &&
 > +
 > +	cat <<-\EOF | test_all_match git cat-file --batch &&
 > +	HEAD:deep/a
 > +	:deep/a
 > +	EOF

This heredoc should instead be used to write to a file to use twice:

	cat >in <<-\EOF &&
	HEAD:deep/a
	:deep/a
	EOF

	test_all_match git cat-file --batch <in &&
	ensure_not_expanded cat-file --batch <in &&

 > +	echo "HEAD:folder1/a" | test_all_match git cat-file --batch &&
 > +	echo "HEAD:folder1/a" | ensure_not_expanded cat-file --batch &&

I'm not sure that these are interesting cases as they will not cause an
index read and thus are not affected by sparse-checkout.

 > +	echo ":folder1/a" | run_on_all git cat-file --batch &&
 > +	test_cmp full-checkout-out sparse-checkout-out &&
 > +	test_cmp full-checkout-out sparse-index-out &&
 > +	test_cmp full-checkout-err sparse-checkout-err &&
 > +	echo ":folder1/a" | ensure_expanded cat-file --batch &&

This is a more interesting case, again using outside of cone paths.

I would still recommend reusing an input file:

	echo ":folder1/a" >in &&
	test_all_match git cat-file --batch <in &&
	ensure_expanded cat-file --batch <in &&

 > +
 > +	cat <<-\EOF | run_on_all git cat-file --batch &&
 > +	:deep/a
 > +	:folder1/a
 > +	EOF

Again, point the heredoc to a file and then into the test:

	cat >in <<-\EOF &&
	:deep/a
	:folder1/a
	EOF
	test_all_match git cat-file --batch <in &&
	ensure_expanded cat-file --batch <in &&

Thanks for working on this!

-Stolee
