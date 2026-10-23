Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.144
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792756651;
	b=VVLjftk2yRWPfnxUt1rIot/6ReuxSQxg4cQeUsiNmYRuvj4i94PcAvBFiQ1T3frVQXHm
	 Ak/5NrBR+U9MGj/Dz1Ng2NIInI9ED4ifgfoUYrRvjzLZbMUvsiyxzaQiWncoKiNMuTgXr
	 KqiAekaWPB3YzkmfzixtVOplm/3l8OfVpoDaYRD1hlCAz+Nxc4ie9aPdTQxO2wLHBmzCq
	 QqRx83/fv+aFmOUz1RyaOyiU8n8f/mWXUJrvxoc566qB+Uas6SOhXYEqyy+xShBwkG3me
	 pgM+GEi5B0fqqTNMbWWGHOAOF1E+kIyE08CGt+ZEIb2+LUMj+Z/oJFI7tOslGePcblg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792756651;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=qLh5nz/giaTReexBpWtvzZIHslRbw1U1w/9i4SXhITg=;
	b=e6ZTAJj/ES+NIy5fE3A+CqTM/n3T6OIoDihq/OBKxIi20XrWdATbYR1numf5vmnJOr6r
	 4kQe6H7IHIojDK+Lryp42UKGqTum0J3vRnCFY4YV5Vo57No098xlh0Gc9iy7uHcuPRHb5
	 bvsmNiMxMIminRubc1Ggr4dpIzijhJqBCdqIKI+a2Qrs2et5w73xzxeJKVFnZW9e3wIq8
	 KkKOn5VKSEthLkALDQzorTBIiV8/LduuGUA6OexBndH6SAOjzp3p/+P+XxeBo6n/V4tuV
	 StHkfbVrIrayRVt73sgya/tOwsL35AituTXAMWdYMxGOpSWsPFQf1jsw5S7KP0lHT3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=KS92YaIw;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=ZwD11vfE;
	arc=none smtp.remote-ip=103.168.172.144
Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26EA1606A31D
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 11:57:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 26EA1606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=KS92YaIw;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=ZwD11vfE
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 6DCB5EC013B
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 07:57:30 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Fri, 23 Oct 2026 07:57:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1792756650;
	 x=1792843050; bh=qLh5nz/giaTReexBpWtvzZIHslRbw1U1w/9i4SXhITg=; b=
	KS92YaIwfUVfnK7fuCF0G4DneJEt91SVF6hphPlcg+7ff53LCPwdegvKoON8iD8K
	hnzwQTIbaQxnMPzckEO9gPgxU903Q4Pi3ZxzEF185cN9IftYXTb7tbn0VyI0+zVe
	olD+MMhmJKKWFqw6VTFhybETippWgypMRn5RbVdomlhNqQg2q/Re8Uz0ulBfuMt6
	cZQ9WWAt+05LELmO2i/Ihr7dQ2rSWWmxvWTqJAnVKMsLoQwd/VQoKGzzHzWi2e08
	SeqoUPEzZ2Xr4rVWaldU6EZ2NcKn7OtWSyt1tk8uF5uAdwIs7bgxaUIgwQeDsT7J
	AS+05uECE8O02r3QDnffCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792756650; x=
	1792843050; bh=qLh5nz/giaTReexBpWtvzZIHslRbw1U1w/9i4SXhITg=; b=Z
	wD11vfEti+QzwXwR6d0l2Fb+Tep7sNVP6kgsktO4uxdZNWOk6CVzxIEypVCCSF68
	EQPC8hFI4oQ6DQ7uFqFa5NZ7E/+D76J5EKPj4mMJ1QMgiCCC6pJk1NksiAlo5fDa
	+tth85yxwHY0u8cYqHbjUKWOeetQ9OpLtcTh1k3IY/E7+1ZUzYID4BQPM8b+fv7n
	Cl0CG1cP6l3HpA6WLKB66J7hYZoBlby3gei6Bopfov3mZXBq2vwXjpjPMsZlJjwm
	HCQphVHAEFo5PggZe3V0H3mSU8G9ZBCr+lDXMNrrWiTqKFUWz/gg0n9OkIq4SJ7P
	BlqTTT1kT9z0hLvMOVsOg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792756650; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:LqvXxm1349Aj52tzMZPMzD/G6eaFVdk/WpGZ9UjgqIcOSja
	rDyU2vojg2JLq2Wbed7TBbyGYf9/mUymZYDq2LoyRx/5sO4QF9x2Kv/p8SsG2CPJ
	XP9iPC47vWNgZPb0va+cjIRLQcm47XKvEg8llf97CyY58TEwKv049qNQQd7uNRkI
	6zt2/3bBem0y9Dtb3YyWFu7+KscKXCdoWg/rPNRmMYS8HpO4RPK14oZNBzG7wpTB
	c4pojwmS+Lnc4Nhi5yvU+2yRfGZOqFyXR3uB6V21cv5tM1Q6mGZvrod1y1B7dZ+9
	Yi798unZI6/btiNDxJPl/r3vOYQEStx6DwE6y7w==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=cc,content-disposition,content-transfer-encoding,
	content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:6wRLdA+lXNEIMFgY0Li+WE3gqW+cDckZTQWxEmTv2aE=:FVNZ9fJzg9F1ZocIup9K14kiQAMhD7MqCbJx7mVT/70=;
