Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6BB72F56
	for <git@vger.kernel.org>; Tue, 29 Oct 2024 17:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730224127; cv=none; b=T2H+UudODs+Ev6oABtHJxUrHc9msft1YJ3zvbas79LOTf0667F4aCyTfVE5f7MUEcjl0liq3Y7JwAmbnpAuNrEo+OdViBb67axN13uWiJflu0BPj6C+f5f5rngQ8oO1fJV+UGBUxnMWt0Ag3sEeg7IAGSVj4ovGDkGmZg93V03c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730224127; c=relaxed/simple;
	bh=4tTe45CA91d0GbIgN0uTSZEf0cuRGuJTowk/DLz8tYM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FAKpFZGQ1c+FeYznuh+UFx4DsPE5lIPKqhKUx62SzDNadLPa77B80sVwRylagUtpLV+UknGnDJxMLVtX2emW5h8POeKiY+pNkD8MxfVmKPgDjgh9ehn3dkwswwIFX+GzHLaMDci3glky0g4QUgYPCi0hI+F9ilZJcJ7NM3nDl7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=FS441aWm; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="FS441aWm"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-6e35f08e23eso52219687b3.2
        for <git@vger.kernel.org>; Tue, 29 Oct 2024 10:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1730224124; x=1730828924; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4tTe45CA91d0GbIgN0uTSZEf0cuRGuJTowk/DLz8tYM=;
        b=FS441aWmtB5ZpSnJcuEl6DtM6QUV+9+IrBZ+TmOCY4lRHXN1P1iueBt+ljKICz+a20
         B02xMv34cnvFHdV5uwpKgAD+rzt3z2ohJClA+wYgh7grlBJjeVFl4Cmfu5GNvnZXWSq0
         YvJtu3Z8+DznKmziATcNkCGfpVPjHg174409BEMkt1IoAip3ZR5TVgRsxGcM6C4AcZT+
         4MZNIH4zmLm9nypVPmytg7P0zEWCDNO5WE6rXIjvFDjoy3LorYYDqm1KL4pj2QMwXcMd
         h8t1gkYHpF5FRb053eq8lO/P7Bhndc5BJ4CIP16RFkyjssPdEzeqohIsVpJMJo39Z5wn
         p7Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730224124; x=1730828924;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4tTe45CA91d0GbIgN0uTSZEf0cuRGuJTowk/DLz8tYM=;
        b=U2zMDh7a57jKVOaouHjNDqo5lZcKRgtRSVm6KzAYl95QJVWVXPeM2OsQ3jO7T+Tj9x
         6HagAWSQepHb1vq5Ft9dEH5SAJp8XTyNGy9Ea7AUBHkjJLIZeFsvoT2TovzhgikzAvlM
         QNcLfZ3PW+tQ56DQEnreypKDP/ElGpd/iopileaoFPgPmSQ0EkQ4vNTk10SYt8BE6Yna
         abMpB8sK6BnxT7GP8fLZqD3WlNDoKJntCSKg7Ru2ggUxC5LuuHaH0Jlh8QTEtGKk8G1O
         OoaXtRzGU+gf+Vi5CHtb+mH4NK4kRoHNlfHtdZJKq0SUPucsrWKcv/e/Ad8cH/6pEkDp
         FpOA==
X-Gm-Message-State: AOJu0YyeuxsC6ayh6uLxTZve0VFAs+CS1qBTyfIDI66B2pB2cf0m5/lh
	nhC/yif3ODxUqimZ/Uw5oKDN5/MuTPAIqgNzJtEgKJSg3X8zSjkdH1utI4AvfX0=
X-Google-Smtp-Source: AGHT+IGgCi3Fo9y0L7O2lEayM3AR/2ILnuN913cm4VK72/NSE+sAPoa/XutZY1ZhqRUAlVer9RVV1g==
X-Received: by 2002:a05:690c:89:b0:6ea:3313:fa2d with SMTP id 00721157ae682-6ea3313fd13mr23870527b3.39.1730224124688;
        Tue, 29 Oct 2024 10:48:44 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e9c6bda2b5sm20839127b3.33.2024.10.29.10.48.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 10:48:44 -0700 (PDT)
Date: Tue, 29 Oct 2024 13:48:42 -0400
From: Taylor Blau <me@ttaylorr.com>
To: karthik nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 8/8] config: make `packed_git_(limit|window_size)`
 non-global variables
Message-ID: <ZyEf+v54XuJCyQOV@nand.local>
References: <cover.1730122499.git.karthik.188@gmail.com>
 <e99b1dad549bb1e87011d8722b8582172390aa04.1730122499.git.karthik.188@gmail.com>
 <Zx+/rEB8RklP359p@nand.local>
 <CAOLa=ZR5=Zf59Eu7VyZdiO=8LUmoEKMJk4Y1X+iog0VzLh2yqg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOLa=ZR5=Zf59Eu7VyZdiO=8LUmoEKMJk4Y1X+iog0VzLh2yqg@mail.gmail.com>

On Tue, Oct 29, 2024 at 12:09:09PM -0400, karthik nayak wrote:
> Thanks for the thorough review. Appreciate it!

Thanks for working on it!

Thanks,
Taylor
