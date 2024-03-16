Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E2531B95B
	for <git@vger.kernel.org>; Sat, 16 Mar 2024 15:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710604227; cv=none; b=r0EUzMoCr/7HAioXJrWcGQYQ+bfpLB8PW0zpHuUWlEggRSJyFD3JF66FK6uNsJ8es2Fq7J7s+BVVlGr3XnuxQoV978Fp0kZdoEoUzBYUBzaiQnQtDqOdpyn4qwdGV4Blv9Bu0ab4q8zqUu6OeRrfrQAgJWf0+W6hsBSjNpa7o6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710604227; c=relaxed/simple;
	bh=n39MVqsXlhdg/YRT8KkqWrMe9BH3WvVFVA4m8yhzAtA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ngBjUVcAX091bOh+o9E2EsnKJvwso08qQFLdMxucuRI9fDtHYWzQbiq2Yf14r7iV5VXJaosFRNcHcTSYJGZr7FXMbmdDtcsaKJhwep2TDegHlyApmvDf9UdRhCFmoGcRqofkJmeX2o0adPoykX4wYmwtZf57/OD+qjUeQnxFjtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=rLEoYM8n; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="rLEoYM8n"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6904a5d71abso16551846d6.1
        for <git@vger.kernel.org>; Sat, 16 Mar 2024 08:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1710604225; x=1711209025; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iCt+rVFMewvPlx+xhhliFFC687YTCMVvaRCEv5+sAbU=;
        b=rLEoYM8n158UMde91ND36P26s/MhEvcSkbBtCa+QPI7pP5F6FirVI+zVYJvM+8TWC5
         jcNXzA251SQypkDEUWArvHHuomgQPFwbZOAV4unm+TegkyAMXQ4/Fn03+cW43hFY92Fl
         HtFHiHh9BUwlBnSU/s6JRxVQDCgYd9JxvV6MoEJ6nR5kNQGJU39yZHzhP2iNch4Ud/l5
         uIWeBTt0j2Alfd1GqsHwNXXyPipbuZH3wf7TI0RlOeOnImVq94G0QgmOdSpzD91EghX6
         xLYlNsLCDX2WBGQknu4WGrn2YZMgSMTl+mCao+G/QT5G86kNhLUYjysfDbjU7srWoShD
         GMQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710604225; x=1711209025;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iCt+rVFMewvPlx+xhhliFFC687YTCMVvaRCEv5+sAbU=;
        b=qCRDKIyp8cMVFoXo3qvk2htttnohMhrIwiNJIcF19W1vR8+uV4ELOxX4NXO8Q4WHzT
         s7RLGh44VQ7uQAI7cfjTt4j4fE5rQMZNHopyx/mdNrzqSjoiK1wcTvsEz7PYeORCfctc
         n4m16TnysYc2qtWrgwohTHtdDbQCN5Sk1XIF+XNT8C89YFVvXOFAaPcME5GT/jfpglea
         q4PzQ6B4Vz8I/yqUruZGjP0SwyeZsJQItt9MOXkm5x5d08vIE1HTsD6cmFHPkOuoD37N
         yZedzu0vhCqDMYdg9b3XPLvKBVwp1p6TICQHk4Sum0PgMFfzDD9l8PgF9eVmClmuZa15
         dSVw==
X-Gm-Message-State: AOJu0YyxyNMe4TmaBamcnSrBeJK504dIhSOb876II2XwyY6l4AehsVHe
	tySZ+cIm0EjHfn58M+06krOqW7IkQfJ3SmyohAAxuKyL/XexGMvr7ir1HOGjlWQ=
X-Google-Smtp-Source: AGHT+IHTuSClOl3KlQiGwKFBJUDBDs4zTrw5TIHBpyi0uCljtZOemhPY1m9psep/sY1kX1HLP0auaQ==
X-Received: by 2002:ac8:5a52:0:b0:42e:f816:8b94 with SMTP id o18-20020ac85a52000000b0042ef8168b94mr8061755qta.67.1710604225372;
        Sat, 16 Mar 2024 08:50:25 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id hj10-20020a05622a620a00b0042ebbc1196fsm1159995qtb.87.2024.03.16.08.50.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Mar 2024 08:50:25 -0700 (PDT)
Date: Sat, 16 Mar 2024 11:50:24 -0400
From: Taylor Blau <me@ttaylorr.com>
To: =?utf-8?Q?Jean-No=C3=ABl?= Avila via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,
	=?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>
Subject: Re: [PATCH 0/2] Doc fixes
Message-ID: <ZfW/wOm/nqoz8emO@nand.local>
References: <pull.1697.git.1710602501.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <pull.1697.git.1710602501.gitgitgadget@gmail.com>

On Sat, Mar 16, 2024 at 03:21:39PM +0000, Jean-Noël Avila via GitGitGadget wrote:
> While translating this session, some translators and I found inconsistencies
> in the manpages text. The fixes were grouped together in this series.
>
> Jean-Noël Avila (2):
>   doc: format alternatives in synopsis
>   doc: fix some placeholders formating

Both look great, thanks.

    Acked-by: Taylor Blau <me@ttaylorr.com>

Thanks,
Taylor
