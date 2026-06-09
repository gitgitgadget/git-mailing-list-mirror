Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B77826F2B0
	for <git@vger.kernel.org>; Tue,  9 Jun 2026 13:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781011544; cv=none; b=OdiN5il35OFUkSEySc9T+VYZjao3WD2jme0gdUMLICf1seR8XBpKqaHPgYcUzEGaxQP6owmfy8rVPLofz6Hibyb59GpHSgwHyo3vFpJsZ8Tp3u7s+2izOIVTqHnzrL1YEg7aW1T/Qu9Ak4SmbxgYdj4P3xX1y8fxa7gaIhVF890=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781011544; c=relaxed/simple;
	bh=uI74MixGwNT4qFVbAAkoqPHBYU9CC2wW/aBAByafl28=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=syy0UCFKQN/btGMhz3aPIl9cAFCVDK6/UhaJKOzxQ2dQbYTuZAH4QRtvbM+6D0127ZbFjacC4wubnF8HK7wVha5OYaZuDjSoarXeQZ21Q66EnjjFw0rmDU2Nki11v/E0DLjXnE4SkKuMBgdwRfcjfzdyD2nlf7d2q7O7Y3aeTR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JP04ikzL; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JP04ikzL"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-befee9e5ef7so656977866b.0
        for <git@vger.kernel.org>; Tue, 09 Jun 2026 06:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781011541; x=1781616341; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=FchlUKlKwY5AwECSrbaR5htoJswY+vmT/lIndUxCCvs=;
        b=JP04ikzLOyBf43+B+6p+AhGwbaYtrAzki3ajLQDbEPY/E4tesHUhU+9tzhBF608uEG
         QjBHkxcRMyi2xsNeZaenWTsfN9Er1LV7biysqRC0nHjXZtyVfVy1AFe1ZuksDc9Jtu0E
         I8vjRUrUs4HxJstBK4pGPGHd9fsiCyMZXQ9jr44jH42RHTHTrnWA13hENwBruSZ9Hlvr
         R6gSNZ5RkIXWzK019OW6M469AXZsi+MPEopbCUNNMibtwLwgMxeMzhar0kRTmK1lIYjF
         rFNodcOgcmB/914TPi9oVKyVr07LPBsoDqR8NuibsFeuyGv5xPiIHe8ZgK6FfITU2gbx
         ikKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781011541; x=1781616341;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FchlUKlKwY5AwECSrbaR5htoJswY+vmT/lIndUxCCvs=;
        b=IyjtG6bvyDhRX7iT/hrRv8MWGq0RAfRiSv5qu2FzmWfMU43B7Z40i9KoVYHkVviKlF
         hkbGwDPRmopez5nVK/RRLkt7rh1vRrF9aCZvIyDIyAj3IuWDxpKYnP3xrNPK86VmDX7w
         S8PYncfiuv6cUCvOaWW/WfKLdCbN2nz44yzsqtLizmvbzn4vOjJQOWKqD6LcS8SeYHDw
         pb4UZF6KaCLFYcAnC1p2aZXvJt81Bx6tLjdmet7pv8KJXpo8GdoJtAtMo/ar3Gh2mjSO
         uPj6NC0Ykdz6CmlDCGToxhGHd5e6sMTwW7aSf6AWfHeTsGR1+qNNpcZVb6cY9rsP/Eb8
         PdZQ==
X-Forwarded-Encrypted: i=1; AFNElJ9hRsOwmsflM+wpBzTEuORHMgl5SpYj5mqCJ1JuufilMbl+igf4koXG8ejcZG5aDa7uEiw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywc8+wBBz8PJju8uL93+XFVh4wFH1QEP+eqkYZtPPnsVKlHQJTe
	osXfjOhMehnOp9Xhlmf/tW/5qpzg3AiXV6UZ9+RJHrgt1pfTOVzg9xhE
X-Gm-Gg: Acq92OGpgJKwBdSD71t18aON2OiZj/0bp2Q971UD1xgWJu+Q6WFlAQMV4svAoNtFqPk
	RJqkrnnNjN4zi3va6O3Wuh7j+oAkQR7gR5bcS4rerx4IUM/x+ZuD3H2ddkztj+6XR+OduCxPrfh
	cv7A6E1zc/jReeynYPUyPTnloysMjeOyabLNUCN3pG8ClaSxV3/QPYRBUgwmjmDrbCJfEHzI2AF
	HIx2v+0BWLq3/H8dDVZBKj+pnPIwFOUj/wmOzasAXKlv76KWfEQ8BvBRJCdnVEeM4TWngDwf8W2
	nJJXeO9UkfMOyOD1JpyyYznIQPl0nqCxnrm7Nv1VoWBAhlTHWcJAKw7sJJu4vMT2C9mZvDprlZO
	CPZWCgnrGpw3O+g8QyZaOWKRocpJ5eu4IOjxAvRu90VS/ejYKSdi/zmOFPrBGWbQNUsYUzDOVj2
	aHaG2+gzF7pNNGHguuaxlqtKB8glS4Ge7RbCc23S1vaDeLH+4g407OoIp/bE0fhrZcr4fllpjhk
	2GaETBaYfXfChit
