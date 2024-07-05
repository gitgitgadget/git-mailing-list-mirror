Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80DB11465A9
	for <git@vger.kernel.org>; Fri,  5 Jul 2024 09:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720170483; cv=none; b=snejJNsing5TEDspAHHdMajH1SiKI+3MoDKe2pXjI9AHQ+uLVHQSAaW3mDmzpVES95C6QsfFyBsyFlBlEZ5QkQsXW9FGIKtW0P4EcRJy0ljbWytSupBwgJZaQg/8YtauBcAI+CfUOKj+RQ1fN0idhB4zKIzgs7H0JKIkZI1dWUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720170483; c=relaxed/simple;
	bh=QcgAT70Fttx1TwnYDS+FSSD05zRdJX60bLxX+8XkGiQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=oo5wIiWLER4WMWe/PzLeH4m16QKKqmnYEVG5C29UZ6rm2LoiONcIoUP2dow9T05/Thdyrktn39cnXIRRGAfhF1Cy3oPSNFL7ABnZ7LQtBXdmCkUE2e5we5DhrJ3lGu9GgzYB5i3xLiyILaC0tEoJqu/3wpsRI2erzqbrUEihG0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b1fWlBfS; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b1fWlBfS"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-57cd26347d3so1929743a12.1
        for <git@vger.kernel.org>; Fri, 05 Jul 2024 02:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720170480; x=1720775280; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8FikOpy/jm4Hend934gITE5p+WzPLhdvoqAmRnXojpY=;
        b=b1fWlBfSmaVJVEHCO+pZjEp/LM2wtJXUvSXvBqjWSIXj6/xw8+sk4u+ER7aYyGPHQC
         7lODVJNDZwSF5nefx4MxFw0Ulop7p9ORnzn1O+DMQpjwSq/qZrMGKgv2buCJXCGUnyFt
         Zh4vzqjyQaI6TvqQRcuRftbRf5+WKEo73jJQTxmsucld6C7BSa42Ca5Cr5n0PXP+kP4U
         6NGHKg/Xf7uykYmgInvUaK5FpHBEiNGhP+8SKXWVgf/IOZ8pIxf3sBFLa5DZKOQ9UkOy
         qM1G1XpM9CYkI3zwtPFfJhSJi4z9JUR1+gBZsrP8YsFnUmnMks+4+xvO8/BFLU+7Q3vD
         d4ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720170480; x=1720775280;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8FikOpy/jm4Hend934gITE5p+WzPLhdvoqAmRnXojpY=;
        b=Y75yONNFF3USIAw4XwXiHPNm4YfARrx4nbIrJgDt37IdWgTxWk2V8KGgow3Tqu8IPU
         2IYKZNlMPQ+qqD8TWz2hFviCaGcMwbnRHBa6WV5jJBQQfAlQVYS48glHr5RdxGzqRjqt
         m0xuvm6aBVmFyBKAc3MrXLG0aLxn9gxtg31cX0CJv31lxZPUUvYZwBlp/ZLxjuufb0bC
         CNFwlTYEbpqD00bwkcmXcPJs8k+7UZSEevfMaIqZDjmGxSuYUPibsKEolr7iZHYjgA4x
         ghx4le4JKTRZcd2b0drtxzPm8fvfF9vbhbBItst2e64wzREn9qP+cVqgKJWvGXrR8FLA
         jyfw==
X-Forwarded-Encrypted: i=1; AJvYcCWKB1afVaZHU5YX73cG6tZLD7L/oz37rgBL6FDzo4e4AFj/QFaOxyTeT2r2l3gIeERp8S/808QSP+LHKyQQ9u0SQJby
X-Gm-Message-State: AOJu0YzgLh+X2O6mOEpmmIpFQ7Wisc5/rkm0I4MKqH02znT+5cQKdP4u
	Zn08JfLE+32NlTtKLem9i8MyeAxLFm2alpddt7hzHxwpM/fdQBUEITcR3CyDTxhzlJtxbgLqF33
	eMAKT1FAa2cAd0xLljwdk9nz8iQY=
X-Google-Smtp-Source: AGHT+IFq4l025N5vi7FO/H8Z40F6lzyyu06BcEqXB340y6FF9ySJAC6edgx2sSIhyju493vWl+Wntjy6hGL4NrvszO0=
X-Received: by 2002:aa7:d5d6:0:b0:579:e7c5:1001 with SMTP id
 4fb4d7f45d1cf-58e5b3ab677mr2109181a12.23.1720170479503; Fri, 05 Jul 2024
 02:07:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANoqcKYwgA5sT0fAgSp4atpuPOaUSDALRVcf9XoajOe0g6xibQ@mail.gmail.com>
 <ZodRSw9LEwLa_nOG@tapette.crustytoothpaste.net>
In-Reply-To: <ZodRSw9LEwLa_nOG@tapette.crustytoothpaste.net>
From: Abraham Zsombor Nagy <abrahamzsombornagy@gmail.com>
Date: Fri, 5 Jul 2024 11:07:47 +0200
Message-ID: <CANoqcKaPhAfp1733a3M5P2sMQa8Wr_Ezpje6-ANzE72qUcZ-tA@mail.gmail.com>
Subject: Re: Unable to push to git server
To: "brian m. carlson" <sandals@crustytoothpaste.net>, 
	Abraham Zsombor Nagy <abrahamzsombornagy@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 5 Jul 2024 at 03:50, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> On 2024-07-04 at 13:56:15, Abraham Zsombor Nagy wrote:
> > Hello Git Team,
> >
> > I hope you can help me.
> >
> > I'm trying to push my code to GitHub, however I'm unable to do so:
> >
> > abris@dell:~/Projects/maradandohalo/server$ git push --set-upstream origin main
> > Username for 'https://github.com': nazsombor
> > Password for 'https://nazsombor@github.com':
> > fatal: protocol error: bad line length 175
> > send-pack: unexpected disconnect while reading sideband packet
> > error: failed to push some refs to
> > 'https://github.com/nazsombor/maradandohalo.git'
> > Enumerating objects: 31, done.
> > Counting objects: 100% (31/31), done.
> > Delta compression using up to 16 threads
> > Compressing objects: 100% (22/22), done.
> >
> > I use Debian 12. I tried this with the git installed via apt as well
> > with the git compiled from source code. Git version: 2.45.GIT
> >
> > I also asked this question first on StackOverflow:
> > https://stackoverflow.com/questions/78670914/git-fatal-protocol-error-bad-line-length-173
>
> I know you've got this working with SSH, but I'll just mention that
> usually this message "protocol error: bad line length" means that you
> have some sort of proxy (such as an antivirus or a TLS-intercepting
> device) that's tampering with the data.  TLS, which is the protocol used
> for encryption on HTTPS URLs, has built-in mechanisms to detect any sort
> of accidental or intentional modification of the data, so if we assume
> that both your version of Git and GitHub sent valid protocol data, then
> this means that if it came out bad on the other side, it was tampered
> with in the middle by something that can decrypt the data (which would
> have to be something trusted by your machine).
>
> That's why SSH works for you: because the types of proxies that
> typically know how to process HTTPS data don't know how to decrypt or
> intercept SSH connections, so your data doesn't get corrupted.
> --
> brian m. carlson (they/them or he/him)
> Toronto, Ontario, CA

Thank you Brian,

I cannot think of anything, I'm just behind my home network, I don't
have a dedicated firewall or proxy. Pushing via https works on Windows
on the same laptop. So I guess it's something in my Linux env. I don't
know if it matters, but cloning worked out of the box on Linux.

Sincerely,
Abraham
