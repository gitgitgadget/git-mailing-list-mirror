Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958D138AC7D
	for <git@vger.kernel.org>; Fri, 21 Aug 2026 06:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787292337; cv=pass; b=BVNItAUF6mxlvamO6VvEvnBjrY2fVNSrSIoeYAm1qACvs70IAOhGQ7SpUp8pqAo3kEfuS6XLw3oLW2/4ssaMHjg8imDJxHU9pjVB4o0d0AC4lXxjgFmbyCulA43BvLW2HrRoGg2T8JnREd5OnqyTSs1gfRdqJTpHY1SIdnntON0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787292337; c=relaxed/simple;
	bh=RPkD1MjHsW8rA2VkH7C5UEqfQ9+UVIrOeHmecOXBORE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y823+GbSsrWlE2Em4rOCgyyz4ImnwpKCEzUZ0kAnq19BtoNzCeeazJFIqoFUqu4ezEcvWIdcZEj4J9ZegQWuRuwBHREg9KjI/NU4QY45bEZUc8oHlNHK3aOBuHihR7fASVPwrWqIZ6aP/bfI6urBTSobloU641NQA6m6VlubXiY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mFWdz4I0; arc=pass smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mFWdz4I0"
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-4b1be215736so571361b6e.1
        for <git@vger.kernel.org>; Thu, 20 Aug 2026 23:05:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787292334; cv=none;
        d=google.com; s=arc-20260327;
        b=c5DqjcUWYOikjw2Yq9ochucSABMyiBQiFWipeaaUDZrq4f/IeXIHEzy4l3uVVcB8Rx
         P4GNzUAUXd26+FRaYpMCw8sDW0rJ8y2SD1SqPoP0PSW0kxzE8wQqCYWngPS6nJlkf3rI
         7dZeg9hVfDWmAtFoQ0Y+rCPbN5JHZ2kM0xDNLnBPKxvYgvbrQQG4an3Z0/CUGbvwLFXz
         dNbPfvP8nStRlLzqE0fR92+9DQftXKmWtwHDywae65n2wLbNPfSDBNC9afaLLA4aNlqp
         prmrAT0XsnaOIi9imS7kPsVabnAlgkCWI7GJeAvq4MEKz1K+Quuo6QMZ8+oxAsQcTBBc
         5XwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=S6tXQmFGCiBCGGChrvhUP3fCE6DqJ9gMD2CgBJIjN7Q=;
        fh=en/eTjevAOLt2Dy9HfTEzVwFh/fl0oEd8cMtfc183zE=;
        b=hfjt8aCJ51Zr20PnB/MrVfObptEhSDD6Q9AY+pZ7jZj36T+fR5yxnaGcaehckzsggD
         tnfLwb268Z3HdFhqkbqMD71poAGQoA/uTEAApl1/vFejdsBOExMIa6HYjXJURHGzIKO0
         zednjD7w+vfk70ZzM61iWXkhjcge8TXfAZHq9z7iJsjuO45lvJ7gBEJtvmvTl5xlmS3R
         xIrskhnKsC9yR0GdzPECAIUMzyYKQtdNesRwGID9vGBlRBoq79oSPjBUEyuzq57FSoU6
         sf7XvL+CBdvaqgZFTKrxeMjPoBZGqVH4weNC5ylRlB41yvpUvWbeE64tWcRkkHQFsB5b
         74CQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787292334; x=1787897134; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=S6tXQmFGCiBCGGChrvhUP3fCE6DqJ9gMD2CgBJIjN7Q=;
        b=mFWdz4I0+V2fv+vREPkOlmlV81WZJJ3yMg5+S2o/piXX5hO92mhsuE70Xlkp1bvSD9
         /bTTTYFxkazYyU6+XwOvD1il/miBPBOrvD73/W5Zw6drXM2265Y8yh5aa8UonnsxiZGV
         ufiCBg9xUzh1nFLyXCNY4gJBzsP53e0SgAqxPQVXe3+aggfvgHoD8NdjggIVxQ5wTu3i
         Nygq6pN6ztDZtqyC2dehwZnq9QXuDjbizm72g9v1TZfLFpmqYmBXSiioq4ImlSKeFzfC
         pqdNIxG8auDeqvfkPBC9iDB4sYUPWgowHerOaQeUvZPIvLEb1NM18+/RHiot+N1bDpgH
         Dqxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787292334; x=1787897134;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=S6tXQmFGCiBCGGChrvhUP3fCE6DqJ9gMD2CgBJIjN7Q=;
        b=p3ailtc2LLgZ2hQ0vkYhyav4jCFi9MAjAlzBMCE1IV2aBcNPfcRLwqHhkkLuIIEbsb
         Mvf9YOV1gUv0colsofYn2kLbJa38U0Bgi8kiXd1ZOa3aaHLgLFoLG+NBXKRhlT6CZ5FW
         5fBTxyy3xsRLV7XMEaE5fWG0Ha8m9YF1uGFXaMcQZuEXVanHbpHLxRdKYmE4ZcwRpOlj
         KOS05ED26cvZ0bqA8hTv19+a30gcqWMZu8gSIwXkXYa++I1E8avv3D+HukloSjpk9Urg
         o/RMbqLeFln5CA8m2vTJDSEvX6M9QhMNEodukQyrZ6KkWkKrx8KcpSVwCxZhLEguBTXY
         6cBw==
