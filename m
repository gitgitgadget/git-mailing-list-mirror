Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F804139CEE
	for <git@vger.kernel.org>; Tue, 23 Jul 2024 14:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721744351; cv=none; b=J59+cyxsHQ3OKV9S9s2C5p9qOgYjL0oNbH2wI+NzQ6kvaz2pDsakD5h6TiLz9MwcCVmgL7/xF1s054tLB+fFlr5CHGS61Q0k0O2RYh8JPMpJ51CSShCyXoFLglDZxTElxm1scXMNYUo3gKcCHgHQ4QGeIoqDZ+zCzy9N++XNQXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721744351; c=relaxed/simple;
	bh=i8GTO5zan7th2IRExUvWfcbaHnJfEt35ySd/FCoK92I=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=RK1dLxm/6AM/Fxn97seI2pRHZIZeHb6PaIflsF9yG3D1XpEGYcEdfv9hT/qosYI8ouDsv9a+PxFD48NJrOqavl930TBFtg85btQ+SkdLcVHdQ1PDNnjLLJPtIwYRKsyb1kvOpboiFvgj2yqaXgaFQltVj/vEKV2xJfu7w9Vcdf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=qMpAYZyS; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="qMpAYZyS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1721744341; x=1722349141;
	i=johannes.schindelin@gmx.de;
	bh=lhOk38neoi4JpbOtBfXtYKsIy+JSLqBNesisPNDFM7o=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=qMpAYZySn466bS5n8qCp8Zd1M5khqYT4I8GiieT7G7NjHULY2vTmO9PtPcND8uaG
	 gcmyZraJUNkkwxWiuUWY6WjAMKSY648t2WmzNotjp5T9aT0pT5DszXbB5UiteWlyk
	 6cybetGxyV11Yr4llXXCjQ3c83tRrlRaqMNVWac72s6JxvouG7PKSvlp5kB+ceB5I
	 6oex4705joFMi2WompNEIus3nj2mOBI234ket5UZhFIdJX+rPAZSLKBQflpng3go1
	 mceOwpZnBEOugXCgKcIqd9WhVJZdDtn1J4CxMn2JfAj6gQE8C02YTuZyskFy2duQn
	 bcOyBbbdZE8ozAz1RA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([213.196.212.218]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N63Ra-1sGja10kHY-00wz9Y; Tue, 23
 Jul 2024 16:19:01 +0200
Date: Tue, 23 Jul 2024 16:19:00 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>, 
    git@vger.kernel.org, =?UTF-8?Q?Jean-No=C3=ABl_Avila?= <jn.avila@free.fr>, 
    Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH v2] asciidoctor: fix `synopsis` rendering
In-Reply-To: <xmqqplr59mvm.fsf@gitster.g>
Message-ID: <a1d70653-182e-e063-5438-2b3179d011f7@gmx.de>
References: <pull.1749.git.git.1721507416683.gitgitgadget@gmail.com> <pull.1749.v2.git.git.1721679949618.gitgitgadget@gmail.com> <xmqqplr59mvm.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:ZIuTQYqBkNuEa/J4W4xBdfV1MRqk7WHthq8RUrvqWa1PmIv+91t
 ZSdoQ87DxfMH5GURUsDAn5MjwO9JYK00ynPzvN7ohqcSoUcUSHsG3ywooN7QurrZ/eFwGIY
 GamxRhUb667fHgPBfOJS54X7dtOCv4qrp14wIqfXvPT9Z1KQcntQXAAKlJr2F99/4IfDOua
 iMsoM6ip2CwRUsLPdOhbw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:N6ATEM4G9fg=;LP+kYIX+xqtIbSh7WtvwzrCUjxG
 IZa+myiMGqkgIiWBbdvCWQG/GNlboeg8FT7bfZYay4e7QpMrRlAJAtZaqpFbMSWqJvGFwHQqR
 1/SMfy+HDUD+ob6TyjpG2R/Cn4qxFGOPWXU442r/8UYjwPPr3o2mGdggAinfBFuQljofAcpOg
 FYVrwTXwloZ/SKvSXuoIGwo+AV7xgRDC3o1DWvoT790GQtqokQB6hXTLMQJIULOpvrEcB2WIL
 GlN27gFa3hMsNueXYIaZR7Oxf0KSNA7WiTQEvS/3Sek0DcPIsfqMUfKdvjVQd6X+daVgbi50K
 lwsPK7ZniC9+VcHMMGk5csIslISMzm/zciitX9Xs2P2KUOotYkMjRkFm48IyysQTvoaLRDLgN
 bM1dplBLlsGwi2+yCPK/W+0f21404XpPvHdthp838Rmg1LyYJG8ACmVnC4y19PZNiH/mpYmor
 X2swRYkJu7kbdxLCYnancp8TgNgYwCwfknhAd5vzY7dqNeWYS5NMopd97gqkDSWC3s5rPq0l6
 FdnJWuWE3WjQLi7EXsEn7wm9skLjHuGxH1Q4oHOeJLhcbEI9T9Q4jPMJ2BcuaFlx5qRPFn8Ak
 euh5QoJPhJzELffrm9t/RR3qpzejPnSedJryhXpLrMlJXROEZo2QUIH/xH+cuHmVK47PHoODB
 VdvP1DGV4MGm6Nf+A3P36NckqY8BsjLKofVBCCePpMTmF1H+PpftJmWZ4D8DJSyyDPoCs/Ray
 leZZGRnL9YpFQ4rT9RQdQ1tYsLF+omMTLKbKBco9d0xWkHqmqxfZON9DqwsFcE6v/6woswsP1
 pZoJvVCuYQbbJxMBkBNBIuvA==
