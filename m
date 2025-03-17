Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B4514900F
	for <git@vger.kernel.org>; Mon, 17 Mar 2025 23:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742252419; cv=none; b=b/ErpwZXH584IC98SbpsTyWjOpqqfrGaTCSzPaNor81qzJgkEci1uTydvEoM0EbDjgc/GDwiULsPIlvShonr/rnZeDsS3nd2Cq4r6ouZv+UjOLojxMqV++KZ04C6xRvHI/JIWrmhWHMWOY3kS+t/EL8uPQAvWKqqGo3qiWWyeDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742252419; c=relaxed/simple;
	bh=Y5ZvPs7FBnWutXoqBkeqog7BfaugW8GG3+Ol/8zbLkI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=tLarPLMjQolzzBwakenIQwLW0DXGnUQ0P3pfuMu9f5sIKJq2P9aD26zhyAbZ10DkCiaySx4KNWct2fREiZZ7FWYsjiEEUyZrJNYsewklaHQZrAASZCWpm0LcLpT4EhJTHHHrq62hhemJMuHxRb208HuIGOK3Vla9gdMvpAUN0xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=SYjRk36M; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="SYjRk36M"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7c24ae82de4so566996685a.1
        for <git@vger.kernel.org>; Mon, 17 Mar 2025 16:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1742252414; x=1742857214; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xPXMrQ9d9fpA/SvqrVvv0hMEs4igc11pbFKHLXjL4ss=;
        b=SYjRk36MzmKdpc6b5kc5YVIlF8otLWpB/KrxdoonBAdISRuGwo5WWXtYhpJumy6Fiq
         8eTUyS+y9di7yslex3xRZO+IpGTIb3P8pO99JUff2f/1+lx41tQCavBEjcpTk0+bPTen
         2tfT7VBKsZ/gv0kM8ERd9/2ZZL2b9ag7hD+VxrE57XlqD7ALyvfbwDotX9q/PbdzpX/2
         3sGXeCu22xecae3QrRcZ8Vi5OODZdWOY0PRa4unmWmdCTxAFWg3TDTAbVhkqcfCVL+Zp
         z0HwO83rG+XTtZ0GtIW4ApXeQzUKkf/rkipHFhs/DWe++7YviwQg1WKTINkzSIcPuwnD
         3dbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742252414; x=1742857214;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xPXMrQ9d9fpA/SvqrVvv0hMEs4igc11pbFKHLXjL4ss=;
        b=ZO2YRiSEpU8Arpy8ltsNKk/IoVHefok/tDE+wZEbdR75ZQWef7/VJWvCdthSGR4FfP
         QIntet8BD1wqhDWqrjYs7Cq0cCmo1ni7q+NA8USauvy0z22e+lkhJOppxiCjNJyVdxm0
         V62tm1KQvhQX+Y0OkMcUSSItPkfSrLLQO+O+MO75DgdSfWX6+Z/GeJg8Wa34pjzKYYVy
         5QADOmoFW/p6bgajMR43KHBRSpxCtwq2sElzSMXNT+6MwruLJw6ydbUInEogbiS8m4Al
         LSaQXLGqp5ZTYJspfioz2tvaLltslolEWua53LORV0I+ioYDCLoXZdkZVyB7lSjCysTW
         +mrA==
X-Gm-Message-State: AOJu0YxT6WTbNlE3swuGWs6Udp2fyZNaxgKnRPQun577tnTBRjeU8qnw
	0RSxpbh7+SfVpkB5bHQTxknA4+z9V7MzQS+euqSjL+S9/Vsb2bGP5C57gEndYT4um0WL7pjzvhW
	7kkg=
