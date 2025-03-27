Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB4CC20F066
	for <git@vger.kernel.org>; Thu, 27 Mar 2025 10:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743071365; cv=none; b=bscDzGP6cZZ3mO0EjpoSsUQMc5RAqJNrxCmW6dBsT6TDcuzGbSN0Mxoll4XuEQyMZGDQLkDKjxV+fEcj03Vh4aTzjhVTMfP5/nbmKpKLwbj9WOrD1rn7+cj3O4vuEaGSDQ6zHvDdhWZXBdyjhDZ9kOqhBha2H5srwVLzpvfJ8x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743071365; c=relaxed/simple;
	bh=RUpo7h66KaRbLLlpDhD4hQ6JwizDMFjGAnssrFgIbB4=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=CIXNo4PdK2HJvvhbDm4wV3rOoEeK7EqPrZJBq/jxfzP96TcjwI6kKAOIshvgtc3TAB1dL5nGAbNXrEwpnS96B3OlFGQvilvm/3wotdVzsWXwzZiJ834Rl/HQe8Q/xg5NztWnk8jtgIAc+S/s3cu/wZ5Gzk8e+b4OTigv6eYKJRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=jQblXHRj; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="jQblXHRj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1743071356; x=1743676156;
	i=johannes.schindelin@gmx.de;
	bh=FQZBZAVVRTuJLSUy1OhSrSgbuB4vjWC+mPH8BrctKgQ=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=jQblXHRjcUz3nlF8nH50Gt4ijdeE9+nzFj2jNqK8DJ1UYJdivr7naPyGHmPn56il
	 M3thRWzVjZ3Hh0heYL0ZcVUloqOB+8MbLANhf4PXxHHnZu6zaWuA1qsB21bAdvlPh
	 i00cLOUE0rVzXwJwG8zIsEXiUM0y+e88cHa3opiNdLF+8NdXzamWoMyemNAf1KUgx
	 NrYZN9bWTJXN8aQ32L8UfEko5cQaZetu3xefHUEPYAR01SiGB7AjLQVHcsXKbKnyo
	 p+EY0AxM1HFuJEiTqHu3ysVGUVfRXg9oUlyKvdM1fapEqq6y72suPkYpxdYjPg58c
	 DxtH81Ns+JKd9aodeQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([213.196.213.156]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mlf4c-1tGPJG31Vq-00fXqu; Thu, 27
 Mar 2025 11:29:16 +0100
Date: Thu, 27 Mar 2025 11:29:16 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Taylor Blau <me@ttaylorr.com>
cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>, 
    git@vger.kernel.org, Philip Oakley <philipoakley@iee.email>, 
    Patrick Steinhardt <ps@pks.im>, Phillip Wood <phillip.wood123@gmail.com>, 
    Karthik Nayak <karthik.188@gmail.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 08/10] compat/regex: explicitly mark intentional use
 of the comma operator
