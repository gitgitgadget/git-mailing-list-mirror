Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3322F18E25
	for <git@vger.kernel.org>; Tue, 18 Mar 2025 23:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742338975; cv=none; b=Mhn7JoqPeLDgWrFVXl1jJiEg0w6pu4RYUSYc5LSgxJlk2BRwfGvkf2sypw/onIEVDblhTI6ff0nCKp4aWAYIvUmHi5l33oQ2FP6WH/vW0TSPteg7XqgriVJTvhcCxNlITV4bRoz0TkvCrs+XCE/8d4P/LfHaWBPx0Nqj12+h/HI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742338975; c=relaxed/simple;
	bh=PZ6wzmo8LBeUqT8e/5YVv0s+Lv3y52Y+WX9I1ak8wzY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dvFVJl8bdQKoEdZ4KZUjnJWoMjPweDbsajgqTQNu4O7JN4DtdRHauhgoOlXnSbgEnvTiNQ+UnhZELQtiIjcaMrKzoApMkbpO0F3Fv/7IhWFsvzdp2GmOt3/ROun2wX6Ub7CD6FPtMFoWR8CQQVtJ2JTeGp1RbQsiEv1GUMbck/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=kAbaEaIh; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="kAbaEaIh"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7c5675dec99so665418985a.0
        for <git@vger.kernel.org>; Tue, 18 Mar 2025 16:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1742338973; x=1742943773; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5T8ujjzIOE1UuP/SmiE/Hwp1TiNiCwBJfqKFX2kG5/g=;
        b=kAbaEaIhGo1c2c2Js7lJ/dJDwsTIZlqqYOeTiYKLJBmH8cE7wj0ZMkSaHXBmB7lZlN
         tspIneJ5QRix+8koB0HnQ5p9OzmUZFadzrQs/EQO0VBwiBgydJ9D3cTC+SiIogVpJtSp
         rohB6VvGPWiaNEenyFjjPrTkdbSVhpqlsTO/IFcYJVHx1VvCcJl2GT2D62WA01Yx0eaU
         gmA400lsV2qFmIfTGzwDFStf4CnK4aUJtqaQSaA8xNijaWEeM8K2O0mpSvBwYtk+9ulJ
         vVoWpDSCyp9R4FjJR6XgoroIQKjtEOp/W0febCvUkxhO8RzhueGCmYFIimFYBBeXJLjq
         P7uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742338973; x=1742943773;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5T8ujjzIOE1UuP/SmiE/Hwp1TiNiCwBJfqKFX2kG5/g=;
        b=cvSGMpD3PxJAdQAEUTYqg14jhdwvlMqmqDhWm4bMi+7T8wssIlZg7XlIDuvW0VsW2i
         fwLhM5nUw3OBbFHx+lDvH+W5hIPgP25LjGLZKPKhzMxMxWSP40yc+rg7Y7C80GOnUWzl
         +6nJpMtBkoXjEpMhHbQsIrNukkrYeglLKBcxcpiwfr/4RzjTOY2N0ttCSWvhboNuCORf
         nKB0UE4shTZ+CYV6biqEhD57RdRizNsA3rApFZACUFDYLXHMqOuezy2gKNiX611V0kYE
         UBm+vS200BgMZ3JXt0MikJXgBOBpP0MajycUNoswnQDkZtLodY5I57o/6Rycpm0YuUsL
         buyg==
X-Forwarded-Encrypted: i=1; AJvYcCVaYiG4dVWZCy6RaZ9woUvvVirfLGo8wuycLb9JXj4P2lMgQskjoGvvUHwHgqOSA4fwgIo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuMU6UEbb2X/uJRM7sipGYYr1xV0qPuqWF+QNG8OhUpc6b9Chw
	ebgpUfvUabDirPZ6a837PUxb77NhaHdBmYOPOzVnGlc+EaPsFmJdGEW0inwjYjzntUrLRqSFJ4k
	dCxE=
X-Gm-Gg: ASbGnctnWCSLN9eCconmDYKY+EvIGUSL7amb8FbEtz8oHVct8I6zCcB+nKAk67h86Tm
	8hoSC31cxXI3yLjtQwpmbXb+Ib+tFYMhKV6WV8BOR6bImtGwG9LR/8heJUW+ySjsFu5/qZBreQa
	7y2ctsT+7n2zf/44LXYWFhTtnduQjQMyVYdvnBPuus4mujqeM5PIiZayG0mGD38NqPUBookhWMs
	EI/iuETvE0BpkjxFZRpEfJ2OVRm5Yn/G85CH7fkYyEIClOrY0FtQN77Z+kPKdQHtKb/Sj738vyh
	zDgPQ8hbDV+HoYiw+RRDyQsUgVYoOf4kC6hnhGzXEzUDA1do/UNeullozkYaxH8a0oPh7A+rqZY
	i0p9ds1V/wgXcOZXc
X-Google-Smtp-Source: AGHT+IG/bBr9F48fSLvWf9ZQ9xRqqvPdfmyICSWyXJQeEt2AUr8CbEi+z9toV9G0KCGmrvlfYDEMyA==
X-Received: by 2002:a05:620a:1714:b0:7c5:3c62:804c with SMTP id af79cd13be357-7c5a839694emr77917385a.21.1742338973080;
        Tue, 18 Mar 2025 16:02:53 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c573da3d39sm775869685a.114.2025.03.18.16.02.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 16:02:52 -0700 (PDT)
Date: Tue, 18 Mar 2025 19:02:51 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Igor Todorovski <itodorov@ca.ibm.com>,
	Bence Ferdinandy <bence@ferdinandy.com>
Subject: Re: [PATCH 0/2] limiting followRemoteHEAD being used
Message-ID: <Z9n7myvpnDOWFWqt@nand.local>
References: <20250309030101.GA2334064@coredump.intra.peff.net>
 <20250309032016.GH2334191@coredump.intra.peff.net>
 <xmqq4izxq63y.fsf@gitster.g>
 <20250317180604.GB704553@coredump.intra.peff.net>
 <xmqq1puva3cu.fsf@gitster.g>
 <20250318053905.GA2051217@coredump.intra.peff.net>
 <xmqqmsdi2lm6.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqmsdi2lm6.fsf@gitster.g>

On Tue, Mar 18, 2025 at 12:18:41PM -0700, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
>
> > There is one interesting case we haven't discussed. What should:
> >
> >   git fetch origin HEAD
> >
> > do with respect to refs/remotes/origin/HEAD? Right now it does nothing
> > (at least with the v2 protocol). We ask about HEAD, but since we didn't
> > fetch the matching ref, set_head() won't accept it. And after my
> > patches, we would not even try to call set_head() at all (since we are
> > not using the full refspecs).
> >
> > But it's also something I could see somebody doing to try to update
> > refs/remotes/origin/HEAD. I've left it alone for now, since my series
> > does not change the behavior either way. But it might be something we
> > could do on top (though it gets funny, because with the code as it is
> > now, we'd have to ask for all of refs/heads/ to see the pointed-to
> > branch advertised).
>
> With v2 protocol, we have direct knowledge of where their HEAD
> points at (when we ask for it), so we shouldn't even have to know
> about what they have under "refs/heads/".  I do not think it is
> within our contract that we'd somehow make sure that HEAD in a
> remote-tracking hierarchy is not dangling, or something.
>
> In any case, I agree that it is sensible to leave it out of these
> changes for now.

Ditto, and I am quite happy with the end-state of this series.

> Thanks.

Thanks,
Taylor
