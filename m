Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="u+y4MoGH"
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EECE85
	for <git@vger.kernel.org>; Fri,  8 Dec 2023 14:29:43 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id af79cd13be357-77f42ee9370so101840785a.2
        for <git@vger.kernel.org>; Fri, 08 Dec 2023 14:29:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1702074582; x=1702679382; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AhboHkyvfXeuYNbms7U7UbankdF9fTtNwcAMA2jHUJc=;
        b=u+y4MoGHuQ+wyWuN4nOYuKfkWYBtQtOmR5ZiMh/3oPuGtruMqK+Rfaj0rJZqQN9gcY
         grJFiKqaMvLynLKd8j9C6tBRuLGL3kacCPaH5a+nN1D+uvcXUWpBL28tbhf4342lMFnZ
         zbIgf+4k0cHak8oaFFoTLSkdVWQtwcgR2QIYPQEqosgFaOO7sCckF+P3S4QGQ7eQFVaL
         coNhqc+3hY3ZzQzXzq2xwpJr6AlyZqs/uTL+BH2+t6F0aediaWVve7zBpJeKXvbzJteh
         3TF6rDK86Qw425L1s7Li7mZaSfitnCNxcJnPXF/dJuojFYyd9qRlmEl/sDpG1XQVscKP
         CpIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702074582; x=1702679382;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AhboHkyvfXeuYNbms7U7UbankdF9fTtNwcAMA2jHUJc=;
        b=cFPoujBOE0xzaj8TLIc1S+rMeqZqgjOnZCwS+NmTfBmr1zZNFlylGz1egUTZhvN+W8
         gkaInN2C1zJ5mTQD8lkPnfUFfy+DHjk2SIkqyU7ny2j/TBpXtp/9gF6hsdLyR659RI04
         6Qq/2mAO0DobW2HlixyA2bou22suH4LweC8vBdkILISPB8DTZZIejK4KOgh6eMjyM7iD
         hCFucBi4PSn63aOGYBjvMJvrtKjW6jpYMpk5JGTxSNmQw9Q2O2dYTtFTUy1KVWAciOCm
         daCXnkgN8tAD+69oNT9bfrQqydlD1E/VfToKEM/RzldZnSRs8fHzewFy0SyoOBNanvx+
         CugQ==
X-Gm-Message-State: AOJu0Yyd989MZ7iCTdTjBxWfxnMArNxSKF/JuGMqj0WdygMcOnOtEVg2
	UEQSaJ6ZUmFPmG9vuNu77OKgZA==
X-Google-Smtp-Source: AGHT+IEYAcDO71Gh/+Boj2p7jH6TLOiryWRUwVdQsg1jFpAyoJ3GtNyVosXGN92PHnzwUAxaDRpHWw==
X-Received: by 2002:a05:620a:530f:b0:77e:fba4:3a10 with SMTP id oo15-20020a05620a530f00b0077efba43a10mr769231qkn.102.1702074582695;
        Fri, 08 Dec 2023 14:29:42 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id s8-20020a05620a080800b0077d742fb27esm998850qks.49.2023.12.08.14.29.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 14:29:42 -0800 (PST)
Date: Fri, 8 Dec 2023 17:29:41 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Jeff King <peff@peff.net>, Vito Caputo <vcaputo@pengaru.com>,
	git@vger.kernel.org
Subject: Re: Minor UX annoyance w/`git add --patch untracked/file`
Message-ID: <ZXOY1Qq4MKQPEEAZ@nand.local>
References: <20231130192637.wqpmidfv2roqmxdx@shells.gnugeneration.com>
 <20231206195407.GD103708@coredump.intra.peff.net>
 <xmqqmsuk1jvp.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqmsuk1jvp.fsf@gitster.g>

On Sat, Dec 09, 2023 at 06:09:46AM +0900, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
>
> > They _could_, but keep in mind that the argument is not strictly a path.
> > It is a pathspec that may match multiple paths. So:
> >
> >   git add -p path/to/
> >
> > for example will pick up the tracked files in path/to/, but not your
> > untracked one.
>
> The corresponding command w/o "-p", i.e., "git add path/to/", will
> pick up both tracked and untracked ones from the named directory,
> while honoring the ignore settings.  So I suspect it might feel more
> natural if "-p" followed suit.

I tend to agree. I do think that the full specification of when "git add
-p" implies "git add -N ... && git add -p" would be difficult to explain
to users.

But I think it's a worthwhile trade-off in that it makes the UX more
consistent in the common case (where the argument to add is a literal
path, not a pathspec).

Thanks,
Taylor
