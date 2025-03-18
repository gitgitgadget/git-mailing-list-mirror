Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED3D72063FE
	for <git@vger.kernel.org>; Tue, 18 Mar 2025 22:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742338219; cv=none; b=p/xkJ2Ul1MYURMbiaRPpcCFok3SubNqREy1vWhVEt9uN9dk4xEB4vnkYXyzKzrz7XDuo/wV/d7syAMZSO9dZx1YV5U5q/ExpPrK4tLFnl1KP0DUrbtEoZ6kVhBMNEElKhawTz86N1MRQOIlIlwWe4U3leffGsQgNgueO1mRjr+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742338219; c=relaxed/simple;
	bh=2x7uAul9LTMUT+4mahHD+wDgU35EIRXAZ6eetOgZqt0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FlOJLyJT3HCI5iY5p+ACNsZMTn11q7K3yrIxjv3WoHEwBPenyrsHsCfBH1ytaFVcm64oAxl4STcykncXNSYuLUvRG6k/vOITsBLRNIcpLcL8/Q8p+rotk6w9jFEId1H/7REDrVuRkmQIKPZo9qR+VWDY9LhhOS0mIbywl9WNSjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=lQXHv1Ru; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="lQXHv1Ru"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7c58974ed57so324315885a.2
        for <git@vger.kernel.org>; Tue, 18 Mar 2025 15:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1742338215; x=1742943015; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=g5dvccv93SrH/1qLljpuVv2S5Py25wnhrgMoKpDvkbQ=;
        b=lQXHv1Rua1ExFRwxLrmjtdoTeU1IbDk6QE+Bq3cl9s+0D5eUBj4rw9nesEcSE4oClW
         6Lhd8C3qi/75N340OaJeFLho0f+bxJu8eKmKq2TlsevfDnIdScXmI+ZyuA0haeKd59O0
         9TBKj25VkgnyYFD4yuRyV2CrG6IOH5qKiGFN2ek74kVar/Wg4UVg4BuoPWucMxnEmE/T
         BGuEwnUyroGzX5WTG4KUf9DDT9AXjN87HaCLjlCM0niJAGOmMhWlI61805mSlPXnXBI0
         +XI9gWN8e5VOJEqsiTYQSUoJFr728LahyO5XP9aZY0+SWqfA00QiXY0DJjw4Qpt27eYN
         PMKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742338215; x=1742943015;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g5dvccv93SrH/1qLljpuVv2S5Py25wnhrgMoKpDvkbQ=;
        b=vnS38aKBhKw6y3B7lthqNea9wVZFYVEhDJQe5CJFMl+dGm806vAl10eE+9Es7g/K8q
         Zo/vXUcmy8hBf0T2zT3In+Cjh5fPTIPpUi5MhXoLRbHXMs1Riz2HxRKqglX51D0+8ZJk
         vQxq/fNXgjFxA5ibIYtSxslRdfhan/wcjTMAs+7VnwPlboC2QWqtP+/VWItDU2vqN/aC
         dHhqcEKDvPm+t2uqaBYVxni2YZxkMmxApCthdWcMuqaJGGNase3vzXm98Pv+UBsoKW6s
         WR/x/cXhwx3lYqoIF8FHd6op8OF1Pc3IplKw7qg5ydZgTDK89SZA5p4fmB3YvnqQTvWE
         SF1w==
X-Gm-Message-State: AOJu0YxaVMrvGWC9HKd5V8madr4zGIVWF2AtCmW5qCycCi4xdLYAmJyk
	1gpGujYNeMSYvSkYKyhBjOGZ16emP23dEf9u2WX5ElImWr7g9Oaax00ZjS9zxKam+NHHig3Z9K2
	K4+I=
X-Gm-Gg: ASbGncvXJ+kACPMoAfUNXReYUX8zHdr3q481yP61tQLhV1sAVsYRKub2JA+wbnOSrN5
	dE7Epw6hB0YOzixWtovvC7kOYtZ/k6TB0s4Lm2NLSxmKn1SsVNbtX2IbydYmDJLdgmwL5VhLmax
	iUpOFW80u+VtBW8BHOm7jlAM9yMcbS4yOOWIvV3bBGqOMXqgfXcni6g5F/duohsA/5Al1NlQ4Zy
	QmhFhiPoARh8o3w2tmooX6YY9Ylh63f2/ONHp79LKmgRAPmyYW5ksyhLr5bGcvP/qqVxggRE3vM
	6/ar0ShQms2bx0OfCn7wjICK9xmduOpoOqJwenqXhEPUzb12vFsG87hDw9BCSIEqVHfQcesrZmq
	ygT4y2JByFAyG6MqJMbZR9vxa5dk=