X-ME-Sender: <xms:qkvbaoGDbOneB-6DkeTw_EC5FO0LY7Jr2BtcSdQ_34GJ1GXpDSVMdw>
    <xme:qkvbanWD2dJgXMZ7pEqS3lxKJhRp9CvQ4h4-hKLXHmB6olfppup6hKNXAGo8d5fqv
    XP8yYFHlBKnJyu4t_JOlwxNuqf9VxnGcL8SGP8T21nGFSL-sbRdmwWq>
X-ME-Received: <xmr:qkvbavwM3Qzo9kHQKp-slMiar79Ig_XutqujgEFaUWQBVluvh-alkB0AWE4IEsgVQQbPvg>
X-ME-Proxy-Cause: dmFkZTGoAwrymGEQB7ZlxDh8q/lyEgSpdsl25uJpxaUDjl09K93A+9yF/rYxhU+u07xEHk
    Vsjvo/+8n7LLt90nn+eP5REdNXbkt+r+QtViGFSocm192nUePDlqOm6Q+ti2TvLqKW/G/v
    ivFwOpF6Odwd8KPjA3rlDURsM9kf9OVUvzoA0okc8Ypj/gcn/i4HNyjEgKq0VjFPLdNrJf
    REhguQyYeZyLOWco98d1Yv1kQl9zMc5XiJgErhMVS9xRz06GH61vHyw2PRksSuqW3thFU/
    +/8lRsoyl82hSOZjIeiI5UIu6ernqba9Cms9tfylpEpS5LhuO4OY0cbolvCcCDmR9o/3IL
    242wVHPBypV8JneCir7q6GDaNu+nziEsi2Nd+t4nQ9zkXREv/ddrDJsWY+MEs/tXf0jhCt
    /rHDJ0pJAbSmYMaf3qiKb5ko0/b0suaecMRV4DJfz6BOykvHR9EHhcUNO2F3qlu/YYunBe
    ckBhxh2MOVMcC4zQXM/eqoymVwoPeDHeVmQxfpEeryQvRCfv7I/u5ReRpCE5ocxHvS+Y1V
    mKnMP/yJ4qts5vuFlFlFtTskOD1K9HFj7TiHnls8An7JvAAt9CnzyL/A8R5ejhtmUP2sn7
    kiDmx8T1api8ue5D4nS04BFemx+bY6M99zJY7htNZfN86Om2lRlJNCf+WbLA
