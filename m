Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C161D1AF0D7
	for <git@vger.kernel.org>; Wed, 19 Mar 2025 18:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742407378; cv=none; b=vEK0PiIAwVZbRCRqC/dJsRx3vCeNIJNGs7tHFt20egy0pLPf5906ePEIUBsLjHWnZ3AMpnOTJM6atlijhUX/z7LfBCCSSMEEYF89r2Rr3ZusbA82Tn1eAr7Adi7uOD5oITBsCMj8E2znO6RXYEQhAYsA2u4zHik+WKmC/DTjR+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742407378; c=relaxed/simple;
	bh=BLTcp49zYtPBUTf6hMexNq0+3mPL06pjQflImxU7hVc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Itg82hKCElU21rKLuoSxN+gP6lBzC+/+0aoxTSSR6KT/KKchXn3ddi2NDv9lakfqfen8BwsYj0iWcMt1V6I39uF1sFLnz9YsCIHyoqrt37+iWh63PRPbhhGYvnd6dr3Hn8BDlIpT/mtyCqutWx3CiB8YgZoRappZcVmWg0kELWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=iCC/LTB8; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="iCC/LTB8"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-476ae781d21so69487051cf.3
        for <git@vger.kernel.org>; Wed, 19 Mar 2025 11:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1742407375; x=1743012175; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=82V+9OBVhfz1rl0X3ToLYFEKpkQWbuoU72EMdi4LkX4=;
        b=iCC/LTB8TVADAYaiVSORHgkprC85S/LNbvb0QZUTnTbvgDXQtmh2GHzoJt8wY9PceL
         MZvi3rGi3MZQtJdetmGkpQp6vcsuL21Na/8Kq34R3UQDt4olfHSy0nEh6pf+GrYYXFgR
         W8lt3uzgozXjs6FLhP5mzLBJX40TM/mp3UDNQEDyZCKN9m+sgXQQj2vms/yNDtlnrb3u
         0LdWIdDD+5PKVnooMl2XW50wbMHps5aKb5bNRs52RfXCy4FqndaPBIJqS2yI4qrjNGEx
         r66pyK+ojSoNNSgaSRdV+MWz8hmUnbpzpbMVRw6l7yr5NfwCSYfBKtjp/J1NbdzTNp0i
         oPyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742407375; x=1743012175;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=82V+9OBVhfz1rl0X3ToLYFEKpkQWbuoU72EMdi4LkX4=;
        b=SNEQ7GkK4tfpd721czpbtNuUkrS90OlwgWSVT62ZuWnpyneD2n8R+X/RKalTowynrK
         0r8yIYrt5XXmDWWz+zimFTwMkwlWg+SjLIR9T0BA3EyX6e/ypwgps+ZdoUlaQeZYAShi
         yq0gcQ8FkDdOK0Ngzz0Vf84dG5MsA3ZrhvFmjB7shjNiZpIK+vA01dPU2AjWyL3/tR2a
         5bT8cPSksXrc37MOzBTYx7k84/5Huu4X2acLOgp74qcendjt5bHtU1MyBvIh2rfkssaD
         X5Y7Mbz/FQjAslr/2I/0x5c7AqBKj0JgbhZrqhJ1Pn9Wg1NHxW424dcG5KlMmbY5CJQR
         qhQg==
X-Gm-Message-State: AOJu0YxTODjxoXiJEDvOH0/Il2+6FQX8uPNfulbbL6pCfRgMXNfgzo8+
	edb1HFDpC75RHryNKLcX9d3QIpYNCnm6Q/ibfU8By/63nxwadpuZIf1aNomURIc=
