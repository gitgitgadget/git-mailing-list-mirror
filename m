Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3BA2EC553
	for <git@vger.kernel.org>; Tue, 31 Mar 2026 14:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774967490; cv=none; b=vC1+Wxg+DD0D6RYtF9HcDac+m0VqsGt1jP0iM0U8eZ/OliI3RBTFiInjXr6P0GSG69zuSISt7+lA6dRqi2f5V6vKrPo/5L6mJ1EV4eqHORz41bYoJk5g28evPfmiE5GbwSXCgT4wFIbC84XmX0uux3GcCMQc7zK7zITBYCT7Dpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774967490; c=relaxed/simple;
	bh=lAHLQJ8Vbmgpho2ySOgsubN+ZcLJX5dN4Bzese5aUCM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ch5Mgjw6tEmX+DfdBaFT6gQr6uD/6JrT6yNlfL5OVqriHUztBF18r0UbUgw/SuESb+hm5EGBcWdcqJrK2wNa8v1YLu6fjG6x6o8pIU11sUFMCnUEF6nqLFSxPHhzlv34mjxFRJcICpxw58eZp2dVFIXCy2JmhU34p1YkpsQMVuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kg7stQ+O; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kg7stQ+O"
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-40f0e14b9f9so3867868fac.1
        for <git@vger.kernel.org>; Tue, 31 Mar 2026 07:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774967488; x=1775572288; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RBBWbx707ZEhoOVf9Muo1mHgqudcIBPXW54ajYoGtcM=;
        b=kg7stQ+OP9Op80zGWRUn9cVQP8B10lPdayz5Cz5ynrBd4w6iqzVkU6szwFJzs7Sm+R
         /DdTYv/D8qIa7jSIWjCV+wo0oGpS+S1oSFxO2Ukx9Qx1xGMaed/oo2Qe2ItvSTCsZAs7
         4KWezy/ftFvYBtD8ZlN7TMSykeBF5Np8+Xk61+zLx89k+60Oa7ZoU2ZHaQE1DyAiWf5e
         +Fsqcl3Vb0/UJIUXDGHQYX1JeDPbxOYiSGdgu9gWzX1YRE3lxs/3mvJxZZJyzLDPR50P
         M2vdNmtiQk1mLhtZZbFG992LFBoguMVSEreZ6jv8D/3Lf+2pG9a1JWgkeoMg2K7y5pjv
         VvEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774967488; x=1775572288;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RBBWbx707ZEhoOVf9Muo1mHgqudcIBPXW54ajYoGtcM=;
        b=C/MspJpQaD5Or28eiCYYSefEkO4bPVzcgOaC0rwsuO+zG7Aqf2vTxNNUbkN7e/TXCh
         jG/qAYB+tjIWhABb2xsH75PRsqepMvHvNSE9ksl+pat+fG3mya3Q+BTL6f0XTkMPUy/f
         7LvzUIGxssm2BiO1RfG1B5Q2JxB+D37Vu+yX1fGRRdEk5Wl+AXM25clwyrqtnuOLF3GM
         u3Q8qBSoflscWyw3fbtgQeD8OjTmtm3ej3syKB5rA5VME3aV1i9QffnPQeutfufwTbQB
         Jaf1O6EcT8E8LVbmNjX4nh76HCAS3cxap9MGlXrZSEQDMmETTqcB/gq1T1vvN6MT7amJ
         XEng==
X-Gm-Message-State: AOJu0YyHuPZXYq0/mlv/cSbKLyBjAW5/XMZOFjkctIYmy57T1bBM/p9l
	Sd7s+Ez8SfxC/Dhzzu/tIqAqFx40MPxJ60QrRK1+hQm0vCEy3QfuXLP8
