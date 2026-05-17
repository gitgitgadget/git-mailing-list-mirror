Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6593462809
	for <git@vger.kernel.org>; Sun, 17 May 2026 06:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778999548; cv=pass; b=uOHlqrLaJFYJB3OeD8UdfjZZ5/bDbyruV6dNb50rW5CvNqy7tZZScB/aG9Xo9I1zQNpdA4NH5beJyq7W6Z+u/h2cPR4aGBJhgfPQpDYingksVg/j215uCVdF0Za00BhsmgwVl5GhgoNje497yKifnihIuq5Z/WSoAeQMP6QdQb4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778999548; c=relaxed/simple;
	bh=90oXqwWXzejocELnWypulPvhmMfkh5gL/d0QavIKoiA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jcqDJclYBI7ogJvC0eNmROwLxXbGdKqPo6otutxUSBMXJjihSz+OKIlBJro3dLWrzTq34Z+l/eTOSBhnXk5BLiWulqplEFGHmMWA3TERIlnu1fAMMIvnnSHy/EIbEoROSu4eqFwI6b8o0Q1GH/BGMp01o2fYdQjol9SongWpgnE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J9IIgSXF; arc=pass smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J9IIgSXF"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-bd373f83042so285433166b.1
        for <git@vger.kernel.org>; Sat, 16 May 2026 23:32:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778999545; cv=none;
        d=google.com; s=arc-20240605;
        b=Vb1Nf5EtHaBSzNMYAxTXauMuvLxufrqhvyFRJI8P8WhHVyTwieTPfwovk3Ic2fgBeG
         pjMHbbFoS5PDCtKeszpngq+lg2YnxdPYHaXh+K6lLLu73tXVwO81NpREyxz/G/pXOYEb
         sgm6kA825xb3cyLwElBV/AQvYtkZchLueL3+QIMuC9euXdKr88J5qei6HNCvtE3ff0NT
         HSuf55aIO1RP7z43LkiOImJSP5wOqNK6+KJRnRkwXIVwl00lEb/ylEq2ovupRS4vvFNa
         SokxWwIihdsezboPNv60t/wN5u2dDzh9lg+ogBOGzYVGNP8yEXwEiixxne1uCqh8Qaor
         O5yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wg9YbzgpyxiFvh45L1zxcd5IQUNPhUwLysmfp6dEitM=;
        fh=PVEDoZoq66bB/JlLfaoz5LRZ3cOSiXje7RVJr6eNkBQ=;
        b=Ar/yGH2WFR/72uo7Aa16WVrUCrsAhIUakTSoEZCzV3XZPNEJsO8Sc2dwopXEGyII9P
         YKvWwAh4k5mutlEo8ch8hMlHSxmB5XJl1/kPfSFw6iMnYbxoe43aGPo1KqRAfo9KZKUa
         oeZo/qMPIeoxnJNDcX2HJMBIFpeZYIDzPCcJksOUs95fCFff3BeZestgHfjgPyP3hMZF
         ny6mjlQ4fGm4JA2/7ljZNTC5g7NGWKiFT6oCstvjyBkXN0KuLHHhoc2+S1ySNdW90Xty
         /lDKEvnypNeqwEFuiEuj5rUxz1fJTFxAxXwpmiDuUmqBhPHBF3c2YisuUhsldrQuWjn7
         X6TA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778999545; x=1779604345; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wg9YbzgpyxiFvh45L1zxcd5IQUNPhUwLysmfp6dEitM=;
        b=J9IIgSXFBuGJr7CfE+UpQ6AHSwjM9Ltd/k5T7GOLVxsIJ/VGlwT83UpvtVAzFwvwwH
         cB2HV5nJMwB0f2IsFUAK8OT5l+VP6p9viWCX42KZoj0OnlRmmUwf2McoWY1zC2WNTD3d
         nMzuDArczzmMbXkDqxYkkZjPtAqUgt8/Pbt4p93+dEY+Jmoy4yqUAv+01BGgAqGAfWF5
         f3wvo+BRTvnfH8ME0muCzWosP4ujZrzzCiUmIQ5878h3kQKUsvupUoif0gPmapdcWDrm
         6HP0fAynOpkJ3579eu47/9g8P+h54aXFSRBHRvI5yHw2E9p8CPrSwcamut3J18kQvNEF
         Owcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778999545; x=1779604345;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wg9YbzgpyxiFvh45L1zxcd5IQUNPhUwLysmfp6dEitM=;
        b=c7OwI/Q2KHZ/G7eu9sG5505PmN/Zf6RNxY51e1Le783H6liyJ4Au1MYOgLtWR4SkwL
         UvmH0+2QRuRzY+tYE/0RLkIIvRG1mYlbGyKswXzzbqcIoOX1DwA+kFw7uPNw8ttibuIo
         UkEVD9BlAY0chjKxLEuvX3SbV4MtZmzWDdTwQ38W3KJ9thM2BUB7E8BUpGt3hF/NwnPO
         HSKTOCqS1dqhTG+zPKHqVQ5ARgTNyb0RM92611AfHfgvjOWl0ztxjelDcCfUKbWfiaTC
         rLbLO7oGhaiDZSVRmyYAzY7YaQI8aWhKXJeQs0VGICSooww3oMQii+7iBlTcYoTkJEwJ
         MMbg==
