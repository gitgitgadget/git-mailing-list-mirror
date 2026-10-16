Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0678A34250E
	for <git@vger.kernel.org>; Fri, 16 Oct 2026 19:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792178565; cv=none; b=AEbKbrsXhl9gyNtZ5r40sgPe/T437oQP7PpuEQgV/iklg2ZjCfknDjCueua5tR/BwJYj3RQ3SKGRbHxSKSGbwNgsYmo+rjRvXF+foQPbAyHvRYnHiWB4ofWM4G+1NWyKWEH9V3T3e6q7GMPptlOGrlW9lpl0RQ//U6isrwF5i7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792178565; c=relaxed/simple;
	bh=5Emp9X3/uiCPK1vbUL2ZR/YivxzJFrrMa07h7+H4Rgs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qyshV8ciG+3dJzuecFmIK0D//TGUcSjdaNb949KP+AWmpXyX2jgCb88hPgsLKbxeIftcEoUIlFoRH9kC5aMvQ6JDJREEBkPW+pZgIZ+wrtkQgGpPxSt05Cfd9ZEj11Npk1F3eDZ7XNe74DhQHIblVVWoEheGyOc0q1kFrleKV28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FlGDmQAS; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FlGDmQAS"
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-4b28d9537bcso267020b6e.0
        for <git@vger.kernel.org>; Fri, 16 Oct 2026 12:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792178563; x=1792783363; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8en138+V80Fu0VI0GQYKh+QAZjIhOPeWWgp/E7PjN0E=;
        b=FlGDmQASpaWxWnwp5D+x3dURsKSMRWgoXGlNgGrN69T91Aw1c0v5rHHj/nMa1dbhqY
         B549t6v4pUN52j2PYBaWFr1stV2kLqfYHz0cNXWeB+Q8hlws32/E7CMtO4IMeJG/UTh3
         CoNq88qLWE87u2Iv4uAIGZ1o1bQWH3EIL+d79nXwhyLsKmhc/n+KhLZozZCyIKRGVw5w
         klLoa6YvCVLNx61LFc4Pr8nEBaTU5NrV034OUhYM8qspI5z+6fs60lrltrT/C+0ZGtee
         y78jbTJpofxKU0vAkdlxaDiM5qz99gLUANTUBRkAiOkFKaT8i/7SAox4dp/3ZiX3Qp3E
         PmSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792178563; x=1792783363;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8en138+V80Fu0VI0GQYKh+QAZjIhOPeWWgp/E7PjN0E=;
        b=AJSRFJThQpHzZ5Abhi0JryD6oENQqeZjpm2EtChZmbX0xYMRabnem3a703BN1HgMrT
         ac4aBbpzviYcZtFzEyylqWuaou9Z8JqmEzCLf8o5uOXI8S7CINlNbf6SJirCW+HPO0GA
         QtB23/S6Or8wbkfEGqFbBNVISJQEiM08bLA5Ab17xnlAmzQ/T1rK0cPGd1s/Yl8cR0Nc
         TSpVTJD/KUFg7Zl5uoCpwT2Jd9Tu4Nhpf8TRZBUG9S2S3f/59MgFI8VnEZ7OEI15xFaI
         pJ8BxGeNNNYsh+nmmYLk8R1bc1EXfE+T30ilACG+5CddrDOLr8XMhe9Q6oWvujyudlgp
         f+Ug==
X-Gm-Message-State: AFq9FYKTa72JwPxfqOm8gkp8khin6p8qNFTRi437VnonnGZc8YHLg83E
	qIrF0U5Ns7yTXJxbLeg9lzHjX9SSvpdnkQwa9a5ey5fbbIsLf4HMdxkB
X-Gm-Gg: AYBFou155cqgeL6PmW4cZ7pU1hz70K1O8DWMaz+lbfcCk0SpBgMX9BuViIyHhIW9k1w
	QzFhSHRkqHlVg/fNktnTtDCSTI2UbwvDHkYzGCRgbFuBfds95LjwJy7GQk+WQgjdYRhrUo5dy/Z
	FCnWFIQzW27+yfoKJXdZrrRA/ERjR2g4eHXrA7t4hEzum4T6iMWnqQiQ9MewvXdzI1L8xvW2V4J
	Ke4kUBJPnDDcDA5jg6ou37RciS+AAfszAf7vCwL8jMdq0A/K6JEj2eo8NsjNjLLh7fyPiWiu0Gc
	4ClnF2F2wTgQWwSCwamooWXkuz9v+YCmTg6w49Mx8B400JQ+u4Ve+WGYxMY/AKA3wbcmwMY6SnP
	0dQHRdkjfhQ/8E4A/impwUcY/MjnoMGJr2nCWE3VIn/zBjEfCGm2NPH0tuNsGtfW2rDthice0ei
	bE7fvLvHBwvI1wsTew++xE8KrYURRjcCnLiq6LW50VpWGLv3mUf+r12IrwCO71P9a0zMyUjYz+8
	y8+Y9R0xPuzNUrLF8iJxNQ=
