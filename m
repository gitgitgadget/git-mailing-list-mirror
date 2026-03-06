Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7A2330B09
	for <git@vger.kernel.org>; Fri,  6 Mar 2026 05:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772773859; cv=pass; b=kVA/ZY1x05u9hOQ8wj9XnX7gyIgmfpf2UylJU8I5iN+uP1HeKqVGfFGXpmxJyL0zlugDZ9hOoZS8bqIbwVToNLw/QjlzjqDH7cDJv1rzK5v1rIALh3kHNff61FmPG3+I7XJclqzJ8jdkiF1YAtTXyEb44h/UxAgoc84CqdRAL68=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772773859; c=relaxed/simple;
	bh=auf1yLYEbLKish4BXHUmrUAEs78XFQv0P5cG1Nb9fpY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=pFD35rG3OVkRxUGY+YFjZ1KUdq7kXuf0cMOJJeixXc16O2dRAPLy8M60ky5XIIgzPSS8xrIPISrgmD1Tg/Z0jFclv6JnNpI9dLAecokD3uYPZM7bPovJE/Q1maJD3RbCohMQIKM9O1c5zclW3uLUw/dxybFA6DCK6ClWXn/f7ho=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mXB76HSN; arc=pass smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mXB76HSN"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b93695f7cdcso1159657666b.3
        for <git@vger.kernel.org>; Thu, 05 Mar 2026 21:10:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772773856; cv=none;
        d=google.com; s=arc-20240605;
        b=OtCWksa3i0iX0WBDTg2YtaUCg5qsG5SrHS2qTvYL05PeNQ1sfGsZ+dZx7OAuiPPOA9
         drc7tNvpLcd6doD0YOqPf95LIYz1Ro6unkatriCiAvZiZr8Zi76wxt3HXRr7/1WnMLVo
         6YdYslDbdDOgx6JyZWPVO5c2lZfsU6/WmzAM/edr2xRMbsTcG3Z9beRD4eNP6D7A2elY
         88YyXdMbjuvIbwDLg/YtZV+J/Mk6T74l7l9yFCLXJ3HHUiOlWfIJNsHQ3/io8RKp60vk
         VT+Yf4MeNtSWkmL8P7tXw7bRk6NVlcVvLsBKAKbDoX910OnJhliMX/aYgM5/ekUpzNcl
         QDVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=auf1yLYEbLKish4BXHUmrUAEs78XFQv0P5cG1Nb9fpY=;
        fh=AdLvfp5rDLFEqEXBqPWoMWgsTSDK6pd8NZNu0VEubK4=;
        b=O41Ooo/uxCxM0Zn3Yb/Cipej5H1I09wIxmyPzWClCWh/t312YtDR/pAgnku891AXOl
         LQ7sqIsMp7hw85Ky3vXtibh/VLlNhYaWOmQVzU6DCuPSEFxE4kf0/7qRZT8XV/keVbei
         pRai9MgMSzhVP6UzRtMs3RsEG0jgyqw0mzHoFbrqstsjE2HMsNHXC6uR2UrqkWhuK0PH
         j1RYm0cvbhK1KTYUiC6SMCp16JGLvJHDWjigqSfOOZddbwlgjAkpE+Zpm580zpIkKqUR
         Rv4iYjvPRrm68joBtHALYqWTogAyeqcOdLyc35gP/AHUGckKzHLEsQFVZV7Cy+UfPg6Z
         EDJQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772773856; x=1773378656; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=auf1yLYEbLKish4BXHUmrUAEs78XFQv0P5cG1Nb9fpY=;
        b=mXB76HSN/eRQ80SrkQSrsC+LKqHAsA8LYojNWkcotwSgvG6F/kC2ypcLsfbzYuyc4T
         vYVj71fERY4eN4xFMX/JR5CR24z+8+CS/98xMrglYmwI9Bys0V5dAE9X5h79hJLS6JH4
         FQRK78twvgwhIIjAp2SxNiitsQLO9A+X9o0qsJ+6+UivDpqbVrP8xVmM8mVfPGhid1i5
         GYdK6SBTjA4Stnpli4DCoXsmiNUf0w2WFjYbEyycD0cH/eN4slvpj576QrBjA29CO4nN
         B3I8SQJizwybD82UTpF3m012Wqwkws/SVGYx/AU0dzrSojsAGgOLQoJJyMt+GpATgNjg
         YvmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772773856; x=1773378656;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=auf1yLYEbLKish4BXHUmrUAEs78XFQv0P5cG1Nb9fpY=;
        b=fUeeHJlBuYJMADAUaE/86bZY4hW7lvHgKHfVzqtW+40D6K1CERfKyiJVHT3CsYTvIS
         4hkUgXBmIvEiW+DZPLEXpo6xSJKo5nwRhWBDoV9pYQqvxKI/lUTW9B9q0N0nQSoJAuS/
         hfz18oJwttMeHkExwWCqzyVzOgxgfAvi5I3bjtQPN970FzUgxS09c+GeKWT/w//f+pnA
         ODEzkP6t8MhRHVY39Zt1tjVp6zpcjIsyi5EKJ6fh/QlozJYiJ9LNu1SuYbB58DErT3Oy
         w0Ai/qxd2EKGzgwfCtPonFdOf6Ojfac6UzUmq2njcmSBPKg1HIj+d7OX+hil6VuzkPjC
         LTxQ==
