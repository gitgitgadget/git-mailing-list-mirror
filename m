Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E2E5388E52
	for <git@vger.kernel.org>; Tue,  7 Apr 2026 23:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775604526; cv=none; b=L6lGoMWEbQ4fEMqbvdHzHECLoOP8Suq79oMF7MQYw6sPfSOYGEXS9b01JDmHX9aOzJa1Q7HoTTISESQSGhgsVFu8H7S6Gt/kxRHO8a53QMk8zkG2PiJFDE82GQLqnm8oN7+I3FoXPmuvqmQz+UR7hmDSzupGXT/o2Fts7InRPbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775604526; c=relaxed/simple;
	bh=+Wkaht5LmLbkyxQBIW7NNf7WMEx467zh7omapYjtJZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sA0QBFGH5jEA6Kh17jSF7AuSIsm2CMxmI1uLzb95Z19VUdJ7AEgXaniPMN8MfuHBuFvSxJdss6zxaRW3kaicUQZydZscygDi1Bbpm+O0rSoSNQATl194/1/yewqmMANJsIUmbeTWX8C6eXprax/2zOI8I3KBbW5lqUZP/Pg88xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tFMY/C91; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tFMY/C91"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-43cfac48bc7so3065940f8f.0
        for <git@vger.kernel.org>; Tue, 07 Apr 2026 16:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775604524; x=1776209324; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ahj+rdFw5S3uUhNWjxeq5tFBU2UfLXjjUU+vd6lf8GA=;
        b=tFMY/C91scoX3/NnBCSP35E8u7eopqoF8Stvta6N0kS0e84zhIViqPNxZChQu1S21A
         ILGiCVZ0fg27InSdv71sudZ/pXsuePrz8HEtceu78v23aSgsLhi+mdUdh4hkFrTST0zb
         T/jqcUcRAgGVQ+uVm+4soeO6+gHqgwxrsSRZxeV6Y/zU3e8vU0TDPLpPOVIZlANJaea9
         5Ultz4cVGPaYFu2BitSH3BNZA4xEkWLMCif0kbQhOlSCaU/pSecSja75IlDdp+kCr6gQ
         bzsUuOtAXpQ6kHz0YimOP7yKdbqE2+9aUUTYrUkDnxKuilEdZxxrf+NYBpMHwT+ED3GH
         N6Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775604524; x=1776209324;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ahj+rdFw5S3uUhNWjxeq5tFBU2UfLXjjUU+vd6lf8GA=;
        b=S8dqb0qjXsx80sm+cSNHwabAgaxKawS9OdNpMrrC1kG0Pl5YccDAw/cRzLgzspfDYv
         Ygu/GQYaBS8msE9nukAMTdxth9rCr29Nv/1cEEj92J54W+ZhAO5wehdto8HtvZHOMKBv
         LKi+n55uVRxwpTMLIMxkJhieUsXqPsZfjMzgJpVyp2+6d4kpfmKsmUAfIyz9JLYfHd4j
         8cEG1Y7hw3Gkm+OqALQs6QUUqRtui2BkLA8sTTv1EYDk6RrFyXdgwetwjC6HLvwtKIr+
         F3ufqyTF25Homovh/L5Gvh9k3Va+3/qELWsg7J1YG/TRETjNR/CXkWFNHTf7a7pG2Gpm
         tCwQ==
X-Gm-Message-State: AOJu0Yx1n3UHPkNb5Vm14KBjOEALIGyxHR0WMYPsYArEB4mxqs/0iIBh
	vSuN3F/BVhnhDayrjPeepJ0GoVaFZor4K6hbEdNL3Yhp8+8M6lr06iaH
