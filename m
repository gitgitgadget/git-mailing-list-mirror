Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 450B31624C3
	for <git@vger.kernel.org>; Thu,  6 Feb 2025 14:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738851057; cv=none; b=XOM2c9c5ckblS+yY9+hVzsARwcYD1jIFt8EQM7DrkhqftP/XJS57t475kpqYX9IPCnBgajupgWkqvQvYZqnPhSwGiD5IrqKLVAP6rxCKyvyMtYsJgj9Kd/vJKSn0qVXXdzw9haQ0dtnOh2D9JnOvUoz9QyS8Vy7k2MnRlR1vgw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738851057; c=relaxed/simple;
	bh=wNPIyBBcFYGRd9+1def4R7d1mtUPAPTXB/7ZJ8gPINo=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=NoNy+BbmaQ7egwEoMIpLS4A2f7aFNcpsKuZ6sxcy/x87PCauJYB1YZL3q9mq5pOfXFdkf3lWEEKcOZcuvBERpMqLU7+4Wup05fVYSJf4q2Oov/zzOWTxFlG47wiyOG9aTNFiXewpkVIBSm5avZugq5yKijE3A019zRJVZ5pbEy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J2EcjwCH; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J2EcjwCH"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-467918c360aso11794331cf.0
        for <git@vger.kernel.org>; Thu, 06 Feb 2025 06:10:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738851055; x=1739455855; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wNPIyBBcFYGRd9+1def4R7d1mtUPAPTXB/7ZJ8gPINo=;
        b=J2EcjwCH2rZ0AHnVPPb74YLAJNgXhu00LAVQ7m32exzPBMofbYWyRm8D7HEwniV+mJ
         /rbUDL52APpwqM+5M/aLaR0CHENiLDNuc9Cqs2hJBQx/Ze+3gIGB2ew0wYfuerhWi1jo
         Ya3ZIUOS3GqSLZt028IXqXmcmi1NzpdKWFAIOWF1WlglDQlmlX+4comkJfornMcCMCtG
         M+nPWg2O2eF914QZDlhw9riVty6V8bJfHE5a7D298r0E9+DUNEthiyCm7/GZ1wNTe0mL
         yFyCg4OHWQ7nlMKlKfMd/KpKFhuRwg2zuYJSXERiP9tl/RannjAwLga9FbQCltQ9v2U1
         H0xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738851055; x=1739455855;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wNPIyBBcFYGRd9+1def4R7d1mtUPAPTXB/7ZJ8gPINo=;
        b=B+ZbaC0dW14nx+PYNBq3s1vbWBitNc7vuGUjQT9G47TzRyhD+PEUzz1VUv5qcNXo/f
         +P6sNFgL7F8ILRQeOryMeMah9kAEbBpMa/t3PrawT971H+2K08/mFcLRbOKGPJmOcmDM
         5nj8JMe4Pxv9dUNxz4VDJAyRNcsCeiK04+PzsinPN8Gg7xPz8h+FMF+PCXzJnWp6yD+R
         TNvfEIIFNkW9vcf0e07yDlXptTdaMlql0Ojm9IvJ2fdjPADkBBfQep2Opho1YPt9YjmM
         NQoZfRQ2t+SXoFwD5WmxR67iOMXb3IKJBH9C4TecbJmqKTZTNft0TW/EyzhbNf6LNIFC
         OXHQ==
X-Gm-Message-State: AOJu0YxFiU/MeRfaP4DAdS0gpmOBy4rKlCTEk24t462YhUTS2HoxdIa0
	nOvsP1kCfXyJQTRgKRbrnHH4ykipwIwQ8A020oUdslSIQxUG0gNQfOz6jdqCtbNTTIuh3D6hlhn
	C7eGC3Cz/GP5lUWGKPu0Ukgt2GkoIiH4y
X-Gm-Gg: ASbGncs/Y4obrfPeLAPzDO96mBObqmwUINk5PXT1SUx78lFLLdBI3Ydqo6x4sHXyIsH
	/VLLRb2q+qsz6B2RWemKTHh2WT36XsOIPqGPrytah6NF9SpTXsHjCSfkzJ+xxyH03qAea3Jg=
X-Google-Smtp-Source: AGHT+IEu3UZeSti6V6zB41oTwq0TXnABO0FRuXwJOwbI1aabYCjKb3VUdF0AwfuLCeCHbrRCTfk7HAAHkQLObmR+714=
X-Received: by 2002:ac8:7d0e:0:b0:461:646c:b8fc with SMTP id
 d75a77b69052e-470281bbd39mr97527521cf.23.1738851054873; Thu, 06 Feb 2025
 06:10:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: USA Linux UAE <usasoftwareengineer@gmail.com>
Date: Thu, 6 Feb 2025 14:10:44 +0000
X-Gm-Features: AWEUYZkItW9c46D9GiWpMseAEAJDl-Pnm-vtjf5B9Vee3EAR7gSliNtKUbux_bg
Message-ID: <CAOXJ2J-StZYg4E9eGug=wHNjBu3aPdoy0x17aS9jLn14SyfJkA@mail.gmail.com>
Subject: Managing one github repo with Gitignore and Submodules for two
 different remotes
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi everyone,

I'm hoping to get some advice on managing a GitHub repository with a
slightly complex setup. We have a main repo that utilizes both a
.gitignore file and submodules. Our goal is to push this repo to two
different remote repositories (let's call them remote_A and remote_B),
but with a key difference:

remote_A should respect the .gitignore file as usual, excluding the
files and directories specified within it.
remote_B should effectively ignore the .gitignore file, and include
all files and directories, even those listed in .gitignore.
Essentially, we want the opposite behavior of .gitignore for remote_B.

Additionally, we need to ensure the submodules are handled correctly
for both remotes. Ideally, the submodule pointers should remain
consistent, regardless of which remote we're pushing to.


Could anyone offer advice on the best approach for this scenario? Are
there any recommended workflows or tools specifically designed for
this type of setup? Any insights regarding submodule management in
this context would be greatly appreciated.

Thanks in advance for your help!

Amjad
