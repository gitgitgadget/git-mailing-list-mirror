Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F160617CA02
	for <git@vger.kernel.org>; Tue, 13 Aug 2024 14:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723558703; cv=none; b=Xnd1aXWj1XRps59r3VMGsEA1g9fAhM5fMbL8Mw6JKcAoiIJJ8BSKzzhK2FEObZW25dJ2utSesH4nN5GXi+6Ia8+PqI3LhRLuIWhtZpGFQc/66xk2QX3xXtOglhzCmC2ZnkytBkwD7Tk/FPRnDqJoYXVZwU09x9DNn6qINtTNgVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723558703; c=relaxed/simple;
	bh=RSKzLrBEMdEVvAUU/kaFWk5nX4wL2ysCRSxT/NNs6no=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=MOurB2DdZ0w/rke2KY8HhV6WalqfZTiUFzT4Z/T9uenU4ZShxJu+QoLnPYCpC3GsYv2LWeHOvwwb7SBUksKwfvmX4wpeguuRsihSAGoDsqjDRPS7nfiHDAzO4mMyc14mvjqCc5Of55KMshn1F8/fgISS19uvXh/XVtmoqnqOqw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H38Hb7iD; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H38Hb7iD"
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-26119999171so3683059fac.2
        for <git@vger.kernel.org>; Tue, 13 Aug 2024 07:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723558700; x=1724163500; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XKSF2c6wdKPfojwrZwjGKrdAF4EUa3+BHfOvzdQpxko=;
        b=H38Hb7iD11Eax/ft2JUMGnB+81oKh4tQTUiV+TXWFxh7Vbr9GZpwgDLWShyT/0yRnv
         MFjHJ/vLAU6ygkWailTiDZumHUmZcVMAYtqzXU7HUw05f5vpNFTvx8zgjCIVPFTlt16x
         so07STUXd2L8z6NQ2zKFbrrUWZDb5W1yuOK9/gcRsojNXqgaAfOlbXxjmzC/+h8PQnBf
         W01U4EaBnBKRgL8Ax6zUCki3Mzu7Hcm00csHv0Ta3lX5XVFA8FJT6ivd6RK67sYPr4GA
         7Bxe52e5K6/rQXxZs4a9GkvfcS38zcd13WtoogjduWYgAm1y9MIY8DLPmWGE6P8lKcKg
         6VUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723558700; x=1724163500;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XKSF2c6wdKPfojwrZwjGKrdAF4EUa3+BHfOvzdQpxko=;
        b=G4KN9mJM+nId5i4wfADHbd9NO+hVDQnYtQLjO7VCP3Spe7m+QXt83ONx8xeW0nD0n3
         IrxYKWO8LLY2ELxdDKKj3q2umYRaVsx1SXVR5LkJrgz8rwAFlGkYO1qyqAUDaxdfU7e3
         5IUWMkyTvy15gwVvdaAw7gQ7r/I3gQv7bpRyVCDVPof1KCYTQNkbl3AgV34NCN5UsVYB
         8FdwF1X5KoyzOOkt/AfN8eo0A1wbiMMa4ihNxAdQaDnDPnxKraelmJjC6tn7XpagtHY9
         0Q5AZ9XEobDeNkbH1vWROm5rFD1stwvGa7ePAp/MxBoIrGFMSuqjXcSecOWs7aleVKM7
         5EWg==
X-Gm-Message-State: AOJu0Yw3AU4PwH1VizE5Y4EVLbTVYipF6dHlw+GviEK68fNOQkNO/TLc
	QvToGFVoWTTJGbGWuTVIdrvc473RmnOxhNI1UZEofcy3a0t2HT0vWH1fVYrx
X-Google-Smtp-Source: AGHT+IF3cI8Ej7k601Z7b41bjXkdWXSXW/loxF8V6Wo1B6XyQZI7SDHMJ5CBi46gUMStpZ41Y7NIIQ==
X-Received: by 2002:a05:6870:d626:b0:25e:29e7:14c8 with SMTP id 586e51a60fabf-26fcb83c1afmr4224957fac.42.1723558700143;
        Tue, 13 Aug 2024 07:18:20 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7c6979eda6bsm1462568a12.26.2024.08.13.07.18.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 07:18:19 -0700 (PDT)
Date: Tue, 13 Aug 2024 22:18:55 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: [RFC] Implement ref content consistency check
Message-ID: <ZrtrT1CPI4YUf5db@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi All:

We have already set up the infrastructure of the ref consistency.
However, we have only add ref name check when establishing the
infrastructure in below:

  https://lore.kernel.org/git/ZrSqMmD-quQ18a9F@ArchLinux.localdomain/

Actually, we already have a patch here which has already implemented the
ref content consistency check. But during the review process, we have
encountered some problems. The intention of this RFC is to make sure
what content we should check and also to what extend.

I conclude the following info:

1. For the regular ref which has a trailing garbage, we should warn the
user. This is the most simplest situation, we could reply on
"parse_loose_ref_content" to do this.
2. For the symref, we could also rely on "parse_loose_ref_content" to
get the "pointee", and check the location of the "pointee", check the
name of the "pointee" and the file type of the "pointee".
3. FOr the symbolic ref, we could follow the idea of 2.

But Patrick gives a question here:

> In case the ref ends with a newline, should we check that the next
> character is `\0`? Otherwise, it may contain multiple lines, which is
> not allowed for a normal ref.
>
> Also, shouldn't the ref always end with a newline?

For symref, I guess we have no spec here. From my experiments, a symref
could have a newline or no newline, even multiple newlines. And also
symref could have multiple spaces. But the following is a bad symref

  ref: refs/heads/main garbage

I think we should fully discuss what we should check here. Thus I will
implement the code.

Thanks,
Jialuo