In-Reply-To: <Z+RlEwwTvFkUWwkT@nand.local>
Message-ID: <1c8a3d80-5817-1e2a-de8c-06046d372fea@gmx.de>
References: <pull.1889.git.1742889711.gitgitgadget@gmail.com> <pull.1889.v2.git.1742945534.gitgitgadget@gmail.com> <dc626f36df34df4897289e508dbf608512a93870.1742945534.git.gitgitgadget@gmail.com> <Z+RlEwwTvFkUWwkT@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:NS/6zANdKbTYMVlIEI1EPX/TQ3YyAg+jvZc0NHs9xbU6vxO50Do
 WU9z73SgKwJYu0Vno7GySXiJHqhkQflB8eZ/v88sXnGm4Y4Y6eM7hMVAvL9NiUFXWBxF7um
 h9B/wwqDTxP/U/zl+tai1/CJvA18Xs7+Ar+u6Mf+ANwISJd1et630g7N1ZFfAajpqIChldn
 Lj7hM5C6/oSKb/d9N2eJQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:VbVaH8lg0iw=;2SOv9wWfhQAj+eix/09HDE01Dwt
 arePVPzkd1gZGnQUKTuW59O0Jqagix3eKDhAAuMmGlmY/zqY+EHJ5GNi8LSO2rivECGQBYYCH
 C2EK9+HsPkAc/84XaQ60SEKDtIwpfjGzjrwj7lqKOByqauI+ncsz/egP0MNeRpVRkmM0kqrb4
 uduPUtvSBgXZYoVQBey+yXp/JjkPsXdZYTQjvQaLSFQyIBx2D0CY1dogj4LDl/JaJZeV7C/ie
 VVr0u4FWEsRQHe84vCimbErEI/LindNIYgHdJJNtKxOMtksG4XxOcMK7IFJkeGQiTJ9KPAxDw
 /byvkFrSKo+YZ0JOY6ovOgoiGr886bnr/nEzUMq+J2/BcZz1u9nBtruWhACcA/AqqTi7MR5O4
 gKLQ2KBe+wvWkCe0dMoPtQ0G6rnganZMPC+x0XReln7GxyzOrpACjL8ymN7ssXbOy+UD9ZdmS
 Zbzh/JMSGYz5mzLLCbA4Mi81vvXgZA17BAxxTCpEpjdKpalqeO9qL9zMSkrtbWfQjJP5VgSac
 492pxHScagVz3BwLBWS/EFPRhekBR5hD+a8WOCyvUq9D2Vc/AebO7skDF+Y+k1MWcyUqJeQSa
 PpzVGZmLZ8BYMjGGWqCQdbf9a+fO4cXY6CJ95XUPXXav0r9dm7rvRldIgEarbegkRnt5MGW++
 oUir6tA/QdkdqSdTTMFYoMdb6/9MrmPJo5FUt3X68MtcxsZ6MGFrfXSpia0RlGDwReJo12OSg
 r5eEv7YorlfSV8anOOOsQssiPt1nCM74eg0FtNV/aHWKwGAqhgRVhNYO6ewBu+etF37IeKder
 hG9kfl51c2K+ZnCM2bpL3886mOpV1Jj2Kv5EWOlhtYKkIyiv3Tu52Jj7xF+sC0r702RPRkXLG
 D7AIN90/YbTbSweE+eeVHSX4dHkIbqQmbhnwBSDWa0b3EDiJTRZ0Nbo8ND0PO5noolux8OTgt
 SQv1ouDirBELu1G/SvcaBYt+UqbMePuFEtbDHv4VxPeYIzTOWbQ6s/7VwbI3QO1FSfOO4awhb
 DWG5F5zE7cWaqWmfETpuRmqmNC1WCpmnjlcENA+CkufULQAMQ/RJWvRxbgGrzE74Ve195ZVCW
 DP+vU3ZTF3jeK+oEkLggeRsYKssSxuWCQUfp7mBpqqlNZIoHueaPG0ChqvSMqOzNaPHQ9Kl+M
 Hz6rIVbcPgpVjVKIlYBXM/Zxo88rlNMlD89pyexqwH5UMwhyf8Es4C67Jwpbup5Sc+BOeJ8yV
 i2xQk4bnfdg9QNvOiiQNI0Y1azH0FqVEwBUGD0X3dKPi4iSEpSkcVcHnxXsxQHg1R3O84yZHu
 VFaiVfGEJeIspL6pW8eglo3RcmVikogFzK0/NVmwWgF814oTPRkl5QB0h5OZ30+gWrbKcpcfh
 unY+Xuwup4ZzND+WlzSdWh1cH7S/EgP1BpQ9dszOAV2azk5stGYzUz5RRoOamSaElGw3VClSQ
 kya8PFzrSfUsBuOj+9faGgNWIKk+gf6bu9p51NaiVOdNPPJoN
Content-Transfer-Encoding: quoted-printable

Hi Taylor,

On Wed, 26 Mar 2025, Taylor Blau wrote:

> On Tue, Mar 25, 2025 at 11:32:12PM +0000, Johannes Schindelin via GitGit=
Gadget wrote:
> > diff --git a/compat/regex/regex_internal.c b/compat/regex/regex_intern=
al.c
> > index ec5cc5d2dd1..7672583bf7e 100644
> > --- a/compat/regex/regex_internal.c
> > +++ b/compat/regex/regex_internal.c
> > @@ -1231,9 +1231,10 @@ re_node_set_merge (re_node_set *dest, const re_=
node_set *src)
> >    for (sbase =3D dest->nelem + 2 * src->nelem,
> >         is =3D src->nelem - 1, id =3D dest->nelem - 1; is >=3D 0 && id=
 >=3D 0; )
> >      {
> > -      if (dest->elems[id] =3D=3D src->elems[is])
> > -	is--, id--;
> > -      else if (dest->elems[id] < src->elems[is])
> > +      if (dest->elems[id] =3D=3D src->elems[is]) {
> > +	is--;
> > +	id--;
> > +      } else if (dest->elems[id] < src->elems[is])
>
> Should the other arms of this conditional have matching curly-braces?

No. Have a look around in that file, that's not the coding convention.

However, a valid concern is that I used Git's convention for the curly
brackets (appending the open bracket to the `if` line), which is _not_ the
convention used in this file, which uses GNU conventions instead. I will
address that concern in the next iteration.

Ciao,
Johannes
