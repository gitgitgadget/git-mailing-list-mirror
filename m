Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F5B537BE63
	for <git@vger.kernel.org>; Thu, 29 Jan 2026 08:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769675396; cv=pass; b=hN4ZKr4lctJ/3va1WyGEHaP3/RTiVo55OubLJ7XyDNullTC5B9GrpyL5mmPz7f3wG3WKrpNSi8UUAE25dazzFsviVgUjOv/6+GmUK0b2yFXsjeva4q1EWIW6JHwQOPgOFI9L/EaPRTw+EdQiJJkDstamGc3A8D2zZaL7mvMrk6I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769675396; c=relaxed/simple;
	bh=IsmQzbpRkyFibzYeaeuzFqHoWsPqXj6gmBVettt3J68=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fJhpEE72ZLSV61TIciHsYMe3CWWRLboplRwAENo3iipvY+u7SqibmSTJNzkSnFD2/Do6MjkgSxEwBhmuai2ZfQcDrdgOCUysN2g/tuBozXXlbTYO6kLWy6me1PgF34n50vtufRkLpBztVlc82N+H6q+thBM5xXXzMbi3Cf0d8U8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QaWnfX7+; arc=pass smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QaWnfX7+"
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-2b4520f6b32so1426624eec.0
        for <git@vger.kernel.org>; Thu, 29 Jan 2026 00:29:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769675391; cv=none;
        d=google.com; s=arc-20240605;
        b=ERKkjDz4g/HmXOS6AaSX1rMvJyPY+TgjyH7OJG9YXf7g5JW/cALxF2m7yQqTkQTxly
         3QCxSqG70bKPiT1cDAv3A5c5FEQo0656to3TkgSX3iqNmqZ3TiC6FAzpYRGT75W8eraa
         YPoZPPrHJoYCTlI6EB5xyAFLSQe5ISqj7XMR9Khv1L3j6fSUHc+zM+xaLyjH/olU0gsg
         kMa9uV0i2dpSyFpMRQuflQozvzZyg4Nn/ccqrjJBiRPT7n4L55ZVUr6vVec4CotFTrM5
         1RnEpUg6LrlwyIFCVFwO9gXiNUj5eGNcO4ny2aujn/zYyHjpJEki5G3x2jCe/oubmcaT
         L9ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=g1YmvHi+hRdLOISWbQJbHpcXq4TiQuSurd5JhPI+WV0=;
        fh=6j2Zo/ppaYLbIVYFUydrihuDcycJgfFI3CPfifOih7w=;
        b=J+YeS4+T1DdCGXSxYeqNrTGv+CqXU4cRDCyybg/d5GUQRzRLUy8EUftPKTCaaLoPQF
         MrpZhOFOsi1TcMFGwATBEj9dIAAHYM9LlA2NpG4925wAOo+29622E6HUgc44CAHNupbB
         GNGfGnHN3wA3YCVYFVKcTxTLIAZnDP87kVyB0rrEzO/9cVJJax51tOX0ZNnD5JxzzLtc
         AvLxP1chdpNri4CFJjQMjr4gfIVVidy7iFZgq2UBenzp4fKlxOLOsDaOhww4JXBUxBGU
         ZUsEbsnAw1ZnYJcPWO/ctR5pTiRhVBNxeckwleAIQkYDqFl/8t6XWX1kNTWe2/NoAwUf
         31hA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769675391; x=1770280191; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=g1YmvHi+hRdLOISWbQJbHpcXq4TiQuSurd5JhPI+WV0=;
        b=QaWnfX7+LiKMiYNNjDmIjOAOGBflMxlOB71gGEuVpEORqoyMqQYtEoASKyRdP9HX7O
         nv3nwcOqCGy7v9TohLKMRnj/1stVybiEtX2yFWA7t4wtfnTrBMmCYfLAhjTKv5t0tuiP
         FxhEjcPzST5bNzUtq3jFZS/+Fc82k7RC0J9wjk8BsJgXOq4+a7TsCO9Jyr4dIAPlhofg
         6PV7G5HOFFsdhuzg4N/9cKAPoxH0V+V9WsOPrC1JBGA4LU8PdjL3cTZWwfOlY5dcNyCy
         Z9O2qGFYueBO97sC6avVSOYud73L3vUz5y5OomOKzWjfRUPj5OTNKoia91YAqVsP2wCJ
         jpLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769675391; x=1770280191;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g1YmvHi+hRdLOISWbQJbHpcXq4TiQuSurd5JhPI+WV0=;
        b=I8jew3sXi08BLfnzxxhGu7oVTQcVufGSQk7zEUPRr79jg44FrtvuPsxkh0lHt9+UvE
         g3tFVbxM2AmjFKN13e6Ac6vvFscgZHoeWaluRm+6EAT6wsEHV145TGQ7SfjvDOB/CHoy
         xg2UrHuPKpLwLQSgkpd6b6dZfuGVw7JWXRcNiVSSruKxdAS0KuXbZthpJexaoWeLAo6w
         CldUV0KOD4jCjVgbHtq5Ig6GacTVANDE0S9X+eSerEtYqh3dAEzFVVcyvdgAYcGZ0Cyc
         aOpuhdP2+8Oezi6mnAX5hdbMpRyWZRNFWte0pXqHC9zeelyNDKKjyp0Z0NvP47ilNbtZ
         ssCg==
