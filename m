Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0686A239562
	for <git@vger.kernel.org>; Thu, 14 May 2026 17:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778780749; cv=pass; b=C7exCw3/opm7PQCK+UVPxDXjXQW2I6HtyR9JcSuQttsY52QOhKRlfnM+vtQYdQe43Nmm4NsLvH1hx9x53d3nxCDXUsQqS2jdl1vsN0jumaR2Mjw5TvuzgHiUE38nEK4ggwf/EJhB4GpTU83AvJsYa/grBviOLN25Um0D35vQ/I8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778780749; c=relaxed/simple;
	bh=ToAkUBxRB+iW5zEKO04oEJeuLfUO2WN4k+dhN/+McS0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P9vmr6tBvAa0d05G+Nq9XHN0Q2PpIM8m9LzHQiSLX0S4zJjkkeokYhcr2vMWooY1Xwsh5rdfB7dtk5McqG+ucDPdtSMH49KHZfxTIFG3YiS+vsHu70tSNUUt6g5RHe6MGMHRbphbCWo5ukBcpnAsYyXKUz1RKRxSXtOEVfQn1lQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A0OpEl4u; arc=pass smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A0OpEl4u"
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-65dd9b25829so4738126d50.3
        for <git@vger.kernel.org>; Thu, 14 May 2026 10:45:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778780747; cv=none;
        d=google.com; s=arc-20240605;
        b=goOyp4EXwzR0S6etBLp+OpYYYCLK31U6u7upu6O0+qXIt3ynpj2VeeSwJ/6ugZyk3W
         Txrj1Xj5mO2pvjLMWFsJPPp/7wZD0XEhEJ5jIKyFmW4hC7eMJEA2HScgq88byObo5ivL
         vJ78LuY2hbiiLVmc7nqr+uc4+E7QGqHeVc/HeTT+MASw3vlfrttkCqclE261r3gIDDAM
         3iHrr6KOgwkO1hYaC7Il+8DZ4oZ6PY8IT/wigcbN4IGfmFBC8ExuKe5EMODsvP/96Aoa
         /9mtSZY1XJeyk//DLrvEf+0yk512JB1mfq8UKK5Uu+0J0PiQ7uBKqwByziLA7xeBHLyO
         zoqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wx8T2d70QmSg8NHe/C1mZvkCrtMHCjmzXc4369ja9RY=;
        fh=Qwwp1ngPemnQzBY2BoLoy64AzminAM50aHvg2nDhZAo=;
        b=AloNfcSjJ64CuENFYZ88aIibWIachyZpMiEpmhKBdsc0YsTSTCO7VE+g3iOH1F7bY9
         4kh0vIVRWd23+2gJA1edmsgx5BZutmp52sSMLEmfCSKil74FWazRSRJfDG4tXka9zL/G
         EKzC8e6Z2t2z6T2/Dtu+YcIMPVQBUYCE9/FFpG1I+sLZ13Cglbj5y2OfqB5arM0NGoVZ
         k/Ah2Er+sxL3DBOPw8mh7GNOIicAcOay3+Jho0yDTkP5Ho3pDdowyuMdE/8tGWseXbE2
         xLq2xhX2ibiw/1nxdPzHQQZnMeUPuJ4se95ld5bWJoR3PdWKn0uWYsej8LpBhLUym87t
         l3rw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778780747; x=1779385547; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wx8T2d70QmSg8NHe/C1mZvkCrtMHCjmzXc4369ja9RY=;
        b=A0OpEl4unb47mmsZYko7TyN1tA3V/iIsO74gE+ktS9RkBG2I5Ml81uPm/nh3L0vXu0
         y2UAkrLq5DS7SvYXS+1QmqoAnUiOO7l5LUIYwbx6eTusFdRnsqmj+xYuPx6qZNGkylbI
         KkMg4ExiNi4gnPy8Hws+kZW3CicTQhMVxuXFLYBVXUrVoawllxG9neOw4OiTCLrjm/C5
         aI2MqXf+iSTqZl8XAJ2fplIr8+bcZ3UphaIRArEeGGlL5jRjTp9qB6kyni+DTBp57mMg
         7CD5uaTAjVLqxBbfsHhyK2Q3aQuwlmEQeT4drQBSIzlOYIPXGBNy98cteQwVkenIHw8m
         76Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778780747; x=1779385547;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wx8T2d70QmSg8NHe/C1mZvkCrtMHCjmzXc4369ja9RY=;
        b=Hc9BGCTMhw3F0dL/8FCRCvl/uZid/3WcbwNTdZFP4CHbC53nHN0z5kiMOmmFr/VCU3
         0ET7WvYYPLCyfkkIAMyWEJND2n3gf46LGcznkpOeYkt3apWNR3+9qk7Q5whZYScGcO2I
         uScA7eobJFC489gkfB7aHhDGi35HucUOXG3Z9CmvwH0RifEWsbIjJ+JODkjVL8HM8Egq
         K+Te9u8MuNZdurSVSJYrClvcSz2pLtw3PFaoH2y/Ub6yOjmDFeuB8V72dW/SPL6bGxtG
         YF8go+fJ+ovu/hjFRMnCQS+p9XHk42eIHJ3Ke14RzfjVyMuR8woiFHd0fvvKWWdpCMx2
         5A/Q==
