Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A629125C6FE
	for <git@vger.kernel.org>; Mon, 24 Mar 2025 15:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742830767; cv=none; b=jkgEojACrQEy2UJrGn+rQJhzurk1dfMnhz6pCk1Ea0W55ujt9gA80i0XiUXIwfJ9JmlyPLkeKAhu2KdLIrUyvKvftgyRBw8ciu+MhGrLEzt+qtu1ZpMr2WNKZxDYMYAIU7PFttVsZ7pb9rBaBlzE308SnFtul81JfZIHOl21bj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742830767; c=relaxed/simple;
	bh=Wa+u+YO9wXmQ1Jpo+KaRpC0Fhd8w56+jsNKD2fRnLdU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pkA033RFYjpWt/c7pyjwn5HAoiQEiW0Tg0nKUsZcy2HIi/6CVz9KPZHTgcyPAK1613v8DwAdODuXK3NGd/IiX+bd0ZOR+vBIPjHqpuQP3S3kOIk2L3g4wNpqmmjYrmD0vjvOQGfW5poXRBRBgS7fFZoPFmVMM6/R+36qvpt2vVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OALqnf14; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OALqnf14"
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-2c75830b455so2529426fac.1
        for <git@vger.kernel.org>; Mon, 24 Mar 2025 08:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742830764; x=1743435564; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iLtOXkM3SSMJzSiLUv+OmL3AvGRgGOParhDDCI1UmvU=;
        b=OALqnf145a95d1iQNQqUQs6Mn+M5zb5BybvQtHGEOumkrRgrgUdujRE9ELlYGEuksH
         jvgVQX3E5iwZuBNNq18oTT38rGDlBdjU8G/cLMFs7V3RFJC/CCD8sFZGtwo56dFV7x+D
         Rzz3cXvSE3VAeHFxT2vjkDZKY0q3HoXXspk2gQWwHrOueVWuRXkC3rJnlqzPlWhoSLtR
         DHri+cgE3svF8oXOXn6orH60swwx5zSx7WMLRPjotLn7vjCUCdTn+2EDSAYVRqbO1q1K
         op0f9aN2JNeaMnm0tHOGdkseWu4dO+A/AzQ73KFDmoZiAwxVoJv+JbI/SRnemYuYAuzk
         h2uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742830764; x=1743435564;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iLtOXkM3SSMJzSiLUv+OmL3AvGRgGOParhDDCI1UmvU=;
        b=oYSewhNIr47GdCOEw/ehY6gYV2Yht1o2kvRfBWga+Py7X06Ma55a5RiOaFutHx3gwo
         nxi+FSWBXl65b4o7BjMNUUxCQbHN+yfsgxOVUiuTusv0yEIib4XMejS+pwxxTKzFdPgn
         LRX0R43M2ZtnT9x3Eu1g7wBPMcFbtkev+dajxOXAc2Buukx8rov8wlf0OOxFtrXswB9H
         tpLRzftOlZT9n2mKSma+6BG4hZe2UOktcudMPQCuvgil9foIJdGEUo3g9HGnVneavXWz
         gowzWqHqtVhGVgXTurT0GgVtWlZs7JMURd6gny11bE522QkpCH6eEI7p336zpiGubf3R
         vRiw==
X-Gm-Message-State: AOJu0YzVGRw4i6g1gIDRmFqmY1E/DGdcmPLj6IGHpaNAescIGaxdNjio
	Hb2+LWl5Y9gBIJOOMm9BRpG+QkHJg4e9kQOagw/NDPySJw/IJmzBDWhAZA==
X-Gm-Gg: ASbGncvLYu3cwlRUfjdUkJ+JvQ5IEjSjubG98BMPHZrhvFTXiKnJ2XvX1AIXGR/urRV
	Yi1MF5a3ge7v7EwJXJGpXBTbI3FPBVGrVB6mvQqh4RfMbF/hnL9GC6wejL35vMEHLrSGwpyvX71
	nN83Z1TcEkW66mH+w7rThqKOxQb1zR7FjBH2VWikYLqcQnSZB/VV9eEv+QbTQsCnySwl2elUUE1
	+39rxktFBQ1Ew7XrzomGT2Ekl96Yrc6zk8u6tibFc5YGSbRYtUBb4d+GyIzkDKFohC4wTLh0Yfz
	VLxCf5sV3ot/90MQw6QQcV0MkdGLhdX1Rrp4Ww==
