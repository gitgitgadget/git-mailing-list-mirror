Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793721366;
	b=pMtZ/mfrXTbycEaWSa3he9vsKhsVE3RSlJuiWu+BIq95FbdF4W6z0Y/34zUh9YB86RPZ
	 ZIMPqpPvRyA3yLHaUGcC9izJsSUJZObpEUoa0GyGtrvmzb94bqqZsIom3Y/CSOgy9D4+A
	 6kLjYj71GqDxFjKsWJq3BBQ4aTg/oM4MLpI6EV7ojrY/HMs+rCDc2thHyN5aWyMiTAGQC
	 f3JiNvTmbdh+N4ovTlMR1t457Cu+nD8PUo4mzOcVqpDgBgTnFBkDj+/9Ajd/qsddUcAoT
	 y43Z+9Y19SpsfhmDMn1bwYH+tAFEcDLKjqlhDGwDsRHMnULVO70Ixl9T3kUR3PIx9Dw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793721366;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=kedwJpFlJPXeQbBllxWbVJqREFypaXURx/Rxi0ZPICM=;
	b=hwJjyarHWScHN8o2GTUgqGMuskwpx9s3579I49AxJkXVGYDwcQk+MpM4J+60rbYWPHfi
	 33/MQRh1JrtbxVZDuhfWQHT5I7QeSQpZ3dlbFZFYIW7vblFgGjLyW4+W8d3HVCDm/GZ2L
	 l+rajur/7D3ZJFlzpVHU0FKaJSLz65qYzc7VorZiVqRpqRRrTlk09frEg2y57dyiiWWgE
	 91YIyZUUIDBejNYRmIFvfUIFIVoaKLXNmunRVnGpIjdWqG11TJ+JkRhlt4Xcv7ybUldcN
	 fufczTK8y1cx28jYG5OYfPItGUflxom6fQlA7UcsD9VKZvQXnQ2s1uI4d8S/btoBU4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pDByy8hB;
	arc=none smtp.remote-ip=209.85.210.175
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42562606A324
	for <git@vger.kernel.org>; Tue,  3 Nov 2026 15:56:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 42562606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pDByy8hB
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-89f639ba307so1600140b3a.3
        for <git@vger.kernel.org>; Tue, 03 Nov 2026 07:56:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793721366; x=1794326166; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kedwJpFlJPXeQbBllxWbVJqREFypaXURx/Rxi0ZPICM=;
        b=pDByy8hBUpj+q8wb+ez4SgHiyyKmnJfk2in+9WifWIO+uwO88weB5Zf+5zdAUJM485
         Bi5Xk6oHD5mriBQgbqIrxHAsQm+Kdc+173u82BzXAahGt4OoeILTLY/kT1gEBwkF8zY4
         yIv05eKeP1ePEfZZfAeFPNZui6W9yKfgSI6eaYnQ0/3qTRCSUQY4r5F6tb2WFde0VhJs
         k9lcFsVK+zaSGLo1awbKc63e5B8IYHAo02rBSgOTfhiepcS/GjW74FbxO05lqc3ihlPx
         cIYtgueZPDYzlesKrzOdcxM9mNaw1YEY4i6vgLc8tE0k7YXPrr8jtVoFoQF9yd0eMAq5
         JxOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793721366; x=1794326166;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kedwJpFlJPXeQbBllxWbVJqREFypaXURx/Rxi0ZPICM=;
        b=O1nfnPLbhfQICPrlRSMIf1OUpyjKwlr7urWh9WBtVC1TM8Pil2oUlaETk5DnJBIkz+
         kjyh27awHgH00Weag+lTvXK/HOKHsLliADruDRlxa7g8LQLrItcXTkIEWYW7o3d/WUdS
         zSFALH92r7w3zLDgumQndFGansdiRAXi93VvYRP8Kdgr7gIzWTo5Ggk76Wh+AHqZqNjL
         m4d2wVYjBEqjRPVTwp5cwD+Y+Iyha8A65eQ2ToyGV1Eft6m8RHA0KowDw5bgt/Ld9Fq6
         LhiIsa1bVcL3XIk74CvJ2SPz+jUvWf3iSlT9PWtTITYLlqxx3EMiFV9J0qz6IIHv2mwv
         QxFQ==
X-Gm-Message-State: APuU4Z/bUTwFGjsZOApVdtZBVlJtGtqQi/XwJz2fk0x7UU+AR9B9eIur
	YkJafMEGM212x2cRIqs6W+oVFIRTG//YSlxccKC8LnkOQELEVrybwQ/CaofTQDeTyXU=
