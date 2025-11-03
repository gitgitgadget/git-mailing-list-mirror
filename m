Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17CF32ED86F
	for <git@vger.kernel.org>; Mon,  3 Nov 2025 09:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762162676; cv=none; b=bmJaavf9ky49VIg3sMnPnfprAgyIw6FAgx5k51TYCCDhB+aqb2HDQB3Oaw1gSbR9s4/Zh90ipTg0T0A0St1v9lLo6zkOm3mct6bjQzHU8bwtjOkghio0TScOI4g/MeIwB+uIac+o1RkNJQJnlYojZs9DJAZR01s3Qgx2aB52Nhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762162676; c=relaxed/simple;
	bh=KjZCJpgJBCpiEdIg2/2x56q76sjwEAY1F9ePB4vggS4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B7wxWsKjBOSlZS2tIEYHOLxk/Co6UMgiXjwoHnbjLO7fW48L9lqJ7vqAlZNbtIoIOjc9aegiDzUWXPVmz5YbaP3CnbUeOkqzi7pp53Y/+A3xHuW0hJtdzeUhB3DekKoapgpQc6WzTlDI0izC6v7oLxLA3pPp3zHzlJmXkeNbT8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YcE4kq/0; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YcE4kq/0"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-475dc6029b6so37217295e9.0
        for <git@vger.kernel.org>; Mon, 03 Nov 2025 01:37:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762162673; x=1762767473; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AY5IQ1aC50XjChq0noPaQdEWyGDVUkLp8hDjg7aKUPc=;
        b=YcE4kq/09uE0DYPWdFbo6giC90cPPexIGhJCwM8h7oImHYufBcefvcmS4gqTBcfK2z
         o7E1AMexAGPLorf2jvmy5Y8l4VSs61Put1xvGgp1RqgPW32/cOEnCaIqN7hcxqknMs78
         ubDQ2aToPuHJdpYRJnX4o4wc8S+9FpkoMVhdsUupnW6yD/PLnbmqweFshOQPHwqmZg9r
         P4FIYPec2p9lrwAZ/5P2xksxI616q0kLfxhfm/TV6SLTxuem9ZONP2DORqadYtl/ystQ
         TG5Rjfeh0q9s+3ZrI+JXa1f5a1J7TqtKTnDaUHI36Sj6K3oPWBgCHdD6i0jB8ziQrToU
         y6VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762162673; x=1762767473;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AY5IQ1aC50XjChq0noPaQdEWyGDVUkLp8hDjg7aKUPc=;
        b=JSXdptnujs9bouCDR9eXqg+4fgUVNTmUJZgeSbkHElIK7LMFT18WjyHsi54o305/IT
         ZfPQaHu3Pfc7AX5kSYJU+5qU5gHy+weDLMGqdTfv2BGomDrm5xA+7t5Q9yNzc4BwD5YR
         sNyDtqGnoRk7OyCWg55th5ZBQ2joS5Sz7JzpOsYNYvmBhM55PfwJvivpa9AI63r3XEWP
         gjvMlSm9EiFkHTxQtmD676Cv26iAhdiXu3cv52YvnDhzEOqdhEjlxoR9NCkJ4re+7S52
         gwKlCTxGrbagUaNsWkLk03bTO2iPlkBhMi27GRrFeSX+3HtSVWX6tSHwq+REj0mGHhpC
         K8ag==
X-Gm-Message-State: AOJu0YyIacWhvv8S251fBDhx+y1eYAi/RHA3DLnk3tLcbTYfs/8hjg8L
	QLAo0cG3DgAcI6v/xiob2d4Aofv5CASmZezX/teoyUHpPc2sReXPYiun
X-Gm-Gg: ASbGncvEVM6oGLpIakWRSUcWwx3KEGQt8YsYoQ4A5zyMFdGgIJ99bBOuCfyPUQ50ut7
	F1RXdi/ZopNeTQTsQQeXaJp1mB/GUbQNzbe44uu4PTeo/EAzBeP22XkYlpG72Yso3e8EhK5mq7l
	aKF06XBgOp9Fiyo4M9jFlKLwnGgM3SCJ21z0No5PNcu331d+NMvu4v5Zxvoeq/O3GyB0OSYWUEA
	JRdSsIHir0igOpoRVPT4ni9zaKSw4NkDWQmKjBMBWcXqaQTcfa7PSPaOuCUsT4io2dVJ7bBF+Ri
	hobBdi2AOb3vtiCmeSeRYig8u2zTp9FuCIcoTKxlKRiNgRNP9ypIqzg9lzULQ9XgsqI+/WoM6Cu
	MYQoKbV3vWdjPTsFpt5x6037nYnf6FePHBvXaBseZD4J5QowWlW80Qm+0YD2esr2NcoAztODO
X-Google-Smtp-Source: AGHT+IEfdOB2DVO6EKQLnVhXY8ixjzT+zJn4svfOrjjo+b9ZMgSxo86EuYRMH0TiHFHQ8EhGnWxf7Q==
X-Received: by 2002:a05:600c:628e:b0:46d:3a07:73cd with SMTP id 5b1f17b1804b1-477346ee158mr96641245e9.23.1762162673034;
        Mon, 03 Nov 2025 01:37:53 -0800 (PST)
Received: from ubuntu ([105.112.122.216])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4773c48de65sm144550715e9.1.2025.11.03.01.37.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 01:37:52 -0800 (PST)
Date: Mon, 3 Nov 2025 09:37:12 +0000
From: Bello Caleb Olamide <belkid98@gmail.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, usmanakinyemi202@gmail.com, belkid98@gmail.com
Subject: Re: [Outreachy][Proposal v3]: =?utf-8?Q?Re?=
 =?utf-8?Q?factor_in_order_to_reduce_Git=E2=80=99s?= global state
Message-ID: <aQh3Ic+iXsiqMo4D@ubuntu>
References: <aQZaqG6t4F6XE0nt@ubuntu>
 <CAP8UFD3TdUb9RBktdxwA7Qj=6Oxqpzg-ZrVP5eT_+38TPE+n-A@mail.gmail.com>
 <CAP8UFD0yamBJQHT8eh1=u9-m2f80K9FM21nozB6paPpEJrP5wA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP8UFD0yamBJQHT8eh1=u9-m2f80K9FM21nozB6paPpEJrP5wA@mail.gmail.com>

On Mon, Nov 03, 2025 at 08:58:36AM +0100, Christian Couder wrote:
> (There is a "Reply-to: 20251030144934.9689-1-belkid98@gmail.com"
> header in the email you sent, but that email address doesn't work. So
> I am resending to Bello Caleb Olamide <belkid98@gmail.com>.)

Thank you very much.

>
> Hi,
>
> On Sat, Nov 1, 2025 at 8:08 PM Bello Caleb Olamide <belkid98@gmail.com> wrote:
> >
> > Hello,
> > This is the third iteration on my proposal for the project
> > "Refactor in order to reduce Git’s global state" for the 2025 Outreachy
> > Internship program.
> >
> > The change from v2 includes correction to the subject line to have the
> > correct encoding on the mailing list.
> 
> Thanks for iterating on your proposal.
> 
> Please make sure you properly submit it to Outreachy though. It looks
> like you haven't submitted it yet, while the deadline is today at 4PM
> UTC, so you don't have much time left.

Thank you very much Christian.
I have successfully submitted it to Outreachy.

> 
> I will try to take another look, but I am not sure I will have time to
> do it before the deadline today. So don't wait for it before
> submitting.

Okay, I will be expecting further feedbacks from you.

Thanks

> 
> Thanks.

