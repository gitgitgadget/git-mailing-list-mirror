Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE421ACEDE
	for <git@vger.kernel.org>; Fri, 12 Dec 2025 20:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765572030; cv=none; b=iFYoJHNKrgI9/+3bO7Fs6uEGPmxzw3bUQzBiez3EFVCpltxhP2lxqTofoBlwXcBJBnk7DKZbFN6QWgtYskZLk8DMil8RNrEvZ/BOMQf8q1APX/CCloYmuTpC2c0Cra0OMBcOm06To1+fH9pITmgbxjzyzG4P33qdHfKdF1EfF10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765572030; c=relaxed/simple;
	bh=1lsWmlKKEVPxNNIUZT9r87OIGtUWwbLt3jj06EQTbD4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K7tECyrwuMuersous8TTDtKe4bzXEOKRutyf/MttcXOA3usrVROGZqC6UDpUPSATGxJF3Otur8O2BDX6xJTwF8ykPSkgl975PIR42gy5/O1EHr7kA6/XhMsbEDqeo35MH6oI+EC1Frsjisj10fp0DobYIbnN+TzXmTW7J71vTiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g7g/NQ/N; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g7g/NQ/N"
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-3e12fd71984so1212224fac.2
        for <git@vger.kernel.org>; Fri, 12 Dec 2025 12:40:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765572028; x=1766176828; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=h7XL4NGguulp7IVOJRrfYOOjWxbf71pTERliPEhtHRM=;
        b=g7g/NQ/N3afLvljrVy+4f5mTfPr0lkZpu2O3VtOx7QfbELTuenjk636JQc/KTDWEBg
         Vnr8PpO71OCFfYYtSeYpFo0nxvvagMcMSpXTFngDYcrCxq+pv5pmgD7uieSpeZB7oiiq
         Nikhv2hgy72cfMTfzPCCj3xdqpCFxr3n8P4YcwLu2eW12H4kBdBs3D4k9TkHOfEqaZ44
         W+R0B4dxyJKCtR4+cCbs+rRhKoIVOznyC15b+YsubMZZv3pYHvrLI0ULllO4Hwb1q3yx
         6JT+wpHSO5tUGhc5SUisMPyC++pOjYtUNFhr29sbBQPo4O2MSv1iU0rhNGjsnEhRCqxN
         6xKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765572028; x=1766176828;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h7XL4NGguulp7IVOJRrfYOOjWxbf71pTERliPEhtHRM=;
        b=bRmdcqn38ihvcaYIjXanYzRcL6/eDRnhed5kFUuAPQxKcik/dqxFCw2/W7sySjGg0Y
         U5wQEHB0x74ZnBcX9sFtzyUuCHGpslmu1OYfEe03Q939r6KQYegakPdLn0GIbdtOJYjY
         kkm7FRyB3BlSHj7cYtpE97eyjNuq13cOR6gUbQSuoQKrQrlt1qEYs6U/UEuxyy6wKl/q
         udOHCWKrVtxeMTDuICiJ91mSoTnshS0bp1hKKORd7q9tTo7JWRNqtyCbnVVjaax6FiHi
         TU/7UsmZhataZ5PM6YlEDJl1wZtqV8OqL15NHYe+qCG3+Zpaoc8/+Ab/LfTyZPopG0+s
         mX+A==
X-Gm-Message-State: AOJu0YxLd/IjSkmjFt2+8AJR55KFG+k4NFftzTWYPjPi6PEn3bfG9Frj
	QyY72cIlHzthfOnCwLQtOh5mEK6uzwxyr1gTmiwF4drMBY/mJbVoK8BFbuZ0Rw==
X-Gm-Gg: AY/fxX7BS/Qos48x/407i4OR0E1Zh+Tu2EjEhuvixwIF9MhDIni8AsSlgNuF9qTwFEP
	0QWr+L9RzEHGpXWIjKJcEDM1nXtmX4C643gbROa08R0RPA43Y908y0ZKKeRat+rh5OMK7236sn7
	5YLq5jGXR9TOn/cw2gqkeEkrCEHKcjKyCJLiHuaAyUcENZZq1KhbsFGWKUVjQ6QZuYzmMX/vDvr
	Z0pdki3soCUa2MA+t03vaVfF07OtxTtji9+4us9H9jJhZKHsEuWslMQVCZqSOU4PRK1ViKmF27t
	Kn/dQ13Sp0NYqG73uf+of8pxGq1Cutc0P/q8g/TaeQSI85WzRNrOUIykJCoSIJaRwHtVOeGiA3h
	H1SZx1G5tOXpFXQ2Iw0piTyGo8c0dnT7qs89xXBFtLiK9mcRgEMrqIEhCm80kHXjS0Tse7CPW4F
	5AiNmPbrqlHpmReLk=
