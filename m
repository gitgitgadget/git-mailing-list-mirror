Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB932E406
	for <git@vger.kernel.org>; Fri,  3 Jan 2025 11:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735904375; cv=none; b=V368U11WEEAvz6ErCNE+dmzzZaQ17PZUyOwbJgI71FWZhTCI2q+V/B9GVzcLK1JohL5ZBS/uhUUFq4r6gRXWCx6YHRtKVtMrScABFreekN+CMOpfHwieBS1sfw3vAdH04bZ6wj7mCD0rKS+AlDbLW/o8r8NL3ybtV7jUWDnAyzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735904375; c=relaxed/simple;
	bh=f7FS8uSHFVAvTCs28/JSkcGYLPhRRNGlUhDXQCEGAHc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HGu9fJeUZjZsaWsewuAHkNgUcCmbMv8fhZm50gX5wRkjLc4T3hNOhURTIjqXjsXeoyGplDxyWGHzqu1/JP0FLrUQTIsf919t/hDiNRxv/T74u0U3W08eOLmYVoaxjKk6gfc8vJ7sCDBDNQD7dMevnIXfUWNpi+EnNYb3/2HDrCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6dada7c89d9so3112456d6.3
        for <git@vger.kernel.org>; Fri, 03 Jan 2025 03:39:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735904372; x=1736509172;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f7FS8uSHFVAvTCs28/JSkcGYLPhRRNGlUhDXQCEGAHc=;
        b=MYHzSWjf1cXWd5AbPM3H8w58m8yYIyLbDIZZsZj70BjCToGL4PJPt1FHJce81BITe4
         xI7CRj8ai79vhigzapo8rwO9B3Ht3w1R++wHpFb7Os0LFEggqOGM31q0ohaebajKpbm/
         SdMa+rhDpF0VWJQNEQVeL75vuySF9yudoqap4w9hVH/YX4oy0Xg6n2m/FevGaXcBCZZB
         Xvtf0ysTZVwWSfe9ciDhU4uzLJmr2y08d5yUG5gfRYXknbTsoRh6/arfbR3bqd/cFxrV
         WAa+zhi7yrTJREhJDjQP+wdRmas3PLmAUwzpa4LTKZZ6OHsL9LpG4IocD8pVFjmj8pFH
         Vkbg==
X-Gm-Message-State: AOJu0Yx7PPnQXh9v6xIn3G48Pib0s9qLGGqUNc1tQeU8I+au6QxHrNIz
	ytUPa6NDKw9Vi/7sHtYyKRhtJIMV+oHDK0DUtHNcMTm1p/OCryB1VaqhFPJOXdkkW7tfpfXtLCv
	yh3+ngwMRSCngGhSybuRewpF46Cg=
X-Gm-Gg: ASbGncvVTRL8lXAIqC9hrVbc0pG0G5Nc72baktmMaZ69dz7tdQt3bTizFiNC2/cRT4S
	777+HVL3+iAy33bQSpepO34K4dyo+pi1LbGgLnOO66VUDn37C8B209p1lsadpUdntRRLppKM=
X-Google-Smtp-Source: AGHT+IFUsK7SgXZq5cJ5KFhRabbiZoN7v+AivC0N91qZmjvyd8l+Pzwc5P1kvMeXAFpOGsmEUIWHnxbJXOdQRGc5IY0=
X-Received: by 2002:a05:6214:319b:b0:6d8:a150:3eee with SMTP id
 6a1803df08f44-6dd233a4531mr260310666d6.9.1735904372544; Fri, 03 Jan 2025
 03:39:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1735903029.git.martin.agren@gmail.com>
In-Reply-To: <cover.1735903029.git.martin.agren@gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Fri, 3 Jan 2025 06:39:21 -0500
Message-ID: <CAPig+cQoFC_2M-S0d7SLBPFvusXQC93pbk3QP2+qhsa7BJGnuQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] documentation fixes for 2.48.0
To: =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, 
	Alejandro Barreto <alejandro.barreto@ni.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 3, 2025 at 6:34=E2=80=AFAM Martin =C3=85gren <martin.agren@gmai=
l.com> wrote:
> These two patches fix some misrenderings of the built documentation,
> introduced during the 2.48 cycle. As usual, the exact current behaviors
> (symptoms) differ a bit between AsciiDoc and Asciidoctor.

Both patches make sense. Out of curiosity, how are you discovering
these problems? Are you, for instance, running doc-diff and manually
scanning the output?
