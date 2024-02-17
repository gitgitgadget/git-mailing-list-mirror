Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100A033CA
	for <git@vger.kernel.org>; Sat, 17 Feb 2024 02:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708136412; cv=none; b=UTxT3yeHgcvYDbnjH/v547wV/0whp2ZtLmmZMWY5payOb9E1jCg/usiWSrAThOTNu1s+vkn5aK5Pvg+ABUPuU1+1T4xF5u3LitHBrVWyA9dr/czsIv8s2tbHd+sp7YKGZidbBc8S3VqPq2U3lgLcaODykLRn67arclQv4coSMlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708136412; c=relaxed/simple;
	bh=T8WqthVSGvjyNeni1zjXUNSxgxIYp+pPBs026aiR7uc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=UMLkrG1Z7F2hgmkKM3PMlH9m26ozKPdYqvcidDZ1esVuSxmhs0DIdIQosIMur7UDlkT13BMaZ/8xF8lAYJbp7ehMUVgbd2JBlrVFWTQjgMgGc0K1E2NbpSMcwCKCbhK7eWAZHjOMzMbNix6V37yNHSj8OybXy62cV37G837mzt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XH5OkNFr; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XH5OkNFr"
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5986d902ae6so1387740eaf.3
        for <git@vger.kernel.org>; Fri, 16 Feb 2024 18:20:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708136410; x=1708741210; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=T8WqthVSGvjyNeni1zjXUNSxgxIYp+pPBs026aiR7uc=;
        b=XH5OkNFrKfcPnYkV6hBcM0zBAy1TQVZCiiiHaAzZ6pKpAy6l1RzANZVK3gVPwYaapK
         ki1XIQmmU6T+ep2rg21ugc8CMEZOfWG5r80o12KgANZ54WTMlY4jz7HLbcKqvgVu25Ab
         uhvD7CEkoO9VZ7LxNehEa2Wcn/3SAaEcwQGtt6kdRotAS7eGqhtDuuq9LcwI9oSmqxH2
         G4L17G1ZS++oG2BVMlrILABA5Agkx/4yBZ+CRyMHGjj6FxnHqN6lb1p/pjuElMFLt9O5
         /JcW4kHqQ1iLBhRlj3xzb8CvMnLPwxtNh7VY/uSpceH4eK9BVJ8k4tYneZqBW/NsnpJt
         A8Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708136410; x=1708741210;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T8WqthVSGvjyNeni1zjXUNSxgxIYp+pPBs026aiR7uc=;
        b=NXO6xPY+hes85Adm5U7IjDRktHv/rbzQ3g76qLt9APxv6qolxDkismCHE16UDnXycF
         JkGpLUqR+feWr9q+EbAKYLy295DZqvmptRIrwtCUpi8B09p52GLMfLo6sM6JCkw38Xki
         o8QTceW0e0yxtukWOS/BOgHIkwPVYlvc0MFO8zOkyh54MMboM7rQmn6Q+bRxvXLUKaG/
         ulaFhiIYVy7tyaOqlySTIPzni91pPZ653WL6iAFWNWEoEfqWRMQyGQxcUutbwDXkMuoR
         w0W29IotHny7di+epFf+Z3Q9p5CpqI45SWN1snm7RN9HSVNv6Dn1ioV7EzeaZxrDSZHr
         45Yw==
X-Gm-Message-State: AOJu0YyrPLqpHg2T2hlHBcId7am1k4g3W8IJ3xRR5OgfSBnupZGmGTF+
	484RVIuVsa58gttK3OJ8MjaxnHnZ2NgCuXpWpfhKhHxxT3SHjroe
X-Google-Smtp-Source: AGHT+IHuQSeKmLkivP4DpHbzQROwtqErRVLBnu+3r54Cqkk6gIozxtRCFDSrP2Y3SWnq/WrQI0F+OQ==
X-Received: by 2002:a05:6358:d59e:b0:178:20ea:abb5 with SMTP id ms30-20020a056358d59e00b0017820eaabb5mr7337797rwb.26.1708136409801;
        Fri, 16 Feb 2024 18:20:09 -0800 (PST)
Received: from five231003 ([2405:201:c006:31f8:450e:7680:74c4:3500])
        by smtp.gmail.com with ESMTPSA id pf10-20020a17090b1d8a00b002992754487fsm667195pjb.5.2024.02.16.18.20.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 18:20:09 -0800 (PST)
Date: Sat, 17 Feb 2024 07:50:05 +0530
From: Kousik Sanagavarapu <five231003@gmail.com>
To: Todd Zullinger <tmz@pobox.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] RelNotes: minor typo fixes in 2.44.0 draft
Message-ID: <ZdAX1Sfiq6gJCoEk@five231003>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240217002806.231340-1-tmz@pobox.com>

Todd Zullinger <tmz@pobox.com> wrote:

> - * When $HOME/.gitignore is missing but XDG config file available, we
> + * When $HOME/.gitconfig is missing but XDG config file available, we

s/file available/file is available