X-Gm-Message-State: AOJu0YzqHC5sFQCWMbGlZRRIp0eDOHAniyms9KyLb9WjTPRUnWJCFi6+
	bS8wxEGyJglMnf0QQCTGOkN51KABmaeVbLvoi6wskKmtppP7N8uqNs7urYO1BbZjTwOTwhofuMO
	mFYp3TgCrBS6o/mkv5hwCsf6BJYmfZTNc8Q==
X-Gm-Gg: AZuq6aJxrgHYGLTiRmIEhrbyw6CrbH009JMdjxG7IAr/gGSTsgaIt55ySF2gZJwZQ7D
	1lCEyagnVAyj5mDrdwJpxnhojm5gHLQfR93rI9m8drxtccAq1HrlWX2086ORStpPs10IIeBSRK7
	NJsrXhRvcaRA9LalHKZrhS37gaMv1PImKmPDmC/Uyzk7TnwZaWpbgw+UD5zGqIf4tSlONAZp3xx
	6NZgOF5FE+Bt2hI2MDVASYTLh30AIZYmTHnFdOkrQGkxxJLEdK2M3sLxBxTOgL3liAtnj8i
X-Received: by 2002:a05:7022:624:b0:122:33e:6d41 with SMTP id
 a92af1059eb24-124a00f5564mr4792311c88.23.1769675390870; Thu, 29 Jan 2026
 00:29:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1769252118.git.belkid98@gmail.com> <cover.1769256839.git.belkid98@gmail.com>
In-Reply-To: <cover.1769256839.git.belkid98@gmail.com>
From: Bello Olamide <belkid98@gmail.com>
Date: Thu, 29 Jan 2026 09:29:52 +0100
X-Gm-Features: AZwV_Qgf8HxB9ohXffc4mwVxcZnwaVHMQBbW3cpOhlfcllmeuQGkNZsuEyTYk3M
Message-ID: <CAD=f0L_5E+FsnxKOCnFt_Rot9FJ8aP3hzeLTHKEqWD312QJ9kw@mail.gmail.com>
Subject: Re: [Outreachy PATCH v5 0/3] store repo specific config values in new
 `struct repo_config_values`
To: git@vger.kernel.org
Cc: toon@iotcl.com, phillip.wood123@gmail.com, gitster@pobox.com, 
	christian.couder@gmail.com, usmanakinyemi202@gmail.com, 
	kaartic.sivaraam@gmail.com, me@ttaylorr.com, karthik.188@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Sat, 24 Jan 2026 at 13:21, Olamide Caleb Bello <belkid98@gmail.com> wrote:
>
> Hi Git Community,
> Over the course of my ongoing internship, which focused on moving repo specific
> global variables in environment.h into local scope, I have attempted to move some
> variables into the struct repo-settings.
> However there has been some design concerns as regards the use of
> `prepare_repo_settings()` with respect to when and where to call the
> function, and also the change in behaviours when the variable is lazily
> loaded as discussed in [1] and [2].
>
> After different deliberations, Phillip Wood proposed creating a new config
> struct [3], adding it to the repository struct and passing the repo struct to
> `git_default_config()` to store parsed repo specific config values per repo.
> This ensures the current behaviours will be retained.
>
> I have experimented with this approach for some values and I would
> appreciate feedbacks about this approach before we can move forward
> and use it for more variables related to `git_default_config()`.
>
> For now, the parsed value is stored in `the_repository` in
> `git_default_*_config()` and further efforts to pass the repository
> parameter to `git_default_config()` as the callback parameter will
> be looked into later on.
> The link to the CI tests can be see in [4]
>
> 1. https://lore.kernel.org/git/43aaec10-2696-44c9-8728-2045b83dc5d3@gmail.com/
> 2. https://lore.kernel.org/git/a881499d-e236-4f8e-a217-b6bce69e3e3c@gmail.com/
> 3. https://lore.kernel.org/git/8899016f-eeef-404b-8da6-ff3a90e81cea@gmail.com/
> 4. https://gitlab.com/gitlab-community/gitlab-org/git/-/pipelines/2266020513
>
> Changes in v5:
> ==============
> - Corrected mistake in commit message of patch 3 which spelt branch
>   wrongly in `branch.autoSetupmerge`

Hello,
Just a gentle nudge for a review
Thanks
