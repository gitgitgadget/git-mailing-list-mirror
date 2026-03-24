Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CD3C389445
	for <git@vger.kernel.org>; Tue, 24 Mar 2026 15:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774367883; cv=pass; b=LZbY0L2CwQPK+lFRAPFjliEOXLc5REQeEI2y8/2IO6v87kqves2lVXBt7kuW0iHaT16kkEhGziqBu9H7fmvUkI6j0WFYdkpyb/jNiTncdL78RDX7MBAR/RkMQZDHFLYiG995hl9ydW7Rtioj52IxdUOe8tak5Mm9VqkHx3yBpBI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774367883; c=relaxed/simple;
	bh=10FWrWgTLvmyKtGcpTge+G960pwRT0xhF4kC36ohVhQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jm8jSlm/1gNpxonCjNgavhjJKlp8xYROldtTmIffZ4/g97KwBKF6m5gXNtM+OGOeuu6Ez4++uim4XDyDjvOpzgZOaQlPYNX7uYbEaUYLNNTfuCBojHtp73Q2a9kZLQ4imXS5fOqTn7NB+xP+siOqHhLtsf0ICgiQ+gEkrJct6A4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TGbmoqwd; arc=pass smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TGbmoqwd"
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-56a9076813bso2489468e0c.3
        for <git@vger.kernel.org>; Tue, 24 Mar 2026 08:58:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774367881; cv=none;
        d=google.com; s=arc-20240605;
        b=EnIlhy04niG6/rJFEzvOp+7/A0QKioFPNyl7q1p0iqyYbXQ71gmWy/qoDK9VCS7xqM
         oApbW/6q65MAhmYVjen7ahJtn63gSppbyKXgwZ/rmIwBB4/u1ujPRBDmpDlf+ini0gKs
         lQgj5hISNnawmedrrAe0av5Jcx+fsYCxUhFAbJhJBqYS7mqkt8fKMMHy/LWlubb6kAKR
         0FpugX/7GWLVwmLQNWxW8r8TM11hSnIFFn7nnCbDY+7625ikj2dkZPY70bKTAxbNcq8b
         xM26ggBE7QtWdZ/Kv1mjSfDbLbvL9LQKRmY7ANx06tV4kAWtzoYn0GoDpmz8YiqJfKe2
         NS5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+eV/OWJjyT8uN936+gol5deBK80pwb8K5FM5+NyHrME=;
        fh=/gGcX06DeFgoFEwRIaFTrJCIQtIJsBTv+VxT9QcwE7I=;
        b=UBqMp8LD8TQ++wDDKvDShHA4FA1G0vtpeUgZ8D+2kEDk/hCLq87aYjKPHcPR1qAEj/
         DlYJ4a0zEom10izVL4OsAPPhBRvwqPIBhHn0HmvUL4Bg95XZpVNW109Yh/G2162F90vN
         i+FVYDNnOuk4Ri6fC6hDfC2Lh1+u2tF5UBmGarcPa6OHQBZiGj/wdZ4d2qUiXyswNUUU
         i5oGKom1yd+16XScH8DN5ZHGUrNia337i114o2EQaV27u2AFLGeZo3jMPevONz6hVF1Y
         +bJNiCEHnDsOwYdjM0xwjWEUbHl9zPockYbwC3agCiaZkOsEFQQaPaT+P2iGIdQXv7cN
         aWjw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774367881; x=1774972681; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+eV/OWJjyT8uN936+gol5deBK80pwb8K5FM5+NyHrME=;
        b=TGbmoqwdQRBn5eaG7CRo0fawKcDAd5MW7r4fSLNCXMPu2kvGAwHelWbWkWZHNxnYCe
         FmLLQi7u7zNh/jIIymQGG9FBM5pUjOutRj/6SoRDpc4ZSTVWkyIA5SsicW4LdxE2tsMU
         +TtU7r8dd0RKPK0c8YLRc6X/DNF7jDoecrOTDRT90wiViTsmkNXUuWFi/zjJl7s/xMpR
         QBVY4aE3j/FEqonocnds1HqBE+s9YsXOunsjOsn/gypIOlt0UX9Z7TWnYUn/E5dwiHjb
         4ccNyL2SMqf6vB7oZ9i6if+0cx/5EtXUBb8ZGCTCDm7PxP72mGM1hmOlp5bsi6mHki4G
         cBjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774367881; x=1774972681;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+eV/OWJjyT8uN936+gol5deBK80pwb8K5FM5+NyHrME=;
        b=q7weGl/51q4Tt6j9pecaqZKYJqbfwdTurC8aXkl3CSB/oAacsi1x7NWq4WkkCqwNfz
         SdDyXdMvQsVH4vgwRR/BQ7nY3lAeLAh3yw/JeC2IbB2NDut+oNWKWukDAMQ+yWWgCxuB
         CBm3qv0k7YLi94Ptay1OPnvstzo02bCT9alrXqwrxBABV+uyGqEnfD+N1tMc/zb574lT
         QwVMVdV1CnAEO9gJ5NNH6oELIPIOK/w/DklEr1f0Rr5o6cAWiH2al65igWaFbL10AYhr
         v+cGH5lzFcb1hq2QH0+biWuXS/FIjzgBp0hf7Ygb+7unx4PvjnlGQtzgSU5I292E9ukP
         l5zA==
