Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32DF53A1D2
	for <git@vger.kernel.org>; Thu, 28 Aug 2025 13:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756388966; cv=none; b=osXrFxkGpijHM3WPXY8ADvrwS3CyZI5GRe4648+o037u+WrVhLS5sWQU0LxtXYlU03CtXpu8a9wMIO1tlSUmEff1Ms3uxLivi/NEOXb3k4xMP1tHPTwbPrBxYWV/iT6m1t3U8Qq4wBoUSURT3a1yRuH+K/OO/SKHFJtyyvNrlWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756388966; c=relaxed/simple;
	bh=IQw0DiqWuwz+u0+ThEgDQqcAKmlI/TZFMQntKruT1mw=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=HiDITP6Gj9jCBv66BVxsMMY1wn/dpnmBrjEEO7QskKSGTGu4+CxazOt9JtQKN4QfNtgtqDBfTxLqaa9hKuCV+dPIg/cnp17Iw0uNdg4btUAyFoIPxXVOBYZkWsENYBbcjqmrkpMtJY6KO5xeL+Gu21D8i2SeXANqikIgkSva4Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=HJlBQjIC; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="HJlBQjIC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1756388962; x=1756993762;
	i=johannes.schindelin@gmx.de;
	bh=ZiphrXr1jvpbhzzIP225RFVpc3B/SVAcKfPBXgoC1Ro=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=HJlBQjICVZwdbRac+2pNeHi0t152XUjHI52Ua8pga0N64uxK+BL+IgWrtMiBdxa0
	 uwacAN7iiJ0Ea7zn4d3FkXyHdJrTk/yvDBAg2Cz9VZxJ6aOSXc0VOLhBvW/EIPMVG
	 yylHJ17hXhEIf4Vj8WMuRRNmKN0V3tKxK3nUNlWIxddnIj85I2UzXH2IeLMQILojF
	 cMZ1oWQW8+MvNHcrMbKnKsxfY+pMSxPN77Lpepb1o7Xp8gEs4EHvWth06OnR7mJ0t
	 ffuiYPMUSYZ3BkOVbVuGZ0bZIlZ6kVHYRjEnnYS+9dk9VefR3Va+8O0Inx6yZU1VO
	 aUuKe0n5kLMEOLn4yw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([213.196.213.26]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N6siz-1uR1jh1Gql-014sns; Thu, 28
 Aug 2025 15:49:22 +0200
Date: Thu, 28 Aug 2025 15:49:20 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Mark Levedahl <mlevedahl@gmail.com>
cc: git@vger.kernel.org, j6t@kdbg.org, me@yadavpratyush.com
Subject: Re: [PATCH] git-gui: use tk_messageBox for ask yes/no
In-Reply-To: <20250828133301.74328-1-mlevedahl@gmail.com>
Message-ID: <33e2ad25-cafa-66a4-7bde-056ebbf6a5d0@gmx.de>
References: <4b04832c0b8119b784806f54a2354d910965a523.1756371530.git.gitgitgadget@gmail.com> <20250828133301.74328-1-mlevedahl@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:UYFN9HQePxbIxaiJtA+x5yrW8hB+Iff8jhxsd8CI/kheS1bcCTP
 LEHqMhfh58LOw+2Lgp/HtKJyasluShH1HRSoMVyCrQENDo1y4sHU4eDYyu5tE9kz3NhpyjF
 B1r4kOZukf99MccluTwA+LQOqRm314kv9SgBvEdBWXypy7bK3ex1d2RDDc0oAlRO1VmCuID
 +x9Z6ahsAnzAOi9gaTd+A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Q4k4oqA/qyE=;NLxpKnqt6NIU8O2OvMLlbFykgCs
 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
Content-Transfer-Encoding: quoted-printable

Hi Mark,

On Thu, 28 Aug 2025, Mark Levedahl wrote:

> git-gui includes git-gui--yesno that relies upon Tk 8.5 constructs, and
> this dialog box is not supported with Tk 9.0.  Tk provides tk_messagebox
> for this same purpose, fully supported in Tk 8.5+, so use tk_messagebox
> instead.

Thank you very much!

Let's keep your patch separate, to give you full credit, and to keep
Heiko's patch as close to the original that has survived in Git for
Windows for so long.

Ciao,
Johannes

>=20
> Signed-off-by: Mark Levedahl <mlevedahl@gmail.com>
> ---
>  git-gui--askyesno | 35 +++++++----------------------------
>  1 file changed, 7 insertions(+), 28 deletions(-)
>=20
> diff --git a/git-gui--askyesno b/git-gui--askyesno
> index 142d1bc..cd986f2 100755
> --- a/git-gui--askyesno
> +++ b/git-gui--askyesno
> @@ -10,12 +10,6 @@ exec wish "$0" -- "$@"
>  # overridden via the optional `--title` command-line
>  # option.
> =20
> -set NS {}
> -set use_ttk [package vsatisfies [package provide Tk] 8.5]
> -if {$use_ttk} {
> -	set NS ttk
> -}
> -
>  set title "Question?"
>  if {$argc < 1} {
>  	puts stderr "Usage: $argv0 <question>"
> @@ -28,25 +22,7 @@ if {$argc < 1} {
>  	set prompt [join $argv " "]
>  }
> =20
> -${NS}::frame .t
> -${NS}::label .t.m -text $prompt -justify center -width 40
> -.t.m configure -wraplength 400
> -pack .t.m -side top -fill x -padx 20 -pady 20 -expand 1
> -pack .t -side top -fill x -ipadx 20 -ipady 20 -expand 1
> -
> -${NS}::frame .b
> -${NS}::frame .b.left -width 200
> -${NS}::button .b.yes -text Yes -command {exit 0}
> -${NS}::button .b.no  -text No  -command {exit 1}
> -
> -pack .b.left -side left -expand 1 -fill x
> -pack .b.yes -side left -expand 1
> -pack .b.no -side right -expand 1 -ipadx 5
> -pack .b -side bottom -fill x -ipadx 20 -ipady 15
> -
> -bind . <Key-Return> {exit 0}
> -bind . <Key-Escape> {exit 1}
> -
> +set dlgicon {question}
>  if {$::tcl_platform(platform) eq {windows}} {
>  	set icopath [file dirname [file normalize $argv0]]
>  	if {[file tail $icopath] eq {git-core}} {
> @@ -55,9 +31,12 @@ if {$::tcl_platform(platform) eq {windows}} {
>  	set icopath [file dirname $icopath]
>  	set icopath [file join $icopath share git git-for-windows.ico]
>  	if {[file exists $icopath]} {
> -		wm iconbitmap . -default $icopath
> +		set dlgicon $icopath
>  	}
>  }
> =20
> -wm title . $title
> -tk::PlaceWindow .
> +wm withdraw .
> +
> +option add *Dialog.msg.font {Sans 10}
> +set ans [tk_messageBox -icon $dlgicon -message $prompt -title $title -t=
ype yesno]
> +exit [expr $ans eq {no}]
> --=20
> 2.51.0.99.15
>=20
>=20
>=20
