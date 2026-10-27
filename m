Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793125594;
	b=1YdA9Qp7ir3RzmFUyOQCaqXj1WDFUFf1tHFjlmmYTUNlk78wuCnPvfBXdDr/6hoNloHs
	 l6XZHL9R61x+Qgyq3MPgKX0oF1GZb2Pz2m0fwCAYTaaQGxEtE/pmMuFUnXFKJcsYueKm3
	 8+Ihc82VTB5wz6AP59SbWRVFgSnxgos9L9V2dAA0calAmXalhRgLDZhlwF2J3Umn7tl2u
	 TunbyKp0eyDtbZsYM/Bmd7b19uiu9Hyxbz4hBUOAoej5hKDr95ShEa3LoVw3r0jm159XY
	 tSs6FiOYS7vIETffCyKQoQCvXwTagL34ZEbgD6c3wpYO1aisd/rv0ME1w7fwagDiooQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793125594;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=s9YeB09R4avFo/fWYxRNiTD+V8/cTtlBH/xhnd6kpy4=;
	b=NON1LQPNYhWscRFe4ZqIqrgVlmW1LxkMNKUAG2mekAVzuCowfyOvsGFPYdU1ZAnSJxed
	 sMkepJhZnhXdafK1q/owjd8G0eTXSB9tTsCiEeX0IzAcGTctZqLnlgM7l46pLIA6NtqoR
	 QaiH2BvA+UyyJcaO7dqPoiw0i4wMb0V7kQ0ENSjKFbQvi8RRCcMsjYT+zx+nZvduN/m13
	 Fpa9raYbW9TxrbzD6qPvGkvQN1gR/CaKw99v+uACPFc2+SbF8xvDiGyEZmsRwpiDRvOzq
	 dyz+TDOpxoLm8xJmx5GZiDnc7IuqCr63ZeUztk/tPXlvrX7+RWyAmetRQhcXAj7oOzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xIwD2VrJ;
	arc=none smtp.remote-ip=209.85.161.52
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC81606A31A
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 18:26:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5BC81606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xIwD2VrJ
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-6de1fd5f572so133174eaf.3
        for <git@vger.kernel.org>; Tue, 27 Oct 2026 11:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793125593; x=1793730393; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=s9YeB09R4avFo/fWYxRNiTD+V8/cTtlBH/xhnd6kpy4=;
        b=xIwD2VrJ+ILDK+x+dtTHUryZmSNAiECYXvc1PO1JScpEIiFGrtKFE1/FR/z2j028CT
         /k9phZEYuBCg4QWqDnaCC8EHwCGdmaNZdHw/h8FGIHZPgNN96A8u1IN2DUdxToxOqPBZ
         dQwsW8Tcwgzt6LC+TwW9eiGkC4JwNtRCQ7US3PslUkTt6IVL+ee4NECFNJ7p8OSB4xvR
         0/Eqwr1s+6IFwzTjzsw8TW4+fxh/ZBWUibNYeFDO4HiNEsQ/24neP81mtcDH3zjQ/6jW
         m4qpqjK/4ZpF0/9zStMiOLufu/nG+8mbkN9NFyaNtOBJupK2rg9284DTcf67bXA34SvV
         p+ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793125593; x=1793730393;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=s9YeB09R4avFo/fWYxRNiTD+V8/cTtlBH/xhnd6kpy4=;
        b=MR15hFJFB5V/JD5HM0qvO09+LvdlMdGlb/A8uvygfuSDiF6kgHthpnFUr9GSruwNt8
         k7fWfYjdMEaERxxHUWT6rum2ldch6i7uCfKpPTc2r1DGxgxdhdUeeHQQXvECQFyOUuNA
         YdIBY+bGGpId+cvD0qVf43mOpkysjzYvaKcOrs4uL7fAiEd/cu1xeLibE+Mt91AK4GFd
         UgbsLajBd5wrlvwKhaCab/OozjpFiyE1DBbdAPKFpbrhVudlu5SU+PLh3ZSt2otywVF2
         wPpLg7hzP5HIGzYQjjg/yBl+9OPz0oMGLWQ8JEqqeGMjJ9l91sPRd5wCodsuLAAxWA0y
         IOkg==
X-Gm-Message-State: AFq9FYLpFJ+gQa81v1E9LRLE9LnvTSKOgjYY/Y4Ntvcbrs1jF1d8XUqu
	TNA27qRVEnuWASEhaocmIlk7QIHQNumVabTSqvuRwFtIkR+ZLkMXCykD
X-Gm-Gg: AYBFou1i2X7zzlcxPPeWt5OFdC/kcd7Im5JVA8JVqpFJNt9gaMlBBXzi4dFO5L6NXJu
	i/cf/3jyjwxvVXID2trdcGDEOx4CymbnrXBN71jj2xNn8fGT7kmgUM2nv62D9c+Vi1JhwZkyF0O
	uhcMtjFAkh153/kA+5UgXcN9TZFWxx30HH+47upVOSEJnq84mtw/w0psHU/n69bp4uA1L1ryAIA
	dJzeHDMzKdKGI6ep13L5+E+yAVprSITFmjLOdz5vU1HiCvjVTdWfoqA503nn6lsgiXBrZUMjN2l
	DHGGdy/iwNS/2CKXBjEDgmmze0obXYLjYNUf1yQWm8BHF4PasHqZcmmlW9gqD7JE2YrPIsRnrIr
	Txo1+vrj7ZGBiQic8HFlIVpjmKeVjFUJXdYrALzIRx0dZkG9kLPU9bH6/V/OYdJRUO+pUHoglz3
	/i+f26aY4S2urREjkyVANA4vUJJA3eVTc9yEfplUgNInPT4O4RYVLA8gGZy78y0VFcK2VI3WuQi
	qLgUDCtx1pmy+9YaPvbFnECqewfgDWBtWHfTYWgNBC71pbuo5xRRKLBYmcyqgBM/PELVTfP6qxK
	lhi5wFWBNJJY6nmOsk6AucnbVw==
X-Received: by 2002:a05:6820:1347:b0:70c:302c:4212 with SMTP id 006d021491bc7-70c302c4cb0mr4567114eaf.55.1793125593197;
        Tue, 27 Oct 2026 11:26:33 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-850fc005bd7sm11998580a34.24.2026.10.27.11.26.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 11:26:32 -0700 (PDT)
Date: Tue, 27 Oct 2026 13:26:27 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, ps@pks.im
Subject: Re: [PATCH v4 3/4] object-file: explicitly write ".keep" lockfile
Message-ID: <auDsoWt5XVXw2hPN@denethor>
References: <20261020132900.1208343-1-jltobler@gmail.com>
 <20261021182528.3055494-1-jltobler@gmail.com>
 <20261021182528.3055494-4-jltobler@gmail.com>
 <CAOLa=ZSdT2W19-Vg682iv6zhq6sEFM0+rHS-NqL=XQu--JOknw@mail.gmail.com>
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
In-Reply-To: <CAOLa=ZSdT2W19-Vg682iv6zhq6sEFM0+rHS-NqL=XQu--JOknw@mail.gmail.com>

On 26/10/26 09:08AM, Karthik Nayak wrote:
> Justin Tobler <jltobler@gmail.com> writes:
> > +	if (write_in_full(fd, contents.buf, contents.len) < 0) {
> > +		ret = error_errno(_("unable to write '%s'"), lock_path.buf);
> > +		close(fd);
> > +		unlink(lock_path.buf);
> 
> Should we use `unlink_or_warn()` here?

Ya, adding a warning here would probably be useful. I'll go ahead and do
so in the next version.

Thanks,
-Justin