X-Received: by 2002:a05:6808:1a1e:b0:4c4:a040:958b with SMTP id 5614622812f47-53cb7d0b332mr435745b6e.0.1792178562767;
        Fri, 16 Oct 2026 12:22:42 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-5388c16d862sm2165852b6e.9.2026.10.16.12.22.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 12:22:42 -0700 (PDT)
Date: Fri, 16 Oct 2026 14:22:39 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Qin ShiCheng <qeesung@live.com>
Subject: Re: [PATCH 3/3] object-file: write ".keep" lockfiles during
 transaction commit
Message-ID: <atJxHsn_OxJ_HtWW@denethor>
References: <20261016022901.3838402-1-jltobler@gmail.com>
 <20261016022901.3838402-4-jltobler@gmail.com>
 <atHLFIp8MI729ZkP@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <atHLFIp8MI729ZkP@pks.im>

On 26/10/16 08:58AM, Patrick Steinhardt wrote:
> On Thu, Oct 15, 2026 at 09:29:01PM -0500, Justin Tobler wrote:
> > The "files" ODB backend writes a ".keep" lockfile into the transaction
> > quarantine directory via `odb_transaction_files_write_pack()`. When the
> > ODB transaction is committed, the ".keep" lockfile is migrated to the
> > primary ODB alongside its packfile. Writing the temporary lockfile in
> > this manner has a couple of downsides:
> > 
> >   - Failing to migrate the lockfile during transaction commit due to a
> >     concurrent process already acquiring the same lock still allows the
> >     rest of the transaction to be migrated into the primary ODB. This
> >     dirties the primary ODB with new objects even though no references
> >     were updated and the operation failed.
> 
> I'm not fully sure I understand this downside. Are you saying that we
> fail to migrate the lockfile, then continue migrating everything else
> only to then fail the whole transaction?
> 
> ... skipping ahead a bit...
> 
> Oh, I get it now. You propose to first acquire all lockfiles before
> migrating anything so that we cannot conflict with a concurrent process
> that aims to claim the same locks.
> 
> That will of course mean that we will fail the transaction for any
> concurrent process that happens to write the same packfiles. But based
> on what you claim that was already the case anyway, but now we notice
> early and thus won't commit parts of the transaction. Makes sense.

That is correct. Previously when migrating the quarantined objects, if a
matching ".keep" file was already present in the primary ODB,
`check_collision()` would detect the preexisting ".keep" lockfile and
bubble up the error to `tmp_objdir_migrate()`, but still let the
migration continue. This ultimately causes `odb_transaction_commit()` to
also return an error.

For git-receive-pack(1), an error during ODB transaction commit already
aborts the operation. The main change here is that by manually creating the
lockfiles during transaction commit, we can avoid the migration step
entirely if the lockfiles are not able to be created first.

I'll try rewording the commit message here to be a bit more clear about
this.

[snip]
> > diff --git a/object-file.c b/object-file.c
> > index ebe46d35de..39e6299be1 100644
> > --- a/object-file.c
> > +++ b/object-file.c
> > @@ -1321,6 +1357,9 @@ static int odb_transaction_files_commit(struct odb_transaction *base)
> >  		delete_tempfile(&temp);
> >  		strbuf_release(&temp_path);
> >  
> > +		if (write_pack_locks(transaction))
> > +			return error(_("unable to lock packfiles"));
> 
> Okay, we'll now write lockfiles before migrating any of the data. So if
> any of the files already happens to exist, we'll bail out here. It would
> have been great to maybe also provide a proper failure message via errno
> for example, but okay.

Ya, good suggestion. I think I'll update the `write_pack_lockfile()`
helper in patch 2 to provide this additional context. There I can also
print the specific lockfile causing the issue.

[snip]
> > @@ -101,4 +100,28 @@ test_expect_success '.keep file is removed after push' '
> >  	test_path_is_missing "$keep"
> >  '
> >  
> > +test_expect_success '.keep file created outside of process is not removed' '
> > +	test_when_finished rm -rf keep.git &&
> > +	git init --bare keep.git &&
> > +
> > +	git -C keep.git config set receive.unpackLimit 0 &&
> > +
> > +	# Create a ".keep" lockfile matching the packfile to simulate a
> > +	# concurrent git-receive-pack(1) that was already written its lockfile.
> > +	test_hook -C keep.git pre-receive <<-\EOF &&
> > +	pack="$(ls "$GIT_QUARANTINE_PATH"/pack/pack-*.pack)" &&
> > +	pack="${pack##*/}" &&
> > +	echo "baz" >"objects/pack/${pack%.pack}.keep"
> > +	EOF
> > +
> > +	test_commit bar &&
> > +	test_must_fail git push keep.git HEAD &&
> > +
> > +	# The ".keep" lockfile of the concurrent git-receive-pack(1) should be
> > +	# left in its place.
> > +	keep="$(ls keep.git/objects/pack/pack-*.keep)" &&
> > +	test_path_is_file "$keep" &&
> > +	test_grep "baz" "$keep"
> 
> Also, there should be no corresponding ".pack" file, right? Do we want
> to assert that, too?

That is correct. I'll add an assertion in the next version to make sure
the packfile is not migrated too.

Thanks for the review,
-Justin
