Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F3BE3B18B
	for <git@vger.kernel.org>; Fri, 15 Mar 2024 15:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710517290; cv=none; b=Q1k53kt1FKwScZQP6UKjR5pXGJyv9kXB+lV0+O2PWN5O7oHugcNTKfOHGzUiKxX5BT7xDHgIOKmcH7+7cpbi8Svot9pYuvsps5vkdaVWSni5ipGxvpmfLoGuler1AQOjEljNUGA/vL2DNIIF8eb6+esD5x5O27ceh8SppCK/COY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710517290; c=relaxed/simple;
	bh=ziSVZMZg2dJEocVV9+8dgk0hs8UHvLlgp6CaiHb8qFY=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=RODqHiiUbLslx8sJsTAZtlQ2pOS5LMuBuptholQNb/FONWwY3PhNY55MFF4h8p5rX7aXjzJQLU4n4XHEJJ95PDOUWsJLBxucLn+P9zk7TfwCkkdbhIKTXNpcV9IoZh42WxpI+/hqpSJEVCXOyyGIvPlWhvoI8Ly+u9B8oPno5N0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L9JumueS; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L9JumueS"
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-7cbf307213fso36973739f.0
        for <git@vger.kernel.org>; Fri, 15 Mar 2024 08:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710517288; x=1711122088; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=peDrB/QzYIQpKWrvw8fwqDjadXl0Pw7k7BQfGMC8nVI=;
        b=L9JumueSGtH7968nCWqZylsv19nCZLlI4nDSaYNXN+DwvTmCfVlDcZ9kvKpL7l3y1n
         6Awq7jy8CNnvDuntn5rKLju4M2DSRYiEJ2JFrKvwHZ1IKNX0jFs64Pvfg4kHvOEz0jaa
         HIqXDqJxXXZHPboy9WaWX9hYuZkFx9Wrq/oE+Uy9pHE/NJa76py+5M4ZwiN+TDzU4cu4
         cR+8DTQNDioipgR1M5zPfbb+/tqYtWsD3hX0QFs/INM/fzKoRIh/JebkIg5pDucURYIa
         qFJejXIUNYA6+jkKLliYJmMZvotvK3SWtXK+/3qoLOhSk3k3Ve7Id0dxUq24FwrRxgOM
         +jmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710517288; x=1711122088;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=peDrB/QzYIQpKWrvw8fwqDjadXl0Pw7k7BQfGMC8nVI=;
        b=bS5muX7KLZGOeNppDmzKW2kCqK2dNm+crUsdYJZeMEzaeBWw6qmvRMm1Vj1Od3leC+
         UAPekcDY0XuJ0RVm3qgps+mQ5TfIf1/Ungo7FmY00B15EYlA14FsDhkR4G1YPt/H2pYZ
         jSNAFGJ9spAhCNwmTs6CMVILkqjwDzpwl2QKouFu3LKn99QFy0MJKNikLhkno6tuRvGA
         CfZm++b5Vg95RsfbH8qNnVBSn2ibVic5g81rRdIlVpWTWfGZ7m2CBDvBgyjWRi1Ykxoc
         UFQJ6WpDs77HsYcW4zGDm0nJaaH3DPEQuf++bgWnBLbZ30oFw+hvy8wmUNUvh6CiS+Iv
         X0aA==
X-Forwarded-Encrypted: i=1; AJvYcCXEJgm04YC86WB2WMgWClkVhOed3Ocu3vY79VfyfWmVyvW35FQs05fKmJfNGTqxzSLH4ve5o94r2ziQkw+mSxxx+kvg
X-Gm-Message-State: AOJu0Yz8/4d5DQBoKMc8YDEVb39L9Fd/SbCC1MhkVVCIlRiyl/Uo3zz4
	dzoZcoCXTV6qrhB0pR4NIeH0Yy02lPLKIzJNcMMdGcGlsiwEqN1v+WyTog9U
X-Google-Smtp-Source: AGHT+IGQW89CHIj/DDMoOwr5d7PWFyiYPPqJVeAMqrwke7czkb6CZlQeQO8edGDg16/jovJJ3KwS1Q==
X-Received: by 2002:a6b:610f:0:b0:7cb:f0e3:c785 with SMTP id v15-20020a6b610f000000b007cbf0e3c785mr2985412iob.12.1710517287821;
        Fri, 15 Mar 2024 08:41:27 -0700 (PDT)
Received: from gmail.froward.int.ebiederm.org.gmail.com (ip68-227-168-167.om.om.cox.net. [68.227.168.167])
        by smtp.gmail.com with ESMTPSA id y26-20020a056638015a00b004772df70c10sm805956jao.46.2024.03.15.08.41.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Mar 2024 08:41:27 -0700 (PDT)
From: "Eric W. Biederman" <ebiederm@gmail.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: Jeff King <peff@peff.net>,  git@vger.kernel.org
Subject: Re: [PATCH 2/2] doc/gitremote-helpers: match object-format option
 docs to code
References: <20240307084735.GA2072130@coredump.intra.peff.net>
	<20240307085632.GB2072294@coredump.intra.peff.net>
	<Zeo9oAkL6kxZRugN@tapette.crustytoothpaste.net>
	<20240312074513.GA47852@coredump.intra.peff.net>
	<ZfIWkJieqcPv5jA8@tapette.crustytoothpaste.net>
	<87ttl99e0b.fsf@gmail.froward.int.ebiederm.org>
	<ZfNqVowQBy47_92m@tapette.crustytoothpaste.net>
Date: Fri, 15 Mar 2024 10:41:24 -0500
In-Reply-To: <ZfNqVowQBy47_92m@tapette.crustytoothpaste.net> (brian
	m. carlson's message of "Thu, 14 Mar 2024 21:21:26 +0000")
Message-ID: <87msqzo63f.fsf@gmail.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> On 2024-03-14 at 12:47:16, Eric W. Biederman wrote:
>> That said I think a lot of think we do a lot of that today in practice
>> by simply detecting the length of the hash.
>
> That's only true for the dumb HTTP protocol.  Everything else should not
> do that and we specifically want to avoid doing that, since we may very
> well end up with SHA-3-256 or another 256-bit hash instead of SHA-256 if
> there are sufficient cryptographic advances.

My apologies.  I thought Jeff King was reporting that object-format
extension did not work, and that had been masked by a test.

I see you saying and a quick grep through the code supports that the
object-format extension is implemented, and that the primary problem
is that the Documentation varies slightly from what is implemented.


Looking at the code I am left with the question:
 Is the object-format extension properly implemented in all cases?


If the object-format extension is properly implemented such that a
client and server mismatch can be detected I am for just Documenting
what is currently implemented and calling it good.

The reason for that is
Documentation/technical/hash-function-transition.txt does not expect
servers to support more than hash function.  I don't have a perspective
that differs.  So detecting what the client and server support and
failing if they differ should be good enough.



I am concerned that the current code may not report it's hash function
in all of the cases it needs to, to be able to detect a mismatch.

I look at commit 8b85ee4f47aa ("transport-helper: implement
object-format extensions") and I don't see anything that generates
":object-format=" after it has been asked for except the code
in remote-curl.c added in commit 7f60501775b2 ("remote-curl: implement
object-format extensions").

Maybe I am mistaken but a name like remote-curl has me strongly
suspecting that it does not cover all of the cases that git supports
that implement protocol v2.

I think I see some omissions in updating the protocol v2 Documentation.


Can some folks who understand how git protocol v2 is implemented better
that I do, tell me if I am seeing things or if it indeed looks like
there are some omissions in the object-format implementation?

Eric
