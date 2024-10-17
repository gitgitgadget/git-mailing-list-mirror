Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C0D01D1305
	for <git@vger.kernel.org>; Thu, 17 Oct 2024 21:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729198848; cv=none; b=pUADxo4opUo1QyeexlN2R6pWGCNcOQb6lzkVA6Y4aX4h4+gVMfB8Kiu8Fv56aWJHNCVRCSuwVq11dYdB4Y5cFNY2MklbCz5qdon+gvCJmbhjbL/OXVKcatrLqAhiFyQ2HBUPZPSyj+BQSbDsLx9wmpBD60FmXtC7hKcvglDN6b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729198848; c=relaxed/simple;
	bh=F7OnDiGZr66308y4lkM3VkqTf5qiWt9Se7bScrrK07A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qD0qcdRk9WwHQLyysoR15WMa8nrdEBdJ9cgcwUERscjXktYieMthcB6JpnqeVPZ9MIh5eZtXBHvbhzvBWX5KV3DLC/tIHkCySM95tDxVDi7xNi/WVi34RH6QC0Q/mHhD2Dk3NynqArZ6HfZ4PQk3WYo+M0JMMyuthj4jQ3UWf5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=Z0idnEgE; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="Z0idnEgE"
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e290d6d286eso1188054276.3
        for <git@vger.kernel.org>; Thu, 17 Oct 2024 14:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1729198846; x=1729803646; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=F7OnDiGZr66308y4lkM3VkqTf5qiWt9Se7bScrrK07A=;
        b=Z0idnEgE3EtB5RWrmXDldgMjNPlndafhNF2Gsiy55H/2HeAkYw5BIzzbHuaIN1fv8r
         0IBiHDv6ZgM7lyrucIS65DJJOVHYNkIN2hRPY5JaRlnSCSVMrQvJ0bkAxw16oWmL708Z
         S12PBGfWULxcnor4aJmHeKCgvYjn23tCb2xTYafv8lwkm2wMtFGrWvldRH757AzIGCwA
         pF5GQVJ0aQkRa96K/uXIv3WwxvrFj7FGibf9V+MLeyvsWW+gptwDkMP5B9i2uwEW4TbT
         ekzD4VwePsNmWXiF7K5fQRfvNOTOyxzSnJHBoFF6rmbfyUNv6slXlLZnARMrK6E1vsmr
         u3RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729198846; x=1729803646;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F7OnDiGZr66308y4lkM3VkqTf5qiWt9Se7bScrrK07A=;
        b=Y+kJgVL9TUiDROn9zIEFCx4G17qmA5Bhrs4UclCqVU/lABRfPXuG56cr4P+jaEF93q
         /eLpAS92RrH/Cu+7ja2M/PzeujpbFn4UIkYIeIQA5CxM/ygShyWTAgZkDOhzazCfH7Rv
         e759WbMD2GyRecSemYgH60JTnLivHcgMjetMXc2WTMiqOklh9hNYqDZnnIJ+6BCzmjY2
         QFrLnCX5ykU//fmOykhKX8wWsrWLmI2wo3hOIzSsYg3wjzy7uMrUOFbpWkIvb5pSUs7j
         XV8ljMFo/xJpsG+VwC/Cq8jMLu6P7bQEo374n2BiKC1sqMKpjJ+aY+0udyQmxsvD7EIO
         hvLA==
X-Gm-Message-State: AOJu0Yx7q3vLh79rTKTHTMvBU7iumCauLIFCpk+RCxTWxOs8V6OFLAH4
	KoiN7RjNXQ5gVPCTwqhBwQ/tV8ar1ceLeQXFMh1YZGYHrwonMrw0Z48kravuHOI=
X-Google-Smtp-Source: AGHT+IFmz9hKY670IHd9JN6skZNp2HUdvMln/MhYtIOy0JLB4d6x0gk3fvAJpyU/WtnGp4biHRsJUg==
X-Received: by 2002:a05:6902:c0c:b0:e29:48ad:b845 with SMTP id 3f1490d57ef6-e2bb12efac4mr247485276.22.1729198845853;
        Thu, 17 Oct 2024 14:00:45 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e2bb0205362sm50793276.14.2024.10.17.14.00.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 14:00:45 -0700 (PDT)
Date: Thu, 17 Oct 2024 17:00:43 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Edward Thomson <ethomson@edwardthomson.com>,
	karthik nayak <karthik.188@gmail.com>,
	shejialuo <shejialuo@gmail.com>
Subject: Re: [PATCH v3 00/10] reftable: stop using `struct strbuf`
Message-ID: <ZxF6+ze67duAO8fn@nand.local>
References: <cover.1728629612.git.ps@pks.im>
 <cover.1729140565.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1729140565.git.ps@pks.im>

On Thu, Oct 17, 2024 at 06:53:42AM +0200, Patrick Steinhardt wrote:
> Range-diff against v2:

The range-diff looks like we're getting close here, or are already
there. Do others agree that this is ready to start merging down?

Thanks,
Taylor