X-Gm-Gg: AeBDietPXm5yquBdSNGHQbKVN7oa0JmQsS1BsdbzrHw3zQWG6dzWAtWzHUHALi6hulO
	rL9Dy07LUmobhlybvfNKEocawJNjcfDoMCWUIHQFOzUcDu2K4UQLe3FcnEMYU80mTaWl2DqaM6x
	RnhnXmwURCCVliCZD4NDwaeIGRSnqpnQUcYq0SZ0voJvtq4UpuuCSC6575A7s4QXNgOI8nFzbuI
	WQxQVAjbPtgSJmHejdwhTlHSAVnedkarYXtNP21OYkuIxSD/OniuvBa+Bo7lSF1i0P/68o2fIDO
	Nip9hPyPDXt8+PnCYeToM4cttv2M7rWLRmLFQQaCG7aYXbZIotRdyZGXREg/Lh/Xen3ORj5yUCq
	k0loyGqB9/8CT3/nn2fdm3lfPjTOU2cS9GSSIp2Z06Pa34iaY23g94Z8pAj5azJg1CY9GTIfTX2
	TJA5x/2G18G12VE7rJXjCCcBpywGmrgoet
X-Received: by 2002:a5d:588c:0:b0:43b:5097:6f60 with SMTP id ffacd0b85a97d-43d292e1927mr27716437f8f.32.1775604523373;
        Tue, 07 Apr 2026 16:28:43 -0700 (PDT)
