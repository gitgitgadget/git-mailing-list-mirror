Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6839714F9D2
	for <git@vger.kernel.org>; Thu, 22 Feb 2024 16:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708619769; cv=none; b=g+oWD7HUlqKV10Q8aC7mFp5rynXi0X9se+hBt7tdgrftEzlTmHwiW1XV2WFL4UQ0JBtasdghYazZK69u8NCucB+brthubvRcC5UaD6CmQbM25ezWdnnp6ixRLIXBYLmX7rto6U7ava8PcHiR8K5Rr1TQyhZZPLKaCFn0YxHqqRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708619769; c=relaxed/simple;
	bh=LkgDx+ujnKG+btQyxV6C+dnaSJ6swf5ZWVf1bPIQiI8=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=E3KnzxjBVZCZYTlrdQR/rKtT1970jNzp5Qx9N8q4HT7RCvnDnm4B1BZDzDu+w6eHoy7ySt2iNw9sznwG1SLuhV26PvTARfMq3U1g0OZajXGVkrqM6U88dTAlKTwiR7mWdQxYNhp7C88X0FagBQi996WfPogbyN60JduyJtFUPM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UMd/Tkuk; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UMd/Tkuk"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-41275855dc4so14973965e9.0
        for <git@vger.kernel.org>; Thu, 22 Feb 2024 08:36:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708619765; x=1709224565; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=JfKc4DJ4c6gpaTHomn2ajGxcabryGB61Dg7muBVTdtk=;
        b=UMd/TkukVpGNV+Q8Bql4ivfE/TMH761NlCi/LTA76C6w9TsDbLZEXAxsttgNekBQdP
         qosy6CqhIUCtAXfi2HvEdZ3Lwwy3SWMyRvdNi2vwt69ZlsBtfSZlxFRLBMBBwxOFyM76
         H79wPioUf1loxhK6hijKIEv/UgRQjnkcDJwUcZlUrvPkvwDJZK7x4GSJba7Jxqydk/3M
         66FlWy/DrE193TF0qThEDvM+tCf+QVEKa3rObqAythRynAqu32KSwygm08fmhfibXGkc
         9xEsxHzbTPQJ7n2F3Yk0LTUUCBSeNubEJn+PJ6FzkbNTavLbme49sid1g3aeXTv8SYF8
         jYew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708619765; x=1709224565;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JfKc4DJ4c6gpaTHomn2ajGxcabryGB61Dg7muBVTdtk=;
        b=Ll4I7VGomSPDneR/QF5AuE+1qSBOfiEyEgQTIa+/KCnz2D/3Ovfd0RyWktK6VdH2aT
         v93XaQRV4f2AIUcxD1akfVP7zBBuy5prf3Ud9CRDFR9m3c8LiKg0Wr45vTxGX7Yokf2N
         v7VtUk981TMbvOW/rn+BlXzolc/CgkjqwuUPDpC3LdltVXkcH7ofDscB+h67/ggMc8px
         pen5cdrxGtIJbS1EK3ArY+31ENLKX0nvBqRL1G2oly65CIiUVGhKogwBVBhxDxiiGgdf
         1PfBrPHjcM5HlA3ADCvgUaMRQpCj1nrWaAW2mriM2DA0Pla4QpQb29y5HfWLbggwtut5
         GLSQ==
X-Forwarded-Encrypted: i=1; AJvYcCXYi6foybQ3/EJC51jiXM8C58Mi0nCADiRNCO8Ry5ObFmBZ6k/aBmfaMSLTC6H/HuynNXIsu31Y1iMHz352Yvb7zwoM
X-Gm-Message-State: AOJu0YyF+DF0w6lqNBJkmEhGmLBK5EeNkhs4pfdviUBF8iAS3JvG3rte
	ce1bcXFm3Qd7HVECACUz0WFz7MMeW+2D3AMaskSMiOlgsPmRVkc0
X-Google-Smtp-Source: AGHT+IF2Hfn9480T8e6HOfzDg4KaYY4wY8JquTSjRFYRSJRW6KNKu2xDsJVlImKF/1XYT1E3QdUnvA==
X-Received: by 2002:a05:600c:4f95:b0:411:fe8e:aad1 with SMTP id n21-20020a05600c4f9500b00411fe8eaad1mr15494192wmq.11.1708619765544;
        Thu, 22 Feb 2024 08:36:05 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:69d:3501:4b27:339f:196f:f7f9? ([2a0a:ef40:69d:3501:4b27:339f:196f:f7f9])
        by smtp.gmail.com with ESMTPSA id m20-20020a05600c281400b0041214ff06cesm21901857wmb.42.2024.02.22.08.36.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Feb 2024 08:36:05 -0800 (PST)
