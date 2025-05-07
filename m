Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940C821770A
	for <git@vger.kernel.org>; Wed,  7 May 2025 12:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746619760; cv=none; b=N3ZsYgB6oEkTnKo0eodCB6qD3uSTmF9T3DlhNJTu8LDx3w+2xp5imJztX3T8gsDAxPysdwbnFfhSqPaVT1AosnqUgQs9izudY7Tvtb5xWzWQU1EGYvLS1Dgyl/vF4BycLlCrGfjFNn5BQdrcCcbeYbf8nU4F+bHWizkPmTkGtx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746619760; c=relaxed/simple;
	bh=SfX0sE+I3xxrZkQLz6v47PTvw1Wf/Nnh+vQBNzKQaLk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uCwlqoaMZpXTZ0/M4VITFmVkwa2MCiwN5eaP/4UKR5/uaIE12b8W0H6JbPuWhF/I059DVDx8ububgKJzVa9Ev+q+Ib90VdibvDsoYjahUNPX3cjUPCyUajY+ifzD7ZluaOdj1CiXHQ81f79tqBQ5dEDGZ0Ed7DbOqzhuL2N2rKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gt4A6wwX; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gt4A6wwX"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-739525d4e12so6635802b3a.3
        for <git@vger.kernel.org>; Wed, 07 May 2025 05:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746619758; x=1747224558; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TH7IuhZWJDqqOAF+crLDXvbPHe8oyrJPjQwxUQVJvxo=;
        b=Gt4A6wwXGfXg23Y72pX6x5TzDPnvFCLU9lsmA2cykeNnZC44CKtJCHsaTlEbxA6WwY
         kFz6NglnwVGiYqtqMfMHXLfFTRCt15tBeHCtsLqyVRzcqMyR8okjxxHE4uF/Q9N7KhCc
         HVxgnHv+Uj+IjseUPVMxAQOqlcv5rIJCB7DNGiZlGEAF4bAV4eCIlh/uNT3RRysfLmkf
         XI+dDSp2u60HODMX3jcw2ZIQD1uCuaZH6axs24PcWbkPmy30Lgolvv+V1OSFver6WLkf
         ijUNmsVdj4GbISLYWGXTKLVd1m5/UodO4SyRnP2V9IItaLcWGNDMkmm3ft+Kg0Mzi1ia
         rNQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746619758; x=1747224558;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TH7IuhZWJDqqOAF+crLDXvbPHe8oyrJPjQwxUQVJvxo=;
        b=POASdDurrWl1YUXS8mIyt3HgoL3GNxCoe1hF7PFcT3DGELTYDTz/n/nHsiZqMk8FsS
         cyeKuRlpJR6NwSCeL+39yrzXQAr5+Qw4z5EdXdK1pVjUNXim5GjCfYFHIN2jO/yGMA/b
         MUn+ON6qS44ZtjaT7jPV8Igloz3+EEbvvft/MyNrnUtyYRfRF6A+KR46vLYcpb+dzYDm
         njuE5ZhyKb8AbZNW5MrkkeSyOatKTphnMHAuDRGZs04onUbt7ee1OXMpKPBuCIN+RrXg
         aPMWXgh/JuF2c03g1rGbUyx2pyynsc7NtA5CfWJ18TUsHjBihBp9wk7ar/pupDU8KQvl
         /yVA==
X-Gm-Message-State: AOJu0Yxtn8tietk32ZtMHTtpc7LAuaHhDde6J9ratkprXRFD0+C52T7T
	o51763rvhADFwpg2hxaw/vIa6vjXw6HmN+outE3+WnriOyWE1sGO
X-Gm-Gg: ASbGncvwM7abEoqikTE/h1xWWxw9wRO5tnvkYxlkQOPCFj6qVOfX4k3o9SpmoCosNdf
	h/ingkhnQoDmbV0Z9uUW8hNSQwAmzj5PImyMnhDsDhkS543xnwcd7ArGzLQ553zXwySwgX7DAOC
	WP4syHe7QMIbOlOsc2WTVMGlSQjp9fvcsLQkP395UPW/1z4g5JQwG0oyC054E6Op4NJed3e9SD1
	1t8mBLb3JnyX2kUIYOwW9aykINPDxKxDQNS5p4zKKnNPivXxlUScAR/Zf5VrXqeun2QcJ8r+4kX
	2TYvzutt/CwcLCCL+Y38ApdrUVN9ub5JimZklosOpG/68Fk=
X-Google-Smtp-Source: AGHT+IEvXTXhs0xkRPOZHirMv+nqTjNzpoXcOJ+8Xtyu+zIF4Kqvaa3UBjaNF/fn/J0PWvujYgvaJg==
X-Received: by 2002:a05:6a21:1085:b0:1f3:40a9:2c36 with SMTP id adf61e73a8af0-2148b81eda3mr3791757637.10.1746619757766;
        Wed, 07 May 2025 05:09:17 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-b1fb3c6b332sm9266039a12.70.2025.05.07.05.09.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 05:09:17 -0700 (PDT)
Date: Wed, 7 May 2025 20:09:41 +0800
From: shejialuo <shejialuo@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 1/4] packed-backend: skip checking consistency of empty
 packed-refs file
Message-ID: <aBtNhXVpnvPuV6b7@ArchLinux>
References: <aBo7OiCKHTyT4DzH@ArchLinux>
 <aBo7nBOl18WWYIsA@ArchLinux>
 <xmqqr011k2ci.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqr011k2ci.fsf@gitster.g>

On Tue, May 06, 2025 at 11:42:37AM -0700, Junio C Hamano wrote:
> shejialuo <shejialuo@gmail.com> writes:
> 
> > +		touch .git/packed-refs &&
> 
> Unless you want to signal your readers that you care about file
> timestamp somehow, don't use "touch" as a means to create a file.
> Readers would have to wonder if .git/packed-refs existed before,
> or what git command that follows this part cares about its last
> modified time, or what behaviour the timestamp would affect.
> 
> What you are interested in doing with this is to ensure that *AN*
> *EMPTY* file exists there, hence you should say
> 
> 		>.git/packed-refs &&
> 
> instread.

Thanks for the suggestion, I didn't realise about this.