X-Forwarded-Encrypted: i=1; AFNElJ/s5KOeWYfTaHc+uJZEDUACM9ZNt3BGua83YT1bJihTTw/M5Rl7qYNBXuR8nZbeyIwcI1o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/Vr1toR2HmNVsQlnkm3OGIak8nDqdvvLHmANQjywR8HRleWO4
	r90jiOm/H3FQD3R03w0/fJT0eSBxM1/1NLCC3SAkknaJE9JyQXZY+UV9JC6Ko/awHCPxUQE2/FT
	I0iFgPgqRCAMNHUEMLO833BBHyfoASF4=
X-Gm-Gg: Acq92OEL2W+Z/sSOd7zu/2FzIC8up4BNpcGpzGnsxp0QoUubGISIyfqPV6i8O15ucJY
	5ayU9btFZElEhDK9znBIqq+1mn3tKr1h6hdCxMVFFfkPB6fecw8OkAoMQJg8Dq6wqq6xqtD6j97
	anxUO51QLhzVnVqCQgA4RHi9hslG0dSgbv7b/UDmr4piY81FtnzzmmWLtKG322hoQgbBm4+M20R
	pMbOFdlBd/Vbr2WLgXoojL6P9XhJ9qQZEw9xLLryJUJinzOU5Apra+z9es7xuIMbx8uorqZseuR
	tvtw6mrp0QmEzxp+4PQKWJAJ3Vzuk/sRmhjr47smqjvWeXEPaWZqO6/pioCrJ1Tz+3L8TgnoxGv
	HNDmJeBlkXHZNEGEgTjQmtQ==
X-Received: by 2002:a17:907:a807:b0:bd3:cb24:ae61 with SMTP id
 a640c23a62f3a-bd5177dac7bmr583181366b.6.1778999544481; Sat, 16 May 2026
 23:32:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260402211717.3604688-1-pabloosabaterr@gmail.com>
 <26d887d2-6ec2-4af1-b0bd-8e9b017bb4dd@gmail.com> <CAN5EUNQCsKD0CJqDi43i2JVBQQChAZVt_THQ1wGpdeydNHHCFw@mail.gmail.com>
 <2e8b9b1b-6a69-4e94-95ea-7f587435bfce@gmail.com>
In-Reply-To: <2e8b9b1b-6a69-4e94-95ea-7f587435bfce@gmail.com>
From: Chandra Pratap <chandrapratap3519@gmail.com>
Date: Sun, 17 May 2026 12:01:57 +0530
X-Gm-Features: AVHnY4IJPqHQ3WH3MplZ3loZOfX-_ckK0GGHdffvDQ08lWG0b_8DS3QSF35E5kg
Message-ID: <CA+J6zkTGgeNuH0eusTy+t8LO3bjygSz4svJB=K4R5ASmBdd0uQ@mail.gmail.com>
Subject: Re: [GSoC RFC PATCH 0/1] graph: add indentation for commits preceded
 by a root
To: phillip.wood@dunelm.org.uk
Cc: Pablo Sabater <pabloosabaterr@gmail.com>, git@vger.kernel.org, gitster@pobox.com, 
	christian.couder@gmail.com, karthik.188@gmail.com, jltobler@gmail.com, 
	ayu.chandekar@gmail.com, siddharthasthana31@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi all,