X-Gm-Message-State: AOJu0Yzzv/hMnmgByT2m+31tzHoizvOEAFYZGdk6SYPC8xor+hrxqXyY
	U3PjNf8lo5+/hT1ZqMlP4Y97Wrb35Xn/f7QZsTKu0/3If3L8Kv7f4kMhOiVeTG6tck/yJct6OnR
	F70Sv529aZzowvjVBCyaqjZuwNe36bJw=
X-Gm-Gg: Acq92OFI4YD0JbLu2RkCROr6aAJ+i4mCozDpZv/Fi63wiTEBH0Gqc0IdR88Y4ZXnB1F
	/vIQXfrdoBfB7IPhSSCujTRYWIeNByibOsbnldLaL5dooniFGGh8FHplHvQsEpf6a7KKrU81dy5
	81HUtSO3TlIsJE/hzI1GHtNquJoPSGSEBg7hI3dY0GjlxAs5ABgszbil99+5F3zbQvREqo5e8oZ
	L7e0gh19NGy1XvKfHPfagMFJkGhHFBCY2ByneqWjAhfnt0kKEaUn7v0XqOUzKz1sXEObNRLTyhR
	xPvmk5JfaK3gbGygV9xVd58afZar+zC98rfrpZpyD86Ap9bltjDMXTauDgW4xp7otj3mj7RKs6g
	8WOzTX1LKHUWy4nVhHrumYWnFIzEV0C9dEPdMl3tsj3MRmFFGo1apj0G0w1WhWNGlvFdP6CyXaW
	TcyJUUMzFKatQiFAWk
X-Received: by 2002:a05:690e:150c:b0:64e:ebb4:1bca with SMTP id
 956f58d0204a3-65e2274f1famr228626d50.27.1778780746805; Thu, 14 May 2026
 10:45:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260402211717.3604688-1-pabloosabaterr@gmail.com> <26d887d2-6ec2-4af1-b0bd-8e9b017bb4dd@gmail.com>
In-Reply-To: <26d887d2-6ec2-4af1-b0bd-8e9b017bb4dd@gmail.com>
From: Pablo Sabater <pabloosabaterr@gmail.com>
Date: Thu, 14 May 2026 19:45:31 +0200
X-Gm-Features: AVHnY4Kw1S2C-Pxoz2Ju8tfHBEFji2BZwgUv79tnpm21e2y53Uz0tzc-9pDrmAE
Message-ID: <CAN5EUNQCsKD0CJqDi43i2JVBQQChAZVt_THQ1wGpdeydNHHCFw@mail.gmail.com>
Subject: Re: [GSoC RFC PATCH 0/1] graph: add indentation for commits preceded
 by a root
To: phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, gitster@pobox.com, christian.couder@gmail.com, 
	karthik.188@gmail.com, jltobler@gmail.com, ayu.chandekar@gmail.com, 
	siddharthasthana31@gmail.com, chandrapratap3519@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

