Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0CDE368943
	for <git@vger.kernel.org>; Sat, 28 Feb 2026 00:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772238515; cv=none; b=pKmY5E3caF97/c5aQXNRjWc4L0skf8EB9LHM2Pc3OBQBn2FoxULBZkHDJ59Ulg4PgwIxn2DeJSxCFhXSnLm3+Cvh+ko/YK91az/+i+0JZhnl4nUBFMGt3PgV8Isoxau2Mc4E6e+prkIEn2JEfXDnX+Lfpu2ANOXnr/88lHe5NfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772238515; c=relaxed/simple;
	bh=spPY9rRSiRMSVjtv9PYMv8EdZB2QjQN04Z3JQI51q+E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nmES6BQ6+ccHKX4xTQL7JfD1eGCnadbt7kaaNVqk8AnwHPAndImZSqfwSSYFdF7tUKDN/FYETq8E5y0YSScSeXUJk/g/rfW841WIHj8HHhRZmbIHt/XFwbZFSYOhCcoWmDTTTPaG+YFydOw7M2sJXIr7MWZDz7WeJ+9UPb2juAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=paultarjan.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JGwVrd93; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=paultarjan.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JGwVrd93"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-827270d50d4so2741147b3a.3
        for <git@vger.kernel.org>; Fri, 27 Feb 2026 16:28:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772238513; x=1772843313; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KhaUB+BFENytNrEBN+smCUd3nZknUQy1GS+uaRxzzEY=;
        b=JGwVrd93fwNuBgq/gePQoSUTxUuUEio/AfcCf1PthIwSyijOosrd0/r1WCnXyMPU+M
         WjKBLhHwGNpb0hFNPfheO4Ld0i8AN5gal9gAEV0vdMz/xqi75ESGwkzUmeUM7a+VpunQ
         lJxoEyXcYcTdYFf39+NPmWIS4/uZeyJADtDX4rkPCl+nH6ydVuiZ/0BixuYtnBxMi2ji
         ZbvaIIyjKZEr13JaHmsKcGK28KBTLJii1dNfoqvFzhfQdjhLX78GQyvH7D1cU/S6Ex/y
         hDTMSKRBM38B9hWz6hwOg8ge/ZgTayKpTgftVyldGR3KHOXlCt8OfoPjrN7XwnRk7fUr
         E6Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772238513; x=1772843313;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KhaUB+BFENytNrEBN+smCUd3nZknUQy1GS+uaRxzzEY=;
        b=mtjD8OJFAmXiy0kYKd/OQEv7KuhK/hzhszJEjAwzuVrbK4OiMVG/xMqto96nWhoGi7
         2DhdYnlSg6V4LHDTgCWLkQkvET//Q9EzgSUidwlIpIkAN6PeFiR+PsXVGLdu8eEz8Xw8
         yg4ZAyyBj7E/DUz49GgJQ2tJYlvnJZlOmQUdqGE1t/tKaPDiI4rtvxWciDb5iHUFvkho
         ScnQLINvvqEtlcObCpu7CDpPSoktQ5fpNwNhvVI42Zm65oQxXSyfgzogsfAOgS3yPEXC
         /M/+5YwQMdsM6HCrvaTxx8a2+N7AMNMafoUwaASDs/Be7SXgkWRv/Cv/SYjung/rqU1I
         jRFA==
X-Gm-Message-State: AOJu0Yw/Mf3YPYoC6jwNT/Fn7gxkyD+oExuYnLn1qi+ZyAP4+z7PLn6Z
	QpI9z5TpuclWqpiFeBePP9plSxr7NyWQHOD8D2dtsBCebRv80cl8pmmJDIlVkQ==
X-Gm-Gg: ATEYQzyQFyCTYjIzdSsBnD68jLXDV61N61FA8nQl0VdqT42HxuTjqvYi2cjHg28Fbhx
	lpUZw3axUKdff52GpcAmFYTtTg6YqVXsfkxiMvXv53emgY9yZ1nh9HEPVcNFEBJgwJqeUZbIwZG
	UNu44bwTv4003TwB8hWDKcf6coi+2vxA9F/OVIMvN0lKBCMHlC3qZlPb+W08+MLwukNHWJKE1Mi
	y4eMIv5EsbXSJDpY8o6B1RD9WmawkAJxqs/x0ClhkCMEqLvzeTjISjtOft6HPKdjnG4GMP7Z3Ja
	x85tLizQvFmf8L3BA5lCNvm6s2/IY6j1YFtf6rnrd01x4Kfz8C88ngY6sDQVAiLbFSL3qYVSLtF
	rATVTAouw4qQs9mRZBUtUPAY8pVWw4yMDlnPm1xgP8roje345EchkvdpVW4ChlGbj7Kc6ZyV7Rs
	dHVaClE25FGHHI8ZojCKH+1iDfOYpXWsSAbuCPNNtCgrhSPP16KfSulw7nuptxECfluhDLyDa4d
	bWpcFp47A==
X-Received: by 2002:a05:6a00:4513:b0:827:34c2:87f5 with SMTP id d2e1a72fcca58-8274d9401efmr3729334b3a.8.1772238512737;
        Fri, 27 Feb 2026 16:28:32 -0800 (PST)
Received: from localhost.localdomain (d75-158-111-22.abhsia.telus.net. [75.158.111.22])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8273a01aa09sm7418667b3a.48.2026.02.27.16.28.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 16:28:31 -0800 (PST)
Sender: Paul Tarjan <ptarjan@gmail.com>
From: Paul Tarjan <paul@paultarjan.com>
X-Google-Original-From: Paul Tarjan <github@paulisageek.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	Paul Tarjan <github@paulisageek.com>
Subject: Re: [PATCH v6 04/10] fsmonitor: use pthread_cond_timedwait for cookie wait
Date: Fri, 27 Feb 2026 17:28:30 -0700
Message-ID: <20260228002830.42676-1-github@paulisageek.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <xmqqfr6mt9uk.fsf@gitster.g>
References: <xmqqzf4w8r20.fsf@gitster.g> <20260227063118.9069-1-github@paulisageek.com> <xmqqfr6mt9uk.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Junio C Hamano <gitster@pobox.com> writes:

> I am clearly missing something here.  Are we handling two different
> kind of events, one that wakes us up to expect "cookie" events, and
> the other "cookie" events, and we know the delivery of the former is
> reliable while the latter not?  So on a quiescent filesystem we do
> not even get the first kind of event to wake us up, and we do not
> start waiting for "cookie" events with 1-sec timeout in the first
> place?  If so, that does sound like a good arrangement.

Yes, that's exactly right. The cookie wait only runs when a client
connects and asks for the current status. The daemon creates a
temporary cookie file, then waits for the listener thread to see the
inotify event for that file. On a quiescent filesystem with no
clients asking, this code path never executes and the timeout never
fires.

So the only time the 1-second timeout can trigger is when a client
is actively waiting for a response and the filesystem isn't
delivering events at all. In that case falling back to a full scan
is the right thing to do since we can't trust the event stream
anyway.

Thanks,
Paul