X-Google-Smtp-Source: AGHT+IGN6OzhTWlaqgtEfcg5iSZHSevjeRKf1YZHcrrTI9O1kSHKouy6STHYJWuaqTX2Gl0EQvVtTg==
X-Received: by 2002:a05:622a:4d4f:b0:476:9548:4734 with SMTP id d75a77b69052e-4770829158emr11664391cf.6.1742338215552;
        Tue, 18 Mar 2025 15:50:15 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-476bb611dbdsm72413691cf.4.2025.03.18.15.50.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 15:50:15 -0700 (PDT)
Date: Tue, 18 Mar 2025 18:50:13 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Igor Todorovski <itodorov@ca.ibm.com>,
	Bence Ferdinandy <bence@ferdinandy.com>
Subject: [PATCH v2 0/4] refspec: treat 'fetch' as a Boolean value
Message-ID: <cover.1742338207.git.me@ttaylorr.com>
References: <xmqq5xkdrrhs.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq5xkdrrhs.fsf@gitster.g>

Here's a small reroll that cleans up some wording in the first patch,
and drops the accidental inclusion of a stray 'git-diff-pairs' binary
that was sitting in my working tree at the time of writing the initial
commit.

Otherwise the series is unchanged, but a range-diff is attached
nonetheless. Thanks for reviewing :-).

Taylor Blau (4):
  refspec: treat 'fetch' as a Boolean value
  refspec: replace `refspec_init()` with fetch/push variants
  refspec: remove refspec_item_init_or_die()
  refspec: replace `refspec_item_init()` with fetch/push variants

 builtin/fetch.c    |  2 +-
 builtin/pull.c     |  3 ++-
 refspec.c          | 38 +++++++++++++++++++++++++++-----------
 refspec.h          | 18 +++++++-----------
 remote.c           |  4 ++--
 transport-helper.c |  2 +-
 6 files changed, 40 insertions(+), 27 deletions(-)

Range-diff against v1:
1:  7e662acb5a ! 1:  04e1ab8209 refspec: treat 'fetch' as a Boolean value
    @@ Commit message
         refspec: treat 'fetch' as a Boolean value
     
         Since 6d4c057859 (refspec: introduce struct refspec, 2018-05-16), we
    -    have constants called REFSPEC_FETCH and REFSPEC_PUSH. This misleadingly
    -    suggests that we might introduce other modes in the future.
    +    have macros called REFSPEC_FETCH and REFSPEC_PUSH. This confusingly
    +    suggests that we might introduce other modes in the future, which, while
    +    possible, is highly unlikely.
     
         But these values are treated as a Boolean, and stored in a struct field
         called 'fetch'. So the following:
    @@ Commit message
             if (refspec->fetch) { ... }
     
         are equivalent. Let's avoid renaming the Boolean values "true" and
    -    "false" here and remove the two REFSPEC_ constants mentioned above.
    +    "false" here and remove the two REFSPEC_ macros mentioned above.
     
         Since this value is truly a Boolean and will only ever take on a value
         of 0 or 1, we can declare it as a single bit unsigned field. In
    @@ builtin/pull.c: static const char *get_tracking_branch(const char *remote, const
      	if (!*spec_src || !strcmp(spec_src, "HEAD"))
      		spec_src = "HEAD";
     
    - ## git-diff-pairs (new) ##
    - Binary files /dev/null and git-diff-pairs differ
    -
      ## refspec.c ##
     @@ refspec.c: void refspec_clear(struct refspec *rs)
      int valid_fetch_refspec(const char *fetch_refspec_str)
2:  fd2354dade = 2:  c3021b82ce refspec: replace `refspec_init()` with fetch/push variants
3:  49b470de61 = 3:  88f6a91c46 refspec: remove refspec_item_init_or_die()
4:  95783265fd = 4:  f0c323988f refspec: replace `refspec_item_init()` with fetch/push variants

base-commit: c702dd48567cfebca3d4a06b691de97da3f8dc4a
-- 
2.49.0.3.gbb7a4a684c.dirty
