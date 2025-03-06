Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F5B3158DD9
	for <git@vger.kernel.org>; Thu,  6 Mar 2025 01:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741224074; cv=none; b=LKX3omRWTvERnTxjhmAsX+yMlvD3UYyLsZ1rjl5+Gf+aW+w8NLsKB5O/yrGsA1Fmr6osWS8xRTmgKkwWRlGNSiwINm9/eJyDxE4FcWg6y2gvasaVB2XNp7ng6v0j2oKKUzLRrpN7ncxdDJHw7RXOoeZMj4gfEnHXPZkp9ZrEroA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741224074; c=relaxed/simple;
	bh=kU8dYf8Qusnqc/V9Rpue2j3o9kLTjI9PbKfxjV2r8KA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hgN82VyKXP7U4WeJOstWPNPPa+xLhiR5L73Z87yUKITHeM6JC4dZV9xR/AbjuMRNXmGtcourTb4Q18cq3/CYIZ93r+OPSSKK5+1zbJKIr6slRH+zVBdJp5QrtFlWLGIhaR7uSrVnd6ciPTDsao0J56snOKN+JrN2kHONmdx6VBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=Qnm5CgdA; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="Qnm5CgdA"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7be6fdeee35so22127985a.1
        for <git@vger.kernel.org>; Wed, 05 Mar 2025 17:21:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1741224072; x=1741828872; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=guf4Ukcc51V9ExQ9TakNo9QkBFxxKbqRFQfB1YKpG6I=;
        b=Qnm5CgdAyFHE/iZrdat9EYDJSMIs68bprYnxGjslK/Wq5Zij5j6Q4mSOynXqqOGny9
         /EJGOGZnaSt93MacsIzt9hLFxI7JWjCcncBnG/CLZZik1MVOh7eZRBUjZeHAbN7h3uix
         K1ZWjjgCnGqDK5rItMpMTDjFew12hAO0LP9Qw9QD5eNosmEjtsXZH55vRo21oJq/yXUN
         Hit8d+vk+Ybyqz1ziovuEp94wkfEgxVTKGc9iSptqJ1J1A3CjCY5x72rPI/G3RB1CQG9
         /x97pFQlksNQXZ8IOrg8pqv5bAD9965IMQN9SDhH7bB3NlGG3WyadyFCv72xYukO5gbg
         64Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741224072; x=1741828872;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=guf4Ukcc51V9ExQ9TakNo9QkBFxxKbqRFQfB1YKpG6I=;
        b=TcvfJytNv0g5HhwUCQC7kNwx8aCSMRKXcZi/QuA1+/kylz+wUEEDrojMB8DilKrglq
         kQqrEE/yKMD4kTpf9aQkFZPPnqhDjEVzdQvqlH66iCviizRBerZtj024F1k/CZyRn2SJ
         zsh1ACDttOy/TxZq1HP5rM5P6IHUvRfFQAK04oI+xwh8pek5nLq4QhAGhxVErmtGKY24
         f4tiRIsrSCvUto1CPFO9yblWbMeGCoEy5+DtJo5VLjU/+YnP9iKQeUzB6f10LVe0vAiE
         r+HYJUenEne6bNOYveQJ1OefP+nEancHrXjui9bjfXv3LjMbTc3WwSenHq2b+14JGpjT
         XlsA==
X-Forwarded-Encrypted: i=1; AJvYcCUG13J9IWyuGtPIpAv0iyS7LRAONSgCe8eFXNYrnVLhayBO0Uhk/iRK2P2G0FUNGNt8GV4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOIfiu7G3nPqhDhXKunmnTmhQ6ws1bqedovDcfc/NSZiABWjNP
	12TVm4TIQ+1llgrYNligrUz0w4arq1pT06q2xhh0d4HXjuFw30xRHwEVYS6g6bekQvT9zxVq+tK
	Q
X-Gm-Gg: ASbGncsECWCw+aDKefZkDluto+GvHShpE8N2OXPTFX1eY0OzEZhTClv4GQZedKsORwu
	/HSqvbObsZn5hcVQAaFPEq73D1k33yDuaWp777u5/S6dGjlP3yPultdXCVfB7blAiJwd9YwTkKH
	nqMiIz2G7mS6rxKM4px7dTdV9/HK41FvA+VCf4x6btyI+V1qAg/ztGY7c8LDKqd6CGXN73lnD59
	oVn7Jk6tSC6gkdtCSuD0WsmruZuShwyKjJaJ/BCwYKTauJXnDF086bHapcZMsgi7vBIvnLDH0qZ
	KEHP5fSD0FxaOXEA3593T1SBw+UZnXvM5FtMGs39CslJs/xXmzSnw3eFQwGR6VeEJoW75rtaWwM
	TWX6wYZRBnxUh1+fn
X-Google-Smtp-Source: AGHT+IFNTGhw1dv7gZacIQGif/y+PtBCx1htfO4zl1T7SjYe7ECE7SKezmPmpjOcPkZVIODsH+VFKA==
X-Received: by 2002:a05:620a:4383:b0:7c0:a3bd:a779 with SMTP id af79cd13be357-7c3d8e8b8fcmr914659185a.47.1741224071974;
        Wed, 05 Mar 2025 17:21:11 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c3e5511328sm18124985a.105.2025.03.05.17.21.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 17:21:11 -0800 (PST)
Date: Wed, 5 Mar 2025 20:21:10 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Jeff King <peff@peff.net>, SURA <surak8806@gmail.com>,
	git@vger.kernel.org
Subject: Re: The transfer.hideRefs of the upload-pack process does not work
 properly
Message-ID: <Z8j4hj/+lboANog3@nand.local>
References: <CAD6AYr-ZC32VNfUfMB63H-rQRfTdV=VQfBm67i2mG+6GDCNxkQ@mail.gmail.com>
 <Z8D/aiqN5e/aRSn7@nand.local>
 <CAD6AYr84KuBb5N-LVBQo-6Gq2Ms3JKQCk0gyO8i=N8gp3whe_Q@mail.gmail.com>
 <20250304075113.GD1283943@coredump.intra.peff.net>
 <20250304075146.GA1297781@coredump.intra.peff.net>
 <Z8bmSj_Ds7ePpzBM@pks.im>
 <Z8cs8Y4CVpP0QHNj@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z8cs8Y4CVpP0QHNj@nand.local>

On Tue, Mar 04, 2025 at 11:40:17AM -0500, Taylor Blau wrote:
> Ah, makes sense. Thanks, both, for looking a little deeper. I can work
> on a fix shortly...

This took me a little longer than I had hoped, but I posted the patches
here:

    https://lore.kernel.org/git/cover.1741223981.git.me@ttaylorr.com/

Thanks,
Taylor
