Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E364522F
	for <git@vger.kernel.org>; Thu,  2 Jan 2025 15:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735831708; cv=none; b=s9hY0gr1DnFs9IuVvZEwlcbUVPZJUOKkCGST6aJJi5UAjzkKuuiTdpPCu3+U5nE1CaOLCdpfQ8kqqXH2TJHHcqsd5ZgC9UGVy//wP6PIhxEHKd8WLbuFW1sl+/WU6nSFSqWAHWK3qvb3/369EdgTJGX51Y+v7WM8jYLatfrX6xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735831708; c=relaxed/simple;
	bh=sNA88V5SMjzEk8Emi57hNDS5P4fHHe7+LtRRT01ZTro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WSSHiFj6mww0Xg9L84TNWhNfL2aMetOcI73Bne04I7aNg89apVBxHtswcqdGCER+/I8Y5Q8Fqd4p5dFfALl6/QtqSMFT4+UhUIzND+ZHNJXI63zfkak0Ncmm2Nk+qwYokIvYwoBUltTR++ewqyCI+/E2M98ZyFFYr6P9Fl3Vc1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Th2yRhlU; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Th2yRhlU"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-218c8aca5f1so195324925ad.0
        for <git@vger.kernel.org>; Thu, 02 Jan 2025 07:28:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735831706; x=1736436506; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=REIRCz4XCbVbXpefEleRXnltmFa44PAd9H+oOsYXsrU=;
        b=Th2yRhlUXKG1ADpWwuAFDv67/hvAxOLp25LqbXYUxW2wjdaXz2nhYacbitQ2yoU8H5
         DTV1azlddnIFAaDyFsun9k+kB+JaPjbaXiCL4NA3HkVosgkOJW+8qCHU8XCVWrZqKJr0
         qirZg7ms+Ttan6IvJZgOsvw1joaA81tNxAdZ3J/T4jmS9bZ1rBAvQTwys7NKIHk376wp
         ljnxsV+6O8PNEHePltnTaBMNexiVccOp53+HlgJeaM3G9DCyG9O6SsUjuZzFnbyYh+uZ
         fo5+QjX0gXaS8uDbTwWDY2mi4qbKZWqMDFvvzmDQ5g505264f1ryOEs/5lb0rhovbsny
         B12Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735831706; x=1736436506;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=REIRCz4XCbVbXpefEleRXnltmFa44PAd9H+oOsYXsrU=;
        b=TYbhqmKgKdWVavJV6n4yiDCQq1qW/ES8pidtei18fD0p0vHGJXg8TIJTD8w0U6nn2X
         yAYU6fhwPhCohEGmshsVodex620ozRV+pCAVPzZkwaYrmtiXcNev9yJTSd+g6HUNL2cS
         sJ2mw5CG72N1oxHv1O7Tb3jFzTdtIuiRWVtalnBmy0p/YjQADkbDc1Tqo/PLP1T2WPAL
         LqRnS9Cu2b+1wbMq3g8eFUyq/BiD7ax9zPgC7WsCYKs7IkwmrHyzkfo+TkV6J2yDiQd9
         o5i1emWgnBjvGujmig33Mt/kFHz8qI0nK0PMq6IQs+pPIZGs4se9QhGA+wD8Qi3xjNLu
         d9/A==
X-Forwarded-Encrypted: i=1; AJvYcCXImzlE0J9LaEX2QoRDiiESQZACAejFi6vweDBR9+oMp4jGBj7ZdM3qzRGXF1yCei9Awz8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOG39oGP0hfdQ3PBGRCR/Due8uhbHPCcXhN1jJgCsmTP8vyKT8
	sl/UGLmHMM/goLDyfMlzry8BOGsBnc+6eyOlXGGG7dWvr+ugNAT2+l2fGOxo
X-Gm-Gg: ASbGnctp0WpS2/V89Y8yPVGiuYWV9gS5+/Uvy/M/8s/bpOxBLl7OwXFct6/z1QY/4Sa
	P5iqw2fRy4u7MBcpNvbfqHCLrYLK8SJ9kW6tMMck99wyLfc/h53Qkm6XttApn+hsdYWQGC3ZzFw
	kg495o1AxzoDIKC1PDYCo3CdDXpG+J7RuD8Xz+lOPMtVLLkBfi17QVhX8WIVehhnXr+ALQ9dZlP
	vl+2VLUTt7sEa+dQ0QCwNSp794c/t35oDSwbeVlSBY6YdWiX2SXQ9iNRFaxu+37oD42cUAebny8
	D7l30tmhvCeRoDcOWA==
X-Google-Smtp-Source: AGHT+IHBScUgXKwOJpauFCEhvnfdroL7MZ4LL/bqY8xl9sJLprhQ759Utxx6XkC9HHxxUGQOATSc4A==
X-Received: by 2002:a17:903:182:b0:215:385e:921c with SMTP id d9443c01a7336-219e6f285e2mr488371995ad.51.1735831706229;
        Thu, 02 Jan 2025 07:28:26 -0800 (PST)
Received: from google.com (56.166.125.34.bc.googleusercontent.com. [34.125.166.56])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc9f5065sm229707665ad.176.2025.01.02.07.28.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2025 07:28:25 -0800 (PST)
Date: Thu, 2 Jan 2025 16:28:23 +0100
From: Jonathan Nieder <jrnieder@gmail.com>
To: =?utf-8?B?TWF0xJtq?= Cepl <mcepl@cepl.eu>
Cc: Hongyi Zhao <hongyi.zhao@gmail.com>, Git List <git@vger.kernel.org>
Subject: Re: Change the grep command called by git with alternative tools,
 such as ug.
Message-ID: <Z3awl9gToJjwap-G@google.com>
References: <CAGP6POJX9GFsNkgGd7o9Pr-tFoz0sgRk51vVG4P0Kn1DPZe+3Q@mail.gmail.com>
 <D6RLU4BY374I.GQY9MLMV1AZJ@cepl.eu>
 <CAGP6POKLdTpwsaGo-oyGAiYJMRzwXN06rv3+V7v5QbL6xtDROw@mail.gmail.com>
 <D6ROC4RAYQS1.3V2K2W5GMAEYR@cepl.eu>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <D6ROC4RAYQS1.3V2K2W5GMAEYR@cepl.eu>

Hi,

Matěj Cepl wrote:
> On Thu Jan 2, 2025 at 2:39 PM CET, Hongyi Zhao wrote:

>> Do you mean: by linking ug as git-ug will do the trick?
>
> No, you would have to rewrite git-grep to use external grep-like
> program. I am not sure whether there isn’t such project already
> out there.

The key question is - what are you trying to do?  "git grep" is able
to search inside historical commits, the working copy, the index, and
so on.  Do we want to search in the same way to find files with hits
(for efficiency reasons, for example) and then use an external program
to find the matches within those files?  For that kind of application
I might do some scripting around "git grep --name-only", but I can
also imagine that your application is different.  Depending on the
goal, it could be something a git command already supports, an implied
feature request for git, or something that the external search tool
might need to learn.

In other words, Matěj's reply is spot on in describing the current
behavior: "git grep" doesn't call out to an external grep tool.  But
as for the desired behavior, we'd need to know more about the use case
to figure it out.

Thanks,
Jonathan