X-Gm-Gg: AYBFou23b4sioHLmRV7R957UtzjXGu6eP0hzf56e1odp3/nqdiHYNLFtxRVaiwnHNtT
	Xry5hf58a8iAr+tpr6NUPMota+qYWr37SWHa8BsKvWW1+T8eHVBXORPvLyPxThVkdAVk28OGvda
	cLXp8qIu7utf5sARxEaLXdH0IjsVcyHYmKKAOdFpt1/gy5FntDHomvjoui2xCsx1Sq9VSyC0tX1
	oSPkiXEhoor/+9eI3Dyy3VmeMEROjyFC0ORtP+HyTLAHcarQIGLQUtOcRx+0Km1JANlv0os+Cnd
	jwUv7qgW3OTxIetwCbw+AP04F/0EmgXNLzDIxrZoaPcNNUO359IdqVd2N0jpnrRBrbPwCaE7rVl
	JUdoAf0h810CPOYnjqO23F40HOY4Dog7sbmQ3HNBQ19S8V9JtwUaKCghv004d3tH4Qa9VKdY4tA
	OUa9rRS0Q7nvJYc9sodEomF8p48N6nuQIH9nI5xKyyD/LC8jXDHQaoZJXbVnbzAhE6dZq0pjrGk
	e6p++uCyygBwy54U83HWk3Y9dd+cCzjCeMS/S9PMTtPyuIB1GvPidwpLD37g+QKhUbm/m76qhRj
	0Nh5Va+IutzsdAq7sOdgrCh+M0z5sSKqC5BkdAXYAqfmUhwZUIQzKgVnt9gbtTdwgOXPSKHjIwv
	2rNHc9c3Z2y1u61Q=
X-Received: by 2002:a05:6a00:2347:b0:878:34d7:699a with SMTP id d2e1a72fcca58-8a9bf719fd7mr9777529b3a.42.1793721365479;
        Tue, 03 Nov 2026 07:56:05 -0800 (PST)
Received: from LAPTOP-PVRSMPQK.iiitd.edu.in ([103.25.231.125])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8aada3d479dsm3543293b3a.39.2026.11.03.07.56.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 07:56:05 -0800 (PST)
From: Aniket Gupta <aniketgupta3001@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH] bundle-uri: do not die on unresolvable relative URIs
Date: Tue,  3 Nov 2026 15:55:59 +0000
Message-ID: <20261103155600.454-1-aniketgupta3001@gmail.com>
X-Mailer: git-send-email 2.56.0.342.gea0b8383c0.dirty
In-Reply-To: <aunb6OjWKWLyl-mp@pks.im>
References: <aunb6OjWKWLyl-mp@pks.im>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, Nov 03, 2026 at 02:04:49PM +0100, Patrick Steinhardt wrote:
> On Wed, Oct 28, 2026 at 11:58:18AM +0000, Aniket Gupta wrote:
> > relative_url() calls die() when the relative URL has more "../"
> > components than the remote URL can absorb. bundle_list_update() calls
> > it on URIs taken from a bundle list and a single bad entry takes down
> > the whole command.
>
> Which command?

git clone, with a bundle list from the server or from --bundle-uri.
Fetch uses the same code, but I only tried clone.

> > Add relative_url_gently() which returns NULL and records the reason in
> > a strbuf instead of dying. This will keep relative_url() as a wrapper
>
> s/will keep/keeps/. We're in present tense.

Fixed.

> These "bundle lists" are quite abstract here. It would help the reader
> if the commit message briefly mentioned where such a list even comes
> from.

Added.

> Even more importantly though, do we now only print the error and then
> die or do we continue? And if the latter, why is it fine to continue
> even if we have failed to retrieve the bundle? And is it fine to
> continue for both callers of this function?

We continue. The bad entry ends up without a uri and the download code
already skips those. I tried both ways of getting a list with a too-deep
../. The clone prints the errors and still finishes.

> > +                     chopped = chop_last_dir(&remoteurl, is_relative, err);
> > +                     if (chopped < 0) {
> > +                             free(remoteurl);
> > +                             strbuf_release(&sb);
> > +                             return NULL;
> > +                     }
> > +                     colonsep |= chopped;
>
> The error handling does get a bit unwieldy in this function by now. It
> would have been great to maybe add a preparatory commit where we adapt
> it to have a single unified exit path that releases memory. But I won't
> insist on it.

I'd rather keep this one small. There is only one error path for now,
so I left the cleanup out. Happy to send it as a separate patch if you
prefer.

> > -     [bundle "three"]
> > -             uri = <uri>/../bundle.bdl
>
> Why do we have to drop these lines here? Interestingly, we don't seem to
> use this file at all in this test.

The old expect was never compared because the test only checked for the
die(). Now it is compared and the bad bundle is not in it.

> > +     error: cannot strip one component off url '\''.'\''
>
> This error message doesn't really look useful to me. In the current form
> the user wouldn't be able to figure out which URL specifically we failed
> to strip. It's a preexisting issue, true, but do we maybe want to fix it
> while at it?

Good point. It names the url now. I strip any user:password from it
first so that it doesnt leak credentials.
