Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="HGskWpQX"
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90B3610F2
	for <git@vger.kernel.org>; Thu, 30 Nov 2023 09:35:36 -0800 (PST)
Received: by mail-qk1-x731.google.com with SMTP id af79cd13be357-77d6f853ba0so192487685a.0
        for <git@vger.kernel.org>; Thu, 30 Nov 2023 09:35:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1701365735; x=1701970535; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pv2QfNpOn2Yt4R8nY1YsK9TA7/AlEJr4dSlWuKRJJxM=;
        b=HGskWpQXWc1CcVtIlkki+iac2eWwX2BYQcV/EjgKGyuHU48BBPH4LphzI/xPzMI1kR
         5jPYYdy00ta00UWKs5RGR+eUeSU7ZWObz7kLtrQdeg+ovmh3IyezOcoTO5jn0ThX3EJD
         T9oOQVlmjnNjVcoxzPcslFcfz6+u6xaGcgmwYo8leC661dzsssTml66kkK4DFChJIqfH
         aLRm2wCEs+VpoHu4I1ItLHsbSxJp5aNeajzAqn0DGpg+OD1DqeelqLvQiAmMyQzUJLyC
         6XXRkg73jBAa9AssOTV7gDxaWvWpLcpr6YZ7fbH28WYTfXc6sD8FgLaRoI1Bh760jSbU
         75dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701365735; x=1701970535;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pv2QfNpOn2Yt4R8nY1YsK9TA7/AlEJr4dSlWuKRJJxM=;
        b=YJgjSSVKV4ugNJpAMuLLrTb/VST5Yvp9iRieCML9UQ9KDSY9hPHSz6KpOoV+/0L97l
         cvJSk3kiAwJt2Ta4xiyHYEPFmQR5bSar/pxWNhJ909f6saf20P8Cw7buL0qWhlx2Ey4Z
         Nqhp3DZTSoOx6jiSSJqD0/UQGhiJBLabyfzaW9Z1ys49SzNBAjFA8CLZ3bPIc9wKI/0A
         ggIFCvTIWs4dJxGSjF4jxGnrRImjeT906vX6x3J9nQJm/a6N2hW5uxBvlMTZxT+F8Q8h
         0XkDF+6i2tjyP/E5y39cKiCXsNoh7r447VmMBCO2rEzBr5L8bMAlJe82RBilLPcoH4OE
         MScA==
X-Gm-Message-State: AOJu0Ywuv8fdRuywOsMtB6gl7Ch3rD7+zoS/Gn54JJVMu3KcQm1JPcJa
	W0NFBjjo4Cf47ZuOvHn5u8DLPg==
X-Google-Smtp-Source: AGHT+IF4zi0ubXK+dSMVq9XjoxvLgIwYvsQ5O4nv65bEfRfCyIRc+M2Fhf0+1+7buy/C0J00EN0ijw==
X-Received: by 2002:ae9:c110:0:b0:77d:a740:9170 with SMTP id z16-20020ae9c110000000b0077da7409170mr17999699qki.4.1701365735576;
        Thu, 30 Nov 2023 09:35:35 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id a3-20020a05620a124300b0077d78afc513sm673643qkl.110.2023.11.30.09.35.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 09:35:35 -0800 (PST)
Date: Thu, 30 Nov 2023 12:35:34 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, hanwenn@gmail.com
Subject: Re: [PATCH 0/4] refs: improve handling of special refs
Message-ID: <ZWjH5kOiHKR8RGkX@nand.local>
References: <cover.1701243201.git.ps@pks.im>
 <ZWe3z59WGE0+8gXN@nand.local>
 <ZWg97gfn80jeB3-_@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZWg97gfn80jeB3-_@tanuki>

On Thu, Nov 30, 2023 at 08:46:54AM +0100, Patrick Steinhardt wrote:
> On Wed, Nov 29, 2023 at 05:14:39PM -0500, Taylor Blau wrote:
> > These all look pretty good to me. I had a few minor questions on the
> > first three patches, but I don't think they necessarily require a
> > reroll.
>
> I agree that none of the comments really require a reroll, but I'll
> address them if there will be another iteration of this patch series.
>
> Thanks for your review!

No problem on either. I doubt that there will be another iteration of
this series since it is already good, so no need to worry too much about
these changes.

Thanks,
Taylor
