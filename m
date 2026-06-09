Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F54A15C14F
	for <git@vger.kernel.org>; Tue,  9 Jun 2026 21:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781040711; cv=pass; b=UqRnVNv29OTuF3B8HkAUzJIZZHCCpkfyXFlihuXJWm7CgvA9Luux2K5SQq21/eg1VEG2ZKhLyMLnTS0GdrTNbn4eU/5mCaXNEUGazeYrKmx6AG1niABiafxQkndE+8Wwo3oNNjHDbzfOdKqZa3yg90+HVD40W45nxCOOI2Y972w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781040711; c=relaxed/simple;
	bh=BqKCbIoFwe+nSnLSjlm4sEpkXe+SUUXVF7D0wwTDPyQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=Q3X5iTxZHYoKyFT/s/lEVYCGC+0UQiXASYpGI4enHNq1PE4Vy2pxWQyxEw4kc2vP3f0bma+NaQ45UCcnyy8aBSSRCYLWuYCdlh+3x5qODaE/OW4zU4A/xxRm7ojHSGgBvyK5ceq6OGJdpcewWVqCmLPIpBFZ3VopvYxcyAU8Sg0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r7SQY1fM; arc=pass smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r7SQY1fM"
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-6607e80a846so6113247d50.2
        for <git@vger.kernel.org>; Tue, 09 Jun 2026 14:31:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781040709; cv=none;
        d=google.com; s=arc-20240605;
        b=kJYSYwNRkmYIBSLjogdg6Gp9cW8UMjuz4j9dmyEXojUceTAfJLnVVc/KntYiWG0LrT
         9ByZwnQJ9rYAb/zAFIdRoPsyphvbjZQZQWxMgs5u778F26W0hPKUs374FoKIZp1zpEDa
         p58nz5nyAbMpsqH9o4f2q4++eiFXtujmqU1X8q8rh+bCAMuXBWZ80JDWS1PqWr9hRO/D
         tlEosYUIzhije0buls9sKvOQu4cpjrVxlTvqlnkKz+DA+YtOAifQLqqw20Jc+Fy0qBln
         jjiWslo70P886eDNsn0AbtM+4Cn7b3krQXnmSD2i9oF0xVMVI80AVsTsUfvE3t89a8aH
         XGzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=BqKCbIoFwe+nSnLSjlm4sEpkXe+SUUXVF7D0wwTDPyQ=;
        fh=AdLvfp5rDLFEqEXBqPWoMWgsTSDK6pd8NZNu0VEubK4=;
        b=WTIxyoOc1c1QLKsAdNZ7xgnhdP7zUSuVUNnEe8fbxndrVqt77G2cVPI7zkUOgSWaSz
         DFe3AwkeoseGrMiwr24gSW4fk6a4RTdGratvrvAHiyI9cXRF5fSU7wU0L1lRzWWL6I0a
         ZBYlTacql5FfkvG6H9o+EmL2W8maxdMA4+lUA4gKTLcXA7BXPflKODq7xrausPdaL4Dv
         FIZ97HJE1XxiveNLb4H9/nIF2U+pwfeRGqYrPyuNc0q32Wui2BjUxrwfpyfE8IdTzACM
         sMrJNQmBPYM41CiEVJyRml4YSDcqIXCPSXBpyRL3VZurczLwyxyG581Ddek2EW9MeqoL
         ZMYA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781040709; x=1781645509; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BqKCbIoFwe+nSnLSjlm4sEpkXe+SUUXVF7D0wwTDPyQ=;
        b=r7SQY1fMng1OvgJHRtds5LhdLrznVV6607wKhvfxCFDAOOlHI8g6jf7QIU6+wNJInc
         ZJWyTNhievcx/NMmIejkyOtB2Ehs5zTbl/+VPipZVtQZS6ezWeLj4ibdd5rNrtvkx+fl
         1yhDDCBmFxTS6hkDqq37SnfNql//iHYbefOSdXGnddRbDJsmOp7s0HWtnJhQhHyyFK3f
         XC+uOehDic1RS4xEoQXxmpthVDxt4VI4u+/V/dIt/ikfUjt5+wd7LaTwBglPPXw6kyh8
         EBa/SLdvjLnyBlf/67JBEp/CBRFJrurfrH83+49hUOXBENbwjGFUbQhfDQcwcli0ytH7
         edyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781040709; x=1781645509;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BqKCbIoFwe+nSnLSjlm4sEpkXe+SUUXVF7D0wwTDPyQ=;
        b=iagq6+6BKaMsHLILDtshkR60i80a/yhAEAkFcCxVn0qbxRpbEBuku3PkGirfwVJt/A
         46cGPqqdnYQS2q4jZL3EpYZpwt+keYz+lrBJ4+NcEmAd66bUjRwXh9payOWp4/vM7IQ1
         p2JSGE8CfqXEVfUhjbaPxYZX5zBS0zVPc43BRi5KUzZNcnr9Vye3z0e7trVCj2s637AY
         TzHil8oNJ9idH01irX3teWHlJ+uIANhqHi3fKP6GKgiOi21fcpxQuFDU1+6uN8KKXtd5
         3mjFlghSyMuIceJUv0vMpQjhtrDa9mScNCjwA/u6IGZX5OxmjwOphMAnvjx3BqNPrbtY
         hwvw==
