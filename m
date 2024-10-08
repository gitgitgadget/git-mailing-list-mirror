Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ACD91FA254
	for <git@vger.kernel.org>; Tue,  8 Oct 2024 17:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728410396; cv=none; b=a0Sam3aHX210XGK4JiAt3URJg3BmDL/X7yXBMuWI80U5Yg/Ort1zLwc5zWysQ2OoG4lqqBsJmH2MzV7CVrN0EqfhuyCL21kuBI8yzBLeu6N2tAWop+vjBO7PEG0YsrFUQTNcC76CSTnPW8kAXBNjDeJLQ4pZNCIm5TnXdwpwBwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728410396; c=relaxed/simple;
	bh=YCX8yzCUQIaXBcypanaJUUVuyKf3SBF/GenbxTlJvIE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hCiSunftpJ1YX9Hf5U6WVkjqESCLVjfOnLNRGpd36UPr2I9tU3KY8UAp6Aq0Zw3yuCsH2jb0BGfAB7PkrNaPMHmkJMo5z7TqvMT6EX/UAXeV62//fVkZ0KRBMeAT1zvMnf7j3GHHP65pq8dUCDsrGcLRXJQq+Rhi36D00HW8mQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=khRqsjAl; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="khRqsjAl"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-20b0b2528d8so67536275ad.2
        for <git@vger.kernel.org>; Tue, 08 Oct 2024 10:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728410395; x=1729015195; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=U5D7ktOQl5WJvNF+yid/o2u0m5APNzzmN+ODdgbRWRA=;
        b=khRqsjAlCLJvOQ2gxyNn1sY4PSl0DEN5Oi8zm8Watl0xIx9+fMXX8TGJrWafuVUYQM
         lxmwUFgUU361z90hz695DoA8Nt+msiKjxTmNQOUvlne7vRQdqlJVjit+FLS9IYqT0hus
         u69PyfxdZ4TskywaniGUhJZ2yDiA62oYEeDXk3Xf8u7DKqyZrR4TsaS2y0o+CWSSxfas
         SxyAL/A8/0GrVqw6R/pixf3JF+VOcjVnavfx04AvnzrqT4bcectucPP030QUWQagsRDO
         Tnxm0bkkvQ+TizBdRByH38mXby2rXq8efV6p9Q25YdmuLiQF5IGc5qNwgIrIzA7xmxIg
         fo3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728410395; x=1729015195;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U5D7ktOQl5WJvNF+yid/o2u0m5APNzzmN+ODdgbRWRA=;
        b=u9+xzy1THAe/7mQofyzI0S54rNu3Rlv5u3dGxWq83kqrVeINejGjJcNYbLvEHQNNHk
         6VYk/wV79nZ5mc6flmarViSMkiH3fpapvoO584hsigGlJbdA6XhY8TfitK5doGoFKQ2Y
         c53yYbIiJgLduF4YmblSFsRnM0KDHdRonkvGg1s01R3Rn0eHb7mJNM/ACn9+2GBZPxf2
         4WjB/S9MVj2A6QQlpvCRB8wEN9LrO23Bwfu3fuWWjs+cjA8MLFNgJHHzMh4P7GMhDC94
         6JDUC0m1QHH7N3vXl4XPzvnD5zxZhoU2dWjNnH5FCqQw8QMuPzP1coY+dAWIgi20D276
         i5Ag==
X-Gm-Message-State: AOJu0Yxhk0edBV91eAjV+f8tDmoP1jdMmzaZD+z9TA8nAIer6MtwKDwW
	rlQ2s7Ia+tQJeYhpDz1c2HMvEebFbeODWXdXEFWXgsqWCDcdM17RKtIYFA==
X-Google-Smtp-Source: AGHT+IGssSruZIX2g15HBlQ0FPl7Guo/6Kg5kQYymUzs3iW81wFACF2UQT7tuhnykktMaUUymSKI5A==
X-Received: by 2002:a17:903:228f:b0:206:b04e:71b3 with SMTP id d9443c01a7336-20bff03f465mr256737335ad.51.1728410394638;
        Tue, 08 Oct 2024 10:59:54 -0700 (PDT)
