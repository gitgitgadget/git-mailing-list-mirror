Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D5633537C8
	for <git@vger.kernel.org>; Thu, 12 Mar 2026 14:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773324532; cv=none; b=DdnGo5C91pvm+HDrhTmiGosdisiK0l6IzBTJGVP5TMECQ+CcbND1Xrwk7qK4CpuQki9nY3JxlVKWG5rUiZOhjOKDi3xkvK6NotvtkxxYZFyhtg34FVvVK7BlLrS3RSIJ1fTnWoaBn06IaxJpH+6QtTeTYTRKtM+9xM7pTS+UMpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773324532; c=relaxed/simple;
	bh=wkKnxyIIfI8jid2Aj7csD0kmpvJv6k0Uzj0r6OOHxgw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DR8MmvAiOgpRVNlcpVFxm8o3MWedDgYLDHvOgcOZhmIUXhxALM/AmuEfz7fo6burLFF4gf2bEPVJ0luS5AizaUIWQuG1LPcA7tt2PKjY2ywl/zjlgNWcXRkDQ6x3gchP9qZ1Xa8oaPiU5kD/pX/WCHsLzKVc6YI4IUHY8YimGUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NSiSgJ1h; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NSiSgJ1h"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7d7439f8837so1116707a34.1
        for <git@vger.kernel.org>; Thu, 12 Mar 2026 07:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773324530; x=1773929330; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MRwBDcRhhDG+BWBokk8cxSHg6L/qM5jCz/8le1X7xiE=;
        b=NSiSgJ1hCVcykBa2lND4kahNSuKonu52Qr749madlrLRqqtyqCdXqq4JFA5dbluAWX
         xVXU1eCyJmk9/SnFmGM5FdFXEYuEcCtp/6mGXikCl40HjpcHD7aSmt+VxfkRzuIvrVKC
         29NjbCdsgacmWPh0CB8T1YUyIph4j1eF1hM6qUkCA2rTL2FpkfthXkB7Ne/aEVZwAFIp
         683nDj9uKSTbC7EXYIFBNf4kjmPO7Z/Scg3O9V0BUwfW/5aimUk74IL4q8Ur0Mu+BHQ6
         MMzp+WtlqDb+bXBo4tsWvKgPWYmez6HpgcG2qE01SipRBq2MIeUJWnDmtv3ylRGkuKfB
         80pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773324530; x=1773929330;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MRwBDcRhhDG+BWBokk8cxSHg6L/qM5jCz/8le1X7xiE=;
        b=lgBSB9cgk9ZTDxinGrvp1HqnY5IWGMDyVzmNTKZNjP88y029leXi6RFjjF4poOEIJy
         AT6vHp4b2U/gTcONcYd1DaJv94y00rQZ564w2RkSB5PLbdT0dNc2U/Od7lKLs7zDrhmr
         hjPkwaINuPcHa12iOXVHTV2PDVL1rxhGR/bRzPgR2uBfX8jD8t6P9n7m5bQxrSRkrCiA
         NT/KWv4zJY1VrBvETt3SnNiN/yFkG9vuPtUpX1RW6Jb/LrwnXq12AUN8QCBpvFGwwXsN
         NUMBZHImo3oEg6GuJeHaC4w74ZAc3++gtUxL88ePKyKLoaKyOtUTf7Cw4f7Rz4Imh3To
         uxiQ==
X-Gm-Message-State: AOJu0YzGy3QPleD7fTfnf8kYqIIrU8x8WrhJiJo3oyHLjrA8UMAbH2OO
	9WNAx+guirEn/PSE7hb4e1KyW/OQMcGdTf6gWpnzv3fWfQ0YH3vOdrpb
X-Gm-Gg: ATEYQzw6M+hwy/zFJ8ceKp7/cgTSIOkaZddr3O4OKiyoQv36HkjIaJJyaErHihAUGM8
	JBp+g1Wx4Z1o9qZa4ZpprZlEu4HstWmj2pgLXlkqBeDnPK5geX7Qwy1l2UJ1pYSXEyekW5hjWld
	BXHluXArHCacWLt6P+sD3eZKTwAOfoKLO4qgw8hkVoBuQx2pVCs1eMa2CFPsfp8sQ1/UV1lV+Ls
	p+EM5KPPhRXPC57WkhTidHD+7xHEsxvFHGU+rfIt8K1XCk793IA/V5prx9jQDbav4zvQYoXElWj
	jN4hCIP2c5zJI7rXg+q8ojaTKl/V4wuaNunKGDtq419qQ9m9W0fTddgBdn2vg8Q/4C69ESaIJPN
	ihvKgMBoFM0MQ9a7+nDa9xReH9OrpZbOrZ/oiEK0E2GuKoar//gG1ssrCfDFK7q3NjFHtDNwRfM
	siNmqQu9yDesNdCaVB