X-Gm-Message-State: AOJu0YwSDoehFQiBIdnSRESNUxRSfFPOSVKrv9CLXLJPaL69xwroHpx6
	gRmqI/4aDJJobOplpDAX1NfYUpWRKvZUMgSj7Qat3ImlzBPI91gq56i2wkoSg+3vZQxKS7b4zUn
	13tgAZ5CdRmslgLpFaH45BW+kAYzZmDg=
X-Gm-Gg: ATEYQzz3Rq/ytpu6E5UE/TfOdxBQb7gevipo6GVxfp8vsiOv+3YHFL7kCxVZhW/mdc2
	NrJeiFMJbHePKqFz3vClNcc/ne3eSiTdcn/iUgX/1KvOSPQww9+Nj2Hxh/roqDnjglsu/plEsO/
	miLeem5ahIX+bdmlfIlmCIVVlt34kCvJWOy0QDkddOAIto871nbE+P9UUrQyBWcOeIwN3FhnH0n
	eMEH2mjnTbeJeXNsWatLcD6QQJIwmjtSF4/zRR46hCOixfPraU7macNUbhSkgckl8NkahQTdkJo
	g1ooeFKa
X-Received: by 2002:a05:6122:21ac:b0:56b:7484:39b with SMTP id
 71dfb90a1353d-56d21f1c789mr250296e0c.4.1774367881131; Tue, 24 Mar 2026
 08:58:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aaN5OPgoGANYlabu@Adekunles-MacBook-Air.local> <aafga8AjpxagiEJt@Adekunles-MacBook-Air.local>
 <CAP8UFD16pvfP4UYJHCCenK3c1-VNTJPpMBJL_LnHZZZXUC5ULA@mail.gmail.com>
In-Reply-To: <CAP8UFD16pvfP4UYJHCCenK3c1-VNTJPpMBJL_LnHZZZXUC5ULA@mail.gmail.com>
From: Samuel Abraham <abrahamadekunle50@gmail.com>
Date: Tue, 24 Mar 2026 16:58:00 +0100
X-Gm-Features: AQROBzA6oIrEL2en3jd3bjLBZ0zZcKCDhJE5IA14L73JapG6DZ0B-UdEBM0yPNU
Message-ID: <CADYq+fZfaFyOd++wT3gTbMNxT7ArGEzmYc09ydOHuSAnu5QcFw@mail.gmail.com>
Subject: Re: [GSoC] [Proposal v2]: Implement promisor remote fetch ordering
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>, 
	Justin Tobler <jltobler@gmail.com>, Siddharth Asthana <siddharthasthana31@gmail.com>, 
	Ayush Chandekar <ayu.chandekar@gmail.com>, Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>, 
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>, Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 24, 2026 at 1:29=E2=80=AFPM Christian Couder
<christian.couder@gmail.com> wrote:
>
> Hi,
>
> On Wed, Mar 4, 2026 at 8:35=E2=80=AFAM Abraham Samuel Adekunle
> <abrahamadekunle50@gmail.com> wrote:
>
> > When a Git repository is configured with multiple promisor remotes,
> > there is currently no other mechanism to specify or optimize the order =
in
> > which these remotes should be queried when fetching missing objects.
> > Different remotes may have different performance characteristics
> > such as characteristics, cost, or reliability which makes the
>
> There is a repetition of "characteristics" above.

Oh thanks

>
> > fetching order an important consideration.
> > Currently, the promisor remotes are queried in the order in which they
> > appear in the local .git/config.
>
> There is the exception of the `extensions.partialClone` config variable.

Yes, I stated it below. I will probably bring the statement here.

>
> Also I recently sent a patch series that might change things (see the
> first patch in the series introduced by
> https://lore.kernel.org/git/20260323080520.887550-1-christian.couder@gmai=
l.com/),
> but it's not merged, so don't rewrite your proposal to take it into
> account.

Yes, I took a brief look when you submitted it to the mailing list yesterda=
y.
Thanks and well done Christian, I will keep up with the series.

>
> > The project aims to implement a fetch ordering mechanism for multiple
> > promisor remotes that allows a client to be able to specify a fetching =
order,
> > a server to advertise an order to the client to ensure performance
> > and cost management, and the client to decide to use the server adverti=
sed
> > order or not, and default to the current order if no order is specified=
.
> >
> > Review of Previous Work:
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> > The project is part of the Large Object Promisor "LOP" effort
> > documented in Documentation/technical/large-object-promisors.adoc.
> >
> > In a bid to better handle large objects, the promisor-remote
> > capability was added to the Git protocol v2, as documented in
> > the promisor-remote section of Documentation/gitprotocol-v2.adoc,
> > which enables a protocol negotiation so that the server can advertise
> > one or more promisor remotes and so that the client and server can
> > discuss if the client could directly use a promisor remote the server
> > is advertising and if an agreement is reached, the client would be
> > able to get the missing objects directly from the promisor remote witho=
ut
> > the server acting as a relay between the client and the promisor remote=
 when