X-Google-Smtp-Source: AGHT+IHnQLSAmyWVf71pGvGf670czHDJmgmrfVj5XS/33ECSs/CogvERD3lHW69JLCuit95zFmLhTw==
X-Received: by 2002:a05:6870:a10a:b0:3eb:7a44:744c with SMTP id 586e51a60fabf-3f5f87420ddmr1645187fac.21.1765572028113;
        Fri, 12 Dec 2025 12:40:28 -0800 (PST)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3f614b7c66fsm34817fac.3.2025.12.12.12.40.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Dec 2025 12:40:27 -0800 (PST)
Date: Fri, 12 Dec 2025 14:40:24 -0600
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 5/6] builtin/repo: add disk size info to keyvalue
 stucture output
Message-ID: <54kuvik2ecbkygjp57osmqjxiy7xtyjeffbzavuxbhuvta2oc5@mkqufah7cb3z>
References: <20251209225820.2861276-1-jltobler@gmail.com>
 <20251209225820.2861276-6-jltobler@gmail.com>
 <aTkTCplQuSX_Y3oG@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aTkTCplQuSX_Y3oG@pks.im>

On 25/12/10 07:28AM, Patrick Steinhardt wrote:
> On Tue, Dec 09, 2025 at 04:58:19PM -0600, Justin Tobler wrote:
> > @@ -106,16 +137,12 @@ test_expect_success SHA1 'keyvalue and nul format' '
> >  		objects.tags.inflated=132
> >  		EOF
> >  
> > -		git repo structure --format=keyvalue >out 2>err &&
> > +		git repo structure --format=keyvalue >out.raw 2>err &&
> >  
> > -		test_cmp expect out &&
> > -		test_line_count = 0 err &&
> > +		# Strip object disk usage from output due to platform variance.
> > +		grep -v "objects\..*\.disk=" out.raw >out &&
> >  
> > -		# Replace key and value delimiters for nul format.
> > -		tr "\n=" "\0\n" <expect >expect_nul &&
> > -		git repo structure --format=nul >out 2>err &&
> > -
> > -		test_cmp expect_nul out &&
> > +		test_cmp expect out &&
> >  		test_line_count = 0 err
> >  	)
> >  '
> 
> We could test disk sizes here test if we use git-rev-list(1) to compute
> disk size by type:
> 
>     git rev-list --disk-usage HEAD --objects --filter=object:type=blob
>     git rev-list --disk-usage HEAD --objects --filter=object:type=commit
>     git rev-list --disk-usage HEAD --objects --filter=object:type=tag
>     git rev-list --disk-usage HEAD --objects --filter=object:type=tree
> 
> The `--disk-usage` option also supports `--disk-usage=human`, which we
> can use in the next commit to verify that our computations are the same
> across git-rev-list(1) and git-repo(1).

So, I'm not sure we can use git-rev-list(1) in the manner suggested
above. It looks like user-specified objects are always included in the
output. When using "HEAD" this means the referenced object will always
be included regardless of the filter used. In practice, this means
reported disk-usage when filtering by trees or blobs will likely be
inflated by objects not specified by the filter. As far as I am aware,
there is not a way to suppress user-specified objects in git-rev-list(1)
output.

I am somewhat curious if always including user-specified objects in
git-rev-list(1) output regardless of the specified filter is
intentional. Looking at git-rev-list(1) --filter documentation:

  The form --filter=object:type=(tag|commit|tree|blob) omits all objects
  which are not of the requested type.

doesn't indicate this limitation. From looking at the code in
list-objects-filter.c:list_objects_filter__filter_object() though, it
does somewhat seem like this behavior is intentional.

Regardless, in the tests I can hack around this problem by using
something like:

  $ git cat-file --batch-check='$(objectsize:disk)' --batch-all-objects \
    --filter=object:type=tree | awk '{ sum += $1 } END { print sum }'

to add up the sizes by object type. This doesn't really leave me a great
way to verify the human-readable values in the table output though. I
may just continue to omit those values from the test like I already do
in the next patch.

-Justin
