Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D5A1CFBA
	for <git@vger.kernel.org>; Thu, 16 Apr 2026 17:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776359214; cv=pass; b=AqV78U/PjpGmxsuQ78xYZ16y6wMg5i84EuRtqJ7ff6y82COIuVDlYCysweiny+yesqtSbUy8FuapzG8/TsDVcwxIqqffw29hO6JiNMRepJpIvq5XdJZMh7Ms3NbtTwqEatnct/QD235PPiizYLnXQHMRfkZWSKB5pv3ZgZRP0MA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776359214; c=relaxed/simple;
	bh=rUIBw7HVCptDP1750PXC4zVPsb7uenrTNB+qyZzu7b0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=slTuSLcUGO4jEoRYqZXwPsu0sldREKLb6LRsbxKrfEgCsbMJdZy6A0HbbJNi6FZBaU28YFVcvQNpJm72qhEnN5zm0kikSQKltXwyftWIQdOLChvL0rko7AeHmJn4p3B+qJa7TlDkF0N2yb0KFlLpVWDnBpYOGkChi49TVpTBRbc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rx/W4uOE; arc=pass smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rx/W4uOE"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-79ee5037d44so14354117b3.0
        for <git@vger.kernel.org>; Thu, 16 Apr 2026 10:06:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776359212; cv=none;
        d=google.com; s=arc-20240605;
        b=gOAzoXugeXd4GUJIG7+k4YF9oZ4iB38Jy9cy8l0nnHGJ71mafUS2Z7IEvUM2Umia30
         1wJDttgdqDa+9Uf1wu4vxHeiNZ/x42Y+1Fn8q/+d78gAX1B8zdtkfVBBZq0V3fwBD5gJ
         YIyzubSJaMLFBCzymjXy1tnAk87lEQUzMnX6CQ8Mj35WIOMWpEilyB4pgs75N6qP40Cb
         GfyP9cIUgis4rrqX5tzWmbm+oPpTK96kHCrz1CfzRs+pTFTpjwGdQCCG4LW/Ld7D289F
         xExCjjsgpR6qF+ThrMjoblJMQdX5bLTmzDYtE0cQGzMar+PaSgZK9qTnd9MhAJCMtLt+
         iVdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=rUIBw7HVCptDP1750PXC4zVPsb7uenrTNB+qyZzu7b0=;
        fh=AdLvfp5rDLFEqEXBqPWoMWgsTSDK6pd8NZNu0VEubK4=;
        b=LnbK+30+iYb9IJF2uS4Sz3k57PwXELDEq1bLdNLneFek58owf+0UXZU9EmZyGI8yhT
         w1TLyOrIADnEmkEKe3bkuV34xSYv3OkAHY7abMzFwcu+pw7nSr0cE+BuC33/doI0MqJO
         pnERR9YiQg6Wf1/sHT9GTjEQ1nOGxAnowVJ2/YkoS/EQwB08RR8LsbzmcVCZInbj8WGL
         ncHssNdoWwQKhfUDfIcfXwt+LqNpNf67Qq6IxFrGT+UEFVnDHlQmWOX7EsSYT30511kJ
         fRHDc3Fdj5prYU+nDcMJWRwndMA3llCSkpX60LBxHLsUMiP73MSwWMdfZ8DExfpD9pnX
         XnWQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776359212; x=1776964012; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rUIBw7HVCptDP1750PXC4zVPsb7uenrTNB+qyZzu7b0=;
        b=Rx/W4uOEW5r60koiBExfEEgZI4TghLzrENIBt+EWuT/1T7cBQqRsTN9qMmhetzpwI8
         vP99K0374rbiuXuv0Mu+p1UyXCkTcU9sD36IYWfKU9s9VKEiLvY7o6rYLHf5kwFNVfmC
         o6nOfNnNJgdp4F4vEpuNWgyDT+kTpqCYCPbLnjNDq7DjGdFhA9mSstAHPYBZclqreyjn
         n5jXzQeQwDSmRwjlqAZzbhm/eotjcglcuPgg53Lc4JCQV1UXAG8qv8YgE5ZbZ2bgs/dQ
         vjqzuYPgoYcP0DLMRaPlN1iXx2c52cj9ZB8sc+ScNmscbhFntgUZqaG3o0KjBLejBAvG
         biCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776359212; x=1776964012;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rUIBw7HVCptDP1750PXC4zVPsb7uenrTNB+qyZzu7b0=;
        b=K5XN4jdpm4OfebErsm5rqDpInDu3iTpKw+yinsQrMj41oOwaBy1ht3cu+zUVIPMYcu
         V8m0wzQCoSR3Cb3q52mqvbfHDItX5TFWw8M6b0BqwTA5yCF3T/DcZ35zoULXnURrSH3k
         URpvXawKX8D2ApfMWEg6WY6uGMNnOwJU31YGduddoPZ5okIK15Ia+kKwhv0jSrHvmvM3
         jHWvHtcQG2lEk+o3Lf6bcvY0NB42vzrYB+oa+W56j3vUu8XR6BDOSXL09zzGjSX7BHvR
         MK/9MD4BDQxpbfuk3vuvf7ew5jK162Z/RKVefKU9snEBihmwELWcum68sV+FEKTE1xlv
         CXYw==
