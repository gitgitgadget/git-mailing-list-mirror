Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA89DEEC8
	for <git@vger.kernel.org>; Tue,  8 Oct 2024 12:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728390240; cv=none; b=jPiX2n5AZbPNTFMHa5bzBFoXAMBw41e8IecvckdcjDJpMQrw+S/S7Zbn13mPLNU5Y5qsFHAVyoJFDBjwafI2apD7TOiQBwJRTIgstrR1xbmZ4LEhRzDhNVCO6np2ZBKlJ0HHd5oui/mxqYDrRqB0z/xs4y+CGwB0v9NbxzK4+XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728390240; c=relaxed/simple;
	bh=mkNxq/XeDJH2zJA504Z59qQJcbySul/cq5YgNkb3Wsk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t/f4syB0imuGWQyRWhiTPYG64X1S8+JLOV8lBg2NhSTQE9E970nWWrt8QDlHERkF3Jk5YJM6Lbe1mDb8gxEowYHnQmkHmUlX5Q/6TBkO5ABZAh/QHocHYahz+QC4+D9PJMndpYTTRtNboXA8DeMFyiiII9aAzoAP3KroeJNy79k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RsXOET2W; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RsXOET2W"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-71e02249621so1534122b3a.1
        for <git@vger.kernel.org>; Tue, 08 Oct 2024 05:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728390238; x=1728995038; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pEe7Eu38JtlAQ/NkiW4j1C0wUizqp1/g8oS+JXwcRWo=;
        b=RsXOET2WFiAqsyR3NGcs4D/o2Bzt2afcE3J2B4gMQBi0BYQdEENOSd6SW+jB+Ndt3p
         eZMNVOOhJ8SGZN71clmSK4lNtSG+59501mA1+1PJ0PXPWM89A4s0dhjipV9HCW5CzqN8
         ejkz0bJF6YrSzEYncwWP2bAUeODvC54pGoufmcOaG7rlE+Vbk0cJZrOhpHP5F8pesfja
         TgKl7BGpmsqwytIQx9AKg9fNNvu38iss3ee/jCNKbZ0Qf50lPuBkYe61FAQ7l2nClE9b
         IaTIqre/Z31Di16wl9FvIDqKHWP7gZUDrMnHc4Q2o1P7PCbWd86liC8dtje7JOBm9Gzz
         K5kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728390238; x=1728995038;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pEe7Eu38JtlAQ/NkiW4j1C0wUizqp1/g8oS+JXwcRWo=;
        b=X5T/oypidsOeStoB4Xe7rnx4cd7/0N3Ypd9hRJCaK3TsUi5AOnC7U0heOsKtUwzasD
         1WlGvBCg9Eia8nZL48BMTpgZ8HSDANqFOTAbNoE61xnKWd52LJ5C1FPZVKPrWq+DPUYF
         359SwUTGNDr8V2b9fRK6D70n1bcMMlWVd4lnqlzUEoYyzmh2ias3CkAyzjPFA+6VQ0C8
         8hQFEBMmAu6cUVrupenmzF3zwHtnZsfIw8ASoHRcSvCSgCmNWLqCTs2splsBORxwR9P/
         Za12jC0jdauHt25CogtW3qoc9kZrMRXgLQtcpSYGGn3lgjWGXTGRJtZ4MUVRRXvHTcSq
         pUoA==
X-Gm-Message-State: AOJu0YzIv5alqJ+UBXuCY2T7lNBN9SwgezyQxnbdTRZH83u4QvuIFBTK
	856lHXkZQWjvbTwqb91vHhiiu1b/26XldueoFXdnBbtUr/ic/eO64vMl6w==
X-Google-Smtp-Source: AGHT+IEzDZtId+AMXEXbvuoNRNuYAbweJR1fgzPxJhaCTD4JKAeOI6IvP40rg+Egu3ucWYi2sVkFPA==
X-Received: by 2002:a05:6a20:9f0f:b0:1d4:fac8:966 with SMTP id adf61e73a8af0-1d6dfa27e8emr24087717637.10.1728390238035;
        Tue, 08 Oct 2024 05:23:58 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71df0d67bd5sm6227345b3a.176.2024.10.08.05.23.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 05:23:57 -0700 (PDT)
Date: Tue, 8 Oct 2024 20:24:06 +0800
From: shejialuo <shejialuo@gmail.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 3/9] ref: port git-fsck(1) regular refs check for
 files backend
Message-ID: <ZwUkZuCtYu7niuFM@ArchLinux>
References: <Zvj-DgHqtC30KjJe@ArchLinux>
 <Zvj-osCNDMrUQv83@ArchLinux>
 <CAOLa=ZQ3Gytt4Lsttxws3DWqbjteJS8mXvZSPzDwBJi_ALS03Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZQ3Gytt4Lsttxws3DWqbjteJS8mXvZSPzDwBJi_ALS03Q@mail.gmail.com>

On Tue, Oct 08, 2024 at 12:43:20AM -0700, Karthik Nayak wrote:
> shejialuo <shejialuo@gmail.com> writes:
> 
> [snip]
> 
> > +	if (strbuf_read_file(&ref_content, iter->path.buf, 0) < 0) {
> > +		ret = fsck_report_ref(o, &report,
> > +				      FSCK_MSG_BAD_REF_CONTENT,
> > +				      "cannot read ref file");
> > +		goto cleanup;
> > +	}
> > +
> 
> Shouldn't we use `die_errno` here instead? I mean, this is not really a
> bad ref content issue. If we don't want to die here, it would still
> probably be nice to get the actual issue using `strerror` instead and
> use that instead of the generic message we have here.
> 

Well, I think I need to dive into the "open" system call here. Actually,
we have two opinions now. Junio thought that we should use
"fsck_report_ref" to report. Karthik, Patrick and I thought that we
should report using "*errno" because this is a general error.

Let me investigate what situations will make "open" system call fail.
Thus, we could fully explain which choice we will choose.

Thanks,
Jialuo
