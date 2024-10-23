Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B482675809
	for <git@vger.kernel.org>; Wed, 23 Oct 2024 20:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729715597; cv=none; b=FvuHikoo5i018hdW5AkXQlFURUA9eGrT+uVk6fmBE2H1cFD1XuoO8JyCSQjqgRVYFAGBo6TJ10+9u/w2udCtR7ReTt4dUMkgisf49Y/RaKgKK4QutwFE3d+wXGg0qNL7Qp+jsK1A320BC0K+sWrcXd8Eyk1RA2zVkSL+WmU8X0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729715597; c=relaxed/simple;
	bh=kc+cLpjwVssx42QhqVN7mEChmBK81LY8uuOb4CI6vQ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bMAyH0+g352/4Ywc/pI3D+MPcrcinerGLpZYdtcck4L6sc+Qx24Skr5/5WRcoUp2VoiXbLjtXL9Q7Na/zIUur/Uh3vx3nmzkRrNqWllEpUAaeEpGB9Pm8kPnGfgE4Zm6PwMM8uo1iC5IBeOH4ywQ8A6mZ/41y7Ma+r81wnQQZEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=XsS3e5HY; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="XsS3e5HY"
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e290222fdd0so209196276.2
        for <git@vger.kernel.org>; Wed, 23 Oct 2024 13:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1729715594; x=1730320394; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=K4RDydHzMGzaNtv937lOqrJ08z3ku4adQ+QHvx/OVOY=;
        b=XsS3e5HYqf+90XJ+c2u3S0ut1cr94v/QkQK2XALl3WyLXKFO5yWsWbvGQQVZO53qZz
         vWm4e4n7fiP34Bjb8t2JwhVNUll7rO8YwG6rSI6earaqYPPGLwQ5WU6xg5ayf8+yHSxI
         HZ4AYbPCmHRnPrI2foJu7BASWFZAgsd4r+Q4MSlSjr6XWDlSpuIuekvEY7E0Rjg8T621
         3qhBpwctHSRUlas+TrMyaPAszNxFxyQ00+pkk6Itme7es/P+fBZj1gNGYgL4zavPiL5I
         aB2ILqc/o8Nxf71PhSP62pHkw3wq2/dlprk3ueRmy4TYLKr1ss76eZxGRDSsarRpC7nc
         GQGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729715594; x=1730320394;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K4RDydHzMGzaNtv937lOqrJ08z3ku4adQ+QHvx/OVOY=;
        b=Ir8/S4bKufxt2XPK3n6n0c/1MX7fua/02riSJVkPBHkhtNTn3O1yeSSYlVecUDW+GE
         fLopQWIBfCR93GPVRwt04+eEg3xEEkoGZSNdic1CT86xm7o+23YTFvWXdlR7niS6wGU5
         Vz0ox8iDuAh2aOS/SH2O229xpQDuvBqv/NphmsVRqqiGLl36xO4UkwrK9XyTsFVfg88u
         BAY6ghRyISKWvL+Jsw7NBxkYZCKy/nLg6TM/K4V2NfXhUqC8NwzqtbjPrL3Hr4v26kPu
         p6C2BDImovXxOpO9g7L+rck0BEnX/Kbd60vgIwDMO9Aca1/fjq7D4F7Cw4eh/0e1Onsr
         LDlg==
X-Forwarded-Encrypted: i=1; AJvYcCVernmkoWQqMXTvJvGUvXrUodewG6oWW1oFl3MSNGOrHLFIj104mtaZC29p9m/vC+Tw994=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKbRwlnO/fDEspq660chU5zzdwXQDCY9rMJ8gYcHXgyx3xpWym
	b6MOfjp0VIYgyEJ9iEjAYlqaSD/LxXThBHfXHQ/hWKV5vr6Dbfygx+vqkyQ2ex8=
X-Google-Smtp-Source: AGHT+IHfTPBzlodpq8zhY3Vffkrh+GqpU/x/4rME+Q1V9ff7V1bWxT2HoWi1CgEDs3Ykd6ufscdwcA==
X-Received: by 2002:a05:6902:2b92:b0:e29:44d6:5c0 with SMTP id 3f1490d57ef6-e2e3a6ccf7cmr4077323276.37.1729715594746;
        Wed, 23 Oct 2024 13:33:14 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e2bdc9926c0sm1689605276.17.2024.10.23.13.33.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 13:33:14 -0700 (PDT)
Date: Wed, 23 Oct 2024 16:33:13 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Usman Akinyemi via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Usman Akinyemi <usmanakinyemi202@gmail.com>
Subject: Re: [PATCH v5 0/3] parse: replace atoi() with strtoul_ui() and
 strtol_i()
Message-ID: <ZxldiQVBxAWbXoT4@nand.local>
References: <pull.1810.v4.git.git.1729634937.gitgitgadget@gmail.com>
 <pull.1810.v5.git.git.1729669220.gitgitgadget@gmail.com>
 <Zxi5TeHM9qD3lrbx@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zxi5TeHM9qD3lrbx@pks.im>

On Wed, Oct 23, 2024 at 10:52:36AM +0200, Patrick Steinhardt wrote:
> On Wed, Oct 23, 2024 at 07:40:17AM +0000, Usman Akinyemi via GitGitGadget wrote:
> > Changes from Version 4:
> >
> >  * Fix incorrect indentation and remove unnecessary braces to avoid
> >    confusion.
>
> Thanks, this version looks good to me!

Thanks for reviewing. This one is looking pretty close, and I've moved
it to 'jch' in my tree, but I think there are still a few lingering
comments that I'd like to see addressed in a subsequent round before we
start merging this one down.

Thanks,
Taylor