X-Gm-Message-State: AOJu0YzUHS5+o3ilnlI6bRMwqshxoFnS8dSWHCsGGaNuHvg6RcV6+ffR
	zltX2+LVt/rYDuyZovGbpIQZAuW5WBhRCGE0vG7MJEMrK9nfdvh4UmHFzCMKAHUivc1+b3Tkz3g
	FLRwKEgVzJBVPR0GdzztYjBzAElBzRhARFjcl
X-Gm-Gg: AeBDiesu+tA4TQ6l0J71+Yniih01X28qLC3ghFLPNUUTqgPi1vj8ro18HHPpeYS0nej
	+ImsGVRY9OX0aFrE3NNLRLLzN2ahPTedyOJNu0EQxLxnv0O9dOuiS3eBgcsp1dmTiNCs9cfJLML
	eUlm/OarB/SKYgB7p5ReGKnCBjITdAhzjhK7yr2zMM8ApPM0xSvMYyBtlDEZnMNGRduRmT9UaME
	VDbpl3tSthG5++zD9bGyM72Ro3gp+ofy1/5Kik8Q/LKiziczk0lwV4G8mT59XS70EcdOyK8x3Uq
	fnnQhBe+2LXpv0M=
X-Received: by 2002:a05:690c:16:b0:79a:da8f:d26b with SMTP id
 00721157ae682-7b9d819c8e6mr456157b3.18.1776359211803; Thu, 16 Apr 2026
 10:06:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Chester <just13.0818@gmail.com>
Date: Fri, 17 Apr 2026 01:06:40 +0800
X-Gm-Features: AQROBzAvND5BvZlc9pJncCpoJkJXkipCPOvs-KECPDg59PDaGntJSA0lEhyYN5Q
Message-ID: <CAHvvhRS9VJgyAdivR6J1Hz14jSuBJOj8Bpdu+g4fV45LRSeS8A@mail.gmail.com>
Subject: I still heavily use git whatchanged after more than 10 years
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Dear Git developers,

I saw the message that git whatchanged is now nominated for removal
and requires the --i-still-use-this flag.

I want to let you know that I have been using git whatchanged for more
than ten years, and I still use it very frequently in my daily
workflow.

It has become a muscle-memory command for me, and I find the
combination of showing the log with raw diffs (while skipping merges
by default) very convenient.

I understand that it can be replaced with git log --raw --no-merges,
but after so many years, git whatchanged just feels more natural and
quicker to type for my use case.

Thank you for maintaining Git and for reaching out to users before
removing long-standing commands.

Best regards,
Chester
