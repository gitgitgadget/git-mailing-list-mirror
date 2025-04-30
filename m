Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8213E145A03
	for <git@vger.kernel.org>; Wed, 30 Apr 2025 21:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746049731; cv=none; b=SPska4I3Uoq2VyAGi4cWLbH/ks4boJn6nqpy+xGrzl5WJXvMeNEIwAh6AS85GqYbJfIi0ryaXi4NfCbpLOZBty7EKAHX8xZs/+m2s+fWhxx9MArL77eOJpBzFk4RE9BCTfeoy1er9IaHq5MLVz+4E24cjkZfC+/PSKR3F8+ev1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746049731; c=relaxed/simple;
	bh=2flx0q0oqOSo7avRbBh/wJBo7CYL8icRfEvXdHwHTtw=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gA3xMzXdAnDcHWEPcJ9QyAOGCiChetCus7Bv65IS24fT/9NmCCTi6WIfJDO2RyZFgV+kGXCg2IXNchiV+DGNxEquPvdKHyBq934vtBvdv0JS66cyLQDyUcFXfmzPnn+DcrnWTGkC9hLM8MhMvZNQvZCYmiN1OjB2uUk99EVr32A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=E7IYIspY; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="E7IYIspY"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7c58974ed57so33961285a.2
        for <git@vger.kernel.org>; Wed, 30 Apr 2025 14:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1746049728; x=1746654528; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uQQlTP/6ckM5Xq3Y2C+u6Ucb3LC8bME9tGZfGLYI5oY=;
        b=E7IYIspYSH2wbmj/Z/ch+5Aiu2Es1qNy/DMK05jsGlDvZ9QdHilzmTvoAPrPtwWG8Z
         SvhfP9kRMGQhBWi6/RqwrrqdgcTvt4rKRpEW1s9k4ukp4t+ZhqcH8I+0hLfB5Ocpwlmj
         2XuXcM/8+11DYpqd44nyWIyNeGzOXXTh8z6VGt3xt+CVxfiKYA7aFG9Mh8pXeyyD9b2v
         FP3kEXrfqpGUP9vZUNXOPOsHW/C7KBgQrih+zfnRPugiJRVE54hanfwwrUgQFdGuyd3p
         c1t4qnax+CVZhvWjTWXzQoVV0C30VdOELUzGuC0CJxmJuz7Gz1l4qmH66f0NtOWijYEW
         YOMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746049728; x=1746654528;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uQQlTP/6ckM5Xq3Y2C+u6Ucb3LC8bME9tGZfGLYI5oY=;
        b=swq1Ht4Cy+0zYwCwZdAxF0AkMyfHrQXfX6iTGmRn/Pgd7VUn1GBeqqkl1uc7aWuBd0
         CSNCEBdSB25xzQHmJAzxCjRYZRWkFmsRZqijjSGfW84eQJZErQ4tIQnSE9QXpFvuJoAX
         +rAryeQfbOauzTsJ8vCgQr+DhwXOIirG2gKgXiqKvhIfKy2cpncK5fVIf95wnJPRYhYc
         +U6sMfohBtx0QtAqK1oBQ0M/9DD1S7W2Sgv7aOZYjuqhjIlC4NqK+8rxdjOtoEF+gTk3
         wSFFt2Ox3xEdelKOdWQ4LVSx89bqwiSrhKnFYtRHzQv5G/o78WG4jAMH/JbdqIAytXg+
         NKsQ==
X-Gm-Message-State: AOJu0YyQNwCl5smfJNlYdJi2NpqpmECcAkGSAsgInY9kNUs885Tp5sd3
	VUpjjwusSBYNjJpk9tJ9MnrcmK8M+Y6qHUmRAuE35qUkVLkF/Mr/2BrHLp/Wl4sMOu7LR1H1mOx
	I4a8=
