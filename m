Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38AD51D27B1
	for <git@vger.kernel.org>; Tue,  5 Nov 2024 15:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730820539; cv=none; b=XDQq2B5avxxMiufxwm6bVWIZ2K2zvkTKRYu1uIYtQqMRa8am5pnakxnCfXbJs7Q6H/1m7LD6t2lKUhHD2Ou9teGue22uUmOn/22JkOe2EpHOT4YwLBOcgzTCkRtm6FJ8wxI+D+vHggFoqkVptM8EUIeeNg5y7AZFz7SNNSJFlmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730820539; c=relaxed/simple;
	bh=1b8RNn6iE2rIKMuMye0a7nL0EYzXhkS15W3hOk6wlf8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qw2kNvhFAAAiwT0jFDxKIHqL1XSM8nzonIIPhg6Ar2t8qT99vhFu5F2cN7xazIBkr10wOMzAEhVHdXXODCJk91MFqTR+/+dlr6FiKy3cReYNNYSr/RtR7RuPRFvMaqjCyMunFh/7PF0QedW9rC7O2KP8GzeSbKGeqP0KIgFY0h4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bUAYUAsZ; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bUAYUAsZ"
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5eb70a779baso2414861eaf.1
        for <git@vger.kernel.org>; Tue, 05 Nov 2024 07:28:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730820537; x=1731425337; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FoctJW9uXMw4U93NM9DGYd9YGqGa6X8IJNJiZMXPIaM=;
        b=bUAYUAsZDEsiNgYGCkJOpcLadlUt7CjAjU7b/vIEGThTz7WfpDGAbFqbWHfhNAbcEi
         MhivD/w/fMZXCXc/NjIEiEVTEDsjsaY8XDrOAT/3cd4kTl5VVjUBrkvnfMq+tv2mctuD
         klyYkFXMUhVnggi+VcBr0vyxpl03AGlB4iRqr2c5wIu1f10fXLVmypVsH67wLNo2KDAb
         JOB7PVX4kSNajDfMYZYFe3K/9cenOVQhhDaeye5Svrw4minzzRhNaHW/zn2nwWyht0fl
         BCllYyD1d4r1OoGLNlrzzWZlLmCudSGJhd5D8IVrQPwH/Kt61OEfxL5f2wBzIN3r0HxG
         e1aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730820537; x=1731425337;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FoctJW9uXMw4U93NM9DGYd9YGqGa6X8IJNJiZMXPIaM=;
        b=H8j+1+dXlAjgdXyExG+vvA0DSUeDdbKAvEYZ8utb6TlxlsWTrp/e1MgygwF2zVgKrT
         w80boiz9q3hlWeOOV7U10BGfXzoXb8O7Su6Ls7HqLCJRHjhTwrkBuWzl6TBFlxTtckiQ
         cw8NPwKgX0lO+x4JYwfPT8hZJ5tboazJ2hDb4KZR46IFQBTd1NuIf4vUj87qD22UpQrY
         peGIKGjSk1e2FxSodCFrf6veOhQCzIfPzirsgsP7ON/eEnvSelnFu7OHVvbWVYb1Guqv
         kXtYZP7rCtvBNPrH3hZ84hdH9baE7zpWOME+TrsZYlBKmcEE993dwH0jwy14lducFFCR
         TlQw==
X-Forwarded-Encrypted: i=1; AJvYcCVWf1I+NKtSNwhwAb3c+YbyxM9NEPyIAxRn0Tj1bzvtVzrvQrROp3dibAta+2LxlYIXed8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSuCVHzi3IUQ2aa2yXrkH9ACzxgCOZAHF/oyDgYktib8OpaCqm
	VS5KXZ26T9jFcktd/d7CAlkJz1d/kz2pQcbA7A4gcjEgV7MdzzyP
X-Google-Smtp-Source: AGHT+IG5FNvvjP7+e/b9Qom1GWfDiFFP3OtCp3eekuRlapZkvsin0lMLOYHSyhf8pE8rOLi/R5n9kA==
X-Received: by 2002:a05:6820:1ca6:b0:5e5:c073:9ea5 with SMTP id 006d021491bc7-5ec5ec942e3mr14710320eaf.6.1730820537193;
        Tue, 05 Nov 2024 07:28:57 -0800 (PST)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5ec704beafcsm2265515eaf.5.2024.11.05.07.28.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 07:28:56 -0800 (PST)
Date: Tue, 5 Nov 2024 09:27:19 -0600
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org, 
	Taylor Blau <me@ttaylorr.com>, Toon Claes <toon@iotcl.com>, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH v3 00/22] Memory leak fixes (pt.9)
Message-ID: <audhpto5cjvo5xo77is37cycws4kasgaquv53ppiewkzuj4xjw@tkw6axaoggos>
References: <cover.1728624670.git.ps@pks.im>
 <cover.1730786195.git.ps@pks.im>
 <xmqq7c9itbq9.fsf@gitster.g>
 <ZynAn6VGChtZX9Wb@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZynAn6VGChtZX9Wb@pks.im>

On 24/11/05 07:52AM, Patrick Steinhardt wrote:
> On Mon, Nov 04, 2024 at 10:51:10PM -0800, Junio C Hamano wrote:
> > Patrick Steinhardt <ps@pks.im> writes:
> > 
> > > Changes compared to v2:
> > >
> > >   - Remove an unnecessary cast.
> > >
> > >   - Fix a duplicate newline.
> > >
> > >   - Polish a couple of commit messages.
> > >
> > > Thanks!
> > 
> > I spot checked the ones that did not change from v2 and the ones I
> > checked at all looked sensible.  Perhaps this is now ready for
> > 'next'?
> 
> From my point of view it should be ready, yes.

From looking at the range-diff, this version looks good to me. :)

-Justin