X-Gm-Message-State: AOJu0YwW/AonxSjD1Ul1+wHVDEV1RAN2MkBryP1MZyVuwobkBS28wGkF
	k6kzNPnyl0BV3QW+sYzYMiiqDSghS9eR0GR1D9kf6HRIRCv2gbfVUjbu7vwbxjDq/jaTgctQJjq
	GTRrVP5Gwvfg3cstF862zbyjA6NIrf36xndN4RQA=
X-Gm-Gg: Acq92OG3Xc/EyksJZUZhDdygd2sLfleSv8GKDnvY/fYbhcsUxOb8Ob+qS4iQZzx6hrR
	7Xwxh6hQWWqMW9oXrTpWKpuxokhPK8/je3geYKsGO9pNfMnQlSebOtDDQn0mNCS2yPfU/TSZyz4
	8xGri9+cRawITCFCJa+U8+920RgnNTI63uoes8iJWi7qDVDl/XUAuZ6v/TDYzCBl4YNxHH6/zN0
	1qliVoA9S37U94iGFv9L5M8QeFXlyIDnXaHdetdGVY5QFSltF6peQdAa0Nw7CCfkev94RNef7Cl
	hnXy3VLkYKUWYjvQIA0/lgO31vrPsbGkVgLVtbEUBtmE3Kq+N0CzB2aFJFW/2281RxqAt/aR/Es
	7KsrWh/Q3y4Ht70dDJLU6qxZ2dvaP0DFe/DaAXhNHgVButmgtwL/X4JRafNwgAHyslJKDy1dq2c
	ci1uI2VU6Lc8C/
X-Received: by 2002:a05:690e:1514:b0:660:6318:eec8 with SMTP id
 956f58d0204a3-66106f89b2bmr18900328d50.56.1781040709161; Tue, 09 Jun 2026
 14:31:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Pablo Sabater <pabloosabaterr@gmail.com>
Date: Tue, 9 Jun 2026 23:31:38 +0200
X-Gm-Features: AVVi8CdNBag7peR6-jy3hF5d74TtDfQB5NVdqxVleW5Zz_DYJ7jjJDSY5IAbQiE
Message-ID: <CAN5EUNT1C6O+xHKfbptO5eohx3Md=h4pKRdqpY8+pD9YT_-3Og@mail.gmail.com>
Subject: [GSoC Blog] week 1 and 2: Complete and extend the remote-object-info
 command for git cat-file
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi!
I've posted my first and second week, sorry I forgot to post the first
week here as well.

first week: https://pablosabater.dev/posts/gsoc-week-1-coding-period/
second week: https://pablosabater.dev/posts/gsoc-week-2-coding-period/

I hope you like it and I'm here for any doubt.

Thanks,

Pablo
