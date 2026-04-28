Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D32963A759A
	for <git@vger.kernel.org>; Tue, 28 Apr 2026 09:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777368753; cv=none; b=q4+vhy5XGHVF4p9daiU9QJGtEhm6YXbmlmnjGRCe9Zm31T7hU5te+MoSxb1KHT/wIFXQBQaEw+ZAZsaxKc21Fw4JGMmcVomrol9umeKAv3p9HtodVcqUf54m8FGFuc03jaMi7ScmMZEJc+DehVJG9NcGvY0PSGU+uTex9fIUuiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777368753; c=relaxed/simple;
	bh=EO/+z+GJnCqcVcD5Rd8ldlL57JKhRqsPBclf9qJN+X0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=s/yAsNLkzR7sQXIDCXS69OoH84Q6JWF5TBF+rRlLqjr5TJgBRGnHtn3FSu1ck/Si3sERq5QgzSyQY3H2Eh+qipCGtrsDnvawz3p0oCcOVVfjdcZo3F12+pydqwvuUfqX+Di35Bg0ruLZVTupZi7D+l5G6Nu26hRUc037U7eEMFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z4qAu4Fq; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z4qAu4Fq"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-43fe3e22e33so7224109f8f.0
        for <git@vger.kernel.org>; Tue, 28 Apr 2026 02:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777368750; x=1777973550; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P0ttMD71OSw8pzf/R3k8jWjNGt5QVc5n4dvSn60zjXg=;
        b=Z4qAu4Fqzq6X1JqC6lUod0En0znojCGom24av/3SNRMD2eNOxXLM6oC5wQcodzSS07
         1cpqpD0vKrBQTGANCUIB1+zYBQwVPzRNYvMN2LItxa1ildcyrjUJ+nC4X0JdYfTHrQVS
         LgRVW3Oj4J4Fs73LhKzho2VWq8ULTa0Weu9x1bDJQsq6BOWpBrTuG7DQab9NNk0ETKNW
         p4Oxxq4+tnbU5Sof1Bgj4Ap8MPw4dsFouw5xgJT3vBncpsszIr5Yi0M6CjIAfn6KJ46r
         wsFsmPRpQzKjZT2II4FzsO6Q1I/Rsz0Xf/Fwtat9TN+7DgSZiQtirxmrLBoIQwnKFO7v
         smCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777368750; x=1777973550;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P0ttMD71OSw8pzf/R3k8jWjNGt5QVc5n4dvSn60zjXg=;
        b=p8QBGODxQS0Nw0v4n8PqtytFupexKSUEHZAhJStVMn45+dSdW2LEXpec4/xHhBXTjU
         HxCAWgLXmrVshhjMz0VEz+g9yAzDgVsNeKWdVRYTAESMshXPAiVKOVFukVWcYnSPIPmL
         gQtDkcoJ9Od8M118fB7dZOFDxCzz+itJso0Ji0SLSqx0KxLPZYIilJva+TaFq65tUSBK
         ZYJFbSzu7aMSXm5xbkEhxhbyJ5NmsJTDfJc1Fu+8Ef6btQiLxC31f6FhfgtN6SSD+5OX
         pfh+Ha9kpQkps3zI3GtVISvpaRNkTiAIzKBp+w0FJnVOa9UsBYpnS3sjl5f+eIu4byNY
         1tdQ==
X-Forwarded-Encrypted: i=1; AFNElJ8b8hfWpIumrqblSsTzkqlgLKwnh/Z7V8PIIKU6LUmm3v+jw3MlbrTR7+kbXipoPp1ymZ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwPrnhE6VI19FUiPrssL0YsmPKS5nbWYPitRjsGFgoBq4ftS+B
	NlcK5mZF7ljZNfyZ95Tp4NGvbW1kzZro5jXwytMYENHSzTjcijhraItG
X-Gm-Gg: AeBDieutxkUWKU0g/DzW0uPuV9L865zlNZDMuC+rFKJPhHI/aBxMsWPHHffWlqXD+Sg
	na3sp7wjzuQV6GhcNNBikVHZmcgld3S1jCkRQHXGu6MVyd8LTXpK8/tdmH85sLt6gcZHaWHFFZE
	dkPqtlgMSYeAUwrFTfBCfOgRyFiXYwzu7w1TkoazgLw2lnGLXFYbtwWlcLzyVRREaesUUlgAVWf
	inZgdFXIOtK6Tw8PCJJ46Kp95fUbdpwTY8O3BWe12B9ByBnzN21FHED0r8I6GvXwbWkfOfQDKK+
	b0JblW2hbbQNtBbdW0fSChEqteTLb+ZhfxykskkLHlLM2AemggqB+GyuHMRD6Xcv3gxoc6qfGl4
	Re8aPV/PhXRqXTA5b+F2fg0C4po1GJpjCFSWRMN6WPHs/jnXlKXvTIHtxHCc7nw4UQ0EPreT5bu
	+KEQoU/f5EJlcy91S0lvo4dt0G8zfD7HbENXJrRc//zcl7eLXi2o7lmnpQO8xcDJT5IpqE+NHxz
	tPXgJt70ztt2uQqd+JuqgIT