Message-ID: <bb23026e-72c5-40a0-bd5f-356a03efa5aa@gmail.com>
Date: Thu, 22 Feb 2024 16:36:05 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: phillip.wood123@gmail.com
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 8/8] cherry-pick: add `--empty` for more robust
 redundant commit handling
Content-Language: en-US
To: Brian Lyles <brianmlyles@gmail.com>, git@vger.kernel.org
Cc: newren@gmail.com, me@ttaylorr.com, gitster@pobox.com
References: <20240119060721.3734775-2-brianmlyles@gmail.com>
 <20240210074859.552497-9-brianmlyles@gmail.com>
In-Reply-To: <20240210074859.552497-9-brianmlyles@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Brian

On 10/02/2024 07:43, Brian Lyles wrote:
> As with git-rebase(1) and git-am(1), git-cherry-pick(1) can result in a
> commit being made redundant if the content from the picked commit is
> already present in the target history. However, git-cherry-pick(1) does
> not have the same options available that git-rebase(1) and git-am(1) have.
> 
> There are three things that can be done with these redundant commits:
> drop them, keep them, or have the cherry-pick stop and wait for the user
> to take an action. git-rebase(1) has the `--empty` option added in commit
> e98c4269c8 (rebase (interactive-backend): fix handling of commits that
> become empty, 2020-02-15), which handles all three of these scenarios.
> Similarly, git-am(1) got its own `--empty` in 7c096b8d61 (am: support
> --empty=<option> to handle empty patches, 2021-12-09).
> 
> git-cherry-pick(1), on the other hand, only supports two of the three
> possiblities: Keep the redundant commits via `--keep-redundant-commits`,
> or have the cherry-pick fail by not specifying that option. There is no
> way to automatically drop redundant commits.
> 
> In order to bring git-cherry-pick(1) more in-line with git-rebase(1) and
> git-am(1), this commit adds an `--empty` option to git-cherry-pick(1). It
> has the same three options (keep, drop, and stop), and largely behaves
> the same. The notable difference is that for git-cherry-pick(1), the
> default will be `stop`, which maintains the current behavior when the
> option is not specified.
> 
> The `--keep-redundant-commits` option will be documented as a deprecated
> synonym of `--empty=keep`, and will be supported for backwards
> compatibility for the time being.

I'm leaning towards leaving `--keep-redundant-commits` alone. That 
introduces an inconsistency between `--keep-redundant-commits` and 
`--empty=keep` as the latter does not imply `--allow-empty` but it does 
avoid breaking existing users. We could document 
`--keep-redundant-commits` as predating `--empty` and behaving like 
`--empty=keep --allow-empty`. The documentation and implementation of 
the new option look good modulo the typo that has already been pointed 
out and a couple of small comments below.

> +enum empty_action {
> +	EMPTY_COMMIT_UNSPECIFIED = 0,

We tend to use -1 for unspecified options

> +	STOP_ON_EMPTY_COMMIT,      /* output errors and stop in the middle of a cherry-pick */
> +	DROP_EMPTY_COMMIT,         /* skip with a notice message */
> +	KEEP_EMPTY_COMMIT,         /* keep recording as empty commits */
> +};


> +test_expect_success 'cherry-pick persists --empty=stop correctly' '
> +	pristine_detach initial &&
> +	# to make sure that the session to cherry-pick a sequence
> +	# gets interrupted, use a high-enough number that is larger
> +	# than the number of parents of any commit we have created
> +	mainline=4 &&
> +	test_expect_code 128 git cherry-pick -s -m $mainline --empty=stop initial..anotherpick &&
> +	test_path_is_file .git/sequencer/opts &&
> +	test_must_fail git config --file=.git/sequencer/opts --get-all options.keep-redundant-commits &&
> +	test_must_fail git config --file=.git/sequencer/opts --get-all options.drop-redundant-commits
> +'

Thanks for adding these tests to check that the --empty option persists. 
Usually for tests like this we prefer to check the user visible behavior 
rather than the implementation details (I suspect we have some older 
tests that do the latter). To check the behavior we usually arrange for 
a merge conflict but using -m is a creative alternative, then we'd run 
"git cherry-pick --continue" and check that the commits that become 
empty have been preserved or dropped or that the cherry-pick stops.

Best Wishes

Phillip
