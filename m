Received: from mail-oo2-f2.google.com (mail-oo2-f2.google.com [74.125.231.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0323930C637
	for <git@vger.kernel.org>; Mon,  5 Oct 2026 17:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.130
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791221751; cv=pass; b=ARRVKpW6ZVjc9pnS5z9k12HHmna2TljbOlnB+9+VBGPzFPGL69JHGZ+pwxStBH3BC4b1KozADSDMZA2SArb77wkqjsT4qWS+2daGnnsLtZjox4ZNeaUUza6XZXOm80hCp/6Jy2c+7um/hvAaJFl/GkQEjm5i8Ai5luvl27VQpYk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791221751; c=relaxed/simple;
	bh=1LnhvNl0nBj+G8sNlsQZekmVdxWldLC7fMl5BqgWcEA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sp1imFNjVckdIJsTY5TDaj9drRtv7YmeuYs7D5RlEd4F9V5T98ak3PNzUDrEBxLwj/o+lmKQTkZCiyB6AyG1dT55L8itCkg/B+1L2Q/8Z5LatBxIRHX/P1yX+P6BwATWs3JkSuH0LSMGDLucD+pZle2LywprXfjBpsfku+M+hYE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ocYkfrHK; arc=pass smtp.client-ip=74.125.231.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ocYkfrHK"
Received: by mail-oo2-f2.google.com with SMTP id 46e09a7af769-824fdec5521so1400573a34.0
        for <git@vger.kernel.org>; Mon, 05 Oct 2026 10:35:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791221749; cv=none;
        d=google.com; s=arc-20260327;
        b=BnyAMD53/ym3hOdncrTAAUYbf6OaXc3T/akhjUy5YrAbFov1uV9g9rcvbL/kVwa1u9
         Zs2SW9vPL2DUvm+I2eP9qEoMob5eU7+K8bxfj4ezcnJX29lfj4EljZl+m2Ut+1/dOesy
         CRhrkwVtCRUakQZbAHRZGqZKWx3uqAZYJ3Uz3zRgRsfySWtCt1Ft82ZXgQ4NJ33OCDKX
         RHQSQnaXshdNff3fgkMvnZlN7QhhDvlSR/q9L4mJzGJdU3fFgq8eutTIRhre2NzuAFWT
         Sbcr5BLhn7oUwvuQ7d1KP3mHIJlDEUGJvde9bSzk6Zgr93vERQ+GGOqEADbMV8J/nQOI
         Pu4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IznhUxquWfbhynSlgIJQ//1g//9VADCP4kP/QGPnZC0=;
        fh=4hRD6dug9K2dA8/Qy44rHfFMnlFofhUgf7dxeZXl9E8=;
        b=nDgz+9szvjU6Sqn4gjwQ4/9Z+UHWXgfGpI23EOBijjDUj0yzdr4JaApqtKSb+eWCdj
         lS6YJ+wcA1QMvSWvwZ4x39yvCkICuUW1IShgW3jLI46xMa8gC6cs91r+qcMyVx6VmyJ8
         couKKSohiC/2iRHwnYozEEPMQPZI1FAEmHAUFGrY/aDQ9q7g9Xy94/siUyzJyfmycW6X
         6K+pZK1DK4bv/NezHlg1b2r60kwvYXmFqbglamYDIYT57dn34w2jd8G6c2SDN6CWv4p5
         L1jY0e3BRq2FoYfysQKSJCp2XAk/k3QgYKSfh+BlPKhfMwxZBBhLGpJeUnHVqx0FiwVf
         oBuQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791221749; x=1791826549; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IznhUxquWfbhynSlgIJQ//1g//9VADCP4kP/QGPnZC0=;
        b=ocYkfrHKHbdd3+Ke+1ZxpMA5/EHBNTsmPr/y9RNvl/ImWOpbIvE/yVPcaET3eqIUtE
         fyUTIakLlFG+kRj8N1XdvnHOs8FX8viRBzJl3P+iqk0E6t8UtCxxfCj+wrnmjpE8z+Jk
         EdWuVPexucVl8wnRdDjtBA6RRvKuD/zZHW3TaZEoLfadNHlbhAPnYSFffNcyC2wwch+j
         RMWh0u1O5oUTTqym4ZDL2hNMfDKTjcUdo913wIuuB8jnLylIKnodk7HV4sjXxY7/3Cqa
         McPR9dak0j0sq2mtEpHMdqGdtohSciU4lX1S4SEZ56NLTSmvy5HS4dX+M2MLOMoqALU0
         PDNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791221749; x=1791826549;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IznhUxquWfbhynSlgIJQ//1g//9VADCP4kP/QGPnZC0=;
        b=C8h0MAw357HEzPdpArn+1NoHMKIRjFTCrVgjb5Tvt18Cq7ABJMYJLulqAKL+3dY2B7
         PtE+s9dAhqUeMHbaeCq75JzSY1YnGiH1vW2i8c4aojp6s6f4WAT9JubhzQqkdh2NzJG2
         D4X21Evgt+MGoNJquli0dvIlgiYMI1/J9toQE3mWLT7c6IUwYqvPSsy86hvtW9i/aZcH
         P2CBmxZAb952GoZyRWitnSrBEBuYp5+yK6i9OyMNQNRC70s4vGDn1iOBCGX3Wa8yD68R
         Uio3+B/GBjdeWo0Oa1qHCp1+Jh7hgEXG4E/Dq99TjArYC2Zfd4vfpoatm4fTajPZgGLZ
         5sGQ==
X-Gm-Message-State: AFuF++nUb6lKh5N8YQya0kK2sRIht9R9R5XF2OkxdiUbYBebx9bjjdaC
	2AnVVZG/PFWqr2V+F5eHY2CsxFSm/KyxvDcLJqvruqWKD6304fOvEg5eqBgEDxUAtkvy+Nsxlpf
	sz+4fDha9qd+bir2hnN5ciaSFguo2Em0BUwJaPmwdOL/e
X-Gm-Gg: AYBFou3u0wGPjmqZMz9PuRh35BeI/35UMXqgnYJT6PT8zHpn2qZuDiYEiZzPbt7FHy4
	xymET+nJrdSZ8hjw7zEClROB8LmP9xto/88D6bBoSN1jbTR2FcQIgs5VwOr8c5fLkUKbTl777Xj
	xOALBWjKLWv/yJXDvhGZGGR+LQmnRWoTPH6PeEGyIGAv+nlu/QTXZSmiTw+T2YBUgdVTVlg/o7a
	uS3xQIZDrjl8ErwoSZ3gASl6NDC6Ji/0p3tcIsucCz2By3INZZCEaOPayQwtEfodLHAIepOV28v
	X9mOwWyd6r/qqmSBf2av2Df+KnHLHvEzV3bB44Z7JQknFYH8VYnikQ==
X-Received: by 2002:a05:6808:159f:b0:4b3:7efc:e970 with SMTP id
 5614622812f47-4f67703d73cmr9072326b6e.5.1791221747801; Mon, 05 Oct 2026
 10:35:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALfz8Qx63qNoSbXq7C7u+KwX4=HCL7=uOUahpXd6j7KvW_c_Eg@mail.gmail.com>
 <asNKZpxiuFhVkVQd@pks.im> <DLWUB05MOV7T.2XA7NG57870ZD@lfurio.us>
 <xmqq7bjwkspu.fsf@gitster.g> <CALfz8QzymKxvzYGWLwdtzERDm1apa8ebZEVyLne18hpTaB=D0g@mail.gmail.com>
In-Reply-To: <CALfz8QzymKxvzYGWLwdtzERDm1apa8ebZEVyLne18hpTaB=D0g@mail.gmail.com>
From: Sphinx <sphinx9692@gmail.com>
Date: Mon, 5 Oct 2026 23:05:36 +0530
X-Gm-Features: AclHuK96YdvAZEy0bDn6jxbMlkOPIci0ZR0512ox_8myuN_fTxoYobVPPmdmHEY
Message-ID: <CALfz8QxzXJ_0EC=a2AEO-_Qy+MGGnjHbE_8dBky23BLN-WnGPA@mail.gmail.com>
Subject: Re: Question: behavior when reverting a commit from a shallow clone
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks, Patrick. That makes it much clearer.

I was initially thinking of the empty tree as the potentially unsafe
part, but from your explanation, it's clear that the empty tree itself
isn't really the problem it's the shallow boundary that makes this
behavior surprising.

The absence of a safeguard specifically for editing a shallow boundary
commit, and the possibility of warning or refusing such operations by
default, is exactly what I was trying to understand.

Thanks again for taking the time to explain it.


On Mon, Oct 5, 2026 at 10:44=E2=80=AFPM Sphinx <sphinx9692@gmail.com> wrote=
:
>
> Thanks, Patrick. That makes it much clearer.
>
> I was initially thinking of the empty tree as the potentially unsafe part=
, but from your explanation, it's clear that the empty tree itself isn't re=
ally the problem it's the shallow boundary that makes this behavior surpris=
ing.
>
> The absence of a safeguard specifically for editing a shallow boundary co=
mmit, and the possibility of warning or refusing such operations by default=
, is exactly what I was trying to understand.
>
> Thanks again for taking the time to explain it.
>
>
> On Mon, 5 Oct, 2026, 10:08=E2=80=AFpm Junio C Hamano, <gitster@pobox.com>=
 wrote:
>>
>> "Matt Hunter" <m@lfurio.us> writes:
>>
>> > On Mon Oct 5, 2026 at 2:57 AM EDT, Patrick Steinhardt wrote:
>> >> On Sat, Oct 03, 2026 at 02:24:42PM +0530, Sphinx wrote:
>> >>>
>> >>> If an operation is then performed to restore/revert B, I was looking
>> >>> into the behavior when the resulting working tree/index becomes empt=
y
>> >>> =E2=80=94 effectively causing all tracked files to be removed.
>> >>
>> >> Yeah, this can indeed be surprising behaviour. The reason for it is t=
hat
>> >> in a shallow clone, we rewrite the boundary commit (so in your case B=
)
>> >> so that it doesn't have any parents anymore. It thus looks like just
>> >> another root commit that has added all files in a single go. And the
>> >> consequence of that is that reverting it will then delete everything.
>> >
>> > Separate question from the sidelines:  As a non shallow clone user, th=
is
>> > makes me wonder if/how these boundary commits might be munged to
>> > preserve original commit ids in the clone?  eg: so a fast-forward
>> > pull still works for future content
>>
>> Something similar to "graft" (and now "replace") is done under the
>> hood, to stop history traversal machinery seeing the true parents
>> of these boundary commits.  As the commit object itself (specifically
>> its "parent " lines in the header part) is not modified in any way,
>> this does not affect object names.