X-Received: by 2002:adf:fcc9:0:b0:441:1d53:cd9e with SMTP id ffacd0b85a97d-4464b2ace50mr2602600f8f.37.1777368750086;
        Tue, 28 Apr 2026 02:32:30 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:7d8:fa01:60c8:18fb:2acc:d4f? ([2a0a:ef40:7d8:fa01:60c8:18fb:2acc:d4f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4463d02f6a1sm4993845f8f.13.2026.04.28.02.32.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Apr 2026 02:32:29 -0700 (PDT)
Message-ID: <a3197c7d-4a19-4cda-832c-b6e67214e7dc@gmail.com>
Date: Tue, 28 Apr 2026 10:32:27 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v15 2/5] sequencer: allow create_autostash to run silently
To: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Chris Torek <chris.torek@gmail.com>, Jeff King <peff@peff.net>,
 Harald Nordgren <haraldnordgren@gmail.com>
References: <pull.2234.v14.git.git.1776270259.gitgitgadget@gmail.com>
 <pull.2234.v15.git.git.1777065012.gitgitgadget@gmail.com>
 <89e0bfa80326d20d11355ed2e73de0907e5c9e41.1777065012.git.gitgitgadget@gmail.com>
Content-Language: en-US
In-Reply-To: <89e0bfa80326d20d11355ed2e73de0907e5c9e41.1777065012.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Harald

This looks good

Thanks

Phillip

On 24/04/2026 22:10, Harald Nordgren via GitGitGadget wrote:
> From: Harald Nordgren <haraldnordgren@gmail.com>
> 
> Add a silent parameter to create_autostash_internal and introduce
> create_autostash_ref_silent so that callers can create an autostash
> without printing the "Created autostash" message.
> 
> Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
> ---
>   builtin/merge.c |  6 ++++--
>   sequencer.c     | 17 +++++++++++------
>   sequencer.h     |  3 ++-
>   3 files changed, 17 insertions(+), 9 deletions(-)
> 
> diff --git a/builtin/merge.c b/builtin/merge.c
> index 2cbce56f8d..3ebe190ef1 100644
> --- a/builtin/merge.c
> +++ b/builtin/merge.c
> @@ -1672,7 +1672,8 @@ int cmd_merge(int argc,
>   		}
>   
>   		if (autostash)
> -			create_autostash_ref(the_repository, "MERGE_AUTOSTASH");
> +			create_autostash_ref(the_repository, "MERGE_AUTOSTASH",
> +					     NULL, false);
>   		if (checkout_fast_forward(the_repository,
>   					  &head_commit->object.oid,
>   					  &commit->object.oid,
> @@ -1764,7 +1765,8 @@ int cmd_merge(int argc,
>   		die_ff_impossible();
>   
>   	if (autostash)
> -		create_autostash_ref(the_repository, "MERGE_AUTOSTASH");
> +		create_autostash_ref(the_repository, "MERGE_AUTOSTASH",
> +				     NULL, false);
>   
>   	/* We are going to make a new commit. */
>   	git_committer_info(IDENT_STRICT);
> diff --git a/sequencer.c b/sequencer.c
> index b7d8dca47f..ff5258f481 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -4657,7 +4657,9 @@ static enum todo_command peek_command(struct todo_list *todo_list, int offset)
>   
>   static void create_autostash_internal(struct repository *r,
>   				      const char *path,
> -				      const char *refname)
> +				      const char *refname,
> +				      const char *message,
> +				      bool silent)
>   {
>   	struct strbuf buf = STRBUF_INIT;
>   	struct lock_file lock_file = LOCK_INIT;
> @@ -4679,7 +4681,8 @@ static void create_autostash_internal(struct repository *r,
>   		struct object_id oid;
>   
>   		strvec_pushl(&stash.args,
> -			     "stash", "create", "autostash", NULL);
> +			     "stash", "create",
> +			     message ? message : "autostash", NULL);
>   		stash.git_cmd = 1;
>   		stash.no_stdin = 1;
>   		strbuf_reset(&buf);
> @@ -4702,7 +4705,8 @@ static void create_autostash_internal(struct repository *r,
>   					&oid, null_oid(the_hash_algo), 0, UPDATE_REFS_DIE_ON_ERR);
>   		}
>   
> -		printf(_("Created autostash: %s\n"), buf.buf);
> +		if (!silent)
> +			printf(_("Created autostash: %s\n"), buf.buf);
>   		if (reset_head(r, &ropts) < 0)
>   			die(_("could not reset --hard"));
>   		discard_index(r->index);
> @@ -4714,12 +4718,13 @@ static void create_autostash_internal(struct repository *r,
>   
>   void create_autostash(struct repository *r, const char *path)
>   {
> -	create_autostash_internal(r, path, NULL);
> +	create_autostash_internal(r, path, NULL, NULL, false);
>   }
>   
> -void create_autostash_ref(struct repository *r, const char *refname)
> +void create_autostash_ref(struct repository *r, const char *refname,
> +			  const char *message, bool silent)
>   {
> -	create_autostash_internal(r, NULL, refname);
> +	create_autostash_internal(r, NULL, refname, message, silent);
>   }
>   
>   static int apply_save_autostash_oid(const char *stash_oid, int attempt_apply)
> diff --git a/sequencer.h b/sequencer.h
> index a6fa670c7c..02d2d9db06 100644
> --- a/sequencer.h
> +++ b/sequencer.h
> @@ -229,7 +229,8 @@ void commit_post_rewrite(struct repository *r,
>   			 const struct object_id *new_head);
>   
>   void create_autostash(struct repository *r, const char *path);
> -void create_autostash_ref(struct repository *r, const char *refname);
> +void create_autostash_ref(struct repository *r, const char *refname,
> +			  const char *message, bool silent);
>   int save_autostash(const char *path);
>   int save_autostash_ref(struct repository *r, const char *refname);
>   int apply_autostash(const char *path);

