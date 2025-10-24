Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75645305059
	for <git@vger.kernel.org>; Fri, 24 Oct 2025 09:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761298761; cv=none; b=YwQ9GmJHz9TaM46B3FesHvsWPpKnqFwT+9cCO7a6UbB57NvhDOkyOxJuRonocU0vz7Ikn6GC+Kqz2XAH9eOSdUDrZJ4SOSuZ1UpF8EdgGXd1h7dJiNFQgbXPccM+9DDBpTxYkPvzkxzyZPoGE9pl9Ca58JUCT+dHPOcjCr8m2uM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761298761; c=relaxed/simple;
	bh=L+QGEQ3cS12TCQaDEHpF7kMFcYpCr4uQbJAZpUqyq5c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a/zsCTBtSpLF/YAKBUU8X3oJH23OSUNmu+62Xk37C7L9dpBOB46oXAYXmQ5Pq4G0fBW+DcGm1awdAZGUI2+WfYVlQK1952ki5pa+ZXGOKLd45Olq2T/OlIIWIfDDDWbAfnP4r+NRcn6RIJhWWK8jLOzb7MwJOhKMY3vbGmzgH30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bvBDRxbw; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bvBDRxbw"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-85a4ceb4c3dso183728885a.3
        for <git@vger.kernel.org>; Fri, 24 Oct 2025 02:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761298759; x=1761903559; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DTRB46lNnCshauix7bNz4+oyyqsxKJJpO6F8T9DUnYI=;
        b=bvBDRxbwNDwzb00VsVSFIMIx2/I7E5mkRdtKwQPvmLrLk3N0uGoPVuiAmsdl3whnb6
         9iCzmDVcY5KuMu85lGkQHepo9BfUGwPnyHP2c89l23fQsKFZDIr5mKkbmpT7u4bhY9bR
         oEG0/gIQ9nPcJ+f2hlCXE0jCvgof7/9nJDOvdrLTpGz3v+HMjyzfdG16VT4KwJt3i3/K
         2rR8E706xoJkObWxkkflpjBUanE3yIG9ezkROdLmgnl0FAR0S80Ha4HPxZow6DOypURs
         O+lzBkRaYuiCMLLShsmDJI7CzFw0DzjDBxuRh5+9FUJQGTaz2O/RywftgxI4aVM2NHni
         9CVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761298759; x=1761903559;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DTRB46lNnCshauix7bNz4+oyyqsxKJJpO6F8T9DUnYI=;
        b=Q2toky4YrmhJrz0ots/HxcHRMguJs6xvJ1QNtb9Q79o/7Gc4rWs/+erWLzd1GHP6aG
         H3Ww9ai7sF61uEUobXI9cqh06DadU1KSevfMqhAqNZuiK8lHA80eMTZlmL1T4W8PkcRk
         eHAOtflna8JktqZy0wkJEUqv3lNXqLk94UABupl9qbss3r2MkhR1pruuom6KfsJLxbxo
         id3Phasgn4xoHJAoxDkMmZlr4Hjiw3isf2b4pXfMK7piktXOXZ6BrNp9KRakvpsYjPcx
         Uu/4MaS2blkLFsiTd7BwgQ520qDczeTo6rwS92+GPYAxeW8myH2d4h7AkkM77j+63560
         cBPw==
X-Gm-Message-State: AOJu0YwV0Iyo5zVg5CYNsIkDVeaA5BGqPVYfU2BBXgDUKjNW/kWXEV47
	PotNoKBCaojF0MaRChOJ17g8o/9djtw7llHvJaGxwddiz5TD6ad4tgP1YwIRgWyB78YJI6ysIRq
	fEqxpJBz0eBG+0asETt3eKVus0+DxL8s=
X-Gm-Gg: ASbGncsVShuhPt6jxwt6kDrclEdpkgsLt9ORlI3aTgGLxPpxmJy4HPZ5izKRALWLOLH
	jCBnUs4OKobSzxJCWL5YOZXPUiIz7vNo+qq3dMJ5rAS2XRDbGCVm0nBV/hIhF+NBHsd24n55+R5
	x/hskQOj2SlX7C+rqbnWUQrBRb18tfEGwZLYvtXfbZPJMIRImxz8SVtBqWe+pSY94h9BI2caCAI
	y7CjaeXMTlOCMmMA1CRzUcHfia2FeuwATdZZw1GppLBRrHOG2Ko7nL3sSOoXVFjFNwCDCw=
X-Google-Smtp-Source: AGHT+IH4jDcXvqptV0WnwAcK6ywZBqnYQVWWgVXBrlELAeIGhuh1HKjoNZPNlCgRfkRiNNGkTw8dStoFje9Qm/K94L8=
X-Received: by 2002:a05:622a:1650:b0:4e8:ab46:39ba with SMTP id
 d75a77b69052e-4eb9435653emr15203191cf.54.1761298759005; Fri, 24 Oct 2025
 02:39:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251013183311.33329-1-siddharthasthana31@gmail.com> <20251022185045.29256-1-siddharthasthana31@gmail.com>
In-Reply-To: <20251022185045.29256-1-siddharthasthana31@gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Fri, 24 Oct 2025 11:39:05 +0200
X-Gm-Features: AWmQ_blUsaZrEC_G-9qtlk9S1HdLS4acxQQCrqGemdU_sb1i4nvZTSIx6evb_Ho
Message-ID: <CAP8UFD0f030KHOJeM44k4wcxrEhFdzycvoaMtFZ-mTZ28LfJMw@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] replay: make atomic ref updates the default
To: Siddharth Asthana <siddharthasthana31@gmail.com>
Cc: git@vger.kernel.org, phillip.wood123@gmail.com, phillip.wood@dunelm.org.uk, 
	newren@gmail.com, gitster@pobox.com, ps@pks.im, karthik.188@gmail.com, 
	code@khaugsbakk.name, rybak.a.v@gmail.com, jltobler@gmail.com, toon@iotcl.com, 
	johncai86@gmail.com, johannes.schindelin@gmx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 22, 2025 at 8:50=E2=80=AFPM Siddharth Asthana
<siddharthasthana31@gmail.com> wrote:

> ## Testing
>
> All tests pass:
>   - t0450-txt-doc-vs-help.sh (now passing, was failing in v3)
>   - t3650-replay-basics.sh (all 18 tests pass)

Nit: a link to CI results on GitLab or GitHub might be better to show
that all tests pass. Just saying "All tests pass" makes reviewers
wonder if comprehensive CI tests on different OS/compilers/build
systems were used or if you just tested on your machine.

Thanks.
