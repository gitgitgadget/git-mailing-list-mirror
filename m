Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8381195B1A
	for <git@vger.kernel.org>; Fri, 11 Oct 2024 16:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728663048; cv=none; b=rN49sPeCvG3rqS3EYpiQ/q5DM8kfuK5WtY8G+emn+AlWjPL6vdpier3lcJnsR1IlPMVGDH4Xg2Hyoyj9burwfoD03LL5hpNYQhWbca0NlS03o9c2pDkV55oTHWsukSTyKLJAmeamCF7U/brWkmrwCE9wA3b10BzvxZwxKJBhs7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728663048; c=relaxed/simple;
	bh=WXXUWvQMqeBEEnrZ/i7zJuZi4dQJH8rFZZYz/RgNx6k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=STiXKpXYL/dDpl6InvP1pqfTIKVyNuCkUdE46UWZxDbC/wtaW4vZn9dnh12eL3BTKBtPGEF4iO3Z+98yGJoi/7rK5wpUapGVuUBUlYQi1+p1rRlrFvRSZwl+CdEJUKOssVxdk0H04bWBIaEYvcih1fo+vf4BO64aQ+CC5B+P4zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b=tg6ruBPk; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b="tg6ruBPk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1728663030; x=1729267830; i=tboegi@web.de;
	bh=7qOSPKCxSm86NYufb6zhw10ldMJWTRk7NdEcukfhOS8=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=tg6ruBPkXDtLU2V/SZ6t5g7QVrLL+DqGWifD79+4Yl6HDF7YhC6qdDHecMqv/5qM
	 ckQylfBaP4qhSSABuF9Rzcj8VQiJeVSWm48wVLS0KvESOhRWbRKcijJCgErtTeYby
	 nmLtsh+9Iepr5fwxBB6mBY0E/NZD1NDF2hlgLhh5DuXIIQ4XM49g7ElLhIxu6flFs
	 /mYEQhXoWsmnda0yTvY7OFz2+1O8/VuZKCj28Wk+ucWnCSTIy3aNLPHNV6iQ+tsWy
	 fqR7WfmwJC6Uk/RhaM4d7jE3th8YotdEjfvdpydwvbt5O31SjmbpiGOd4yKi8FPkH
	 Mka+0sLWxzJ5KIuCAA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost ([81.231.143.213]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MT7WH-1tOosj3Nk7-00RWsq; Fri, 11
 Oct 2024 18:10:30 +0200
Date: Fri, 11 Oct 2024 18:10:30 +0200
From: Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To: Spencer Fretwell <spencer.fretwell@gmail.com>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org
Subject: Re: Verbose Commit Ignore Line Fails via CRLF Line Endings
Message-ID: <20241011161030.GA22682@tb-raspi4>
References: <CABa71ByU_9g_6OgJ9PsoQ99oyMspucTBqO-RkB_2W4smTr2RNw@mail.gmail.com>
 <CABa71BwtEWS79CZwPOa_Nrh1iMrXRo+hyxNBc5F8GsQiwjdapw@mail.gmail.com>
 <ZwWDd1_76Z6zH4mP@tapette.crustytoothpaste.net>
 <CABa71By0WYkbNip6-hmcX2jH1GuHWEx=WBTda5=RV9koR-cVFg@mail.gmail.com>
 <ZwWNgc6JY46bmcjE@tapette.crustytoothpaste.net>
 <20241011044505.GA1764@tb-raspi4>
 <8f3922dd-83d3-4860-a25a-ce52d9d08d7c@mail.shortwave.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <8f3922dd-83d3-4860-a25a-ce52d9d08d7c@mail.shortwave.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:hQvTavVyUjd7uULS6ntt0e9gZ1PNHqWfF/GgZ1M49NWrZy9x/BZ
 mgSBvlco+tkvcwwHXKEmLHl1rm3yXvIdbpWSJ/Dr/GwyOnBAnrbc7cDo7E3zjGnxoRbOPjb
 f3wsbxEmZtdiw6fDdwU3CWzckPTHGeTOhrEyPOaQuB6IB3V3o3752IQ+Usz3SfvKuWj2gjt
 6RVuXcz1+d8rj11onHXxw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:XvSC98cAerg=;qOCFKwfuXBEU8f7gTUqmrjsYGbz
 rh6KfTgCsfsXUq5g3Q4B5raCvNJMgbygkG7+5lb10d6qdrsC+2+8gnE5ZmetCR+fzJtmEtaaE
 jgJ075c2xkue9dRxIx7V42Fzj1vZfI69LKrk77xyn9U19moh1NK9BT/bjVwEM0h+9lCV+B4Sf
 4NB8vFffZWvfZgpt43uijPmXiBncYCfEzJrrYVpaV+RHrnSnQ2po3v6ZXPiSvmhjbxysFXgNr
 wIMkjw/bPzMAnOQyp7gEDMxzupbWPdVp6jELPERZ9Dot57klvqpTNMwSiXN133oCnTcy4g5JO
 LnhzzUBrF8jc2VP+qswyiFw43yok4r9Ed7MqHfkBa89lQadQz/nO7UvaYPqezJ3gfiY3Ep8Wf
 KTcQufTS3RxSynIy0H7ZAMopywsgllOhwCEkaWQsBjRIbtcnzIuhHt4Impi2X/cv07kuICAAs
 Ie4H+MahLWnzkB/ozjtI8ZtHkz8fIpME4xbAvZnNw9dBF8fCsua2QyQ3q52dkOEfzF208leWE
 EjdGTbSL1JkzVfv68xQtsi+XeZfZ0FoUvCbBsxsR54DYFzOTFmfKwvCtys//eU7r1LKan4+l6
 k3rvi0WGPWm08pmwBo072sr9tMj7PVXwrGcglSuXAKJ/A+aUvDYTcD4eqU6p2vFZEJvokH+3z
 TFBqLYOsksCvg+PBbMpFJPMZFqTgj7Y3rCTJ1PVG4BVgV2SSqJp0PsjcQCIHFs8a8ygj5OZ43
 4rLnHEb3i4vluSxJcLGp5UOZZ/Sd4PUsZ+2YxpAp3I0/ABm4jY+bKxOgM2LvBbfibCThZb9CB
 wL/rMsMqOI8naEMvhWVuXQRg==

On Fri, Oct 11, 2024 at 02:33:46PM +0000, Spencer Fretwell wrote:

(Please try to avoid top-posting here on this list)

> On Fri Oct 11, 2024, 04:45 AM GMT, Torsten B=C3=B6gershausen <mailto:tbo=
egi@web.de> wrote:
> > On Tue, Oct 08, 2024 at 07:52:33PM +0000, brian m. carlson wrote:
> >> On 2024-10-08 at 19:34:46, Spencer Fretwell wrote:
> >> > Thanks Brian,
> >> >
> >> > It appears sublime auto-normalizes endings to "whatever occurs most
> >> > frequently in the first 32kB". So, I guess it was witnessing the CR=
LF
> >> > from the verbose output and replacing all lines with CRLF. Thanks f=
or
> >> > the reminder about --renormalize.
> >> >
> >> > Is there any chance for git to support a CRLF magic ignore line,
> >> > particularly considering the variation in standard line ending acro=
ss
> >> > different platforms? I tried autocrlf=3Dinput as well and it sadly
> >> > doesn't normalize the commit message file itself. Either way (magic
> >> > ignore with CRLF or normalizing line endings in the commit message)=
,
> >> > would be appreciated for mixed line ending workflows (especially
> >> > considering WSL)
> >>
> >> The answer is essentially that I don't know. We typically make
> >> decisions on whether we'll accept features when we see the patch. My
> >> guess is that, assuming someone (maybe you) sends a patch, it will
> >> probably be accepted, since I wouldn't expect it would be very diffic=
ult
> >> to do or have major impacts on the code. It might, as with any patch,
> >> take a couple of rounds, though.
> >>
> >> I use Linux or rarely other Unix systems and always use LF endings, s=
o I
> >> don't plan to send a patch since this doesn't affect me, but assuming
> >> the patch looked reasonable, I don't see myself having an objection t=
o
> >> it.
> >
> > Hej Spencer,
> >
> > you are probably the first one reporting this, thanks for doing so.
> >
> > I have the suspicion, that your repo has files commit with CRLF,
> > and that leads to a CRLF entering the diff, and that leads your
> > editor to produce CRLF in the commit-message.
> >
> > In order to debug this a little bit, can you run a
> > git ls-files --eol | grep i/crlf
> > in your repo ?
> >
> > In general, when working with cross-platform, or only with windows,
> > it is a good practice to use a .gitattributes file to specify the
> > line endings.
> > Do you have such a file in your repo, and is it commited ?
> >
> >
> >
> Hi Torsten,
>
> To catch you up, yes the problem involved commiting a long CRLF file who=
se line endings predominated the commit message, so my editor assumed the =
endings should be CRLF for the message and normalized all lines including =
the magic =E2=80=98comment below=E2=80=99 line. This in turn appears to nu=
llify the magic line so the patch itself saves to the commit message
>
> Would an attribute file LF the patch contents? I guess it should given t=
he patch is what is comitted. The other solution would be for git to handl=
e the CRLF magic line better, either sanitizing to LF during comment remov=
al in the commit message or just by interpreting the magic line with CRLF =
as still a magic line. One is a process update the other a syntax update, =
but other than knowing that I am unfamiliar with the got codebase and this=
 wary about attempting a patch=E2=80=A6

I am not sure, if I understand your question fully correct.
As far as I know, Git does not manipulate the line endings
in the commit message. That is something that can be done.
However, it seems that 2 things come together at you side:
a) Files are commited with CRLF.
  That is not recommendet, I would say.
  Could you do me a favorite and run
  git ls-files --eol | grep i/crlf

b) Your editor makes the decision to convert all LF into CRLF
  That is, hm, fixable by either using a different editor
  or setting
  git config --global core.editor notepad (under windows).
  The "notepad" executable under Windows is a shell script,
  which converts the commit message into CRLF, invokes notepad.exe,
  and converts the commit message back into LF, before handing it
  to Git.
  That will do the trick as well.

If someone wants to send a patch to normalize the line endings
from the commit-message, I am happy to review it.