X-Google-Smtp-Source: AGHT+IGdhgXHK8KYpiKFd6sR+ErSLsnl1i/hkKuXrqPUNkzoxHt5AldvtHeu9BksDALHP/qzDJfnjg==
X-Received: by 2002:a05:6871:10a:b0:29e:6f32:6da1 with SMTP id 586e51a60fabf-2c78047e05emr9033600fac.31.1742830764493;
        Mon, 24 Mar 2025 08:39:24 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with UTF8SMTPSA id 586e51a60fabf-2c77ebc8dc5sm2070032fac.4.2025.03.24.08.39.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 08:39:24 -0700 (PDT)
Date: Mon, 24 Mar 2025 10:35:45 -0500
From: Justin Tobler <jltobler@gmail.com>
To: phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, ps@pks.im, alan@norbauer.com
Subject: Re: [PATCH v2 2/3] builtin/clone: suppress unexpected default branch
 advice
Message-ID: <w7kbqucqwajzo5q6qfty2o52tytvzkzsio755mz6cforuenaap@hx3zfd3nns6e>
References: <20250320014646.2899791-1-jltobler@gmail.com>
 <20250321231639.180762-1-jltobler@gmail.com>
 <20250321231639.180762-3-jltobler@gmail.com>
 <966aa1cc-fd4a-42b7-a241-0537767021ed@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <966aa1cc-fd4a-42b7-a241-0537767021ed@gmail.com>

On 25/03/24 09:32AM, Phillip Wood wrote:
> Hi Justin
> 
> On 21/03/2025 23:16, Justin Tobler wrote:
> > In 199f44cb2ead (builtin/clone: allow remote helpers to detect repo,
> > 2024-02-27), clones started partially initializing the refdb before
> > executing the remote helpers by creating a HEAD file and "refs/"
> > directory. This has resulted in some scenarios where git-clone(1) now
> > prints the default branch name advice message where it previously did
> > not.
> > 
> > A side-effect of the HEAD file already existing, is that computation of
> > the default branch name is handled later in execution. This matters
> > because prior to 97abaab5f6 (refs: drop `git_default_branch_name()`,
> > 2024-05-17), the default branch value would be computed during its first
> > execution and cached. Subsequent invocations would simply return the
> > cached value. Since the next `git_default_branch_name()` call site,
> > which is invoked through `guess_remote_head()`, is not configured to
> > suppress the advice message, computing the default branch name results
> > in the advice message being printed.
> > 
> > Configure `guess_remote_head()` to suppress the advice message,
> > restoring the previous behavior.
> > 
> > Signed-off-by: Justin Tobler <jltobler@gmail.com>
> > ---
> >   builtin/clone.c         |  3 ++-
> >   t/t5607-clone-bundle.sh | 12 ++++++++++++
> >   2 files changed, 14 insertions(+), 1 deletion(-)
> > 
> > diff --git a/builtin/clone.c b/builtin/clone.c
> > index f14229abf4..a4008715ec 100644
> > --- a/builtin/clone.c
> > +++ b/builtin/clone.c
> > @@ -1523,7 +1523,8 @@ int cmd_clone(int argc,
> >   	}
> >   	remote_head = find_ref_by_name(refs, "HEAD");
> > -	remote_head_points_at = guess_remote_head(remote_head, mapped_refs, 0);
> > +	remote_head_points_at = guess_remote_head(remote_head, mapped_refs,
> > +						  REMOTE_GUESS_HEAD_QUIET);
> 
> There is another caller of guess_remote_head() in wanted_peer_refs() which I
> think we probably want to be quiet as well. I don't see how it is helpful to
> the user to prompt them about setting the default branch name used when
> creating local repositories during a clone of a remote repository.

For `wanted_peer_refs()` to invoke `guess_remote_head()`, the
`--single-branch` option must be set. This means, outside of the bundle
clone example, there is another way to get unexpected advice message to
print. Interestingly, if you perform a bundle clone with the
`--single-branch` option, the same advice message prints twice.

I'll send a followup version that also suppresses the unwanted advice
message from `wanted_peer_refs()`.

Thanks,
-Justin
