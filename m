Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793374805;
	b=uKQyjj/usBHYJ0ZZfbr8uOU+VTj9FtBpO+QyTzOyVmlnGMSJzpIWXiPUzlr8ro9SKzm6
	 446pt40+8H7a7FhCobvDq5EsNm5H1e1obvYFFdlqaJOksXenFMOmbKzaNU/Hpakliewys
	 D9gKgjVUW6eGTKzUMp9R+E8dZVr/PYBNIrQXS1VdQoUBNzPXU02A1BDfAW7XcAxA9RPDE
	 wvaMqoyi3GvRJTvjDgJDDQk44Rw62n7cUF75etia+fvoy53UaZFZ8wmoDcRBB6w32hCa4
	 +k26hxMjhpYVosSxIymKobut8QAITtg5s60L2kz5l23mFjWi5ah2ZK0Vf41QipZrMdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793374805;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=fFDdeg6FaaDEOKCOfT3abL/1nJzY6yVAEvLN/4/ItVs=;
	b=gEhZLjJj4Khg/PniLpEhuPNgbCBXPwMRceC7iQip3VQTkjLXoN6WLIaflTw4DjRbCNAQ
	 DIBG+DTdrmLx6oRonskJOJ5QnYpstOrie2ZgaGCYNAsqMbmMXozl7r6jS/T0EYQKy/Rbg
	 r4qRRdHszaCveDezsFsbyoedz5RKd06jN6tS7oiZoWKkWizLiUbVKHYTNqLrrv5SL6Hpo
	 qNglRYUGRMpq57CA+fj2V+hGhADjmfy9uA+FPpiyVL9cLEniobwRK/cIbeS8cdb/TNdwz
	 ha9fcdHkXCRX18xQqkVqRTZmczJtlWKDHBWqmqb7SMF574cGUFn/wZyYxZl2D8fd93A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GP69F+pf;
	arc=none smtp.remote-ip=209.85.210.51
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46004606A31A
	for <git@vger.kernel.org>; Fri, 30 Oct 2026 15:40:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 46004606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GP69F+pf
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-854e904005cso1386671a34.1
        for <git@vger.kernel.org>; Fri, 30 Oct 2026 08:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793374804; x=1793979604; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fFDdeg6FaaDEOKCOfT3abL/1nJzY6yVAEvLN/4/ItVs=;
        b=GP69F+pf1L6IXavaZ6OqrILltmYzR+0pZywEVXotNTREwb42bIEUTa3yACgcCH3zDl
         gcIxxD4gsHcZDna5XV5zjcVIJs1sC5trBjlwuJBn4E6HM53OrBN/uYXO4Sy3SYaxgVYZ
         qdV0NP3g6SY81bqY2OmGEG/ELsVlDqbevAnHYHsDLGPXrybwsWYnNKMhgnyvun9As5JL
         enBRGDQWpv7XmvRn9s4cziT5l0ayG3HWrWR1fZd2pBH1pa2dVEiEXVIIrrF1dbzTEh+M
         GUDhNQ8df+w7nnbj7R8bzJN55jrZM8m9o0e4//SvEp6HfTTbbOBWMyP7w8CwVvP6xFnM
         JQGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793374804; x=1793979604;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fFDdeg6FaaDEOKCOfT3abL/1nJzY6yVAEvLN/4/ItVs=;
        b=JO79wQ/UcU6Glidq7lJjcOl4IH/Uwk0iZnLz1/nyZQlaOK7lni8IaqP/w1JOlARl9m
         +YsQbFZY7nVwOUNZEA9phkVOVzddPZxd4cCrjDaL0dbKJOIbF66aZXou/UyGKVTq7cuZ
         ygnysSvU5P/Zfl7klO76+ilrDjcdns3DMlrdujUqjqdDfDUgiMAUr3/pwTF7+0RrqOv1
         1m4ySzJmxNHJ9cWXA7jh9OnZviGOimu+hrdq09R7DSWV+8zyLbThL7/HSYl3tzH6404q
         dbiF3c7Hm9jWu+4Hve3Nq6vssVPTlOjKVPFPSipXgSD+6KCn309L1PDADswKJoSTD0F9
         gtMQ==
X-Gm-Message-State: AFq9FYLyPnOv1DWLevHRhUd4fNAUYWtIX9PVdFyQydD0Jk+SceRxqQyo
	EyWRPz/lsbnU6eRUQ4pGJxhHNjTrSiWvFADy3/eqP3ZMEDSMYWFUahHEGnKCKQ==
