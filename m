Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C609F14EC4F
	for <git@vger.kernel.org>; Fri,  7 Jun 2024 21:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717796665; cv=none; b=luJljMQkMx/jbJjmIh1zAbLGLxs/xVm0R2B1MJhXQe6wJwiDlEYpq1qBCP+ITjEUQ7O6xo70dILms07inyMIVWgIP8USFh8yxysgZp4KoQy4fhMdUTIjo5+jqYg31VxZ3PuU4iaqPlnOoxb12XpI1KeMAGx7GoYlTCS1DjudbaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717796665; c=relaxed/simple;
	bh=L6SUh80TGRbAJ9/pOS1oFPdA0Q//SHqWawK2Rh6KlqE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ONVwwsBKHv1MMtQhCD++bzwKRBlAxG6iy4QdHXF0eD+lP45EYOaUNEjljISDpjpkeh3BRZdaXeYQNuegIbwhWriyLb+j9qmOXuOWa5RERd1x1sbOLOkWva0sgtErRMkpf8BSoeczOE7tQ1JlEHzd2qMonsF2sVr9dwuQjCZyS70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=cP7hQ6aZ; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="cP7hQ6aZ"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-43fdb797ee2so14805001cf.3
        for <git@vger.kernel.org>; Fri, 07 Jun 2024 14:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1717796663; x=1718401463; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UhIsXnpKLsNZbbExCBKZX/O1ZXQ8j7QiaryV+b1DYVQ=;
        b=cP7hQ6aZlccyNBN2eRoCi6XgUwQiq9vfoM1Z+vSLK7ivSRBvdryP/ZqemLvqnY2220
         1TH4REVl3ZhPsPhnN+HEt/ukgHfemqkXsotMDxLz5+281yqfy7FROKGNGYYmNzuAPQ/Q
         Xlwvp5SVsMOrvGmgdz1//uDmXdGr3mAAuD/yWrsmc4KWWO0ZqTWBK0mTq1bxq1aF4/F+
         9xtSl7kG38AOE9zfWMrIujYPzTwiSPkxGLrwok34JNk4Ir0CnBsBLKuY1JOp6xU9ds8Q
         nFs48IVKd67sh8v9E43RF5tVcK4R1Aw1h87bCU9nri4U7LgIO012fWzr7XH7FLKtXWek
         5wgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717796663; x=1718401463;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UhIsXnpKLsNZbbExCBKZX/O1ZXQ8j7QiaryV+b1DYVQ=;
        b=XggLWgzUyqC8WAC1ZjpWhB7Cgo7LnUB47XtQN0U8QmzL7BP94x61rNQBKnhpo5mToB
         qz9ZSY8VeYtkoepZx2DD2IpzyfOibDbf3QXUF2brkZWiSxxldOiXSpisxxeIYsIIbKAc
         oaFMWm8wDkV1ESONzziyrJtDt7a2UIZZDL6rtLneGSmKzMejZgVER+j0kJTP+o9MzHd9
         aGwprbxnzNnaOwKxI2ctLwA9mRz19iGCMRKuR1WfnQ+uEwiixpQxlxuL2cXiHHIFTRnN
         wARKDqm5WCghBI55crfPs4aGq68URRUz8JO4haEYJq3W5BzPot1OStBaUXtQkNNgc2ZD
         mFCg==
X-Gm-Message-State: AOJu0YxounPm/+texYWdJ5KD1st0BnvPeucCpc8Ns6Dxeu6zYpiENLku
	RFyIPxZAKwaig4+NK418yksfhPeXVfwNrXB0n7HaMLUUnFtjsb+bO5pvcNn8NKZg0wVaq2SeRjj
	gWgk=
X-Google-Smtp-Source: AGHT+IFWuxFuRRLbilEfT6LYkdosnll0yfco02X7NwMPUH1dPr7lfyPDImr/PoZidWadrCwd9506oQ==
X-Received: by 2002:a05:622a:1314:b0:43d:9d93:f601 with SMTP id d75a77b69052e-44041c7efa6mr51195861cf.56.1717796662659;
        Fri, 07 Jun 2024 14:44:22 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44038b59429sm15507421cf.80.2024.06.07.14.44.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 14:44:22 -0700 (PDT)
Date: Fri, 7 Jun 2024 17:44:21 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 2/2] server-info.c: remove temporary info files on exit
Message-ID: <ZmN/NZlriT3gsw7p@nand.local>
References: <cover.1717712358.git.me@ttaylorr.com>
 <2d5a0536af1a6d45835622e2c020266079fa0873.1717712358.git.me@ttaylorr.com>
 <xmqqfrtog2rd.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqfrtog2rd.fsf@gitster.g>

On Fri, Jun 07, 2024 at 09:02:14AM -0700, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> > @@ -121,27 +120,22 @@ static int update_info_file(char *path,
> >  	}
> >
> >  	uic.cur_fp = NULL;
> > -	if (fclose(to_close))
> > -		goto out;
>
> We should fflush() of cur_fp before nuking it, at least, no?
>
> In the original code, to_close was a mere copy of uic.cur_fp and we
> made sure that anything buffered at the stdio layer are flushed to
> the underlying file desciptor (fd that we obtained from
> git_mkstemp_mode() in the original code) with this fclose() call.
>
> We no longer do so.  We later call rename_tempfile() to close the
> underlying file descriptor and move the temporary file to its final
> place, but I do not see what guarantee we have that we do not lose
> what we had buffered in the stdio with the updated code.

rename_tempfile() first calls close_tempfile_gently() before calling
rename(). close_tempfile_gently() calls fclose() on temp->fp before
returns, so we get our fflush() call implicitly there.

IOW, the tempfile.h API is happy for us to call rename_tempfile()
without having explicitly closed or flushed the underlying file pointer.

Thanks,
Taylor