X-Gm-Message-State: AOJu0Yw3+jwVIePzi9+y6cV53O7irDZVC7TrMggYke8/3ZecLszB70EV
	49+upXzQGm3Or0mlEnx8CMNkQxzQSm+Kyi1QXCBanur+tAFxH6qxNi5jWIc3URSVzQIO87HuBAE
	KtY1Xg++9eWWGJ1bHSlFePXpvSZs/6QXwa97ne1kZ
X-Gm-Gg: ATEYQzwtvNx8gQVpo7VOF3GHI27Ey51ywF2VLy2CLJRBndKP9e2DyPB7PSaCzLOqW/J
	SL+SsnjUNyappEheGVyNSc5VZ2tdnoFB8uXT+GeFUCr5x6d7VpxAKL2nu/FO7sWLo8e/RUEsYlu
	pgahhlM6wRbsBFxBkDKvYqXbUfIxR2Eipqp/mtCA8NX03mDYu5xXIa1Mskov9DicuULCGTNyt3t
	YaAfQr8Pnibtj//A5zKlb2lj1UzYxCqS1Je7c/nFbw9thHhoa7y0OG8AaR62r8FgYkxU5l81Bzb
	ivvFq1bhiWyEu5CRaLrKRqGIRW9BtNzu7wmHXX7hXRxytDCSevfpfdC5+EHga38jMAqQk3X6/t4
	7KWveew==
X-Received: by 2002:a17:907:e8e:b0:b94:1f00:1ffc with SMTP id
 a640c23a62f3a-b942dfaa0c5mr38782866b.35.1772773855852; Thu, 05 Mar 2026
 21:10:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Mansi Singh <mansimaanu8627@gmail.com>
Date: Thu, 5 Mar 2026 21:10:44 -0800
X-Gm-Features: AaiRm53Ithk1unqId6QAOGslQTPlLXQFXkspqD9x1Wx4Q0xewcRYJQhSnJgZthQ
Message-ID: <CAO_P5U2f4MD-URre+4ocC=YQ570hr03pZHDk1jvuSOKx4aLOCA@mail.gmail.com>
Subject: [GSoC] Discussion: git repo structure enhancements
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

I am planning to apply for GSoC 2026 for the "Improve the new git repo
command" project, focusing specifically on extending git repo
structure with metrics from git-sizer. The ideas page mentions this as
a potential improvement.
Before drafting a full proposal, I wanted to confirm:
1. Is this direction still desired, or is it already being worked on
by someone?
2. Which git-sizer metrics does the community consider most valuable
to add first?
3. Should new structure tests go in t1900-repo-info.sh or a separate
t1901-repo-structure.sh?

My contributions so far:
- t7605 microproject: https://github.com/gitgitgadget/git/pull/2050
- Variable shadow fix in repo.c: https://github.com/gitgitgadget/git/pull/2062
- Structure tests: https://github.com/gitgitgadget/git/pull/2064

Thanks,
Mansi Singh