X-Gm-Gg: AYBFou0/RkdWbotZarlleYc3myerVC7AuRt+XjY4D5F83C4UHrG5g99vTxqV0HgQqYU
	Nkjyxb5fq+RW7GQJKLYShA5xJb26hKXNhDqvyXNZajQaeeL+SI1miQgN0kCPsUSuDru9/SwX2Ia
	6nwdWn9RjfHs9QfW4ARAofAFVspuskFAQpEdxnFwrRtU0XHi7AFJu6Xt6oY2Aq4tahUDODATX6W
	ichbCNOmXGCYc9CljqVs+5jWGaThQLqlZntWz+OdSTh3OrgaiuA4P4RHNCE2F2x6K+LBklN2fKo
	L7RZ/j2ucgtwiQiR9J5Cu7xFcHj6garshpDrEJ1igxBMzIGip2xOC0YQwJGTzaxgKL4UN7UzAnT
	O5CTn+314t+tK7YhgwIyLOtImWhFxLsn/+Rv/NEr1ohFmylJre++ZDQInTCucamrrOKlN1mND0K
	h9I1UZwq02wUe4zckPYAYYnCjdL1BtZ2LorvkR6Ybx43WLWRlVN+bDDLIXFp5LmqBiVFu7avSLp
	M474Tui6tFjMLVE2t9TlrDXWf/lDFZptomQRidvqGp92Nm4EekKHQ1ra2p0enNsqI2FA52INMdr
	RXWWrFXGlMoEiVB4rLj3eZF7tjCeeKeF+XrngPHuC5M7BOwWxSbSNw==
X-Received: by 2002:a05:6808:1b2b:b0:4b2:8d83:436e with SMTP id 5614622812f47-563ef93c51cmr3016016b6e.8.1793374804010;
        Fri, 30 Oct 2026 08:40:04 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-5640fe45587sm1717471b6e.15.2026.10.30.08.40.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 08:40:02 -0700 (PDT)
Date: Fri, 30 Oct 2026 10:40:01 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, ps@pks.im
Subject: Re: [PATCH v3 4/4] tmp-objdir: merge loose object index when
 migrating tmpdir
Message-ID: <auS4SzrVGYfAG8KA@denethor>
References: <20261029002413.3291184-1-jltobler@gmail.com>
 <20261029232220.1245827-1-jltobler@gmail.com>
 <20261029232220.1245827-5-jltobler@gmail.com>
 <CAOLa=ZR2AmC4EDM7V2A9UainUZ5md=dQT_pnJycxuqV7BhfxxA@mail.gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZR2AmC4EDM7V2A9UainUZ5md=dQT_pnJycxuqV7BhfxxA@mail.gmail.com>

On 26/10/30 08:55PM, Karthik Nayak wrote:
> Justin Tobler <jltobler@gmail.com> writes:
> 
> > diff --git a/loose.c b/loose.c
> > index f2e111c25e..0ce9c7486e 100644
> > --- a/loose.c
> > +++ b/loose.c
> > @@ -311,3 +311,50 @@ void loose_object_map_clear(struct loose_object_map **map)
> >  	free(m);
> >  	*map = NULL;
> >  }
> > +
> > +int loose_object_idx_merge(struct repository *repo, const char *src,
> > +			   const char *dst)
> >
> 
> Nit: should we name this `loose_object_map_merge()` to stay consistent
> with the other `loose_object_map...()` functions?

I specifically did not call it `loose_object_map_merge()` because,
unlike the other similarly named functions, this one does not update the
in-memory loose object map for the object source. Here we are only
merging the "loose-object-idx" files.

> > +	if (loose_object_map_write(repo, map, fd) < 0) {
> > +		ret = error_errno(_("unable to write %s"),
> > +				  get_lock_file_path(&lock));
> > +		goto out;
> > +	}
> > +
> > +	if (commit_lock_file(&lock) < 0) {
> > +		ret = error_errno(_("unable to write %s"), dst);
> 
> Nit: Shouldn't this be unable to commit/rename? This will differentiate
> from the above write error

I choose "write" here because logically we are trying atomically write
the final "loose-object-idx" file. IMO, I think the difference in
filepath should be sufficient to differentiate between the two as well.
Ultimately though, I don't feel strongly either way about this and am
not sure it's worth a reroll, so I'm inclined to leave it as-is.

-Justin