Content-Transfer-Encoding: quoted-printable

Hi Junio,

On Mon, 22 Jul 2024, Junio C Hamano wrote:

> diff --git a/Documentation/Makefile b/Documentation/Makefile
> index 78e407e4bd..371d56eb5e 100644
> --- a/Documentation/Makefile
> +++ b/Documentation/Makefile
> @@ -209,6 +209,8 @@ XMLTO_EXTRA +=3D --skip-validation
>  XMLTO_EXTRA +=3D -x manpage.xsl
>  endif
>
> +ASCIIDOC_DEPS +=3D docinfo.html
> +
>  SHELL_PATH ?=3D $(SHELL)
>  # Shell quote;
>  SHELL_PATH_SQ =3D $(subst ','\'',$(SHELL_PATH))
> @@ -337,6 +339,9 @@ clean:
>  	$(RM) $(cmds_txt) $(mergetools_txt) *.made
>  	$(RM) GIT-ASCIIDOCFLAGS
>
> +docinfo.html: docinfo-html.in
> +	$(QUIET_GEN)$(RM) $@ && cat $< >$@
> +
>  $(MAN_HTML): %.html : %.txt $(ASCIIDOC_DEPS)
>  	$(QUIET_ASCIIDOC)$(TXT_TO_HTML) -d manpage -o $@ $<
>

Hmm. This adds a "template" for no other reason than to appease the rule
that all `.html` files in `Documentation/` _must_ be generated. Typically,
templates are only added if anything in them needs to be interpolated to
reflect the particular build, which is not the case here.

Have you considered one of these alternatives?

1. https://docs.asciidoctor.org/asciidoctor/latest/html-backend/default-st=
ylesheet/#customize-extend
   talks about two ways to extend the default style sheet that do _not_
   need to add an `.html` file:

   a. add a `.css` file instead that `@import`s AsciiDoctor's default styl=
e
      sheet from a CDN.

      Upside: it is very clean, short, does not need any Makefile rule to
      generate a file that is arguable in no need of being generated.

      Downside: since the `@import` statement cannot refer to a file in th=
e
      same directory as the `.css` file, it incurs a web request. This
      would prevent the build from working on an air-gapped system (such a=
s
      when on a beautiful island without internet access).

   b. generate a `.css` file by merging AsciiDoctor's default style sheet
      with a small CSS snippet.

      Upside: it is again very clean.

      Downside: this would now require a Makefile rule when previously we
      managed without one.

2. simply adjust the `check_unignored_build_artifacts()` function to know
   about `docinfo.html`.

   Upside: it is still short and does not need any Makefile rule where
   previously no such thing was required.

   Downside: the simple rule "all .html files in Documentation/ _must_ be
   generated" would no longer hold true, making the architecture slightly
   harder to explain to newcomers.

3. stop mixing generated and source files in `Documentation/`. Instead,
   put the HTML files into a subdirectory that is clearly marked as
   containing only generated files.

   Upside: this would provide an overall cleaner architecture.

   Downside: lots of work, may require some convincing of oldtimers who
   see nothing wrong with mixing source and generated files.

Ciao,
Johannes