X-Gm-Gg: ASbGncs3PPIfsHLKEItg3T10Jpm04yoXx+qDgJCiEnUidgHJM1wRfDjELYVEUydDAAW
	ppSdZpqGnFJCQyI8q1x7rZUZXNGRVRUqioyXoQKXyYxWUayXdiw3hGZQ/jbTynLVmC10N7EKpXD
	LVmmNN/KZfEsyNkztDj3lYIVYdFhAlqSrhCRlWn9B8xPb6LlK0wGScfwfmpz3N4Lc1S1gga3tua
	0Bs2q4qG2ndzfpeXjmWccn/cQb70d9DiA7w8qzI/zwMQcW5kRFl3R8ZpraDmqhkHcr2BOthf7Kp
	/3i//gTzqqHcRU0D4EwqxsShBIj/g6300aLtbmJorvNKAUWoQp30EJ/ZrlUIr5CwDXbOLC4V93E
	S4mvksMo/PZdM
X-Google-Smtp-Source: AGHT+IFrYiHKrL7SvC7PfHiJlKUup8XEsOZgq5nzr5th6oF1uMaNEgZNxeYezpdlAOpjrbEkZxW5og==
X-Received: by 2002:a05:620a:2a0f:b0:7c5:3c0a:ab7e with SMTP id af79cd13be357-7cac74092fdmr786681085a.5.1746049727925;
        Wed, 30 Apr 2025 14:48:47 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7cacdee090csm10721685a.72.2025.04.30.14.48.47
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 14:48:47 -0700 (PDT)
Date: Wed, 30 Apr 2025 17:48:41 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Subject: Re: [ANNOUNCE] Git Merge 2025, September 29-30, San Francisco, CA
Message-ID: <aBKauXrGU8cMVXVI@nand.local>
References: <Z+L3Mt58n18KUNzs@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z+L3Mt58n18KUNzs@nand.local>

On Tue, Mar 25, 2025 at 02:34:26PM -0400, Taylor Blau wrote:
> Git Merge 2025 is happening on September 29-30th in San Francisco, CA!
> The Contributor's Summit will be on the 30th. Here are the details for
> the main conference:
>
>    When: September 29th and 30th
>   Where: GitHub HQ, 88 Colin P Kelly Jr. St., San Francisco, CA 94107
>    What: Main conference on the 29th, breakouts and Contributor's Summit
>          on the 30th.

Since announcing[1] that Git Merge will take place this year in San
Francisco, CA, I have gotten feedback publicly and privately that there
are challenges for those who would have to travel into the US in order
to attend.

I (and my colleagues at GitHub responsible for producing Git Merge) want
to make sure that folks who can't attend Git Merge in-person due to
travel concerns are still able to participate.

To that end, here are a few updates on this year's Git Merge:

  - We're **welcoming remote speakers and attendees**. If you are
    interested in speaking, but weren't planning on doing so due to
    travel constraints, please consider submitting a talk proposal to
    present virtually!

  - The **Contributor's Summit will continue to take place on the second
    day** (September 30th), and will have two-way A/V equipment set up
    so remote attendees can participate.

A few more logistics:

  - Tickets to attend remotely are $0. If you have already purchased an
    in-person ticket and wish to refund it to attend virtually, just let
    me know.

  - Likewise, if you have submitted a talk proposal but wish to give it
    virtually instead, please let me know there as well.

If you are travelling in-person need financial assistance to do so,
notes that we will **stop accepting requests for financial assistance on
May 15, 2025 end of day PDT**. This is so that those who have open
requests can get a decision sooner rather than later in order to start
the visa application process. If you are planning on requesting
financial assistance, and haven't yet done so, please consider doing so
ASAP.

I am sad to not be able to see everyone in person, but my hope is that
by offering options to attend and participate remotely, that Git Merge
will be more accessible to those not comfortable traveling into the US
than previously.

If you have any concerns or questions that you wish to handle privately,
please feel free to contact me off-list.

See you there (virtually or otherwise)!

Thanks,
Taylor
