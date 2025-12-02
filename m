Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B258530EF88
	for <git@vger.kernel.org>; Tue,  2 Dec 2025 09:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764668422; cv=none; b=QsUzTxjZhNrsVMgcw5CqpCAt3r5Y1B17W+gupVMk4DjF64HDrSfy6XXyoqgQxKch2xZZpG03iVNnG0NGNpGQqKrZ174CgalEJ6C/6w3LgWy4YboR4l9z6waXpk0HLmD34BJ3Ivw1ujQADUT0tX09MHsmPOH5hO8hWKQ2C1Ptdgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764668422; c=relaxed/simple;
	bh=ZW/5HZLaK81BBO4tjRDALEv0HnJVdx3KoRGLa96XeyM=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=YRsYz1EI+7I49hlB6WTkckMPSdFcQnaa64zDoyH9AdK3XAJy0cIrvgKCEnrgUTAqbxGOP633y8pXHFZLy2hgR95DVWWgXInwY9o9OkAbZWyPdD8CmVxyDZnROKk0dDvAIuB180HOwZiYVNuSAKXi8yticEtYfiPe9JZo8XVGQiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TQ+JK4Ef; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TQ+JK4Ef"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4775ae77516so51635075e9.1
        for <git@vger.kernel.org>; Tue, 02 Dec 2025 01:40:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764668419; x=1765273219; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZW/5HZLaK81BBO4tjRDALEv0HnJVdx3KoRGLa96XeyM=;
        b=TQ+JK4EfME3a+EZW/PF1ZPhARUrRTyOIY6ZPgmCrFA0wfHp6hviWUtn/YWIEm9Wrol
         vtRAZDmkNfZ9Ml3Ab1Z2uaaoIob/6oZmGobYK8aBjvKAw3iUm7vID3GThaEAuSsAA0Fe
         lb1+gw97VSly/AxOjA43YZ+eeHZvMiYvF14OJ7wf4yl8xYZcEH24Hos5E/U1KM8owINu
         ULT10H3+7lMKgqe9NWJ0ZqD2qeV/tWqlv2uPmXfdqGHhjTZKPaLzmAdZ+w072Y2cfwm2
         Yj8lJYusR9wbW/31Klnpxm6FGDobotn1YtvD7DwB1907NlbyLA9uiOuGGKuT0ulVAwy1
         ZgRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764668419; x=1765273219;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZW/5HZLaK81BBO4tjRDALEv0HnJVdx3KoRGLa96XeyM=;
        b=DwVc8VGBFUasRT15FqsbuS0Y0785JtB2L5yb2NXBE59zXjZC1DR/zWgP1N7keV4E/g
         SnsEMaKltMYdMrngD+m+bGco2K1mISSb122VaREiJSP7yv1HXvX9oTUhj+TSXEHGBja+
         43rPk9MrjsuZNpHKDXpX3BkdUIX6sznTpVlGUjeDGP3L3gq5TzD2AWooITNGvRCz8ZFx
         ohhyAnbFxqDOLTmPrAFAmenzG1/IEjA2kcOxuvJ2eCDUH7dnEvUlIQJvxde83SSFsv86
         n9rb3DZAmZ8x5zfQL+k+hM5Nd8+rr2MBvSygQhVREvPdLRXQwyqGggSbw1S+kSDVa3Ow
         0erg==
X-Gm-Message-State: AOJu0YzBdy5v+UC6Ch+OrcLI4hKxymWA2SYGmEcC9rjhj/n30bm+Nob7
	rNY+z316bmiW2WzjjAisbDf06sN/TiOKNjjzlwN/pcDLsbe+dBU8rzzM
X-Gm-Gg: ASbGncsKw4WmOXmDFfy84dhqSG3q9oU1/1zFCmUZo4faZ5dm9c3+g8Mj6PFyhWOxTUT
	lo+mt0wtzR586XRYPs3aOsRkpiMSJON8EJgic/2wzhXEeK29lZAgffrtQuZNx+G70BN0N0UCOsL
	noFZYks0jeSsnwihma29TJUZzTigbNKuEWxAi3Csm6WJXUdpO51l5aK7vLF7G2nkZfXvcxymK1f
	d4fxstGukAk5d2y39yx5MHJZbmn0Y8Sgfl6Racbgi9PZ9TueefBRdoW6FL6CJFZKyEsbUe7j9KX
	EDXgIgOAFyA+TcoKmOUGC0jyjxi2S5QULSz43ruvLxDvt1kRWPZ+HRJzkkQV/M8sPhAMltwqsWj
	o/zsPn4wYO0gy0gWx+8IqtZuwJNfYWX+NqPIevf3CIEzISnPjSGYl8FRzkrWsOnTSyJ67kbcR2U
	O/K6rAS/5fDn/GGac=
X-Google-Smtp-Source: AGHT+IG3K1LvMvqA5UdyORQtI8o7bRNiwCKsR202GsHswCLkycaWgUiU+5JVicAYS5TD/1X1DEmNsA==
X-Received: by 2002:a05:600c:a07:b0:477:a219:cdb7 with SMTP id 5b1f17b1804b1-477c10523aamr455516465e9.0.1764668418826;
        Tue, 02 Dec 2025 01:40:18 -0800 (PST)
Received: from ubuntu ([105.117.0.144])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47926f2c5e1sm14091175e9.2.2025.12.02.01.40.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Dec 2025 01:40:18 -0800 (PST)
Date: Tue, 2 Dec 2025 09:40:15 +0000
From: Bello Olamide <belkid98@gmail.com>
To: git@vger.kernel.org, Usman Akinyemi <usmanakinyemi202@gmail.com>,
	Christain Couder <christian.couder@gmail.com>
Subject: [Outreachy] Git Internship: Refactor in order to reduce Git's global
 state
Message-ID: <CAD=f0L_-b5d5qVdL0TASS5iA8rWQxianT4_2zmhMtwN8p_TYbw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Git Community,

I write to you with great joy, humility and gratitude to have been selected
as an Outreachy intern for the December 2025 - March 2026 Internship program.
Working on this renowned project gives me the privilege of working with,
and being guided by, some of the best and most impactful engineers.

My appreciation goes to everyone who guided and assisted me during the
contribution phase. I have learnt a lot already, but I am eager and keen
to learn even more.

In the coming days, I will be working on the project
"Refactor in order to reduce Git's global state" and I hope to make
significant contributions both during and after the internship period.

Thank you all once again.

Olamide Bello.
