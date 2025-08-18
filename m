Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 205282C859
	for <git@vger.kernel.org>; Mon, 18 Aug 2025 23:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755560740; cv=none; b=jnvTaKAQ17JIBMuXbIxT+6a80E0zkFhSRrVadPjb4v7LtaU5z/qA6hZrwU/DeJJBD4clxTzt5lRh5w3z9m5CYSvunirLs7jO21QiS75o8dBg64hZQb9hIP4FgONGgFQ7CHpYqUIFbf97GPUJuuNse3Qu8MsvwAKV7gz76XlWuZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755560740; c=relaxed/simple;
	bh=mxWIYMGtp8769Fp9TVrRT8gyVI8E0wpQdiJoRFKX0HY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=LhByiC81/JFOVGxUcdkuTA43BexrBD3MqU70srwZ1AekWXJc2V4OEk9M+E2MdX0I0IhIlTR07bDuGQC+ayuOTELJTuDbBaKHSh+fIUyh8CMOgXreIK+94EugKGv6y2cI3KczP94NmxNwXLPxP5AL8vWOG+nT1EJ1xlIzeGRvORE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g1d9/u+F; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g1d9/u+F"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-618896b3ff9so9222396a12.1
        for <git@vger.kernel.org>; Mon, 18 Aug 2025 16:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755560737; x=1756165537; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=O1S4PAvWX3NjKh5NcbtKHl76wzVGBLJBfEi51rypGN8=;
        b=g1d9/u+FUE+E3s7etqp/LjM+WQd5IuQlJ/G9cnUtWDoSGPUd2p67AtdDm49kE1Sh6V
         CEW5oIsBMJTHq6qTtoNQI9sG1pGIp6n0z9TPlcsX/2Fq+hMSMK3c1dXXLOLW76JYE2VM
         Y/wE0g7WBDtki0sLUV0kRc3CDaaW54J49kDYWU1CfplyOUERSWxoIdrcYPbO9AWdmWUm
         1jv10au4m72FgQ+mG6gL83iIqPSrjTQBnPeLU+AH3vYjKhlGlHVs6jbzLf3Ro2IjwCov
         vrVWTeiKsB6IK3xexTiNkams7QEbD5rDDBVGRTUaDbA82Hq/RPZDTUhF6zy6MLAOpcj0
         1tDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755560737; x=1756165537;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O1S4PAvWX3NjKh5NcbtKHl76wzVGBLJBfEi51rypGN8=;
        b=gsJrANDq3JyRJclAoPptgzFSFXG0T1gdRs+qY+m91+alVF02qzaDcC9KzK9Y+8v4bL
         GIijiCn6cxMVRTHRlFu6JuF0FMowqWZnJ2VaDu5McSZLQIBGJrljAEJjlkzYbfFzlNjA
         gsFT2y6BnFzkyJIxcPA/YGwucAQXhBeJSMI3eDq+6rbsr/9Tkjw9ZdPxlbT6RFPTf8v4
         LzJ8KVzEh+yTnFrX7fRAKgLwEvklUiw+e4dbk/JnhfoIu5m727/sIvhnCydrHZ2bbQxX
         wNEMh8SWy8PlRzHZcScua1WnzX7Q5O2M/0Oii+lv3EXoWbqRO4/+uCqjfn0wIU3ne0vS
         jEnQ==
X-Gm-Message-State: AOJu0Yzfz3+rJYER+tTQ/mm+jf1tgFKlKxenxJ2t+HoUiXbhImE937sI
	RCoGZalitg4KsGJdgd/ZQZEREK2nGavX9YFNpetMFSpzjRS4XjFLk8Oduoav+eZ4T1ph/oNof+Y
	8xbt0nq5AVns9njqoOYa4Rm3MnObmKpsPTKBfcgo=
X-Gm-Gg: ASbGncsObydyUeF8IZQ+LoBeQVCJlV2fhMG7GyEiKiD55DyGJHLupDm57zrlQ+jYf/q
	TGaS0VYOhauW3E0obxkVRJSVwM0pik7HIpjmmvIpcD1b6FlvoCQoGv26yEl2hBcTCh4pinWfdSg
	vyLfb64txd0d2IOGFp8U2yoiFqloUP3aTN+9XO7cAKsTpGhpm1Kf1vFiBzli0JImHARA7KlrsN5
	lQ0//n3DqS7vTF+aaU=
X-Google-Smtp-Source: AGHT+IHkwkIhl+qbtVM+g4WeXbYdv52fxJwh2YQ1KpauuiY7/H6Q73rqh+tdYZlz6ckwX21MSgOYLrjeIHYGax1DUJ4=
X-Received: by 2002:a05:6402:35c8:b0:618:ad7d:cbe0 with SMTP id
 4fb4d7f45d1cf-61a7e9b5332mr270003a12.10.1755560736983; Mon, 18 Aug 2025
 16:45:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Mark Waite <mark.earl.waite@gmail.com>
Date: Mon, 18 Aug 2025 17:45:26 -0600
X-Gm-Features: Ac12FXzt_1T8VNR-fEU6RJrD1yGpuuR-IfRHeSGeBU-KfiWvI5kjOkZmhZNZbKo
Message-ID: <CAO49JtHLs0yCAmNX-2VO=0mC-u4JKPWw86Lg+xe1pV6Dr6YZWw@mail.gmail.com>
Subject: Jenkins still uses 'git whatchanged'
To: Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Git 2.51.0 has deprecated the 'whatchanged' command.  The git client
plugin for Jenkins still uses the "git whatchanged" command to generate
its changelog.

I hope to release a replacement soon, but am only starting the
implementation now.

Mark Waite

Message sent as requested by git 2.51.0

'git whatchanged' is nominated for removal.
If you still use this command, please add an extra
option, '--i-still-use-this', on the command line
and let us know you still use it by sending an e-mail
to <git@vger.kernel.org>.  Thanks.
fatal: refusing to run without --i-still-use-this