> > fetching missing objects.
>
> You might want to split this very long sentence into a few smaller ones.

Okay I will.

>
> > The ground work for adding this capability to the v2 protocol was
> > started by Christian Couder in [1], where if the "promisor.advertise"
> > config is set to true, the server can then propagate its promisor remot=
e
> > configurations to the client over the v2 protocol during the negotiatio=
n
> > in the form
> >
> >         "promisor-remote=3Dname=3Dprom1,url=3Durl_encoded_value1;name=
=3Dprom2,url=3Durl_encoded_value2"
> >
> > The client can then choose to accept some promisor remotes the server
> > is advertising using the "All", "None", "KnownName" or "KnownUrl"
> > configurations as values for the "promisor.acceptfromServer" config opt=
ion.
> >
> > In [2], Christian added the option for a server to advertise more
> > fields after the "name" and "url", such as "token" and
> > "partialCloneFilter" for the client to use this additional information
> > in deciding the remotes to use as its promisor remotes by comparing it
> > with its local config information.
> >
> > This was implemented by adding the "promisor.sendFields" and
> > "promisor.checkFields" config values to the server and client respectiv=
ely.
> > For example, if "promisor.sendFields" is set to "partialCloneFilter", a=
nd the
> > server has the remote configured like so:
> > [remote "foo"]
> >         url =3D https://pr.test
> >         partialCloneFilter =3D blob:none
> >         token =3D "fake"
> > then
> >
> >         "name=3Dfoo,url=3Dhttps://pr.test,partialCloneFilter=3Dblob:non=
e,token=3Dfake"
> > will be advertised by the server to the client who can then decide,
> > using the "promisor.checkFields" setting, to check if the passed field
> > matches certain conditions before deciding to use it.
>
> The "promisor.checkFields" config variable is not quite to decide if
> fields can be used, but more to decide if they should be checked
> before the remote is accepted.

Okay thanks.

>
> Using the "promisor.storeFields" config option is better if fields
> should be used.

Yes thanks

>
> > This work by Christian is very crucial to this project as I will take
> > advantage of this and enable the advertisement of a "priority" field
> > that the server can use to communicate with the client in deciding to
> > use the server recommended fetch order or not.
> >
> > in [3] Christian also implemented the option "promisor.storeFields" whi=
ch
> > allowed the value of the configuration to be saved in the client's
> > configuration file for use at a later time.
> > As above, this option will also prove important when the server adverti=
ses
> > the "priority" field as it will allow the client decided to store it in=
 its
>
> Maybe: s/decided //

Thanks

>
> > config settings for that promisor remote, for later use when fetching
> > the remaining blobs from the promisor remotes.
>
> Yes.
>
> [...]
>
> > High Level Approach to Project Execution:
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > 1. Introduce the `remote.<name>.priority` config option:
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> > As said above, when fetching missing objects, the order in which the re=
motes
> > are queried depends on the order in which they appear in the config fil=
e.
>
> Not sure this is worth repeating three times.

Okay

>
> > To make this flexible, I will introduce the `remote.<name>.priority` co=
nfig option,
> > which will allow the client to set its preferred fetch order to each pr=
omisor remote
> > configuration, and then make it fetch based on this "priority" order.
> > The value of this option could be an integer between 1 and 65535, where=
 the smallest
>
> Why 65535?

I considered if the value might be stored in a small unsigned 16 bit
integer type
and also it will have enough room for many priority levels.
But we must not use the exact range (0 - 65535).

>
> > integer indicates highest priority.
> >
> > This will allow a promisor remote be configured as follows
> >
> >         [remote "prom1"]
> >                 url =3D https://prom1.com
> >                 priority =3D 10
> >
> > Therefore when the client is configured with more than one promisor rem=
ote
> > and the prority is set for each promisor remote as follows,
>
> s/prority/priority/

Thanks

>
> >         [remote "prom1"]
> >                 url =3D https://prom1.com
> >                 priority =3D 20
> >         [remote "prom2"]
> >                 url =3D https://prom2.com
> >                 priority =3D 10,
>
> [...]
>
> > 2. Community Bonding (May 1 - 14, 2026):
> > ----------------------------------------
> > - Discuss design details with community and mentors
> > - Understand safety, security constraints and design considerations
> >   when implementing fetch ordering.
> > - Read indepth the Documentations for promisor-remote, gitprotocol-v2,
>
> s/indepth/in depth/

Thank you. I will make the changes and send a v3.

Thanks

Abraham.