X-ME-Proxy: <xmx:qkvbalM487uJ84gubXBmL-uwl6sxaj5SFgHEBQhQOAIo7-6bdv4XiA>
    <xmx:qkvbag4LdFtbCTtTilwRPgkvFhZzlu_5eOfLlJy7zn0UtBH5gaMlSQ>
    <xmx:qkvbamM01yS01onWIGpLFLFAQx2FZaakzTB2g8jNKljzygrCg7DYGA>
    <xmx:qkvbaunyigl10jpsa8z8Em3B9VCoTEgdXPRazbfpS74lw9y1lYszEQ>
    <xmx:qkvbao0OCHWcJN2Mdox38jffrc0ms1qkLr9bLj-75Z8of4YtSqgooP_v>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 23 Oct 2026 07:57:29 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 569ea7d0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 23 Oct 2026 11:57:27 +0000 (UTC)
Date: Fri, 23 Oct 2026 13:57:25 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/4] odb/source-files: reload alternates on retry
Message-ID: <attLpY_V0uOZzGII@pks.im>
References: <20261020-pks-odb-files-reload-alternates-v1-0-d9e156323836@pks.im>
 <20261020-pks-odb-files-reload-alternates-v1-2-d9e156323836@pks.im>
 <CAP8UFD0woTHVqy0cXtWJCL9Pt_jqWXT3m0bN=LufOQ_zJaKeAA@mail.gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP8UFD0woTHVqy0cXtWJCL9Pt_jqWXT3m0bN=LufOQ_zJaKeAA@mail.gmail.com>

On Wed, Oct 21, 2026 at 04:32:34PM +0200, Christian Couder wrote:
> On Tue, Oct 20, 2026 at 11:01 AM Patrick Steinhardt <ps@pks.im> wrote:
> 
> > diff --git a/odb/source-files.c b/odb/source-files.c
> > index d31da6e5d9..86f3fd1136 100644
> > --- a/odb/source-files.c
> > +++ b/odb/source-files.c
> > @@ -425,6 +425,7 @@ static enum odb_read_status odb_source_files_read_object_info(struct odb_source
> >                                                               struct strbuf *errmsg)
> >  {
> >         struct odb_source_files *files = odb_source_files_downcast(source);
> > +       struct odb_files_dir **tail = NULL;
> >         enum odb_read_status status = ODB_READ_NOT_FOUND;
> >         enum odb_read_status ret;
> >         bool retry = false;
> > @@ -448,10 +449,11 @@ static enum odb_read_status odb_source_files_read_object_info(struct odb_source
> >                         status = ret;
> >         }
> >
> > -       for (struct odb_files_dir *dir = files->dirs; dir; dir = dir->next) {
> > -               if (retry)
> > -                       break;
> > -
> > +       /*
> > +        * When we have reprepared alternates then we only re-scan directories
> > +        * that were newly added.
> > +        */
> > +       for (struct odb_files_dir *dir = tail ? *tail : files->dirs; dir; dir = dir->next) {
> >                 ret = odb_source_read_object_info(&dir->loose->base, oid, oi, flags,
> >                                                   status == ODB_READ_NOT_FOUND ? errmsg : NULL);
> >                 if (!ret)
> > @@ -461,6 +463,8 @@ static enum odb_read_status odb_source_files_read_object_info(struct odb_source
> >         }
> >
> >         if (!retry && !(flags & OBJECT_INFO_QUICK)) {
> > +               tail = files->dirs_tail;
> > +               prepare_alternates(files, NULL);
> 
> This calls `read_alternates(files->dirs->abspath, ...)`, but when we
> use a temporary primary directory, `files->dirs` is that temporary
> primary directory. The prepare_alternates() call will then quietly
> find nothing new because temporary primary directories have no
> alternates.

*sigh* True. I really wish that this in-place modification of dirs just
went away entirely. But that's a bigger change to make.

[snip]
> I wonder if it would be better to always reload the repository's real
> alternates, instead of `files->dirs`'s alternates. This way, objects
> that moved to an alternate would still be found, not only during a
> receive-pack like before 5946a564cd, but whenever a temporary primary
> directory is used.

Yeah, we should probably use `files->base.path` instead.

Thanks!

Patrick
