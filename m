Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793902012;
	b=RsJ7iLOubyeleX8Jc2OasQHy+1M9ESRPNb6So39swtIiWbS7PprGAMAkX932e/qjfzIL
	 HzuqIOmIFeKSdOQQwwoDq3GNa3d97x8QfAGtUfNphF3aUzIHegs6vwl/tLYDAtxU6avz5
	 eKVTGBMPDCuAK+rZlhQAH7WRxOnFmYtXYN8KvsBqVILnWAlsdjwIcjTj3MiLI3cci7hwi
	 I9iEUFiy8SktwTmTazUcIGi9xUTTaLu2e8Z7DaiKx1vfjQ46JvV3sIT2Ok+Th5+iyOsGR
	 3MWVy4LK/r4Cycx/t2jQLHs7HZS20ap8pfumIDRtfqQiRJOuMUFLOGS5oGSehS4Upnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793902012;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=T8sEprQNW8eBuCYiQUa50NXEGaOL6nJICBmmSxlYWyw=;
	b=WNlth+Nx7QLcO2T3DufRWhUnqhZJpKTu2rUuMYI9MVE60IMvu//zLPs1rA1hXcPZSFuH
	 S8vcbt1TWmRZ0XobKQMqUCSDkqPGfy8hr3nED4AXIyYw+v1gyPwiur10M24Tf7jskUovc
	 jkJk3XlPVQNBQIAecUXru/WEqgDP5gdrORkISNY2+g8rlyZqsbFZ5n74b+EkNvLZVxxJP
	 3IFXmOVpx8K7DYPn7oAsYTFUnB+aguAMnsJlhtOwT99bixARERLeW7yggIh7I3toAqUdx
	 WQqVCzvzhXkIIdGCGTKVWof1tL9Hu3fuNh5Oo1IQ5ZmbsbE6thxUluBSz3hOYiPi1/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lCW0SKmf;
	arc=none smtp.remote-ip=209.85.161.54
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F27F606A31B
	for <git@vger.kernel.org>; Thu,  5 Nov 2026 18:06:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8F27F606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lCW0SKmf
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-6b19e291cc6so1912820eaf.2
        for <git@vger.kernel.org>; Thu, 05 Nov 2026 10:06:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793902011; x=1794506811; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=T8sEprQNW8eBuCYiQUa50NXEGaOL6nJICBmmSxlYWyw=;
        b=lCW0SKmfd1VZuqUrhD/Xkbb25Zkvb1xSR6Hb2qAPxGZk3GhWpOafQia4zqbILI6Ppc
         W3M+ZKnvYI7Kt5XUpr0oUoHHmvXv0SJUxIenWa5jW1DEnJyM8+1OoBXtDovcO85fmUCu
         XGFemAPLJUNgwxj4f4yYx87JABCuY/9Itrn98qZ0BnZDcjShOqIQ4KxQQjjrrx+opFu6
         G7UX3BPsCLEFtm+e+iSIhMnNaAG6w4zsGxtRYU0Qb+pb7pVtTr83LwUBenOnJqTjxwoM
         OGFEcn1/ghJWXiY8Sm4tT/OeYSId9pMsjkawYa/sDR4RMUMVfawkosnQuUvb8psvbJuk
         k08A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793902011; x=1794506811;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=T8sEprQNW8eBuCYiQUa50NXEGaOL6nJICBmmSxlYWyw=;
        b=a7NcQ2SLm+rf5G85TxzQ4e5Jmt6oMHpnUyJiWdf6QXE60AuHwdCojPZ4WZZId2Ot/d
         VwNieC75gZxCnmB6vVHQN1mVv8gWfMr4Ooy2E7gS/htOAhEIDFh7qO/eDjuzp2Kci0Ze
         t97gwS9rHRiqmT+qS6V4pgmIkdo2FoTomfvEGGxhi1mjbW3a8upuSjEyzA1lz481lGqt
         zey4uAXveqRriaK3Db+Db0+seSaYInDKlATc3DOWOKNGVdaz5H1kUoKTEMQANyIv/Thv
         Sf1FCtWfQXdYnCDtNXdzdjvJRNkTPGneoI4oPWJgL1SLE/8XEUnQFkwVoLRdsKxoXbQv
         5P7w==
