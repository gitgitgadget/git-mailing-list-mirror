Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35BA1494287
	for <git@vger.kernel.org>; Fri, 16 Oct 2026 18:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792175877; cv=none; b=k3jLCKYbo8AnRPDfeoJe4OQ8SJRH0OcVwEe+KbjDhQds4+SHHXq0Lf0S0YivjjPtlJwoVyNLi8+tJsN4LJg3/TlccJuQY5UF9rskqSP1mwDnxlX+24oBYmg1fGB9KV+oLw2YuQzCp+35HSPNle0PVVLcMmF+/qJccdouTux1y+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792175877; c=relaxed/simple;
	bh=pLZcWpwIedfx73qXa1Y8ekalkr0W9HG1xs/XgokO/zQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JsfjUx1QlcVRXMhiNi20Nyqv902Cp7DLIl/K6YA+Sm5tkfkaxjTe+XFXtA9ARn3LLMdVEkP7qbiZpO06UGBSNlXpAEroGtMmjcvrwQvbWdHarZYm32NRWLgw7V/V3UutbjkAkD04ofA+aOeoxDMUcK6wjm3bWyT5e5/Q41jkfVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b6Ipwh7a; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b6Ipwh7a"
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-6df5e315bd1so176707eaf.2
        for <git@vger.kernel.org>; Fri, 16 Oct 2026 11:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792175875; x=1792780675; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KsVmjN3DyuAGfPhngjenm4ePwCaQtPk22xtGC9iTuSA=;
        b=b6Ipwh7an3mSCZS6XojMvGtLiNdeu5jrE/U1w3XTEpHS8kSCtFPa6stozU0TD1NRvM
         D86OdPrbOAOI86eZOXEpAG6cmZs6B2DNMSAcQuKGNF5xdkiS8E6QDiRkBClTdbq1g3c0
         lQbcGDil+C2VZqWLH7DvUUGN+vBLtPIyxIt69oYutGipMPHzzVWFkWqAdFmGssIXUPjQ
         YnSG/AEh4dBPne+DYDEAEs9Wyu/fWZ4OFMxcsksJB3ID2nqe0bkwxTbZebQno92253DT
         YHLiEzpR0/NtP8ci1vk7xdBsefL9HnZwuTNudX6+Ft4bIlY3f3WCVqTqutf8o3E4OsmO
         w6vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792175875; x=1792780675;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KsVmjN3DyuAGfPhngjenm4ePwCaQtPk22xtGC9iTuSA=;
        b=DkB/mIE3zSA3a4qBWZtKaBKSiIv2fFdwLwgBA9tdZHyhyhq/2BXjyjLq6Rm9VrthTj
         nLKwn6Lz3lstSrrTeUPgg00Gvq55SYoTA36nl/UI3dzM82iI1WnvQPVBwzP1MZu26IJx
         /bGwtrE9k8Rzj5e6+CdEeIvZ3w3g8TVeY9RjTmXYX4WHdO8/RS+7l4CQ4lp9Jo2jLK54
         YPGJu0DAOFeXI1K3WVNFltrVNRpihYH1nZEubtU/CUHr0pjfDP6DFmXLzCeGemSptjAg
         rJXxX/yhPjEjBB4gvX+DC1x6bFZC5bxe7/Kscw2uO2QffefhqcDIMmeP5tXPAjgTQB5M
         AvVw==
X-Gm-Message-State: AFq9FYJx3kCOy10zfWnX3DAEc4TxxCLrrKzB6VVDYn+Bj6A9GJmIADLL
	n5Yh4ZcCVowH34wqshxFf+J3mLsNEC2M1n08gcnnt5NeqPYIEhN6s9bQx8Iwsw==
X-Gm-Gg: AYBFou2tnGl0/jteJopYB/tDF6zgCwD0VH+tlvuxP9W33vCBZU6JfKA8Y1+ybXYpNdg
	TsuQqGGbOzK/xWvcUOXw1yuZP420mXHklYUAaZ9sZkZoXWg+XzWmd7f52ou3mTvm6zJdQ7o4eXK
	puHg27bjRfbpEamH9v+gFX0LBr+8bB3F9QHK5Brifx/YnSFb86p93BwOlxql0icAmS7w7G1Nv7/
	bRoBt0rq38OHjv4HUYuJE/D7ulXtBrUQeeX1USR4RJKAVz2C8o62NoU2pG531Fh46yFTXhDtiYt
	G5vcAIoIqZ/H7xyMOR2n92JSruHBSox2jd6m9SrqLLqFQD64SZf9hSojphmaA1cVzPVOQ03Wkm+
	33YF/mPEYiOilBJunbvLHO023wp6jVoUakq+hC9QIAez/syJcG6ilkK6ozdlKZFhLpZYAgGssdK
	DH0ap1/B2HFYpG3y0pYVY5LFVoxeKsi08c6dwXPwFgPg4OCw6V13+kX1lX61JRpzADX9DAno08n
	BknsMEAWAm59XiTtq0pcuha
X-Received: by 2002:a05:6820:82c:b0:6f9:6bb7:1818 with SMTP id 006d021491bc7-7035649823bmr233923eaf.39.1792175874969;
        Fri, 16 Oct 2026 11:37:54 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-8443782295fsm1138060a34.14.2026.10.16.11.37.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 11:37:53 -0700 (PDT)