X-Received: by 2002:a17:907:b05:b0:bed:36cd:4f35 with SMTP id a640c23a62f3a-bf3703788femr718249866b.1.1781011541179;
        Tue, 09 Jun 2026 06:25:41 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:69a:b801:201a:26ab:8d41:fb43? ([2a0a:ef40:69a:b801:201a:26ab:8d41:fb43])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bf054e051b0sm1040126966b.31.2026.06.09.06.25.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2026 06:25:40 -0700 (PDT)
Message-ID: <54bd36e9-3d21-4f83-86d6-2882a14779de@gmail.com>
Date: Tue, 9 Jun 2026 14:25:39 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH RFC v2 2/2] builtin/history: abort reword on same message
To: Pablo Sabater <pabloosabaterr@gmail.com>, git@vger.kernel.org
Cc: cat@malon.dev, ps@pks.im, kaartic.sivaraam@gmail.com,
 ben.knoble@gmail.com, gitster@pobox.com
References: <20260607-ps-history-reword-v1-0-ba43a3cbb81b@gmail.com>
 <20260609-ps-history-reword-v2-0-a0e6028ca9b4@gmail.com>
 <20260609-ps-history-reword-v2-2-a0e6028ca9b4@gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20260609-ps-history-reword-v2-2-a0e6028ca9b4@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Pablo

On 09/06/2026 11:42, Pablo Sabater wrote:
>   static int commit_tree_ext(struct repository *repo,
> @@ -135,6 +136,13 @@ static int commit_tree_ext(struct repository *repo,
>   					  original_body, action, &commit_message);
>   		if (ret < 0)
>   			goto out;
> +
> +		if (flags & COMMIT_TREE_ABORT_ON_SAME_MESSAGE &&
> +		    !strcmp(original_body, commit_message.buf)) {
> +			fprintf(stderr, _("Message unchanged, aborting reword.\n"));
> +			ret = 1;
> +			goto out;
> +		}

I wonder if we should check that the committer identity is unchanged as 
well in case anyone is using this to fix commits after committing with 
the wrong identity.

Aborting when the message and committer identity are unchanged seems 
like a good idea.

Thanks

Phillip

>   	} else {
>   		strbuf_addstr(&commit_message, original_body);
>   	}
> @@ -693,7 +701,8 @@ static int cmd_history_reword(int argc,
>   	struct strbuf reflog_msg = STRBUF_INIT;
>   	struct commit *original, *rewritten;
>   	struct rev_info revs = { 0 };
> -	enum commit_tree_flags flags = COMMIT_TREE_EDIT_MESSAGE;
> +	enum commit_tree_flags flags = COMMIT_TREE_EDIT_MESSAGE |
> +				       COMMIT_TREE_ABORT_ON_SAME_MESSAGE;
>   	int ret;
>   
>   	argc = parse_options(argc, argv, prefix, options, usage, 0);
> @@ -721,6 +730,9 @@ static int cmd_history_reword(int argc,
>   	if (ret < 0) {
>   		ret = error(_("failed writing reworded commit"));
>   		goto out;
> +	} else if (ret == 1) {
> +		ret = 0;
> +		goto out;
>   	}
>   
>   	strbuf_addf(&reflog_msg, "reword: updating %s", argv[0]);
> diff --git a/t/t3451-history-reword.sh b/t/t3451-history-reword.sh
> index de7b357685..6e0e278c42 100755
> --- a/t/t3451-history-reword.sh
> +++ b/t/t3451-history-reword.sh
> @@ -396,4 +396,20 @@ test_expect_success 'retains changes in the worktree and index' '
>   	)
>   '
>   
> +test_expect_success 'aborts if the commit message is the same' '
> +	test_when_finished "rm -rf repo" &&
> +	git init repo &&
> +	(
> +		cd repo &&
> +		test_commit first &&
> +		test_commit second &&
> +
> +		git rev-parse HEAD >oid-before &&
> +		GIT_EDITOR=true git history reword HEAD 2>err &&
> +		git rev-parse HEAD >oid-after &&
> +		test_cmp oid-before oid-after &&
> +		test_grep "Message unchanged" err
> +	)
> +'
> +
>   test_done
> diff --git a/t/t3453-history-fixup.sh b/t/t3453-history-fixup.sh
> index 868298e248..9f9a3c93de 100755
> --- a/t/t3453-history-fixup.sh
> +++ b/t/t3453-history-fixup.sh
> @@ -443,6 +443,28 @@ test_expect_success '--reedit-message opens editor for the commit message' '
>   	)
>   '
>   
> +test_expect_success 'fixup --reedit-message does not abort with the same commit message' '
> +	test_when_finished "rm -rf repo" &&
> +	git init repo &&
> +	(
> +		cd repo &&
> +		test_commit initial &&
> +		echo content > file.txt &&
> +		git add file.txt &&
> +		git commit -m "add file" &&
> +
> +		echo fix >>file.txt &&
> +		git add file.txt &&
> +		GIT_EDITOR=true git history fixup --reedit-message HEAD &&
> +		expect_changes --branches <<-\EOF
> +		add file
> +		2	0	file.txt
> +		initial
> +		1	0	initial.t
> +		EOF
> +	)
> +'
> +
>   test_expect_success 'retains unstaged working tree changes after fixup' '
>   	test_when_finished "rm -rf repo" &&
>   	git init repo &&
> 

