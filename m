Received: from fortymile.utu.fi (fortymile.utu.fi [130.232.247.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553611CAA6D
	for <git@vger.kernel.org>; Sat,  3 Oct 2026 07:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.232.247.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791012804; cv=none; b=d3/AORnzohdx1ITJpxoRaZyqNrGerIseyoQSfk649bD8x59fP5xWxnHzSI2yMCkD5rTEgGA5c7xPPM3mD6HfeRRnSlWavt5yuCWVoPX5UMry+ykHKP+Ijfz3u0wuk+IZ/ZRHpwrMWEM+mvDmRUS62nkYjkAPrWjZ7aLD9/QtYRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791012804; c=relaxed/simple;
	bh=abshW07qPt+T9PkIJXAuXSraSz6xLqr4jAfajN1LVFo=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nkNebQp5HKDF3Mw17CUKacGBa11I9Dfmbxhd0sGWS9hChCRi6AjIb3FcEHfpjmJr5sSQaVqYihWnnGFuy5pWkCRFv72Wq+K8SVqIK77+om+Ct64fP1FxDeBDwRG0pHP/rcGLmobej5aY+5ITQmZ+q2i4uRV3TxhkWisIPGWnOi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi; spf=pass smtp.mailfrom=utu.fi; dkim=pass (2048-bit key) header.d=utu.fi header.i=@utu.fi header.b=Dgk+2G6Y; arc=none smtp.client-ip=130.232.247.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=utu.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=utu.fi header.i=@utu.fi header.b="Dgk+2G6Y"
Received: from smtp-04.utu.fi (smtp-04.utu.fi [130.232.207.47])
	by fortymile.utu.fi  with ESMTPS id 6937X35s031644-6937X35u031644
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Sat, 3 Oct 2026 10:33:04 +0300
Received: from ex19-06.utu.fi ([130.232.247.46])
	by smtp-04.utu.fi with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <taahol@utu.fi>)
	id 1xCuEx-009OUe-Qu;
	Sat, 03 Oct 2026 10:33:03 +0300
Received: from localhost (86.50.95.90) by ex19-06.utu.fi (130.232.247.46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Sat, 3 Oct
 2026 10:33:03 +0300
Received: from localhost (localhost [local])
	by localhost (OpenSMTPD) with ESMTPA id 45eb9c4f;
	Sat, 3 Oct 2026 07:33:03 +0000 (UTC)
Date: Sat, 3 Oct 2026 10:33:03 +0300
From: Tuomas Ahola <taahol@utu.fi>
To: Junio C Hamano <gitster@pobox.com>
CC: Julia Evans <julia@jvns.ca>, Julia Evans <gitgitgadget@gmail.com>,
	<git@vger.kernel.org>
Subject: Re: [PATCH] doc: don't require a SYNOPSIS in section 7
Message-ID: <20261003073303.G-Gck%taahol@utu.fi>
In-Reply-To: <xmqqo6dbvlaf.fsf@gitster.g>
References: <pull.2246.git.1790957227881.gitgitgadget@gmail.com>
 <01891b4b-ce04-41aa-8065-d7b88e466dbc@app.fastmail.com>
 <xmqqo6dbvlaf.fsf@gitster.g>
User-Agent: s-nail v14.9.22
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: ex19-04.utu.fi (130.232.247.44) To ex19-06.utu.fi
 (130.232.247.46)
X-FEAS-BEC-Info: WlpIGw0aAQkEARIJHAEHBlJSCRoLAAEeDUhZUEhYSFhIWkhZXkguLT4lWFxYWFhYWFBeUVxfSFhISFlbSBwJCQAHBCgdHB1GDgFIWUhZX0gPARwbHA0aKBgHCgcQRgsH
 BUhYSFpIWVxIWVtYRlpbWkZaWF9GXF9IUEhYSFhIXEhYSFhIWEhZUUgPARwoHg8NGkYDDRoGDQRGBxoPSFhIWlpIDwEcDwEcDwkMDw0cKA8FCQEERgsHBUhYSFlfSA8B
 HBscDRooGAcKBxBGCwcFSFhIWVtIAh0EAQkoAh4GG0YLCUhY
X-FEAS-Client-IP: 130.232.207.47
X-FE-Last-Public-Client-IP: 130.232.207.47
X-FE-Policy-ID: 3:5:2:SYSTEM
X-FE-Hostname: fortymile.utu.fi
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; d=utu.fi; s=out-utu-v3; c=relaxed/relaxed;
 h=date:from:to:cc:subject:message-id:references:mime-version:content-type;
 bh=jn0gr8xrZvewV/gR9WHtv9y6+VmkcA51b4utPqDmRaY=;
 b=Dgk+2G6YyybMKgMmhdAgBu1vxbV4Z8nPIkvOMoIV+lC/YBNd9YevIaaDNEXGIQ5QpgtGcQxHwhEo
	1RtQbmLclXeE+1DAC2dkz4FO/i843vYvReBsM2/NtcMyMghyn0kc8LBnZ9ooVms17CKyOboLIc+R
	6057W+RhEB/gtNOFPLQUPjdwCxMadrNe93Tx947mZwlsUvORmILAxqqB7rdmU8fnykNmdKb7+Q1k
	MyOZRgI7QiePF49ZL2o07va9ODNsx8A26kzOhPFYCVnNjVEaVaBos96yHnSBVn5gdlwuyxDOvguz
	Ozzj/RyRqXJcJdhiRMw3stWk604svABxTMzldA==

Junio C Hamano <gitster@pobox.com> wrote:

> "Julia Evans" <julia@jvns.ca> writes:
> 
> >> +# assume the first line is formatted like 'gitglossary(7)'
> >> +my $firstline = <>;
> >> +$firstline =~ m/\((\d)\)/;
> >> +my $man_section_number = $1;
> >> +
> >>  my $last_was_section;
> >>  my @actual_order;
> >>  while (my $line = <>) {
> >> @@ -93,6 +98,8 @@ while (my $line = <>) {
> >> 
> >>  		for my $section (sort keys %SECTIONS) {
> >>  			next if !$SECTIONS{$section}->{required} or exists 
> >> $actual_sections{$section};
> >> +			# Synopsis is not required in section 7
> >> +			next if ($section eq "SYNOPSIS" && $man_section_number eq "7");
> >>  			report("has no required '$section' section!");
> >>  		}
> >
> >
> > I just realized that this script is actually supposed to be able to process multiple
> > files as command line arguments, and that this patch won't work for that.
> 
> Yeah, your version would then notice only the first line of the
> first file, and my update would also do the same.
> 
> You can work from what I gave you and inside the "eof" part of the
> loop reset the %SECTIONS back to the original (which means you'd
> need to keep a separate copy of the original) and also reset the
> "did I tweak the %SECTIONS thing already?  have I handled the first
> line of the current file?" variable.
> 

Something slightly more declarative I managed to hack up:

diff --git a/Documentation/lint-man-section-order.perl b/Documentation/lint-man-section-order.perl
index 02408a0062..160c65e1be 100755
--- a/Documentation/lint-man-section-order.perl
+++ b/Documentation/lint-man-section-order.perl
@@ -13,6 +13,9 @@
 		},
 		'SYNOPSIS' => {
 			required => 1,
+			optional_in_man_sections => {
+				'7' => 1,
+			},
 			order => $order++,
 		},
 		'DESCRIPTION' => {
@@ -53,10 +56,18 @@ sub report {
 	$exit_code = 1;
 }
 
+my $man_section_number;
 my $last_was_section;
 my @actual_order;
 while (my $line = <>) {
 	chomp $line;
+
+	if ($. == 1) {
+		# assume the first line is formatted like 'gitglossary(7)'
+		$line =~ m/\((\d)\)/;
+		$man_section_number = $1;
+	}
+
 	if ($line =~ $SECTION_RX) {
 		push @actual_order => $line;
 		$last_was_section = 1;
@@ -92,7 +103,9 @@ sub report {
 		@actual_sections{@actual_order} = ();
 
 		for my $section (sort keys %SECTIONS) {
-			next if !$SECTIONS{$section}->{required} or exists $actual_sections{$section};
+			next if !$SECTIONS{$section}->{required} or
+				$SECTIONS{$section}->{optional_in_man_sections}->{$man_section_number} or
+				exists $actual_sections{$section};
 			report("has no required '$section' section!");
 		}
 
