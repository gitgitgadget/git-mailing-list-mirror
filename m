Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 916EC3A1B5
	for <git@vger.kernel.org>; Sun, 29 Sep 2024 18:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727636338; cv=none; b=dtk9pOy3CVp//1GblguCdcTZIMsTUr4fdwDUy9h04rly/5aB1WnQr32Tw4IdWeNSNeEQYgZfZMbBh8kqM4pCzcl5q6XwRY0ZsjgkABGJAUGpREa7DxDpkFfTGUSjPAM0TD7bt0F9RTBGvazg6z1LeP1XgIl8ulGUPIr2EUbpwYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727636338; c=relaxed/simple;
	bh=unpGAy0ZCMe+P8k9v16l1gbywjj+7DOMXUasBXA/yJA=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=KfcB274ZCMVSGfeLiOwg9HJgcCWrJ7kEgbeQKlsw8xu4ynuQ+rV6pS5iLverwKSGqSvjJ4OCve+805Vd3vP/CaLgxg7LlgBLXqfmZP9SRKEcVGyEcgQr4twBMbdd+zr1AZ1YsGA1OPnK+lrxvOsAIIww5VR2s1inC5EHqFzMovU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=IkKgc6mG; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="IkKgc6mG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1727636326; x=1728241126;
	i=johannes.schindelin@gmx.de;
	bh=EYN47yyLTOWZ7q0rnp14smUqBYcnEsdJOzNkIy9hPdU=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=IkKgc6mGrOU2+WlOTVhg2IzKPB++HZ6tcVwBs0b/pR5HFWZrBs/5jpwoHnBqpRlb
	 oU9+ud5RAg4LboQPfrtu6g4ogabiktVaDT7fMKZcqtXWZYtgrdytYvEPMCDppgQ7f
	 wxCrFe0ETDjykVTCoBUjtBRLW37zP5vrzUYXWWyTH03LqNYgH85qbRMpFNLUzQt72
	 hEL3oDNAvZShXHHBO/lxqHq7/UIeYSn5H77XJVcT/TXTZngDSAInB4vveB+q5GUZG
	 Pn100RgWJcwr5ii/Qi/V4Rx95zdIuxj6JVj82t38YVzm0EHC0HdL8oRCY/jdXvOq0
	 Xtb+fjcNNPCwLL9L9g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.213.169]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MvbFs-1s5luy0SQA-00wPgD; Sun, 29
 Sep 2024 20:58:46 +0200
Date: Sun, 29 Sep 2024 20:58:45 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
cc: Beat Bolli <dev+git@drbeat.li>, git@vger.kernel.org
Subject: Re: [PATCH] unicode: update the width tables to Unicode 16
In-Reply-To: <xmqqy13qhrot.fsf@gitster.g>
Message-ID: <43570a02-3c99-1d07-4403-3e95c6e6720a@gmx.de>
References: <20240912204047.1020213-1-dev+git@drbeat.li> <7449ce5b-5308-ce6e-394d-43dec511ef16@gmx.de> <xmqqy13qhrot.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:PLCMPBYpMBIatZIJqBh3UlwUTttMY2noqqztslL8pP+9Yo7u19i
 1z0P8YAfzJWVPlH6gZ+Wv0MQ9WMcl8gQKuFHmGbk4kBm/EZtLzC7kmAyD/sN1T8i2tuPPGR
 NrrvYonCZZExWSMoEVyLXdyjh/lgySEs0rL21+kg2sCni3UQjh44y4oDcfBCBrKmDLPDj7H
 iiYw/fV2Twwrjm+ShX0zA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:IJPtnMaOk9Q=;hEYtYe7AHjdhhUYG86/eCiMjmFb
 xowRJ2McURenmAFR/q5idzHhZxtKrlP658q+iK5H02sGXngyc864MEx3cgbBKjHEueFrmDSiw
 AAySo0d6Wi2mHPExGRCxlZq/GhKEi/1Hn4dnqgYW1ScNO1lKaEIUPJhnzIHNY8qlKQeRCeVQ9
 byebdTC7c7mWIdeRV9av8C76T5MA3JcqYxNYhljHa79YoxyK+1ohJNMnYYO49CBQcOKn6THYd
 KDfmF2eBOrzOl5UbwQP1j7dwIzZ/ep+HUbPeMuzuVBIt3lKNxbsdnCWKXTO1/c8BFyG/xMG7g
 NCc85wDT0/bAgILJ5sa7IyXki3uWN7ydyUcnfM1ZivSiB7Mabywoy2j9dtkPG68fGSx1kY4hN
 R8lZOzLFvk8uZntaCMWxgqMgvjqdxUjlzGIGsYc+VDKrH5j41gMiBqrq4RyVAqkKoII5JO6/M
 pffVDCtfoJRrkeSyXJD5dZz4Fr+ttjntDxq/URHFsMdl0txqz7Ywd1LLrcHw6IKI40BxC5ssB
 /mO4WLp2VGn/8r7w5XXbT19AKpesCq0QxfyS9J/lFkXdSgL7TCuFCaon+T+s3fFLa37ICYIeF
 /d+n2dfkArmlpXUzRqS09A+/UUw317eqcGmpR8zktw4IkbcsoZwpEUb2uDcu+CRMamqsIzvW0
 UlyYxsezKj3tfPAM4zv/+xNzfkZgq4tnTWMuV51UtPcX3rhYc7+3E1NO+umCZjkP9+a9H5CD5
 FHeK2s0lIvJeXEMwbqwQskJXxttYGPPGiwA/TYAYeZw+41eWA7SKxq93t89zhpUXEx+6n+NI2
 UTrYu9vCbt3Xw1rOSRGR9syG15y6pFm/VDd7D8kPulCfs=