X-Gm-Message-State: AOJu0YwHIhQXwrRcnACvsVAkg4E27JPRygbwlFUdw8zV2yIIRypqsDGY
	aMSwI4xEqUY+OSt0LcfKXNT/MxOV+uNsfE2Urjojyl17PR4LExx31X6gUreOHUECuaNzrveIr7U
	8bD/g+EKnLYjy1w5qAgunwr/bnArLHVI=
X-Gm-Gg: AR+sD12ZuVaZP0MseX7eT3mGOQo0rRQ25twhziBXiRrbYiK0laC85MO098eeJxYmzGW
	K/vyV+7DEfOllUslNxevM7JFyZJOSkAOnAWQjyhRnJBC7BzD58SvsXny3WmQblzzlsFryW3TZsy
	JtFb6CiRR0Tt640+20WSSJGFNq5aVIehR1dpbtIkeEfrvwrrwG3RRApWc4m9GFFJuKKTypr8v10
	JU1xTL1j/0o1/Pshwe3CVZwx0hep+N+j3Fchzd83iyIFnPDpQByxF5JhNSK1boZHGrNBFTtuSzv
	Wmav2H8RGS6uqHYmthjIoT0lkcDZY5UKhGlPIpT7pJlqOMYb/qoUkHkTbIiNzgv2GwYaSkM1eb1
	5BkL6mQX08zSO7CnbYIzSzZkYwlX+YqqTV+XfQdTAMHPoyDJwM2G2POWCestOUBBMK52pKoEiZw
	==
X-Received: by 2002:a05:6808:4f61:b0:4b2:8e1c:2b36 with SMTP id
 5614622812f47-4b2ef4191b3mr3908711b6e.20.1787292334302; Thu, 20 Aug 2026
 23:05:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260807-b4-pks-odb-generate-pack-v1-0-7dec431ae7cd@pks.im> <20260820-b4-pks-odb-generate-pack-v3-0-bc42252f6169@pks.im>
In-Reply-To: <20260820-b4-pks-odb-generate-pack-v3-0-bc42252f6169@pks.im>
From: Elijah Newren <newren@gmail.com>
Date: Thu, 20 Aug 2026 23:05:23 -0700
X-Gm-Features: AcwNN1Xa5Vqz3Qk72TDQ3rmpT4uRKauFNsjfOgvQTtw_CXdQx0YSuw3QE2ocG3g
Message-ID: <CABPp-BHAeb5Q6kWw8e0fz9+avKyJL0_k7cUzRhesHScJjB3Xfw@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] odb: make packfile generation pluggable
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, 
	Justin Tobler <jltobler@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 20, 2026 at 12:55=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wro=
te:
>
> Hi,
>
> this patch series makes packfile generation pluggable.
>
> Note that this series only makes those parts pluggable that are required
> for the transport layer. The other parts that relate to packfile
> generation as required by our repository maintenance is kept as-is, as
> there is a bunch of options there that are way too specific to the
> "files" backend to be portable. This should ultimately not be much of a
> problem though, as maintenance itself is already pluggable in the first
> place.
>
> It's a bit of a shame though for git-pack-objects(1), which still isn't
> usable with alternate backends. I tried several times to find good
> solutions for making it fully pluggable, but due to the backend-specific
> options it's an utter mess. I want to eventually address this though:
> same as with git-refs(1), I want to introduce git-objects(1) to care
> about all things ODB. And as part of that command we can also introduce
> a command that generates packfiles in a generic fashion, without all the
> cruft that git-pack-objects(1) has. This is part of a future patch
> series though.

So, big picture, today there are three callers that spawn "git
pack-objects --revs --stdout ..." by hand to produce a pack for
transfer: upload-pack, send-pack, and bundle.  Each hand-rolls a
child_process, feeds a rev list on stdin, and drains the pack from the
child's stdout.  This series hoists that shared machinery into a new
object-database interface, decoupling the transport use of packs from
the storage use.  I like it.

> Changes in v3:
>   - Fix a use-after-scope bug on abnormal exit when child processes are
>     cleaned up via `mark_child_for_cleanup()`, as noticed by Elijah.
>   - Link to v2: https://patch.msgid.link/20260817-b4-pks-odb-generate-pac=
k-v2-0-4c8a96ccfdb3@pks.im

Thanks, the fix in 1/6 addresses what I raised on v2.

I read through the series -- I did have an alternative suggestion for
5/6 (which I posted on v2 5/6 since there was already a thread there),
but otherwise I didn't spot anything beyond what other reviewers
already raised.
