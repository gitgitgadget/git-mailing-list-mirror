Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792428572;
	b=uuZogr4L7N1glyJkAerF1zyygFrtUXGb72GIg3bfKFqUR+Es+cO7vUzZPl21btG1zQI0
	 DG9GxC2ONh7/oXA6kwns++g+GmsXyBLeY50Y93XQPuREHVYetnSkbUcmmtAaooPHt7Twm
	 lhl6/tRF4uw+Yb33EfRvr+Pj92GE8PPAKM8vh7ujbL6c2sMOtXwu/z3v+1Dmd+t8O+3IH
	 sNZ3cP+NQhQpyquA3Fh1jif40450OxRSiACEm9BFdYnNX/iOPNKPZWnGnULQ0vmdf4pvB
	 9NtMA28zPe2VGMZ8UnFyNwBXyYjym2ASbzn4y7lQdVqmPEPm/iNP33AX27Vcxd2YGEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792428572;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Content-Transfer-Encoding:Mime-Version:Subject:From:
	 In-Reply-To:Cc:Date:Message-Id:References:To:X-Mailer;
	bh=33o3gn95UmwKTu+g9Vj5LW85dihj8U4Z/GhgsYPC2qM=;
	b=Cqw/miqJkvR5DfENTYJEjXtS93KpjP6vx2rEBjFhlVdV0QsseLmzVb7Rbvgb1gdRqznM
	 xKbLEDmFQlQ6e6e43DQnAJG4FF+ss6lDs7nw3IWbgGCCgZz0hV1fxPrlO1BC0JpVsLWli
	 iaTDHJxaV5u80r9lpyTElygN1MwBKYaZBuCLkzynwRFlASxnDPr8eQWJ949bnDQ78FmQk
	 kzGVZIOJoEAMSVBFuU6lghbrEftIyHmr+Z1bTFFtL1lpy3B7UM81S94v+tpIU7pTP545X
	 NMRyvS3F3H/itkkApdb2Ev2G54RWW/ECP15gUp2bU2rBUYCRqw9KFjKkf0RnR255QFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=KGZUC751;
	arc=none smtp.remote-ip=74.125.224.51
Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F06606A319
	for <git@vger.kernel.org>; Mon, 19 Oct 2026 16:49:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 32F06606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=KGZUC751
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-67489c8202cso1964099d50.3
        for <git@vger.kernel.org>; Mon, 19 Oct 2026 09:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792428571; x=1793033371; darn=vger.kernel.org;
        h=to:references:message-id:date:cc:in-reply-to:from:subject
         :mime-version:content-transfer-encoding:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=33o3gn95UmwKTu+g9Vj5LW85dihj8U4Z/GhgsYPC2qM=;
        b=KGZUC751xSgKwRmfT34LVvv2g8Karvzedf76BGLCzr8xYlxLos4OE7/+sHSHqNO+WT
         oCDo7HHtnRyNlZ/9fo9Xd3+AuzUL4gXzTcJxmxiJwz6rtvYMF6liZ4/qDg0UHRY/hU5V
         CAizf2BswA7vqiHNZZwEdJnHVxoxqenqjOnlz5pa7morIMj6lFC4PbE02GI84HIFo5mt
         SVpZmhdZTW8K0veDSk4WMaZNGgyadV/Q5YNk30rpDZNl9jIoBAKFHRD59/XHVvgSujwl
         N2nCYKQHSShiPRCDVrcZQToao/BBKDp3JpFfVaqi79xck34MaV3LLtg2caDFsbk50l8j
         rphg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792428571; x=1793033371;
        h=to:references:message-id:date:cc:in-reply-to:from:subject
         :mime-version:content-transfer-encoding:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=33o3gn95UmwKTu+g9Vj5LW85dihj8U4Z/GhgsYPC2qM=;
        b=X2QFnEBi4T2ajp5dT3bSoUcEhkF85f0nPLmwouDhNRQ7c7ieKpDOAcH4qzi+j8Kvnj
         iYoD9Sd3Oh07GjGRXMQGagRgFmCGtCILrjn6qgvLjJtCeLcPH4RpX9U0TSn1QqYIzsdE
         zyFNMAP2HTDFcjHckok+GAtiIRascCMJateXJwqrzVGSI+buoFL+xZ6+HxypD9ru6uxq
         doGtkce7kCjFbgr2ZiFHILHz4zQ6/wrRqxo7lHwEBKv1gCcGhRXeLa0N3HNzifomq7R8
         m3ToxZBWBo9yuFJtlFA5euuirZ1FwkUmaa5pIpksaYB0Ig9bb4hmVDxvwEP8FwRIDQWm
         Z1Sw==
X-Forwarded-Encrypted: i=1; AKwUvBxk4qhT7PCgJF8K3+oiJeKZVGM+BtvoRXUo6vXjN0tTGeDU30t3KHWlCG87k3iGXGlVp/8=@vger.kernel.org
X-Gm-Message-State: AFq9FYKdSsJp5mIJhExYn7FpihDkOZwzCWWlbOGD2VUOc3LK4MO7Cv25
	gp5LSn4c493fnepD4bwo+aeyiJC91o7cp4tJWmILDgSTz1zHNs+dMvBAUp+NkTH5
