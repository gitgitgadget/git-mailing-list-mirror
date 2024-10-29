Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1952198825
	for <git@vger.kernel.org>; Tue, 29 Oct 2024 16:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730219551; cv=none; b=Pr8zvnlVGpaptv6K+J62d3pNs6Y6JUiqiTb3gExbr0Z66aWlskESpoccntMcHSFPhiCpQhuLMow9Ox74QdU3K7IKRl1f8kGLV03zrn7bPK2Qal6clkKAwHsDYheA1gMVzM0GauELF6ZCgEtFSW11guA5LV5N86jr45OlRThuX7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730219551; c=relaxed/simple;
	bh=C1+ZtM0bDQbQCHCG6aKowioWm9izUPiFbnuJiHWnQZc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VASv/Dq68z8s2THLibRhGn4I/vlp7Nc2LrxGx3f4bebX/nyPJMjvk1YnvPNhs9Zze125oIEwn0SD+N4ZN1bMntFI166NJ82w1mzXHMR3YNJjtkjB2JI45l1a3sOJwrFGE/VDfpCahs5Lwf68EbZK+7V3Pjhy2aLEpf/csizyVus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b=gLuOuqaP; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b="gLuOuqaP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1730219539; x=1730824339; i=tboegi@web.de;
	bh=W84taUg/EAQZb9P+VmsONMl00LgtNcE58HXOzG1I5Tc=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=gLuOuqaP6V1v+lEBqx1q7fm/J/r/MyLZSw+nr/oMfhd7QbQrartr7U4e5FjUuxWb
	 /gFoieIRUuK5muBUNFRPfJ1xX4Xox6NJ8xjJgMq6V9Hnc/yr5CxWpN6gUB0VETWef
	 PuQVUjipiiKdzn97MdPZj41OSsW8H5V1rXRwX8j6gTDemr1r5h5i2FMXdUGNzujap
	 tDCe9Jpgi2Xz2rawhYkoEPeeRhmxGckH67B3gHjh88ZB1dXb375mtWxVo6/zY4rRY
	 6XAaYzsjHuexFHGHEVEYyoPsGUH2O0A4UI70KphUBGSk9xp2f7hd0zEw/HplTBz/p
	 P19SMO+NlfkgOerlwA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost ([81.231.143.213]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MKdLM-1tQmL91a7I-00VXEO; Tue, 29
 Oct 2024 17:32:19 +0100
Date: Tue, 29 Oct 2024 17:32:18 +0100
From: Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To: Peregi =?iso-8859-1?Q?Tam=E1s?= <petamas@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: Inconsistent handling of corrupt patches based on line endings
Message-ID: <20241029163218.GA30259@tb-raspi4>
References: <CAExmRTbMCayh+vHW3g=2p=FMb=VKXomEbn7_0t+kK-eF79JnEA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAExmRTbMCayh+vHW3g=2p=FMb=VKXomEbn7_0t+kK-eF79JnEA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:yHBvRrqH4OWV80Viansc5Tfiy+4MIfdSZGXnoo5e82jqvkuB/QG
 r2nHQSLYTVW6Vsur4xAogi0ZyWz/nI5v04622rhRNQLFGBUJcqCvbHng9gAzazpLessdm2x
 QuyrPWGx3lHfHi4Es7EpT22YA8sKyVU4ONZqKLEORhE1rn1BYwJLdOlY/P7n9le1up41O9L
 3RoYT+xhpudqJVNT2LUmQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:uzS3zWfPmWo=;U8sedhPOdM4ShPEvVDyBf5GPSrc
 oiqFu2iNzptOMKUir0SzBp9OemABJ7GLbM9HkRuQNOmj1h4VsY8wRpiQLsPlGrqsMtM6Tihnz
 bp4VE01t/yFliGypvUuIC1GRRgR/cjvW6zPTu4B0OhAu50eioDSYab1q6jntpNg9StFxOxXUJ
 +xUVeFnJvF6mzF9ysa5apZduJmkx9xh3irrsldBVjAh5/dqVmqFlS6JNbRGDzpCKsV6acfkM1
 Ahf19MsulPhWi109FvGPtabYYzWWORbs5JLgjPgQHnuVT8rl3oDunYQ7QX4/XW+EmrOw+yaHt
 dsuUMuVfJTAqJh/REF+UyxlRiYKxUP0PDSKZgR+UbXhChcfnYFpNbQc/ZPuTfGj1lWeID6DB8
 wahR7MYUAb2+tYQo1uC1GsPaGzRI5kun3qbUu+R5uYpwq4yYlmdyOfoUoPlUJbIbe083R4jSd
 hBd3K0hJ2WJEsg1QnQ8CFm2zIBG/gcpEns4a0zdzkhOjoQRzQS2rVD89SSNFqYZN0JXpCKYq1
 NHSy6frpoQQ5WzM4UmkYHv2JeQ9MzkEwM6j9iDzswwNsBNvtu03ErW2ynLboohRwetj++5ukE
 +cMe6htZaewCQLW6UcE+7NIlYjvW9/3gwf9Q1skgQUBFwUgMacnSLORegz8VmV123rKsMjr4G
 8i1gMuFoo4QbJJplQPLmgDom/F2bR91F2Lul5NToDCODZv8I/MZgIzvo7AHNX0zP+m8bmr4gM
 ZQURELZyp0qoVyMNoHqfHui2snZrEtQko8T7l7HZ0pZfIFOeJj62MoXiruV9uETO9IuHf1s0s
 cetR4W+HaTKMEa/lNy80A5Bg==

On Mon, Oct 28, 2024 at 05:57:54PM +0100, Peregi Tam=E1s wrote:
> Hi all,
[]

Thanks for an extensive bug (?) report.
I can not answer, if this a bug or working as designed.

However, please allow a few words:
>
> While the example seems contrived, it has been encountered in the wild w=
hen
> I was copying a port from https://github.com/microsoft/vcpkg (set up wit=
h
> autocrlf=3Dfalse and all files treated as binaries in .gitattributes) to=
 my
[]

That very repo is not in a shape I would like to see it.
Basically, Git is designed to work with line endings using LF and nothing =
else.
You can configure Git to see CRLF in the working tree, if needed.
But all the diff machinery, and git-apply, is build on this assumption.

If I look into the repo, this very commit
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
    commit ebdb41039450383ec7f41bd5f589cc46b7fd6a59
    Author: ...
    Date:   Mon Feb 26 18:18:05 2018 -0800

        [everything] Use -text to ensure consistent files across machines.

        If you experience trouble, you can use the following to renormaliz=
e your local working directory:

        git add --renormalize .
        git reset .
        git checkout .
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
is probably made with good intentions.
However, `git add --renormalize .` will not do anything at all.
All files are marked as "-text", so there is nothing to normalize.
The commit message here is simply wrong.

Something like this would have made more sense:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
* text=3Dauto eol=3Dcrlf

# Declare files that will always have LF line endings on checkout.
*.patch text eol=3Dlf
scripts/ci.baseline.txt text eol=3Dlf

ports/** -linguist-detectable
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
(But I didn't check each and every file).

After changing the .gitattributes file, run
git add --renormalize .
git add .
warning: in the working copy of 'crlf', LF will be replaced by CRLF the ne=
xt time Git touches it
git commit -m "all files with LF in the repo"

git ls-files | xargs rm
git checkout .gitattributes
git checkout .

After this, we can fine-tune:
git ls-files --eol | egrep -v "json|cmake|patch"
shows that we can add lines like
*.exe binary
and may be
scripts/vcpkg_completion* text eol=3Dlf
to .gitattributes

Does this makes sense ?