X-Gm-Gg: ASbGncueViwst5wjAgZA3/RnG0cpkxz51Htb6zMVSi/QgttxBy/fhA52RIlEieMxrWD
	urUb8rgGeVhqUA/5B911ZodMDPfOkzh9MOdJcxwXfiSWh9VLgA5i46ptiZWvhCo12M4R82xStog
	hYQ+fZrjSSNfU3fQMVFNCYjqd7D6FNQS4rytNJUQqzhnywuatxusdyUmrAW6hoSjECGA10b/83c
	82Y4uU9yBlDGqN2qU/+lypCxQKpv+cQsiZsipFyc/ciYwj9JxyQaymt8hR4tvFOH+mNFWFLeBz1
	qwPENPVeP2g7CcLDTJ21AiCtU+1ezeMebs00q9KQLM54C+iL5yu2nnIoKw8wbX/m2XEoxQYeTrH
	ToGLrxEYe8JykkIb14IO5zcc3jXs=
X-Google-Smtp-Source: AGHT+IGk1X7i21F4hTj7lbF2xRYXW4VUrTZZyEziEGyq3zd/B0h4lmtDiJLNXuy14GXDQo2GvgzxTA==
X-Received: by 2002:a05:622a:578f:b0:476:8eb5:1669 with SMTP id d75a77b69052e-477083dec00mr64773771cf.32.1742407375464;
        Wed, 19 Mar 2025 11:02:55 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-476bb6735d0sm83603721cf.44.2025.03.19.11.02.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 11:02:55 -0700 (PDT)
Date: Wed, 19 Mar 2025 14:02:53 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 1/3] http.c: introduce `set_long_from_env()` for
 convenience
Message-ID: <Z9sGzWNU5Gn5c/+8@nand.local>
References: <cover.1742336481.git.me@ttaylorr.com>
 <ba22a121fa699e490de00eba988552b6c10fe2fd.1742336481.git.me@ttaylorr.com>
 <Z9rqK8QSs2dA7t6S@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z9rqK8QSs2dA7t6S@pks.im>

On Wed, Mar 19, 2025 at 05:00:43PM +0100, Patrick Steinhardt wrote:
> > diff --git a/http.c b/http.c
> > index 0c9a872809..be564fd520 100644
> > --- a/http.c
> > +++ b/http.c
> > @@ -1256,10 +1256,15 @@ static void set_from_env(char **var, const char *envname)
> >  	}
> >  }
> >
> > +static void set_long_from_env(long *var, const char *envname)
> > +{
> > +	const char *val = getenv(envname);
> > +	if (val)
> > +		*var = strtol(val, NULL, 10);
> > +}
>
> Hm. We don't perform any error checking at all for whether or not the
> value of the environment variable is a valid integer. This isn't a new
> issue introduced by your patch, but now that we have a central place
> where it's being parsed I wonder whether we should be checking for
> errors?

Yeah, I guess it's technically not "new" in the sense that we were
already doing:

    xyz = getenv("XYZ");
    if (xyz)
        *var = strtol(xyz, NULL, 10);

I suppose we could do something like:

--- 8< ---
diff --git a/http.c b/http.c
index c13c7da530..6b01ad7a53 100644
--- a/http.c
+++ b/http.c
@@ -1280,8 +1280,20 @@ static void set_from_env(char **var, const char *envname)
 static void set_long_from_env(long *var, const char *envname)
 {
 	const char *val = getenv(envname);
-	if (val)
-		*var = strtol(val, NULL, 10);
+	if (val) {
+		long tmp;
+		char *endp;
+		errno = 0;
+		tmp = strtol(val, &endp, 10);
+		if (errno)
+			warning_errno(_("failed to parse '%s' (%s) as long"),
+				      envname, val);
+		else if (endp == val)
+			warning(_("failed to parse '%s' (%s) as long"), envname,
+				val);
+		else
+			*var = tmp;
+	}
 }

 void http_init(struct remote *remote, const char *url, int proactive_auth)
--- >8 ---

On top, but TBH I'm not sure how much value it adds. This is only used
for reading GIT_XYZ variables out of the environment, and we're already
pretty lax about strtol() errors in other places. Since this isn't the
interface we expect users to use, I'm OK to punt on it for now unless
you feel strongly otherwise.

Thanks,
Taylor