Date: Fri, 16 Oct 2026 13:37:50 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/3] object-file: explicitly write ".keep" lockfile
Message-ID: <atJhElOsxd1KaZJ_@denethor>
References: <20261016022901.3838402-1-jltobler@gmail.com>
 <20261016022901.3838402-3-jltobler@gmail.com>
 <atHLDysZmYGyMiKk@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <atHLDysZmYGyMiKk@pks.im>

On 26/10/16 08:58AM, Patrick Steinhardt wrote:
> On Thu, Oct 15, 2026 at 09:29:00PM -0500, Justin Tobler wrote:
> > diff --git a/object-file.c b/object-file.c
> > index 210984f825..ebe46d35de 100644
> > --- a/object-file.c
> > +++ b/object-file.c
> > @@ -1256,6 +1256,43 @@ int read_loose_object(struct repository *repo,
> >  	return ret;
> >  }
> >  
> > +static int write_pack_lock(struct odb_source *source, const char *pack_name,
> > +			   const char *keep_msg)
> 
> Nit: I'd have called this `write_pack_keep()`, but I see that we refer
> to the files as "lock" in `index_pack_lockfile(), too. Should we align
> those two functions and call this `write_pack_lockfile()`?

Ya, that's probably a bit better. Will rename to `write_pack_lockfile()`
in the next version.

> > +{
> > +	struct strbuf lock_path = STRBUF_INIT;
> > +	struct strbuf contents = STRBUF_INIT;
> > +	int ret = -1;
> > +	int fd;
> > +
> > +	strbuf_addf(&lock_path, "%s/pack/pack-%s.keep",
> > +		    source->path, pack_name);
> > +	strbuf_addf(&contents, "%s\n", keep_msg);
> > +
> > +	fd = safe_create_file_with_leading_directories(source->odb->repo,
> > +						       lock_path.buf);
> 
> The command has just written its packfile, so can't we assume that
> leading directories have already been created?

Yes, with how the function is used currently we can make that
assumption. The lockfile is always being written into the quarantine
directory after the packfile is written.

I would like to keep this function a bit more generic though because it
gets reused in the subsequent commit to write the lockfile directly into
the primary ODB during transaction commit and there I don't think we can
assume that the leading directories have already been committed. Using
`safe_create_file_with_leading_directories()` doesn't really cost us
anything either because it always tries to immediately create the file
first before creating the leading directories. Ultimately, this is just
a bit more defensive and I was hoping to reduce the changes overall.

I'll leave it as-is here unless others feel strongly it should be moved
to the last patch.

> > +	if (fd < 0)
> > +		goto out;
> > +
> > +	if (write_in_full(fd, contents.buf, contents.len) < 0) {
> > +		close(fd);
> > +		unlink(lock_path.buf);
> > +		goto out;
> > +	}
> > +
> > +	if (close(fd)) {
> 
> `if (close(fd) < 0)`, just to be consistent.

Will update in next version.

[snip]
> >  		status = finish_command(&child);
> >  		if (status) {
> > +			strbuf_release(&pack_name);
> >  			strbuf_addstr(err_msg, "index-pack abnormal exit");
> >  			return -1;
> >  		}
> >  
> > +		if (ret) {
> > +			strbuf_release(&pack_name);
> > +			strbuf_addstr(err_msg, "index-pack failed to report pack name");
> > +			return -1;
> > +		}
> > +
> > +		strbuf_addf(&keep_msg, "receive-pack %"PRIuMAX" on %s",
> > +			    (uintmax_t)getpid(), hostname);
> > +
> > +		if (write_pack_lock(transaction->quarantine, pack_name.buf, keep_msg.buf)) {
> > +			strbuf_release(&pack_name);
> > +			strbuf_release(&keep_msg);
> > +			strbuf_addstr(err_msg, "lockfile write failed");
> > +			return -1;
> > +		}
> 
> ... then write the lockfile ourselves.
> 
> By the way, the error handling here starts to become unwieldy. Can we
> maybe have a common exit path that releases all resources for us?

That's fair. I'll clean this up a bit in the next version. Thanks.

> > +		ALLOC_GROW(transaction->pack_lockfiles,
> > +			   transaction->pack_lockfiles_nr + 1,
> > +			   transaction->pack_lockfiles_alloc);
> > +
> > +		/*
> > +		 * The lockfile filepath is expected to be the final location of
> > +		 * the ".keep" file after being migrated to the main ODB source.
> > +		 * This ensures the lockfile can be found and removed later
> > +		 * after the ODB transaction has been committed.
> > +		 */
> > +		strbuf_addf(&final_path, "%s/pack/pack-%s.keep",
> > +			    base->source->path, pack_name.buf);
> > +		transaction->pack_lockfiles[transaction->pack_lockfiles_nr++] =
> > +			register_tempfile(final_path.buf);
> 
> So here we retain the status quo, which is to record the lockfile in the
> final location even though it doesn't exist there yet. And that can lead
> to us pruning a pack lockfile from a different process.

Yup, that is exactly right. :)

-Justin
