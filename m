Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F6E29614F
	for <git@vger.kernel.org>; Thu, 15 May 2025 09:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747300845; cv=none; b=I4pq7staDnkHn/bs+Dw9WfZqZMoq2c5cYqWa6zDRmSrtbMmQ32DsOuN7zrkxnTck4HcjtuFr0G1Of8DbDTjVtXVC+vDE03is9rLKwvaxAox3eXrCMXT0S8nSTuGnLRz71Q5lAV2LOZYI54nPkm+9AaA1hSrN7XWOjpupDC159/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747300845; c=relaxed/simple;
	bh=ha04QMCZ0Fq+U4zjvAqTDF/0QRZ3CMnmauTP3FKRUyg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dH1E92ybvNqYxlJWGYM5wT6snTbLoGeEalADy/sf16MZ36wgcTe6pEv9BaYiAmihNpQghLH+2hKmBtVaQ3Vvd0ijTm5GMsgcGJ/JeRnfZuoZr30eUx32RAjovbhh0fksV6H3UVH7NHiCXcTl8sAmcuxUejFOwZ41fyoqSEsm6jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=oswald.buddenhagen@gmx.de header.b=g++2O7fj; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=oswald.buddenhagen@gmx.de header.b="g++2O7fj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1747300840; x=1747905640;
	i=oswald.buddenhagen@gmx.de;
	bh=Bl4ldLWg9RiYHDOpZ2VWZG2Ib2XFLJvjpgf3bNZjyug=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=g++2O7fjkBOIff5sgvzfBAKt6srHdakos6nKhvHI8dNzcXBcMLVor1i4U7HR4t/t
	 gT6sJhIAg+6wwRSPkN73VkBeXP1CELrkmnseOnTaGJvWs1CdEvMA6mQc2maK0yLba
	 3qImg7/QotDvX2EG9cus9f5PxnjdELxZwmTpwOKVUiZSbHbHGaLHyQ6b0+22ADCwx
	 8AY68OF14IBVJHrKJtn804MiC2jLKjOotGjOQMpeud8mAWE5tQeHAc8thwTsMbCIq
	 VbtMvgbhzVxZ4AjGdlfBuxiey8O/2MKdZ4XR87IQ1vRyqmMA926+TyFtgUBUT/3C4
	 73piIzBvU69A0MA3tQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from ugly.fritz.box ([89.247.162.101]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mel3n-1unBQI3965-00d3Ij; Thu, 15
 May 2025 11:20:39 +0200
Received: by ugly.fritz.box (MasqMail 1.0.0, from userid 1000)
	id 1uFUlb-DaS-00; Thu, 15 May 2025 11:20:39 +0200
Date: Thu, 15 May 2025 11:20:39 +0200
From: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To: Johannes Sixt <j6t@kdbg.org>
Cc: Gareth Fenn <garethfenn@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] git-gui: do not end the commit message with an empty line
Message-ID: <aCWx56e02RqAUZgw@ugly>
References: <ed1ca9fa-15f0-4601-be31-8a578c7fb788@kdbg.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <ed1ca9fa-15f0-4601-be31-8a578c7fb788@kdbg.org>
X-Provags-ID: V03:K1:j1BzBd2sEuCTGjGJmU1VTVVAhyUst0YpnFgx49p4DZkK1TqvUdQ
 0G39f9enOhgbk+Qd7yaqdOYA9uBKtFYPukMWPe/8EuHjShnWvKVegxwZgcD2uuGkCmd5Zr7
 vz7KtiF4n6yi6OGNkIQEazYlowTN7Tb4ou1O6ISmMF3rRjidquGOykwgPrwOQJnqUdtsPdK
 VFwq+dsE+YOwnoD5S1+AA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:oLAFQC8OTng=;rUoW1MH9cErhTQ0BDLIhLkBoR49
 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
 y3VS9FfZ6P6VbkER6V/2404Qe91DW+k9JL
Content-Transfer-Encoding: quoted-printable

On Wed, May 14, 2025 at 10:50:05PM +0200, Johannes Sixt wrote:
>The commit message is processed to remove unnecessary empty lines.
>In particular, it is ensured that the text ends with at most one LF
>character. This one is always present, because the Tk text widget
>ensures that is present.
>
>However, we forgot

"did not consider" would be more accurate.

>that the processed text is written to the commit
>message file using 'puts', which also appends a LF character, so that
>the final commit message ends with two LF.

one could suppress that with -nonewline, but the proposed code is=20
shorter.

>Trim all trailing LF
>characters, and while we are here, use `string trim`, which lets us
>remove the leading LF in the same command.
>
>Reported-by: Gareth Fenn <garethfenn@gmail.com>
>Signed-off-by: Johannes Sixt <j6t@kdbg.org>

Reviewed-by: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>

>---
> lib/commit.tcl | 6 ++----
> 1 file changed, 2 insertions(+), 4 deletions(-)
>
>diff --git a/lib/commit.tcl b/lib/commit.tcl
>index a570f9cdc6a4..f3c714e600ac 100644
>--- a/lib/commit.tcl
>+++ b/lib/commit.tcl
>@@ -214,12 +214,10 @@ You must stage at least 1 file before you can commi=
t.
> 	global comment_string
> 	set cmt_rx [strcat {(^|\n)} [regsub -all {\W} $comment_string {\\&}] {[=
^\n]*}]
> 	regsub -all $cmt_rx $msg {\1} msg
>-	# Strip leading empty lines
>-	regsub {^\n*} $msg {} msg
>+	# Strip leading and trailing empty lines
>
pedantically, stripping the final LF doesn't strip a trailing empty=20
line, but prevents one from being created - unless the commit message is=
=20
completely empty, where that would fail. i guess this case is not all=20
that important, so we can ignore it. however, it may make sense to add=20
another comment like "puts will re-add a trailing newline".

>+	set msg [string trim $msg \n]
> 	# Compress consecutive empty lines
> 	regsub -all {\n{3,}} $msg "\n\n" msg
>-	# Strip trailing empty line
>-	regsub {\n\n$} $msg "\n" msg
> 	if {$msg eq {}} {
> 		error_popup [mc "Please supply a commit message.
>=20
>--=20
>2.49.0.212.gc22db56b11
>