X-Received: by 2002:a9d:7a96:0:b0:7d7:79e8:39ba with SMTP id 46e09a7af769-7d779e851b0mr1116331a34.14.1773324530024;
        Thu, 12 Mar 2026 07:08:50 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d77a763ba8sm1351517a34.2.2026.03.12.07.08.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 07:08:49 -0700 (PDT)
Date: Thu, 12 Mar 2026 09:08:46 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, sandals@crustytoothpaste.net, 
	christian.couder@gmail.com, gitster@pobox.com
Subject: Re: [PATCH v4 3/3] fast-import: add mode to sign commits with
 invalid signatures
Message-ID: <abLGgq-PXzdWs6kD@denethor>
References: <20260310201116.1130160-1-jltobler@gmail.com>
 <20260311173147.2336432-1-jltobler@gmail.com>
 <20260311173147.2336432-4-jltobler@gmail.com>
 <abKUBRRgRmbJ1hRA@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abKUBRRgRmbJ1hRA@pks.im>

On 26/03/12 11:23AM, Patrick Steinhardt wrote:
> On Wed, Mar 11, 2026 at 12:31:47PM -0500, Justin Tobler wrote:
> > diff --git a/builtin/fast-import.c b/builtin/fast-import.c
> > index b8a7757cfd..d6281ff119 100644
> > --- a/builtin/fast-import.c
> > +++ b/builtin/fast-import.c
> > @@ -2865,6 +2855,66 @@ static void handle_strip_if_invalid(struct strbuf *new_data,
> >  		else
> >  			warning(_("stripping invalid signature for commit\n"
> >  				  "  allegedly by %s"), signer);
> > +		break;
> > +	case SIGN_SIGN_IF_INVALID:
> > +		if (subject_len > 100)
> > +			warning(_("signing commit with invalid signature for '%.100s...'\n"
> > +				  "  allegedly by %s"), subject, signer);
> > +		else if (subject_len > 0)
> > +			warning(_("signing commit with invalid signature for '%.*s'\n"
> > +				  "  allegedly by %s"), subject_len, subject, signer);
> > +		else
> > +			warning(_("signing commit with invalid signature\n"
> > +				  "  allegedly by %s"), signer);
> > +		break;
> > +	default:
> > +		BUG("unsupported signing mode");
> > +	}
> > +}
> 
> I'm still not convinced that it makes sense to warn about this case.
> After all the user has asked us to re-sign such commits, so they
> probably expect such cases. These warnings would thus result in a ton of
> noise in a repository where most commits are signed, drowning out the
> potentially-useful warnings.
> 
> Anyway, I won't insist on a change here.

I'm not really against removing these warning as I also agree it creates
a bunch of noise. If we get rid of them for "sign-if-invalid" though,
shouldn't we also get rid of them for "strip-if-invalid"? If the user
asks to strip commits, I figure they would expect such cases as well. If
we think removing the warning altogether is sensible, I can add another
prepatory commit that simply removes the warning for the
"strip-if-invalid" case.

> > +static void handle_signature_if_invalid(struct strbuf *new_data,
> > +					struct signature_data *sig_sha1,
> > +					struct signature_data *sig_sha256,
> > +					struct strbuf *msg,
> > +					enum sign_mode mode)
> > +{
> > +	struct strbuf tmp_buf = STRBUF_INIT;
> > +	struct signature_check signature_check = { 0 };
> > +	int ret;
> > +
> > +	/* Check signature in a temporary commit buffer */
> > +	strbuf_addbuf(&tmp_buf, new_data);
> > +	finalize_commit_buffer(&tmp_buf, sig_sha1, sig_sha256, msg);
> > +	ret = verify_commit_buffer(tmp_buf.buf, tmp_buf.len, &signature_check);
> > +
> > +	if (ret) {
> > +		warn_invalid_signature(&signature_check, msg->buf, mode);
> > +
> > +		if (mode == SIGN_SIGN_IF_INVALID) {
> > +			struct strbuf signature = STRBUF_INIT;
> > +			struct strbuf payload = STRBUF_INIT;
> > +
> > +			/*
> > +			 * NEEDSWORK: To properly support interoperability mode
> > +			 * when signing commit signatures, the commit buffer
> > +			 * must be provided in both the repository and
> > +			 * compatibility object formats. As currently
> > +			 * implemented, only the repository object format is
> > +			 * considered meaning compatibility signatures cannot be
> > +			 * generated. Thus, attempting to sign commit signatures
> > +			 * in interoperability mode is currently unsupported.
> > +			 */
> > +			if (the_repository->compat_hash_algo)
> > +				die(_("signing signatures in interoperability mode is unsupported"));
> 
> "signing signatures"? You probably meant "signing commits"?

Ah yes! Will fix in the next version. Thanks for reading closely :)

-Justin