X-Gm-Message-State: APuU4Z8asuIPnvKwOjKjyDK2CXk00eUjDGFgOW8jcGmQqdO+Qn90ZrN/
	XY8ZbsqK1zv63NZkbEmv3RLfI4Hyx0q+/3RGhYu2bpwigZBsiqo6nob2/c0UJg==
X-Gm-Gg: AYBFou3S+2w0Ozew86jhfTTCTedAVkHQsToQuFG6ykx7zxlssjG413OjDgvNEdpGOUA
	GV/EdzMCghlF2N12z4ySo480vOi+KsX/OfZgql6nWXNOJi5xeRUYERN+V7ivyQKmSEZLqIlxX3m
	2Bw3MZVntC+cD+tQdxIXtw7alNGk22MgXqlufOd2MeuNuHGzzF2Hcw5wlo1INxV48QfAUfWMR35
	9vfLZCd04H/ALccMEjIVAtQ5oW/aZjFTvaihKyTVTNt9oxWjf6zsgcLE2pTMGm3Lb0b6TzI1BWy
	e8YsI71V0BbMW1OopaG0mR6+F1pa1FOt688e0HT+BTw9Wc2fkJ9k0OMOdiWdp5qG6gONTKDmN2y
	0eWOnU9qT5ZVQFCTz0nRWsNu0fDJrTiCDa/ll5fKI4XUPiJcuW+tfKd42pBQTs/qy3tRd05vCxV
	0WoHeF1iSiFxQuvUBUnyS2WKfeM3guvhAX4SmPaEHccYvffnVU8kAnT1bbyGuh7aFsIRCkHV8+w
	xRDXSvmo9bXnB4/GZHaPeyMXINsYTQYfIbMfpIVL77TMcU2zAKEHC1K8Tx9L6kiqllKoCtu2Koe
	grD0N+FpjTVgYoh33BQQ2ngLEyG4IeRSH8Zpqg24PgSp6z75vUl5
X-Received: by 2002:a05:6820:2383:b0:6ff:3c22:3053 with SMTP id 006d021491bc7-716e78daa62mr235762eaf.51.1793902011405;
        Thu, 05 Nov 2026 10:06:51 -0800 (PST)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4acea680d38sm5409931fac.15.2026.11.05.10.06.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 10:06:50 -0800 (PST)
Date: Thu, 5 Nov 2026 12:06:47 -0600
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/2] object-file: return error on index-pack abnormal exit
Message-ID: <auzC7sZ95tL-5Axv@denethor>
References: <20261103212410.1389988-1-jltobler@gmail.com>
 <20261103212410.1389988-3-jltobler@gmail.com>
 <auyhIvMHLomMQrPm@pks.im>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <auyhIvMHLomMQrPm@pks.im>

On 26/11/05 04:30PM, Patrick Steinhardt wrote:
> On Tue, Nov 03, 2026 at 03:24:10PM -0600, Justin Tobler wrote:
> > When git-index-pack(1) exits abnormally after reporting the packfile
> > name, `odb_transaction_files_write_pack()` records an error message in
> > `err_msg` but still returns success. Current callers ultimately discard
> > the return value, so this does not cause any issues at present, but the
> > return value should still reflect the failure.
> 
> Is this a theoretical concern or does git-index-pack(1) perform any
> important steps after reporting the packfile name? I think we should of
> course respect errors in either case, but I wonder whether this is a bug
> fix or whether it's a simple cleanup.

This is a theoretical concern. If `read_index_pack_report()` returned
success and finish_command() returned an error,
`odb_transaction_files_write_pack()` would append an error message but
return 0. This isn't really the correct behavior. In this case though,
it doesn't cause any bugs because the return value is ultimately
discarded by its callers.

-Justin