X-Gm-Gg: ASbGncvMBHY/IoKXSKikE1CAh6ayaSP1ho8zl9vfx0I6B4cXeqPiFOGWc3ElV4UNDjE
	Ci0oiE5kOMJjaFj+vYC+4l6Pl7IdqGGgdywlCIiW5wTxljJzd4kGQSJnHdhfV+NrKz86SOzoCvd
	PsaNEl0naSwN5khx3DKJDqZEI79TZwvzE5V2Y3Or8iqpLLb//QQt/3uDb1+g1xK42EH2T7FOX7w
	Ydd+79mxofFiVkruLMDFAfSQ0Vm/jpTqQJz22nUz098jaz47NP6jI9YnNWrEBXERqJofbfgVMnn
	zYrFGnlPjFZQm02hFAy5yYvY/APhuGAmaYkgkmXWo4MpSwUWopXYMw3DgAra6rcWNflNe7c4yyj
	Sv+bs8nTrxOS2qIdk
X-Google-Smtp-Source: AGHT+IEaKRl6ZaT6g/2ZcCP4/xZmd+XkerfGUHqLfix21dDrns1Y0k5PiB9q5uRi8oda01dHoXh0Xw==
X-Received: by 2002:a05:620a:4726:b0:7c5:5584:dc1b with SMTP id af79cd13be357-7c59b2c39bcmr252419585a.54.1742252413969;
        Mon, 17 Mar 2025 16:00:13 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c573c719f8sm639481685a.36.2025.03.17.16.00.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 16:00:13 -0700 (PDT)
Date: Mon, 17 Mar 2025 19:00:12 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>
Subject: [PATCH 0/5] repack: introduce '--combine-cruft-below-size'
Message-ID: <cover.1742252411.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

(This is based on tb/multi-cruft-pack-refresh-fix from Junio's tree,
which is at 08f612ba70 (builtin/pack-objects.c: freshen objects from
existing cruft packs, 2025-03-13) at the time of writing).

This series replaces something close to the existing behavior of
repack's '--max-cruft-size' flag with '--combine-cruft-below-size'.

The new flag is much clearer in its intent and function, and avoids the
lack of clarity between the two that was discussed in

  <cover.1741648467.git.me@ttaylorr.com>

The new behavior is as follows:

  - '--max-cruft-size' is a cruft pack-specific override for repack's
    '--max-pack-size' command-line flag.

  - '--combine-cruft-below-size' instructs repack to only combine cruft
    packs which are smaller than the given threshold. This will likely
    result in packs which are larger than the threshold. But that is OK:
    the point is to limit the size of the individual packs on input, not
    the size of the outgoing pack.

This series does break the existing behavior of '--max-cruft-size'. But
I think breaking backwards compatibility here is OK, since the existing
behavior was so broken to begin with. I'm happy to consider other
alternatives if others feel that this isn't OK.

The series has an interesting structure that I feel may be worth calling
out. The first three patches are trivial test cleanups. The fourth patch
modifies the existing behavior of '--max-cruft-size', but does so while
keeping some of the old infrastructure around.

That may seem like an unnecessarily complicated approach, but it greatly
simplifies introducing the new behavior in the following (and final)
commit. I think that this results in a series that is a little easier to
review (since we don't see a ton of code being removed in one commit and
then re-added in another immediately following it). But if others feel
like this was a mistake, please let me know ;-).

Thanks in advance for your review!

Taylor Blau (5):
  t/t5329-pack-objects-cruft.sh: evict 'repack'-related tests
  t/t7704-repack-cruft.sh: clarify wording in --max-cruft-size tests
  t/t7704-repack-cruft.sh: consolidate `write_blob()`
  repack: avoid combining cruft packs with `--max-cruft-size`
  repack: begin combining cruft packs with `--combine-cruft-below-size`

 Documentation/git-repack.adoc |  20 ++-
 builtin/repack.c              |  62 +++----
 t/t5329-pack-objects-cruft.sh | 302 ++++++----------------------------
 t/t7704-repack-cruft.sh       | 293 ++++++++++++++++++++++++++++++---
 4 files changed, 354 insertions(+), 323 deletions(-)


base-commit: 08f612ba7000bf181ef6d8baed9ece322e567efd
-- 
2.49.0.rc0.6.g7f120c35e9