X-Gm-Gg: ATEYQzwPtGj2/YWt/gXfDcZIOizLQm/Xj8co6rjs7OmcjFMkwkjsiiLB0muvJHGjx1V
	VJX4Szhsf0zPbpQxWz9yD8KKYXggPpMhDuongRcM+EAARSBZqq6q+gp15idE1mlPY0cNj0jIje3
	ltwXHv1ibXAuHpI0z8CTw2iL4uIU2DzRoj4w7e7MtS5ylVlFfjGxugzx9oxW8ZR4SxWSmyDo4tA
	grPHmcvngZbqzAqyaLULNxqdM8v0K7DRuOzvQXdmYxxh8ij7o8CjlrdmBgDfgRWBSjrj2LULHF4
	SQIa5nN1iJMaesqZc5MQ8SznQLiQ7SWbaAoSQxIbOwCIn/7Cx80uQ38irXPeh0GpCAZzCDApNbs
	NfjyRj1IMFk8HcDS6xq57kHnf1zLno5Mj0q1d35buPHWx+371ZRBvw6CrU4E6oMZqnIS7t8FNsQ
	W3iaabpbxzIyCJZSpt
X-Received: by 2002:a05:687c:409e:b0:409:9a0b:b733 with SMTP id 586e51a60fabf-41cec167efemr8823791fac.10.1774967488171;
        Tue, 31 Mar 2026 07:31:28 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-41d048e1984sm7387465fac.4.2026.03.31.07.31.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 07:31:27 -0700 (PDT)
Date: Tue, 31 Mar 2026 09:31:25 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 5/6] object-file: generalize packfile writes to use
 odb_write_stream
Message-ID: <acvX8wdg39xTy-Am@denethor>
References: <20260331033835.2863514-1-jltobler@gmail.com>
 <20260331033835.2863514-6-jltobler@gmail.com>
 <act8YM8tMeUr3cJe@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <act8YM8tMeUr3cJe@pks.im>

On 26/03/31 09:48AM, Patrick Steinhardt wrote:
> On Mon, Mar 30, 2026 at 10:38:34PM -0500, Justin Tobler wrote:
> > +
> > +	if (total != size)
> > +		die("unexpected number of bytes read");
> 
> Do we want to mention the expected and actual number of bytes?

Ya, that sounds reasonable. Will update.

> > @@ -1543,6 +1542,40 @@ static void flush_packfile_transaction(struct odb_transaction_files *transaction
> >  	odb_reprepare(repo->objects);
> >  }
> >  
> > +struct read_object_fd_data {
> > +	int fd;
> > +	size_t size;
> > +	unsigned char buf[16384];
> > +};
> 
> This interface feels generally useful to me, not just in this subsystem
> here. Would it make sense to instead expose it in "odb/transaction.h"
> as a new `odb_write_stream_from_fd()` function? No need to expose the
> structure itself, I guess.

Hmmm, exposing an `odb_write_stream_from_fd()` function could probably
be useful. Would it be better for it to be put in "odb/streaming.h"
though? Maybe the its use case would always be related to transactions?

> > +static const void *read_object_fd(struct odb_write_stream *stream,
> > +				  unsigned long *len)
> > +{
> > +	struct read_object_fd_data *data = stream->data;
> > +	ssize_t read_result;
> > +	size_t rsize;
> > +
> > +	if (stream->is_finished) {
> > +		*len = 0;
> > +		return NULL;
> > +	}
> > +
> > +	rsize = data->size < sizeof(data->buf) ? data->size : sizeof(data->buf);
> > +	read_result = read_in_full(data->fd, data->buf, rsize);
> > +	if (read_result < 0)
> > +		die_errno("failed to read blob data");
> 
> It's a bit unfortunate that we die here, but we don't have an easy way
> to return errors. I wonder whether we should refactor the interface a
> bit to maybe take a pointer to a buffer as well as the buffer's length
> and then return an `ssize_t`.
> 
>     static ssize_t *read_object_fd(struct odb_write_stream *stream,
>                                    unsigned char *buf,
>                                    size_t buf_len);
> 
> That'd also avoid having to cast away the const-ness, and it allows the
> caller to control how many bytes they want to read at once.

I think the above suggestion would work. I believe there is only a
single other usage of `struct odb_write_stream` so updating shouldn't be
much churn.

> > +	if ((size_t)read_result != rsize)
> > +		die("failed to read %u bytes of blob data", (unsigned)rsize);
> > +
> > +	data->size -= rsize;
> 
> I feel like `data->size` is misleadingly named now, as it doesn't
> reflect the overall size but rather the number of remaining bytes that
> we expect.

That's fair. The variable starts off as the initial size of the object
being read, but really is just the number of unread bytes. Will update.

Thanks,
-Justin