Received: from five231003 ([2405:201:c006:3236:eb8a:e5f7:a2c7:6285])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c593f8152sm12593465ad.153.2024.10.08.10.59.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 10:59:54 -0700 (PDT)
Date: Tue, 8 Oct 2024 23:29:51 +0530
From: Kousik Sanagavarapu <five231003@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [Question] local paths when USE_THE_REPOSITORY_VARIABLE is not
 defined
Message-ID: <ZwVzF9Xgn72tT5Ee@five231003>
References: <ZwQSWcmr6HWTxxGL@five231003>
 <ZwUkUuQgxaE2-djk@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZwUkUuQgxaE2-djk@pks.im>

On Tue, Oct 08, 2024 at 02:23:54PM +0200, Patrick Steinhardt wrote:
> On Mon, Oct 07, 2024 at 10:24:49PM +0530, Kousik Sanagavarapu wrote:
> > Hi,
> > 
> > I have two questions but a bit of a background first -
> > 
> > [...]
> > 
> > So my question is - do we want, in the future in which we are free from
> > the dependency on "the_repository", for all the local paths to be a part
> > of "struct repo_path_cache"?  Which in my gut feels wrong - one alternative
> > then is that  we will have to refactor REPO_GIT_PATH_FUNC - or am I missing
> > something here?
> 
> What I don't quite understand: what is the problem with making it part
> of the `struct repo_path_cache`? Does this cause an actual issue, or is
> it merely that you feel it is unnecessary complexity?

I feel it is unnecessary complexity.

	$ git grep -E "(static GIT_PATH_FUNC|^GIT_PATH_FUNC)" | wc -l
	65

Meaning each of these would have to have an entry in
"struct repo_path_cache" in the world where we don't rely on
"the_repository".  Some of these are also not direct ".git/some-file" but
".git/dir/files" where ".git/dir" is also given by a seperate path func,
like ".git/rebase-merges" and ".git/rebase-merges/head-name".

So why hold pointers to such filenames instead of just calling
repo_git_path() manually - all these filenames are "local" anyways - unlike
say files such as "SQUASH_MSG"?

> > I got into this when I was trying to refactor builtin/branch.c to be
> > independent of "the_repository".  It was a very naive approach of just
> > manual conversion of all the git_* calls to repo_* calls and similar
> > changes but the compiler started to complain since I overlooked
> > GIT_PATH_FUNC and some variables in environment.h which are also hidden
> > under USE_THE_REPOSITORY_VARIABLE.
> > 
> > Which raises another question - why are variables such as
> > "comment_line_str" and "default_abbrev" hidden under
> > USE_THE_REPOSITORY_VARIABLE?[1]  They don't seem to be dependent on
> > "the_repository"?  Again, I might be missing something here but am not
> > sure what.
> 
> They do depend on `the_repository`, but implicitly only. The problem is
> that those variables are populated via the config, and that may include
> repository-local configuration. As such they contain values that have
> been derived via `the_repository`, and those values may not be the
> correct value when you handle multiple repositories in a single process,
> because those may have a different value for e.g. "core.commentChar".

I see.  Guess I didn't do my research right - didn't know about
"core.commentChar".

> > By the way I don't expect this "naive approach" to be the right method
> > of doing this - I was just tinkering to get to know
> > USE_THE_REPOSITORY_VARIABLE better - since builtin/branch.c also calls
> > into ref-filter which heavily relies on "the_repository" so changes
> > there also would be appropriate for the complete picture.
> 
> Yeah, in the ideal case you'd first adapt any underlying code that you
> happen to spot that relies on `the_repository`. That doesn't always
> work as it is easy to miss that something implicitly depends on the
> variable. But in case such a dependency is missed it will get to light
> eventually as we continue with our quest to remove `the_repository`.

Thanks for such a nice explanation.