On Fri, 15 May 2026 at 15:03, Phillip Wood <phillip.wood123@gmail.com> wrot=
e:
>
> On 14/05/2026 18:45, Pablo Sabater wrote:
> > El jue, 14 may 2026 a las 17:15, Phillip Wood
> > (<phillip.wood123@gmail.com>) escribi=C3=B3:
> >> On 02/04/2026 22:17, Pablo Sabater wrote:
> >>> When having a history with multiple root commits and drawing the hist=
ory
> >>> near the roots, the graphing engine renders the commit one below the =
other,
> >>> seeming that they are related, which makes the graph confusing.
> >>>
> >>> This issue was reported by Junio at:
> >>>     https://lore.kernel.org/git/xmqqikaawrpx.fsf@gitster.g/
> >>>
> >>> e.g.:
> >>>
> >>>     * root-B
> >>>     * child-A2
> >>>     * child-A1
> >>>     * root-A
> >>>
> >>> [...]
> >>   >
> >>>     * root-B
> >>>       * child-A2
> >>>      /
> >>>     * child-A1
> >>>     * root-A
> >>
> >> I'm rather late to the party here, but personally I find the indentati=
on
> >> a bit confusing, it would be clearer to me if we had a blank line afte=
r
> >> a root commit
> >
> > Hi,
> >
> >>
> >>       * root-B
> >>
> >>       * child-A2
> >>       * child-A1
> >>       * root-A
> >>
> >> It takes the same amount of vertical space but keeps the children of
> >> root-A together.
> >
> > I have mixed feelings about which approach to choose.
> > The idea of a blank line was thought at
> > https://lore.kernel.org/git/xmqq8s8vvw9m.fsf@gitster.c.googlers.com/
> > but Junio argued against it for having an extra row because the
> > indentation he proposed didn't collapse, however I find indentation +
> > no collapse the most confusing one.
> > I'd say that I'm fine with both approaches, blank line or indentation
> > + collapse.
>
> I'm afraid I don't understand this - what does it mean for the
> indentation to collapse, or not collapse. Looking at the examples Junio
> gave they look quite nice to me, though I'd find it clearer if
>
>
>   | | *  12345678 2021-01-14 merge xxxxx@xxxx into the history
>   | | |\
>   | | | \
>   | | *  \  23456789 2021-01-12 merge citest into the main history
>   | | |\  * 5505e019c2 2014-07-09 initial xxxxxx@xxxx
>   | | | *  3e658f4085 2019-09-10 (wiki/wip-citest, origin/wip-citest)
> Added defau
>   | | | *  ad148aafe6 2019-09-10 Added default CI/CD Jenkinsfile (from
> f7daf088)
>
> was rendered as
>
>
>   | | *  12345678 2021-01-14 merge xxxxx@xxxx into the history
>   | | |\
>   | | | *  5505e019c2 2014-07-09 initial xxxxxx@xxxx
>   | | *    23456789 2021-01-12 merge citest into the main history
>   | | |\
>   | | | *  3e658f4085 2019-09-10 (wiki/wip-citest, origin/wip-citest)
> Added defau
>   | | | *  ad148aafe6 2019-09-10 Added default CI/CD Jenkinsfile (from
> f7daf088)

It probably *does* look clearer here, but I have the same reservations
against this as Junio: the break won't be as noticeable when --graph is
*not* used with --oneline.

> >>> without the patch:
> >>>
> >>>     * A root
> >>>     * B root
> >>>     * C root
> >>>     * D1 child
> >>>     * D root
> >>>
> >>> with the patch, the indentation cascades:
> >>>
> >>>     * A root
> >>>       * B root
> >>>         * C root
> >>>           * D1 child
> >>>        _ /
> >>>       /
> >>>      /
> >>>     * D root
> >
> >    * A root
> >
> >    * B root
> >
> >    * C root
> >
> >    * D1 child
> >
> >    * D root
> >
> > Here I think a blank line looks worse, too much space for just 5
> > commits and becomes one extra line which if this were like up to 7 or
> > more parentless commits one after the other would be more noticeable.
>
> But there shouldn't be a blank line between D and D1 so the two
> alternatives take up the same amount of vertical space, the main
> difference being whether D1 appears next to D
>
>      * A root     * A root
>                     * B root
>      * B root         * C root
>                         * D1 child
>      * C root         _/
>                     /
>      * D1 child    /
>      * D root     * D root
>
> Of course if the indentation was smarter it would take up less room and
> look better than having blank lines
>
>      * A root
>        * B root
>          * C root
>      * D1 child
>      * D root

