Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94AB618CC15
	for <git@vger.kernel.org>; Wed,  9 Apr 2025 19:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744227068; cv=none; b=ROmN/Fl6KggZvpkq/cjk18cmAEBuriVEmco/O9Uvtg6NaBwobShmUj1K2c+bsVm/ns2OoKISXqYmcDV+0M76bgk6bWdxHcYsxWFTAc3pOCR8ECdhfERVizK28mxYrPcQDRzdTPzTrFjPqoVK/eSiJBsWOxNG6rtn1yTArquzreA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744227068; c=relaxed/simple;
	bh=gCawKjc5tYqQCCvJ3Fhojja1UChEWZBM33731fLPbgU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o1IYENKUkYcQ7SpmBLaoW3F3eAKA2eQVTIja3pMpgcXMUQe7kYluquTMdISBDamoXfdQwWiB3yBRRBIjMxhDYyo3oRhMFwtOAK5UdUUYBlXxNaGxuNsRpkSE8s1R8HDyGR4zJWQ129Nuqr3VGEu4lpKt6c7BRdjwF4jThSRjhGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6eb2819468dso8310416d6.0
        for <git@vger.kernel.org>; Wed, 09 Apr 2025 12:31:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744227065; x=1744831865;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gCawKjc5tYqQCCvJ3Fhojja1UChEWZBM33731fLPbgU=;
        b=jG4c3gDd5b7VjTSTCNFoR7gwb2z81N6r1F4pttmB2gZER0bitr9JEMpSBLQ3ezr31G
         IzTgq+0lHBOyNGB1hyQfOXHTtqo/1o9qaCzKXgt3PkkuTF7P4t7hrjd9pnnHVMZDlDfs
         g2cZnpoUEz2xnGtqnWc6TkAQ95OoK2svjsidgpW5g5sEpZK/bcWAXdpfnSk+zEIAzYEl
         ENC9tCmxhP4s9KgTsbA5LAR1P96tHjAjfGg6kes5sd8evqBKInCeNlwiC1qGG9NAU8hY
         rkqwQi/8obtO/uuvN6L+wXze1Um+eC55GFcG49Bv4Lkx8zw1WThFZmRIgkCOmE2JwqzH
         hIvQ==
X-Gm-Message-State: AOJu0YzfpoHTen+FaPXaXp5BEcNDfIlFKbARO+7mjxZ/URq0Q7sBy47d
	NlL4dezHa+WxvcYJqt8bOcLUs3Gfbotr1m00JTAUG71AC8VNCxodTt2qawvSGIooDWOKWyUKu9e
	j21Vw8rmFeN4w6hpme4r366D+kaB6OunR
X-Gm-Gg: ASbGnctzHd0fQKMc+L2l35XMt0ltiYDTIqUjN6UZ5r4RM4Zkt0SiaCPe+nZPj7yVT3H
	1EtBRIHhUP7NqtMAOxASHCcH0GmrwPBJBRtzc8KChNuvG8DYBE25G9COsLkSGro6rXiOBt7Wuc5
	n/kzLK35WnyhhVDc35XfXA
X-Google-Smtp-Source: AGHT+IH23/WeICiTZe6VihB4eWxHRVl3vnfuMJ5pM/eKn9Oqyc2kT0xBB9R/C95hPJo3U0lNb/3BJixD54Um7xkyLVw=
X-Received: by 2002:ad4:4ea4:0:b0:6e6:60f6:56db with SMTP id
 6a1803df08f44-6f0dbc487c6mr22094886d6.6.1744227065326; Wed, 09 Apr 2025
 12:31:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <AS8P191MB2174CB58B1A29D1492EE7842FAB42@AS8P191MB2174.EURP191.PROD.OUTLOOK.COM>
In-Reply-To: <AS8P191MB2174CB58B1A29D1492EE7842FAB42@AS8P191MB2174.EURP191.PROD.OUTLOOK.COM>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Wed, 9 Apr 2025 15:30:54 -0400
X-Gm-Features: ATxdqUEU3wIEyH7EcgQ8fYuD0lqDKNPzZoKTWl9zohhQh6w9uphVQ3l4AgHOTAM
Message-ID: <CAPig+cTK+jz_kF7zd85nVRCn-6sqbH0o7N_ZDtDZDVjYbYgQtQ@mail.gmail.com>
Subject: Re: Possible git-gui bug
To: Lauri Reilson <Lauri.Reilson@proekspert.ee>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 9, 2025 at 7:11=E2=80=AFAM Lauri Reilson
<Lauri.Reilson@proekspert.ee> wrote:
> I have a small issue with git-gui. I added the git-bugreport to the attac=
hement.
>
> > Whatd did you expect to happen? (Expected behavior)
> Expected to commit using git-gui. Commit message was in the format <#task=
-id message>. I use ";" instead of comment symbol as "#" is used as a means=
 to track task id.
>
> > What happened instead? (Actual behavior)
> Git-gui gave error message, that I need to provide commit message. Tried =
one line, folled the error message (first line, blank line, remaining lines=
).

This sounds like the problem addressed by [1].

[1]: https://lore.kernel.org/git/20250315140913.577422-1-oswald.buddenhagen=
@gmx.de/
