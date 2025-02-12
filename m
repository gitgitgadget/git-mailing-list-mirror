Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E22B2D600
	for <git@vger.kernel.org>; Wed, 12 Feb 2025 06:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739341074; cv=none; b=rY3jytyWOvFGCs4/eF/u45YVNQYdnT+Phs5sjbnnWkuao8RQ17buYX6aWSe6Dl0KEPil4imDQoFCkJUrMK5xjKGXAw57QNOVmc0bBfFHCMBRZ1AJfGgIZd5K/hQgxB6pYITtjJWBO9xPNMyWUYGvpOUIvugqDCSLGSf/+MZHnGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739341074; c=relaxed/simple;
	bh=aMdss6F2EpwsBculbfOvzbRRfiiwk2D7tIGKYVL7kVQ=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OSw57pd29U6MOm4fUsL0fDSviyW814Zm1HnHyOxoD1nXHXUHwdhzWAKO36Dm1qBr9CcbXBddn1V8NjGdLbRvUe3DOF3RobD7hXoI4su7LwG0iJ/lAjs04hp34Ha4Qe4CbSiP+Lq4CUNu7VwE2qwAX68GAFH0ssQlmK2A8Z+Tx6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b=lAuYGJyY; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b="lAuYGJyY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1739341069; x=1739945869; i=tboegi@web.de;
	bh=sAOGUqYb18Q6UJv+OLhYMG6I95zSdw0ZH5M7aGG196A=;
	h=X-UI-Sender-Class:Date:From:To:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=lAuYGJyYt35zwNmnswBMQ0GJEQ8Im1vy7GCdjNmisTUBLNxbx5M4BehSkG6EYfNL
	 ZfZDzGOsSdYMgg0bN7UMFNEMuNDrM4N/pmTU+i5h4mISg0lv4kS0FczhIWgVyh49J
	 T+kYV4hlct4Hu3U7T38W0QU6UGXbrplto7we/U9DCDTYXRxB51MSXDh8BbLthWmAH
	 fq5L4J6thKSkbGmt/HURjnXdz7FbFqf7Vqrg+RR4rGHW6L8Qqx4+eMu3P4nwKoPnH
	 1Ga/FvTCJEnYMKywqvHqOAHP11dUoMQWe+li+oN32k7tnkTqBC4u6rZ5WSiN0F4eI
	 RPDSNkrbiEIt1MxjFQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost ([81.231.143.213]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M1rTG-1tft412EWW-008qQJ; Wed, 12
 Feb 2025 07:12:37 +0100
Date: Wed, 12 Feb 2025 07:12:36 +0100
From: Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To: Josef Wolf <jw@raven.inka.de>, git@vger.kernel.org
Subject: Re: renormalize histroy with smudge/clean-filter, again
Message-ID: <20250212061236.GA990@tb-raspi4>
References: <20250205214726.GA30202@raven.inka.de>
 <20250211235707.GQ30202@raven.inka.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250211235707.GQ30202@raven.inka.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:U8aYUQcZXDQIXszhVR6vwHwKXU/6ZGNQSZBZSapoQMEN1O6Z8t3
 bymf4hxlDEcJjVZS7eU26894BtVDpDHZDB2+Gyj2N6X5A5Pr0Q6ko2akdSWiNDYCFzmep4T
 0DpQE4C7ekllGLrdmgPveZ08v1Q2f0H2bEOzd5N6Z5F9xmfes+qlZAAnI522+XqT76G7tSS
 b05i2w6rs6H6niA0sqOmQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ijKMs0Gfpd0=;q739f3s/mE9lPQeOxz/yOqXBGn1
 TLJRuvv0hlRD/6svyuN/a32KAIlu134opRQE00U9+xUkN2NpSHbKygKwdY3cJd0O/LmqnEPbU
 Wf5vLzg2CX+kbCm3mLM1MogFrqSTwPyHag7d24YJ8sIbPcjC94a8yWuwdo2+oBKx1MB7IeU+4
 0RTIJQoBmQzRU6fBU3Tkzp+9jFrK9QMXlcJI0ZY7RW6bnHhgFss8587IcFyj1q7WNPnntUj0L
 XYrt9JE3lXTXhVVaO8pMiDZ63KuKODZhjdbgYDJGOkA1f8znSYHu+ADYGq/Dh8NgmrAZyZyKz
 X3i7PiQxXl9/4UcLlpMOH1GJ3Xgw/yQ+HPSYk2m+/1Vo8i2Lw/6vSk1oqCw1YB3fso+RH+gEz
 nfQpwJkDNuUhCkjxHg8X1LZHEFYxDcNdlvfkY0f6344VXq+iqhrqPWHrGknYoQPFNGg9++Nox
 TZSPZNJuwZ17oDVAxyKn8rywIm68A92JWtWVY3Eiqu4cuLdTGQrr6g8IpmSCZft8PX6nqgs+i
 SKt72bLFLXnldYPviD8xftnxfqrVnQaiA8ziz1tihJz2TFzxUwTG5u7QgPix30LrPsDwsYYG/
 ezZ21SAd86v5JQYO9XDSpCbJjm3gmU8akuq04U4049iY5Y/setXwrNZ1tlkS7TyQ5CrxW4gHM
 syfJVvvTkzr3vMYHyfyZPEs1rHLwCafrGz/g/E4tVtuDIAUMDeThLhiKL8qSQVSno7eRaW8cj
 F5kd2uoqoBf4Zt7EdZ0Eb+8hVTJL15Yfz/M8Zm1XPkYAd5ST5jIwcka25gqlUQ6KbegpfZKcr
 hR8ETN8M5wvorDCJElwlDRtBzSpwIi9zhQ/QiyACleIkhfLQgDLuwE2k4ToCQU/gEqvwOdWTB
 hPqyLGJI3hr4iHVdyx5Zf3H4VzUiVO9jAtgmSdB1yOLWfPpEhGxOwROlYibrgxpVg59sK7OsR
 6DXA8gdZsFqcIo+WmaWnAUoPcE8LvWB5yD3kOLOeJlnSafBFhrpyLSoOKMrgMvlBmKLKuIIy5
 oiUqNdEiaOIzG8hqWwzE6YF99FwerY3X3ZpI1O3YPQYAJPMNWcuJK5v9G5GZo/HC2XCNLWxRJ
 wZkTvMK/bfs+/E+pwXATUOLq0S9QUrh0zO67Lxr1v2nHKREvTLKihPdWystNbKMs66da0LOOO
 OSZpXmb1G504cLaRduFB6wZp61W/un0HAWB2+wRuRWJkFULj2diP89QR2M9IZHYFw8IhkJCFi
 fXreRV3XzCGIV3Td68A0woTp40dJJXm8iaefaJBSk+cA/A3oWJYTJyrQAu8VDgtNOiyBqtzNG
 f+CIcW39nnaJJ4kvnI8o2snBjtwRYUPCvg57g180AgKyPZj9yXHNaR/VTar8SxRuSp8NxTJL6
 b+uVKpWj/RLYnCCJyzOgRr4PrAeVt5qmchLYs=
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 12, 2025 at 12:57:07AM +0100, Josef Wolf wrote:
> Still struggling with my filter problem.
>
> Here is what I do:
>
> - Set up a clean filter which enforces CRLF (yes, for this specific use
>   case I want CRLF even on linux)

In general, clean filters do their work when 'git add' or 'git commit file=
'
is run.
Does the filter do the CRLF conversion ?
Or is it done in .gitattributes ?

>
> - Smudge filter does not modify the file at all
>
> - Set up git to fail when filter fails, so I can double-check that the
>   filter is actually runnning:
>
>    $ grep -A3 filter..etsfile ~/.gitconfig
>    [filter "etsfile"]
>       required =3D true
>       clean =3D ets-utils -c
>       smudge =3D ets-utils -s %f
>
> - Specify file as non-text and install the filter:
>
>     $ grep etsfile .gitattributes
>     */P -text filter=3Detsfile
>     $ git commit .gitattributes
>
> - Check that git gets attributes as I want them:
>
>     $ git --attr-source=3D$(git rev-parse HEAD) check-attr -a P-0113/P
>     P-0113/P: text: unset
>     P-0113/P: filter: etsfile
>     $ git ls-files --eol P-0113/P
>     i/lf    w/      attr/-text              P-0113/P
>
> - Create helper for renormalization
>
>     $ cat renormalization-helper
>     #! /bin/sh -e
>     git add --renormalize .
>     git diff --quiet --cached || \
>         git commit --amend --no-edit
>
> - Run the renormalization for the linear history:
>
>     $ git --attr-source=3D$(git rev-parse HEAD) \
>          rebase --root -X renormalize \
>          -x $(dirname $0)/renormalize-helper

That will change the index, the repo, but not the working tree on disk,
right ?

>
> So at this point, I'd expect the falie to have CRLF line endings. But it
> doesn't, so I do:
>
>     $ rm -rf P-0113
>     git checkout  --attr-source=3D$(git rev-parse HEAD) P-0113
>
> Still no CRLF, so I look at what is stored by git:
>
>     $ git --attr-source=3D$(git rev-parse HEAD) show 873a9b:P-0113/P |le=
ss -U
>
> Again, no CRLF.

Just to make sure:
You want to see the CRLF in the files on disk ?
Do you have a valid .gitattributes file on disk now ?
If yes, what does 'git ls-files --eol P-0113' say ?
What does 'git status' say ?

>
> So I check all revisions in the history. Resut: no revision has CRLF.
> So the renormalization process does not work for me at all.

In general, renormalization is about the content inside the repo.
If a filter is applied, or .gitattributes are changed, the files
on disk are not updated automatically.
'mv -f P-0113 /tmp && git checkout P-0113' may be needed.

>
> Any ideas?

Yes. The best thing to do (tm) would be to create a dummy repo,
do all all the operations from scratch and post the stuff here.
In other words, write a shell script that creates an empty repo,
fills it with content, and does all the operations.
That would enable people to reproduce it and look what is going on.
Hope that make sense.

>
> --
> Josef Wolf
> jw@raven.inka.de
>
