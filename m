Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49AAF1CFEC1
	for <git@vger.kernel.org>; Mon, 21 Oct 2024 16:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729528475; cv=none; b=MJFmcr/MFcaPs8tdIxFzlNPVuCcTIxjud59WrylodMwZfYwOWvt4EVg9VfjliFQ91m3xMlwFbVBv/+eSTStlJTl+RhdZF5fatZmNjrBPJD62xWAW4bDZra5Dde2Pj8NRkM8bBo7tIn3Z96vO6+Ok6q8D1yhZi44w9h/9dO0k+gI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729528475; c=relaxed/simple;
	bh=AfnFoWf9QkySkzECRuy0gJsvrea+tYILlAQHcWOycH0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B8wyyUkr1asdAmPYqeRNL63pkCQDLLTpLDGlB+gXXM01h2el/IC22JuqicuwLWaOldwyTFm97vv+3gY72q+aMHLcIVkVZnBGAJVSynPxVeKU+RWYfDSKTZC9OKJo+CYWAXkM1aJJvmjV54wGa5C+xnCzkLUzVjvRoUMRT2m6Uqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=psKPiBLJ; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="psKPiBLJ"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-6e34339d41bso40991017b3.0
        for <git@vger.kernel.org>; Mon, 21 Oct 2024 09:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1729528472; x=1730133272; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dIlOkTbTIE6NeBeDhrcpEGyEGRDv7BAqNMN2rbwdLSo=;
        b=psKPiBLJwhciXqjU8A/8haeDfYxobUmbsSBv9xDTuiM3b7R/eT4jVuqhvAFbzm7TSd
         strsENwm3bfq37mMwrL1AR25jhxRtbbeE+LIKJ2FTh57U+VPhNkEag34GAhbe1fqy4+l
         qE+r0Gfa00laY5U3LwRwcDu5dsL0mDmXBdyL1VnBNxCRBofF3WdEoeWzItbX7BLUHgRc
         W8QpAWOrZCI53KHZxJuTXacFU3GvWJwVdMhVmvbvCIcjBba+7Uu05qi7q6L+80+CRC/x
         JpYK6qONIQw+GfHSh9+PeFQACzEDS1YHdKihbTXsByaY2UINT0sssT5/ugB6gJy08KVW
         rxcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729528472; x=1730133272;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dIlOkTbTIE6NeBeDhrcpEGyEGRDv7BAqNMN2rbwdLSo=;
        b=kR+PCbAslRil6PNb6ZuLmxKnQzySfJw0zIkZ6AnPITqAxSrU6+lLnjGLWvaLbakARr
         /xzTjxDf0umXdePZxXBdxvgMXP5lU6RALsZuQMcy2dOn4o60q1p7tDUgs5n5qTHjDnt3
         eVC29yeJ5WI45WzM7C/1q/qNFKEekRWdY41y/Sjun52x+asXXsrxprWQpfcJ0QGpxavr
         FTsyJXpaWPfTeGiO6z3wgSSfqlZ6cAdK0hPQgDZMZDTt1lJk7GupmeSXbwwS64J2zcul
         AXIpsQLbdznbKyrzaNsnrVYSKyrWdsaH8S4sdpzy1L1+ddBDTGDVebRWw6hbptifu8Oq
         prBg==
X-Forwarded-Encrypted: i=1; AJvYcCUX61kr3SYatThPU24KwbWLIlBRVEOQGY4YyYKKKyKZLMk7+gfOx7Ak4h/L+4u45kNNOdM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzvII+4VBNZW74GVX65HuCPYl6frvXUXdcYJ+XSEcCwTYXZIc9
	CyzvlA2Wl1GibiMWs3e7S3lsdGyEfpUTaE2wclfNNrnCL1l4XG2pewNg6bmXLQoqa6G4o8Xmxcb
	t
X-Google-Smtp-Source: AGHT+IFr3AGWOZTZ0QEqA5aal+J5V8Czm0ZJSIygCaOZpHG70ENfV58vuYeTu+eiLIqBUHn/JZ2qhA==
X-Received: by 2002:a05:690c:6f0c:b0:6e3:420f:a2d1 with SMTP id 00721157ae682-6e5bfc78c7emr119004967b3.23.1729528472142;
        Mon, 21 Oct 2024 09:34:32 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e5f5d749e2sm7106997b3.142.2024.10.21.09.34.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 09:34:31 -0700 (PDT)
Date: Mon, 21 Oct 2024 12:34:30 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Usman Akinyemi <usmanakinyemi202@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,
	Usman Akinyemi via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org
Subject: Re: [PATCH v2 2/3] merge: replace atoi() with strtol_i() for marker
 size validation
Message-ID: <ZxaClmjrLAJiVxNJ@nand.local>
References: <pull.1810.git.git.1728774574.gitgitgadget@gmail.com>
 <pull.1810.v2.git.git.1729259580.gitgitgadget@gmail.com>
 <5d58c150efbed1a10e90dba10e18f8641d11a70f.1729259580.git.gitgitgadget@gmail.com>
 <ZxZHH-oHE7g09xIR@pks.im>
 <CAPSxiM_BCz2n-uOOSRk3AsVp-Y7R+1XNfVRt6dH6=fWVBZ6cBw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPSxiM_BCz2n-uOOSRk3AsVp-Y7R+1XNfVRt6dH6=fWVBZ6cBw@mail.gmail.com>

On Mon, Oct 21, 2024 at 02:24:38PM +0000, Usman Akinyemi wrote:
> On Mon, Oct 21, 2024 at 2:01 PM Patrick Steinhardt <ps@pks.im> wrote:
> >
> > On Fri, Oct 18, 2024 at 01:52:59PM +0000, Usman Akinyemi via GitGitGadget wrote:
> > > From: Usman Akinyemi <usmanakinyemi202@gmail.com>
> > >
> > > Replaced atoi() with strtol_i() for parsing conflict-marker-size to
> > > improve error handling. Invalid values, such as those containing letters
> > > now trigger a clear error message.
> > > Updated the test to verify invalid input handling.
> >
> > When starting a new paragraph we typically have an empty line between
> > the paragraphs. We also tend to write commit messages as if instructing
> > the code to change. So instead of "Replaced atoi() with..." you'd say
> > "Replace atoi() with", and instead of "Updated the test...", you'd say
> > "Update the test ...".
> >
> > The same applies to your other commits, as well.

Thanks for noting, Patrick.

> > These are a bit curious. As your test demonstrates, we retrieve the
> > values from the "gitattributes" file. And given that the file tends to be
> > checked into the repository, you can now basically break somebody elses
> > commands by having an invalid value in there.
> >
> > That makes me think that we likely shouldn't die here. We may print a
> > warning, but other than that we should likely continue and use the
> > DEFAULT_CONFLICT_MARKER_SIZE.
> >
>
> Ohh, I understand. Philip suggested this. For the warning, will I just
> use printf statement or what function to print the statement ?
> Also, how do I test the print warning statement ?

You can use warning() instead of die(), which will also print the
message to stderr. You can redirect stderr to a separate file in your
test, and then grep or test_grep that to ensure that you see the warning
message.

These messages should also be marked for translation (with `_()`), so
the result will look something like:

    if (strtol_i(check->items[0].value, 10, &marker_size))
            warning(_("invalid marker-size '%s', expecting an integer"),
                    check->items[0].value);

Thanks,
Taylor