Content-Transfer-Encoding: quoted-printable

Hi Junio,

On Tue, 17 Sep 2024, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> > On Thu, 12 Sep 2024, Beat Bolli wrote:
> >
> >> Unicode 16 has been announced on 2024-09-10 [0], so update the charac=
ter
> >> width tables to the new version.
> >>
> >> [0] https://blog.unicode.org/2024/09/announcing-unicode-standard-vers=
ion-160.html
> >
> > I can confirm that the output is identical to the result of running
> > ./contrib/update-unicode/update_unicode.sh.
>
> Thanks for double checking.  I did the same when I queued the patch
> and it indeed looked good.
>
> > Maybe we should add an automated, scheduled workflow for these updates=
?
>
> We could, but the consortium aims to issue major updates once a year
> in September, with minor versions and updates "will be avoided", so
> we may need to devise automation that makes better use of resources
> than to scrape http://www.unicode.org/Public/UCD/latest/ucd/ daily.

Oh, but I obviously was not suggesting as crude a thing as to scrape it
unconditionally, and certainly not daily. No, I was thinking about
something checking the `Last-Modified:` header and only acting upon
updated Unicode definitions, and checking for updates only on a weekly
basis. Something along these lines:

	```yml
	name: update Unicode definitions

	on:
	  schedule:
	    - cron: '1 15 * * 4' # 3:01pm on Wednesdays
	  workflow_dispatch:

	jobs:
	  update-repo-variable:
	    if: vars.UNICODE_LAST_MODIFIED !=3D ''
	    runs-on: ubuntu-latest
	    steps:
	      - id: check
		run: |
		  set -x
		  latest_update=3D"$(curl -I https://www.unicode.org/Public/UCD/latest/u=
cd/UCD.zip |
		    sed -n 's/^Last-Modified: //p')" &&
		  if test '${{ vars.UNICODE_LAST_MODIFIED }}' =3D "$latest_update"
		  then
		    echo "result=3Dskip" >>$GITHUB_OUTPUT
		    exit 0
		  fi
		  echo "result=3D$latest_update" >>$GITHUB_OUTPUT
	      - if: steps.check.outputs.result !=3D 'skip'
		run: echo ::notice::_Now_ we scrape and do stuff
	      - if: steps.check.outputs.result !=3D 'skip'
		env:
		  GH_TOKEN: ${{ secrets.UNICODE_LAST_MODIFIED_PAT }}
		run: |
		  gh api -X PATCH \
		    repos/$GITHUB_REPOSITORY/actions/variables/UNICODE_LAST_MODIFIED \
		    -f value=3D'${{ steps.check.outputs.result }}'

This would use the repository variable `UNICODE_LAST_MODIFIED` to store
the `Last-Modified:` value that was last seen (and implicitly act as the
knob to prevent running in forks: if the variable is not yet set, the job
will be skipped).

Sadly, to update the repository variable, we cannot use `permissions:`
because the workflow syntax does not offer the `variables` scope.
Therefore a Personal Access Token would need to be stored as a repository
secret. I used a fine-grained token in my tests whose sope was
Repository > Variables: read-write.

Ciao,
Johannes

>
> 44dc651132 2024-09-12T22:40:47+02:00 unicode: update the width tables to=
 Unicode 16
> 872976c37e 2023-09-25T21:07:04+02:00 unicode: update the width tables to=
 Unicode 15.1
> b10cbdac4c 2023-03-30T21:15:17+02:00 unicode: update the width tables to=
 Unicode 15
> 187fc8b8b6 2021-09-17T12:19:20-07:00 unicode: update the width tables to=
 Unicode 14
> 65588b0b2e 2020-03-17T16:36:05+01:00 unicode: update the width tables to=
 Unicode 13.0
> 5817f9caa3 2019-05-29T22:50:45+02:00 unicode: update the width tables to=
 Unicode 12.1
> 584b62c37b 2019-03-21T22:06:17+01:00 unicode: update the width tables to=
 Unicode 12
> 570951eea2 2018-07-09T21:44:52+02:00 unicode: update the width tables to=
 Unicode 11
> e233bef43e 2018-04-10T14:26:17-07:00 unicode_width.h: rename to use dash=
 in file name
>
>