X-Gm-Gg: AYBFou09t2yKIs66ywxXGvBFUexJiMrD+Me+uGZF256v1gsNVw08xKkNNccx5s/bDF4
	OPBV21zMu1L0TcRWhzqA0Bq89Q4Jf6wgMqVJUpa7rq0pkwmAwf8dn5UrAKV8CP1cxpvyacsGzyX
	BSeVmaBRWq+ABYW5/WB0tMMU+HBXKXV2O6ueNl9lNtBgQARHQcuvpoSM2UPBO8recsYZXUAoI21
	s9hTHjkmEvLqzX/tkMJdG9P2gyhnwdroXu6zWLB7Ukxm0uTRrtKCu46Hu3AmuU3NLk6Rho48aIx
	vbWRVDIlfjYtUpj7m93AwxnS0q/DSpoVlvNNxd8SrPA4xTEKf/iv2e3qrU5aut9s8isl/TWalbA
	6F4/l+0ctyD35bv56T/m0ecwx3UII1ZPxwgZ9hXtDuxXkwh/U3cVEnx/b3Y1v3uKagQw1BLDVON
	HjUHQ6B0e3s51dyuicsKJFuQQC7ZhEZ1/ay66EH8GBKuwInIyhhg9Bf9RS1hddwzu9sGijpBI6o
	3yUIBempBF5zc4mKK+0kCUSufIdGKlrUN4Khb0ztb2LQfXKpNPIuRAEmGGrLBG6U5HywPUeU46D
	1mj3xZ67WU5JbGB5Aoj16bGQa/unT9C9y0W+KXkmFHN4OV0=
X-Received: by 2002:a05:690e:1183:b0:679:ad30:eff3 with SMTP id 956f58d0204a3-679ca83b62cmr2602741d50.64.1792428571078;
        Mon, 19 Oct 2026 09:49:31 -0700 (PDT)
Received: from smtpclient.apple ([2605:a601:9092:700:1909:b48c:a809:b114])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-679b1e11207sm4275355d50.8.2026.10.19.09.49.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 09:49:30 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 2/2] doc: add new Git tutorial for beginners
From: Ben Knoble <ben.knoble@gmail.com>
In-Reply-To: <3a38b208-2640-46a9-b486-9be614d71480@app.fastmail.com>
Cc: Julia Evans <gitgitgadget@gmail.com>, git@vger.kernel.org
Date: Mon, 19 Oct 2026 12:49:19 -0400
Message-Id: <F1D19B27-6BA9-456B-A43A-41D7B597F749@gmail.com>
References: <3a38b208-2640-46a9-b486-9be614d71480@app.fastmail.com>
To: Julia Evans <julia@jvns.ca>
X-Mailer: iPhone Mail (23D8133)


> Le 19 oct. 2026 =C3=A0 10:25, Julia Evans <julia@jvns.ca> a =C3=A9crit :

Acknowledging the original was a long email to begin with,

>> On Wed, Oct 7, 2026, at 3:48 PM, D. Ben Knoble wrote:
>>> On Tue, Oct 6, 2026 at 3:37=E2=80=AFPM Julia Evans via GitGitGadget
>>> <gitgitgadget@gmail.com> wrote:
>>> +[[step_2]]
>>> +Step 2: Introduce yourself to Git
>>> +---------------------------------
>>> +
>>> +The first time you use Git on a computer, it's a good idea to tell Git
>>> +your name and public email address. If you don't, you'll get a lot of
>>> +warnings from Git. To do this, run:
>>> +
>>> +------------------------------------------------
>>> +$ git config --global user.name "Namey McName"
>>> +$ git config --global user.email you@example.com
>>> +------------------------------------------------
>>> +
>>> +The name and email is so that other people you're collaborating with ca=
n
>>> +know who made the changes. You can set them to anything you want.
>>> +
>>> +To check if the name and email have been set, you can run these
>>> +commands:
>>> +
>>> +------------------------------------------------
>>> +$ git config user.name
>>> +$ git config user.email
>>> +------------------------------------------------
>> Ought we recommend the newer forms (git config set, git config get)?
>> Or is the idea to remain compatible with older versions, such as the
>> 2.32 I happen to have in /usr/bin on unsupported macOS 12.7.6 from
>> very old (?) XCode?

I think this got missed?

>>> +
>>> +Set your default branch name to `main`, by running this command.
>>> +Git is going to change its default branch name to `main` soon, so this
>>> +sets you up well for the future.
>>> +
>>> +------------------------------------------------
>>> +$ git config --global init.defaultBranch main
>>> +------------------------------------------------
>>> +
>>> +If there's no output, then it succeeded.
>>> +
>>> +Step 3: Create an empty folder and 2 files
>>> +------------------------------------------
>>> +
>>> +In your terminal, create an empty folder and change directories into it=
.
>>> +Later on you could follow the same steps in this tutorial to take an
>>> +existing project and start managing it with Git, but we're going to use=

>>> +an empty project so that everyone following this tutorial has the exact=

>>> +same files.
>>> +
>>> +For example, run these commands to make a folder called `myproject`
>>> +
>>> +------------------------------------------------
>>> +$ mkdir myproject
>>> +$ cd myproject
>>> +------------------------------------------------
>> I don't know, and I'll probably bias towards what you've already
>> written over asking for changes, but: does it make things any easier
>> to read and follow along with if we "git init myproject" instead?
>> Perhaps this version plants the seed that it's not too late to start
>> tracking any existing project, though, which is valuable :)
>> I wonder if you had some rationale for choosing this particular
>> sequence? Just curious, now.

And so was this.

Both are fairly minor in the grand scheme of things, so I=E2=80=99ll treat=20=

silence as =C2=AB not interesting right now =C2=BB and not be offended ;)

> Thanks for the review!

You=E2=80=99re quite welcome!=