Received: from lorenzo-VM ([84.33.160.4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e4f7d4esm46840510f8f.34.2026.04.07.16.28.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 16:28:42 -0700 (PDT)
Date: Wed, 8 Apr 2026 01:28:39 +0200
From: Lorenzo Pegorari <lorenzo.pegorari2002@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
	Patrick Steinhardt <ps@pks.im>, Taylor Blau <me@ttaylorr.com>,
	Elijah Newren <newren@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [GSoC PATCH v3 4/5] t7700: test for promisor file content after
 repack
Message-ID: <adWSMUZtlh7ct9bX@lorenzo-VM>
References: <cover.1774205661.git.lorenzo.pegorari2002@gmail.com>
 <cover.1775431990.git.lorenzo.pegorari2002@gmail.com>
 <8e58c1263d15fb8dba8ce1d2866d369e938bf2b6.1775431990.git.lorenzo.pegorari2002@gmail.com>
 <xmqqldez9232.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqldez9232.fsf@gitster.g>

On Mon, Apr 06, 2026 at 03:05:37PM -0700, Junio C Hamano wrote:
> LorenzoPegorari <lorenzo.pegorari2002@gmail.com> writes:
> 
> > +test_expect_success 'check one .promisor file content after repack' '
> > +	test_when_finished rm -rf prom_test &&
> > +	git init prom_test &&
> > +	path=prom_test/.git/objects/pack &&
> > +
> > +	(
> > +		test_commit_bulk -C prom_test --start=1 1 &&
> > +		
> > +		# Simulate .promisor file by creating it manually
> > +		prom=$(ls $path/*.pack | sed "s/\.pack/.promisor/") &&
> 
> So "prom" is a list of filenames; since $path does not have any
> funny letters that interferes, later use of unquotd $prom will
> list these files.  OK.

`test_commit_bulk` creates a single ".pack" file. We use `$prom` to
create the associated ".promisor" file.

> > +		oid=$(git -C prom_test rev-parse HEAD) &&
> > +		echo "$oid ref" >$prom &&
> 
> Oh, not quite.  How are we guaranteeing that there is only one file
> in the list of files in $prom?

Yes, because `test_commit_bulk` specifically creates a single pack.

> In any case, quoting from Documentation/CodingGuidelines:
> 
>  - Redirection operators should be written with space before, but no
>    space after them.  In other words, write 'echo test >"$file"'
>    instead of 'echo test> $file' or 'echo test > $file'.  Note that
>    even though it is not required by POSIX to double-quote the
>    redirection target in a variable (as shown above), our code does so
>    because some versions of bash issue a warning without the quotes.
> 
> 	(incorrect)
> 	cat hello > world < universe
> 	echo hello >$world
> 
> 	(correct)
> 	cat hello >world <universe
> 	echo hello >"$world"

Ack.

> > +		# Save the current .promisor content, repack, and check if correct
> > +		prom_before_repack=$(cat $prom) &&
> 
> This is misleading, unless you plan to update the early part of this
> test to store a more realistic data in the $prom file.  Wouldn't it
> be equivanent to
> 
> 		prom_before_repack="$oid ref" &&
> 
> at this point?

Yeah, simply using "$oid ref" would be better at this point. One less
confusing variable.

> > +		git -C prom_test repack -a -d &&
> > +		prom=$(ls $path/*.pack | sed "s/\.pack/.promisor/") &&
> 
> We expect that there is only one .pack and .promisor file.  Why
> are we listing .pack and turning them to .promisor, instead of doing
> 
> 		prom=$(ls $path/*.promisor) &&
> 
> here?  Don't we expect that this "repack" to recreate .promisor file
> as well (and if we do not see the file then we detected another bug,
> which is a good thing)?

100% correct. I just copied it from above without thinking enough. Will
do this. Thanks!

> > +		# $prom should contain "$prom_before_repack <date>"
> > +		test_grep "$prom_before_repack " $prom &&
> 
> I do not quite understand this test.  Ahh, OK.  We expect that there
> was only a single entry in the original, because that is what we
> placed in the original .promisor file.

Exactly.

> Enclose $prom inside a pair of double quotes, as it is misleading
> without.  I wasted a few minutes wondering where you are expecting
> these possibly multiple promisor files from.

Will do that.

> > +		# Save the current .promisor content, repack, and check if correct
> > +		cat $prom >prom_before_repack &&
> 
> 		cp "$prom" prom_before_repack &&
> 
> would be more standard.

Ack.

> > +		git -C prom_test repack -a -d &&
> > +		prom=$(ls $path/*.pack | sed "s/\.pack/.promisor/") &&
> 
> The same comment about "don't we know .promisor file should exist,
> and shouldn't we check it directly?" applies here.

True. Ack.

> > +		# $prom should be exactly the same as prom_before_repack
> > +		test_cmp prom_before_repack $prom
> > +	)
> > +'
> 
> 
> Same comment applies from earlier to the next test piece, I suspect.
> Let's take a look.
> 
> > +
> > +test_expect_success 'check multiple .promisor file content after repack' '
> > +	test_when_finished rm -rf prom_test &&
> > +	git init prom_test &&
> > +	path=prom_test/.git/objects/pack &&
> > +
> > +	(
> > +		# Create 2 packs and simulate .promisor files by creating them manually
> > +		test_commit_bulk -C prom_test --start=1 1 &&
> > +		prom=$(ls $path/*.pack | sed "s/\.pack/.promisor/") &&
> > +		oid=$(git -C prom_test rev-parse HEAD) &&
> > +		echo "$oid ref" >$prom &&
> > +		prom_before_repack1=$(cat $prom) &&
> 
> > +		test_commit_bulk -C prom_test --start=1 1 &&
> > +		prom=$(ls -t $path/*.pack | head -n 1 | sed "s/\.pack/.promisor/") &&
> 
> Do not pipe head into sed, as sed is more capable.
> 
> 		ls -t $path/*.pack | sed "s/.../;q"

Ack.

> > +		oid=$(git -C prom_test rev-parse HEAD) &&
> > +		echo "$oid ref" >$prom &&
> > +		prom_before_repack2=$(cat $prom) &&
> 
> But more importantly, this may become a source of flakiness.  These
> two packfiles are likely to have very close timestamps and depending
> on the timing, how heavily loaded the machine is, and the phase of
> the moon, it is not guaranteed that you'd grab the name of the new
> pack.  Instead of sorting by type or getting the first one, which
> would not work reliably, grab both and filter out what you already
> have seen.

Makes sense. Ack

> > +		# Repack, and check if correct compared to previous saved .promisor content
> > +		git -C prom_test repack -a -d &&
> > +		prom=$(ls $path/*.pack | sed "s/\.pack/.promisor/") &&
> > +		# $prom should contain "$prom_before_repack1 <date>" & "$prom_before_repack2 <date>"
> > +		test_grep "$prom_before_repack1 " $prom &&
> > +		test_grep "$prom_before_repack2 " $prom &&
> > +
> > +		# Save the current .promisor content, repack, and check if correct
> > +		cat $prom >prom_before_repack &&
> > +		git -C prom_test repack -a -d &&
> > +		prom=$(ls $path/*.pack | sed "s/\.pack/.promisor/") &&
> > +		# $prom should be exactly the same as prom_before_repack
> > +		test_cmp prom_before_repack $prom
> > +	)
> > +'
> > +
> >  test_done

Thank you so much Junio,
Lorenzo