El jue, 14 may 2026 a las 17:15, Phillip Wood
(<phillip.wood123@gmail.com>) escribi=C3=B3:
>
> Hi Pablo
>
> On 02/04/2026 22:17, Pablo Sabater wrote:
> > When having a history with multiple root commits and drawing the histor=
y
> > near the roots, the graphing engine renders the commit one below the ot=
her,
> > seeming that they are related, which makes the graph confusing.
> >
> > This issue was reported by Junio at:
> >    https://lore.kernel.org/git/xmqqikaawrpx.fsf@gitster.g/
> >
> > e.g.:
> >
> >    * root-B
> >    * child-A2
> >    * child-A1
> >    * root-A
> >
> > [...]
>  >
> >    * root-B
> >      * child-A2
> >     /
> >    * child-A1
> >    * root-A
>
> I'm rather late to the party here, but personally I find the indentation
> a bit confusing, it would be clearer to me if we had a blank line after
> a root commit

Hi,

>
>      * root-B
>
>      * child-A2
>      * child-A1
>      * root-A
>
> It takes the same amount of vertical space but keeps the children of
> root-A together.

I have mixed feelings about which approach to choose.
The idea of a blank line was thought at
https://lore.kernel.org/git/xmqq8s8vvw9m.fsf@gitster.c.googlers.com/
but Junio argued against it for having an extra row because the
indentation he proposed didn't collapse, however I find indentation +
no collapse the most confusing one.
I'd say that I'm fine with both approaches, blank line or indentation
+ collapse.

> > without the patch:
> >
> >    * A root
> >    * B root
> >    * C root
> >    * D1 child
> >    * D root
> >
> > with the patch, the indentation cascades:
> >
> >    * A root
> >      * B root
> >        * C root
> >          * D1 child
> >       _ /
> >      /
> >     /
> >    * D root

  * A root

  * B root

  * C root

  * D1 child

  * D root

Here I think a blank line looks worse, too much space for just 5
commits and becomes one extra line which if this were like up to 7 or
more parentless commits one after the other would be more noticeable.
But there are cases that blank line might be better:

  * 10_A2
  * 10_A1
  * 10_A
    *   10_M
   /|\
  | | * 10_D
  | * 10_C
  * 10_B

Feels like a shower of commits instead of an indented merge.

Pro to the blank line, the parentless check is the same and it's just
printing a '\n' at the right spot, while indent i'm mimicking like if
there was a commit there.
Anyways, I think in the majority of the cases the indentation +
collapsing looks better.
Sorry for the brief reply, I'm busy today.

Regards,

--
Pablo

>
> Thanks
>
> Phillip
>
> > This is done by adding a is_placeholder flag to the columns, the root c=
ommit
> > is actually there but marked as a placeholder
> >
> > e.g.:
> >
> >     * root-B
> >    (B) * child-A2
> >      /
> >     * child-A1
> >     * root-A
> >
> > (B) would be root-B column with the placeholder flag active.
> >
> > Then teaching the rendering function to print a padding ' ' when meetin=
g a
> > placeholder column outputs the second example.
> >
> > There could also be the case where there are multiple roots
> >
> > without the patch:
> >
> >    * A root
> >    * B root
> >    * C root
> >    * D1 child
> >    * D root
> >
> > with the patch, the indentation cascades:
> >
> >    * A root
> >      * B root
> >        * C root
> >          * D1 child
> >       _ /
> >      /
> >     /
> >    * D root
> >
> > the _ / might look weird but that's how the collapsing rendering does i=
t
> > for big gaps, this case being from the 4th column to the 0th column.
> > Another patch could change the collapsing rendering for placeholders ?
> > I haven't done it to keep it minimal, but a follow up could make it
> > to be straight '/'. This would make it bigger but easier for the eye to=
 follow.
> > IMO is not worth it, but opinions are welcome.
> >
> > The patch also adds tests for different cases like a root preceding mul=
tiple
> > parents merges and the examples above.
> >
> > There could be some edge cases still so any testing is very welcome.
> >
> > Pablo Sabater (1):
> >    graph: add indentation for commits preceded by a root
> >
> >   graph.c                      |  68 ++++++++++++++++--
> >   t/t4215-log-skewed-merges.sh | 136 ++++++++++++++++++++++++++++++++++=
+
> >   2 files changed, 198 insertions(+), 6 deletions(-)
> >
> >
> > base-commit: 256554692df0685b45e60778b08802b720880c50
>