Right, this would be ideal but that would require too much change to the
existing graphing logic, and should be its own patch.

> > But there are cases that blank line might be better:
> >
> >    * 10_A2
> >    * 10_A1
> >    * 10_A
> >      *   10_M
> >     /|\
> >    | | * 10_D
> >    | * 10_C
> >    * 10_B
> >
> > Feels like a shower of commits instead of an indented merge.
>
> Yes, that is a bit confusing. I think the thing I find confusing with
> this approach is that we're treating the commit rendered below the root
> commit specially, rather than treating the root commit itself specially.
> To me it is the root commit that's the odd one out because it does not
> have any parents, but we treat the commit that's rendered below as the
> odd one by indenting it relative to its parents.

I guess that would make the examples look something like this:

  * A root
  * B root
  * C root
* D1 child
* D root

No cascading, and no need for that massive _ / collapse line.

* 10_A2
* 10_A1
 \
  * 10_A
*   10_M
| \ \
| | * 10_D
| * 10_C
* 10_B

I say it looks better than the alternatives, but I'm not sure if this will
be easy to implement. The diagonal connection line (\) will need to
be printed before printing the actual root commit, which will require
lookahead logic.

I'd prefer to avoid major surgery on the codebase.

> > Pro to the blank line, the parentless check is the same and it's just
> > printing a '\n' at the right spot, while indent i'm mimicking like if
> > there was a commit there.
> > Anyways, I think in the majority of the cases the indentation +
> > collapsing looks better.
> > Sorry for the brief reply, I'm busy today.
>
> No need to apologize, it seemed quite comprehensive to me
>
> Thanks
>
> Phillip
>
> > Regards,
> >
> > --
> > Pablo
> >
> >>
> >> Thanks
> >>
> >> Phillip
> >>
> >>> This is done by adding a is_placeholder flag to the columns, the root=
 commit
> >>> is actually there but marked as a placeholder
> >>>
> >>> e.g.:
> >>>
> >>>      * root-B
> >>>     (B) * child-A2
> >>>       /
> >>>      * child-A1
> >>>      * root-A
> >>>
> >>> (B) would be root-B column with the placeholder flag active.
> >>>
> >>> Then teaching the rendering function to print a padding ' ' when meet=
ing a
> >>> placeholder column outputs the second example.
> >>>
> >>> There could also be the case where there are multiple roots
> >>>
> >>> without the patch:
> >>>
> >>>     * A root
> >>>     * B root
> >>>     * C root
> >>>     * D1 child
> >>>     * D root
> >>>
> >>> with the patch, the indentation cascades:
> >>>
> >>>     * A root
> >>>       * B root
> >>>         * C root
> >>>           * D1 child
> >>>        _ /
> >>>       /
> >>>      /
> >>>     * D root
> >>>
> >>> the _ / might look weird but that's how the collapsing rendering does=
 it
> >>> for big gaps, this case being from the 4th column to the 0th column.
> >>> Another patch could change the collapsing rendering for placeholders =
?
> >>> I haven't done it to keep it minimal, but a follow up could make it
> >>> to be straight '/'. This would make it bigger but easier for the eye =
to follow.
> >>> IMO is not worth it, but opinions are welcome.
> >>>
> >>> The patch also adds tests for different cases like a root preceding m=
ultiple
> >>> parents merges and the examples above.
> >>>
> >>> There could be some edge cases still so any testing is very welcome.
> >>>
> >>> Pablo Sabater (1):
> >>>     graph: add indentation for commits preceded by a root
> >>>
> >>>    graph.c                      |  68 ++++++++++++++++--
> >>>    t/t4215-log-skewed-merges.sh | 136 +++++++++++++++++++++++++++++++=
++++
> >>>    2 files changed, 198 insertions(+), 6 deletions(-)
> >>>
> >>>
> >>> base-commit: 256554692df0685b45e60778b08802b720880c50
> >>
>

Thanks,
Chandra.
