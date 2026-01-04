Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A2EF22538F
	for <git@vger.kernel.org>; Sun,  4 Jan 2026 17:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767548136; cv=none; b=dUtRFSCEl5W/nxzruZhhk6NOEXaJfwcZEERr9Et1woCMkFbMmyUwOp+ahBGsFCGpbdasfqixq2pJrQA1S9EHNegFfamlAA8r6Sa2sFwFpkCIDbYA9G2Qb2eVtSlDboKBLMIBL/VadVLg4FeYbny0I6AFmJ3m5D2ABJbWbbueGdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767548136; c=relaxed/simple;
	bh=lfzOJ6ZBSjzLkMJcjS5XHgco1kRuNvcuLKVgfR576Cg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZrGSSpEtEnEypX5TlidqIqQDyAsEkuB+CSRaXmJDvFrY4OqRZKC20ptRV6GH5pgEoPQXVCMKeaAfUzR2fkbJkpMO39PBqE/3J+NRZHgrLTp2IVTG6wZx5w89wLP25pVBsLZaJCZ7nmh2dKeHq3VYSmts02dzxDYKBeYl196OwgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b=ROr5kIFz; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b="ROr5kIFz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1767548125; x=1768152925; i=tboegi@web.de;
	bh=PlrY4nw6CMOspNXrMpnDaKEQoEmkcfrBn6xTLvNlcYA=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=ROr5kIFznii0Baw0d/HqFGKAECM+TyEByEzGiKhKm+BJb98EoZe/m9zeefRYF9v+
	 QYhxZtEvSG04ewXnc0PfDqjwmo/f+YxpLXhee7gcBOQBvK9znrXIETUqHeHXW+nEU
	 wboAhVeR/7FRnqbIdFK16sllVrv3p25lxIhVB2CdAWUnBH96gmIqdRzn6S3c/bBJa
	 7RVru5L8lLncStz7U4OMyIcBX0uPBLj34x8YVGhYJKws1KWrZB2rAssZw4AThO4Ig
	 O1qTOreV0MrzL4geIeWWERLXuJvgwXszlHEkE0SV4E4QUUy6Lb8mOEJ+tW1bMfvzw
	 3iBs/2YGxMHtbklGVw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost ([81.224.105.209]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MkVwi-1wIdG71ivu-00brKa; Sun, 04
 Jan 2026 18:35:25 +0100
Date: Sun, 4 Jan 2026 18:35:24 +0100
From: Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To: Matthieu Beauchamp-Boulay via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Matheus Tavares <matheus.tavb@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Matthieu Beauchamp-Boulay <matthieu.beauchamp.boulay@gmail.com>
Subject: Re: [PATCH] ignores: handle non UTF-8 exclude files
Message-ID: <20260104173524.GA29867@tb-raspi4>
References: <pull.2157.git.git.1767478617198.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.2157.git.git.1767478617198.gitgitgadget@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:OajNyjBUa2RI9hj2VMoQ8N3BTu7/5EU/PStHGTxFX/ilqJcYs53
 laYS0eF1/6okgvbdoc3MwCZoptaKdE5pTqoUu04F3SXHtkQV+nSjoTn68eThf0JPfrsv0f0
 P7o6TjjJXwa6Mkcr6Fi225noFJfc6oBbx6gmFIYcU5OE1E2AByKfwXU0iSKO6uWv5oumLfk
 1MiLOW+ca/kEZ2Diyn8RQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:oDq8T6sP/hs=;IvS6IYHuhpSF0ycMHg7ioj0zaAf
 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
 5NPYtG2k=
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 03, 2026 at 10:16:57PM +0000, Matthieu Beauchamp-Boulay via Gi=
tGitGadget wrote:
> From: Matthieu Beauchamp-Boulay <matthieu.beauchamp.boulay@gmail.com>
Thanks for contributing - some comments inlie
>=20
> When reading exclude files, git assumes it is encoded in UTF-8 and will
Question: The report citet below talks about ignore files.

> fail to apply patterns if it isn't. This is a silent failure as no warni=
ng
> or errors are shown to the users. This is a problem that can take a whil=
e
> to diagnose as many users will not think of checking the encoding of the=
ir
> file and may believe their patterns are wrong instead. Users may also
> accidentally commit undesired files.
Note:
git status is your friend.
Blindly commiting without checking what is staged or not may
lead to unwanted results.

>=20
> On Windows, this happens if a user uses Windows PowerShell to create the
> file, which results in a UTF-16LE file with a BOM.
>  This issue was discussed
> here https://github.com/git-for-windows/git/issues/3329. An example of
> where a user was confused that his exclude file was not working is cited
> https://github.com/git-for-windows/git/issues/3227.
A very short research indicates that powershell can be configured
to use UTF-8. I am not a powershell user, please correct if I am wrong.

>=20
> A minimal fix should at least warn the user if git cannot properly decod=
e
> the exclude file.
I think that reading an ignore file that contains a '\0' could/should
Git to complain. If someone asks my, most users are tempted to ignore
warnings for different reasons. Bailing out may feel more unpolite
but more clear that somethinh is wrong.

>Ideally, git would handle any given Unicode file.
That is debatable.

>=20
> First, check if a BOM is present. If it is, decode the file to UTF-8.
> If no BOM is detected, then try to parse the file as UTF-8. If that fail=
s,
> attempt to decode the file using the working tree encoding of the file,
> if any. If that fails, print a warning to tell the user that the exclude
> file could not be decoded and skip the file.
>=20
> This raises the issue that if the entire tree is encoded in, for example
> UTF-16BE (no BOM), then even if the encoding is given in .gitattributes,
> git would not be able to decode it.
"able to decode: Yes. But willing to do so: not with the patch, right ?
> I believe that this is still
> acceptable since a warning will be emitted for the file (since it has no
> BOM, is not valid UTF-8 and no working tree encoding could be found).
>=20
> One case that isn't handled is if a wrong encoding is given in the
> attributes and the exclude file has no BOM and is not UTF-8. Using
> iconv to convert an UTF16BE file to UTF-8 while specifying UTF-16LE
> yields gibberish without an error and so this case is a silent failure
> where no patterns will match.
One question is, if we should look at working_tree_encoding at all.
The other one is, how much UTF-16 handling of ignore or
other file should we have have in Git ?
It seems that this fix is for a very special case only ?

From
https://github.com/git-for-windows/git/issues/3329
we read:
/******/
if (size > 1 && buf[0] =3D=3D 0xff && buf[1] =3D=3D 0xfe) {
    char *reencoded =3D reencode_string_len(buf, size, "UTF-8", "UTF16-LE-=
BOM", &size);
    if (!reencoded)
        die(_("could not convert contents of '%s' from UTF-16"), fname);
    free(buf);
    buf =3D reencoded;
}
/******/
(Which seems a simpler suggestion)
However,  there is no UTF-16-LE-BOM in iconv=20
(at least in the majority of implementations),=20
so a better approach, totaly untested, may be:

if (size >=3D 2 && buf[0] =3D=3D 0xff && buf[1] =3D=3D 0xfe) {
    char *reencoded =3D reencode_string_len(buf+2, size-2, "UTF-8", "UTF16=
", &size);
    if (!reencoded)
        die(_("could not convert contents of '%s' from UTF-16"), fname);
    free(buf);
    buf =3D reencoded;
}

This leads to some free thinking, especially when we look at
other implementations of Git:
Would it be better to simply bail out on UTF-16 files ?
Techically all files with a '\0'.
[snip]=20
