Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80BB5376BD3
	for <git@vger.kernel.org>; Tue, 21 Apr 2026 16:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776789329; cv=none; b=jPfih8xNXDmuS1xRFlqWVdEJcXSFaz3jtld1jKUBWcVr4YNLgGk2DvFBJlkaNvFQBugI4t1+vw9xoiF6Qat5NEenWI6/U3ksFqCmn8fq5y/EWEOfk0qK7Y7jXJIBVENOXq7pZZ1bEGn1R1/d4GlHwcV42mBipvqStGNCkppiCXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776789329; c=relaxed/simple;
	bh=iu8bpd8qT41XhrsmQlhwXhX5ksjbRKO9TVd82iZ/qSk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=V2WxATBl1S1P0nn41ewiPddqA/8tXcJSV7R8FlmzGSmYaDnDuUQ4DWWgTJ1ymF2mkF/gepRRkavwDUW9r0tbbxpFaTyQ5k2yG1f6y85H1OOyMn7fe+Mvlrp5azkvKQapYrRpmSi+5McHMiydm9dEB/buenxYKAVxSknaov9ye3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=oXu4fhlL; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="oXu4fhlL"
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-463a0e14abfso2225068b6e.2
        for <git@vger.kernel.org>; Tue, 21 Apr 2026 09:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1776789326; x=1777394126; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uAQCG0g5Pdq26Bv7Sg3LQqZBETuLAQ3cEPwBWA7GmQc=;
        b=oXu4fhlL5Ss27Mvwa9q6qvpcd8YMAmRPmyK0OviRIvmbXZKZvKziNaVPlMDEbA5lgw
         bISEHJh1I3rv5iOSoyP2ITC6liF0tTpBDjnTShwvmSwQt64ZDRi8BCcZQC3qGxjnwXug
         hdili+CsbLNdTSPTmupA2gGV9S3/IXcVz7lUPvSV3nTEABEXbzeqqD7b8c4SNi7VMCqR
         E/3ImHwb0XmPtO+aAGti/GGBkRL1momPwh1VpIxqA1bw/D1bgBOadk/YIXprV2bJCyAW
         aylJZERH6jbSNzMGB0n3S3I503aTMMbp+PvfyQ0mHupTVIEIwIrm2uIxk8jx4UPvOuii
         8CZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776789326; x=1777394126;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uAQCG0g5Pdq26Bv7Sg3LQqZBETuLAQ3cEPwBWA7GmQc=;
        b=lUBRiduiQyyg9EzYcExOUrWZhUTy+flm3YcAgf2qmnWsE/1kKMN55UiELSdb4siiW3
         tTttvFm5T6YJitJVaDjJmyc11Ukhbk49Of8OauxHO9t7fb2+gFggmm61H3a+jDrHdhbn
         FpQK6KV1RWWhaAy4L5tSZu3eaYeI+Y9GoKN0KxnHinKCoh3SrV/OZBmevVdtL5mB8FE/
         egIplbM4y7ozmvECxbWhJXmI5c+FQRTbHrDNb9PW0LYpa5z0ojTx/4EGlIdvaFpxKdG4
         phfPvsUA83ZQdMkCvhsQ0wcblpoijd+aWuiQzS9qvpowHWQvuQ2i159rfqiD1yk7cRFO
         fybQ==
X-Gm-Message-State: AOJu0YxqQYhQm3gf+9Eu5UO4OXFd3F5b/oKPYeywshhcvApOeYzq1cEV
	p7qOe/XPkBaKnPlaDKrtTntYOnxlIu1wtijJGcbSphgpR2fo0LPAOu7EBwW8GuHCahXpKMCGawl
	J5L7GIZA=
X-Gm-Gg: AeBDietn+mSxSoWeMe0hjs+Ibw/Ts2l30IysH80ItyxdRwA/Y9q5InYP4FJODwZ9OOU
	JNeCQKi478tA0Jvbtggt8I0rsKUT/FD2ZjyMFLLiJDyWGa2/yYVhd/7+nDFkI2tdd53nV0V9PKw
	CKCSL3pQ5KS9sgGFL6Gf1QY2sRAX21GqpmjWXrBQ39oub6tHdmY7ljbYIv7LTFOmOEuHm8prohh
	+fQ8bBGTB7//jR8oYDBugdByVAViU6+48WvcgU4jEWO/ivyLWRRrG0mXp268G2CcjUolYuOCzAW
	5fVFMup50zsJdMoch+A6WBU+NRt64eu4LAnhOqDSn/nkYqQ+hAMJblt1SKXKhDjvwxTtcBim70B
	uojHhyIMu3nY5KXeUQi8aU6x4MCUESYncCqHGY/6hml8Xb7Z/qOQtLdVt93m/ZjJgn5JUp/1yOy
	q3WX7xiVrsMn2ijlJb47GVKmXKi7dhY2Z3BEGITzP8Qp+SLjuMIx4t5d9MrqHS3QsbQN2h2YmMm
	erzsqKHk47y9cM1cjWlR7iCWc3VziETd601zasSqa4gg5m6dCnCmjPaHC/NtaARf5Kcjf2n39d9
	RKj2TeDKCK2zsHsZ0VtmtYk2pqU=
X-Received: by 2002:a05:6808:1792:b0:472:ee59:7a9c with SMTP id 5614622812f47-4799ca41155mr10141342b6e.34.1776789326184;
        Tue, 21 Apr 2026 09:35:26 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-479a02097b6sm9283702b6e.14.2026.04.21.09.35.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 09:35:25 -0700 (PDT)
Date: Tue, 21 Apr 2026 12:35:24 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Scott Chacon <schacon@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Emily Shaffer <nasamuffin@google.com>
Subject: [ANNOUNCE] Git Merge 2026, (September 17-18, in Lisbon)
Message-ID: <aeenTA8efhY6hNvt@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Git Merge 2026 is happening in-person on September 17-18th, 2026, in
beautiful Lisbon, Portugal!

GitButler and GitHub are co-hosting the event, which will take place on
the 17-18th, with the main conference taking place on the first day. The
second day will be reserved for the Contributor's Summit and a series of
unconference-style breakout sessions.

In addition, Google will be hosting a JJ-specific event on the 16th
which will be focused on the JJ project and its ecosystem. More details
from them to follow shortly.

There will be a social event on one of the evenings (TBD), which is
graciously hosted by our friends at GitLab.

Here are the details for the main conference:

  When: September 17-18th, 2026
  Where: Suspenso, Lisbon, Portugal (https://suspenso.pt/)
  What: Talks on the 17th, everything else on the 18th

This email is just to announce the date so people can start putting
together travel arrangements and to start thinking about topics for
talks and discussions for the unconference sessions. A couple of notes:

 * There are a number of hotels nearby the venue, and we don't have a
   room block set up at this time, so feel free to make your own
   arrangements.

 * Registration for the event is still being set up, but it should be
   available shortly. I'll send an update to this thread once I have
   more details.

As always, if you'd like to come but need financial assistance with
travel, please reach out to the Git PLC at <git@sfconservancy.org>.
We'll collect requests and try to make decisions and notify people with
enough time before the event to make travel arrangements.

Other than that, please be thinking about (and feel free to discuss in
this thread) topics you'd like to discuss, or any general thoughts on
the format, venue setup, etc.

Thanks,
Scott Chacon (GitButler)
Taylor Blau (GitHub)
