Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E699E749C
	for <git@vger.kernel.org>; Wed, 25 Mar 2026 07:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774422967; cv=none; b=uNpW2Yw+uOGP/qqj+d13EA3VvFz8+mfj+9fN/JXDuT4jrUQN0stIq+Th7KFBag5qWknvXMcSEgum0rUTM8EGTrxkJ/f1Ay/zqLYzpVS1/Up9emfw2zRP0pH4LiwOndsGwPJ/2iXwG7I63Qt8OmnITZH1mDoYpMmEEUry4DdOD4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774422967; c=relaxed/simple;
	bh=riDHZoQ9uWX03WyWOzfODZCIYho7bgfotvFLLcCzim4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f6KYTv7aPCGjv/6YAlzLhrF+TwsuCgsxpQuGlOUP451abOg7sw/fj79cq21Mcv00p+q2knRWZW7gioZhaOoPQ7SrP3jXCleYQGTNTZHdwAQilPPejZS1ypo1JXrN74IaHv1GFNZJwP81T6X3/5sOJfTR57gbkNkzPjZeFavsi6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=j3oum/6C; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xSssmVxM; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="j3oum/6C";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xSssmVxM"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 434971400288;
	Wed, 25 Mar 2026 03:16:05 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Wed, 25 Mar 2026 03:16:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1774422965; x=1774509365; bh=NBh6xn3LTM
	Ei2Oz8Pa8b2El+SnPzY5XYVx9GkgpKj9Q=; b=j3oum/6C+jTceyVrqEhWgdBqyd
	nBwsW7drvwXSGH/KlDsVfpmB630EtklUU5tMlKqRbYa4kaOrVvYBPqv2Nw3IAYLQ
	OqTSPI3SRk0ZeVUmMWwIG61X8/1gngFJ8E2MNcPo/pwbcNQofFXBh0EtEzqnLjsf
	DEVtT5mTHfTuNS8K0Be7KloadO3SMp98qEYwDu0c8YR6GWlrF7WSl9i9I6law9Y/
	QThVE7xaJ9LuuUOsDrXWEIMGtoiFPMVYuY1ckx/XEw/zN0JoOvgXwf61jBMDKlXK
	hdg0SG826+eq85v9e80L9zNI7z0xpXWcDaNobKbC0os1V5evtDbzVUPam/Pw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774422965; x=1774509365; bh=NBh6xn3LTMEi2Oz8Pa8b2El+SnPzY5XYVx9
	GkgpKj9Q=; b=xSssmVxMeeL4lvdADRGaiabwMaC74YltXR2NiwrT2tbS6YQIh6i
	x156gO/NxopbzYzOY38xULwGS4zzw87ByYzKkVP3IZZAGIWOX/CW4IPA6xf4hN1Y
	zz9zKM1z7aktkxaoVo0RlC2H0Z2JlDsHQC9Cdmbvu9rDvZep6dUzvoZB6mOhPSVN
	7IwtiBat39fcvyfli8ph8nPfdN+R1rq6/WVJmz+u5LVR5WV4UIzlLiDkHTvbcMib
	4YEwwfsKSmY6yBR6ALGoeNOMo43Gwm39rOvZA6rhHQjyrl3kQ4uXgbXtHHcVxPXA
	+r0232QSxEvhY4tIUuIscjq+Q4J89lga4EQ==
X-ME-Sender: <xms:tYvDad29qURDEmP3nbR4n4zb_d2F2-BKF7WcGzwbY0u4hbZ1gUlCug>
    <xme:tYvDaaEEKkNQqCIqrVnDfXnrIYtkDrR2av7GqX0OYHq5fZgDtmOon80xeEuiiD80g
    V3QFSVQn050k4iZI4AvvJ6NTQLE7Ig08OlQ1BskWeO5PIirsFopWQ>
X-ME-Received: <xmr:tYvDabiUwW-7LL2KAFqiA7NJ_JH6Rfgg75eyTF4BjhCMqwNSBd_npH6bF20wuhiY2KD8otQfq2NCfYRFHA7bOmsNJ5b4aiYarqUWsdgaYUY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvdefkeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvud
    ehgfeugedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:tYvDaV_rg1J1LeDPMiSGINIrNM1tqkpOI8mSXcfJs-aEzc-DL8uqyw>
    <xmx:tYvDaSoP_e6sTfLRwizIGfBJ3rEiMriHZlG9iMJjP2Ag2XXsqVqZkA>
    <xmx:tYvDaU8cryFw3x-QVbn6awf4A6B14NRbdWRekLGOokkwgIRwLrqwyw>
    <xmx:tYvDaWW6ZiGYbFzF89VK8cQAp3UY1ZdZ112soQvKvYph0N0XujWI7Q>
    <xmx:tYvDaZP-S6p7r4UMp9XYc550zh3LgpB9soGr1ofYt4eydNTXlBMdo3ce>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Mar 2026 03:16:04 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 207533f8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 25 Mar 2026 07:16:04 +0000 (UTC)
Date: Wed, 25 Mar 2026 08:16:01 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 08/11] t9200: make test "set -e" clean
Message-ID: <acOLsfavUHJZA1tW@pks.im>
References: <20260325062114.2067946-1-gitster@pobox.com>
 <20260325062114.2067946-9-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260325062114.2067946-9-gitster@pobox.com>

On Tue, Mar 24, 2026 at 11:21:11PM -0700, Junio C Hamano wrote:
> diff --git a/t/t9200-git-cvsexportcommit.sh b/t/t9200-git-cvsexportcommit.sh
> index 14cbe96527..65ef1d7c82 100755
> --- a/t/t9200-git-cvsexportcommit.sh
> +++ b/t/t9200-git-cvsexportcommit.sh
> @@ -11,8 +11,8 @@ if ! test_have_prereq PERL; then
>  	test_done
>  fi
>  
> -cvs >/dev/null 2>&1
> -if test $? -ne 1
> +status=0; cvs >/dev/null 2>&1 || status=$?
> +if test $status -ne 1
>  then
>      skip_all='skipping git cvsexportcommit tests, cvs not found'
>      test_done

Similarly, here I've got:

diff --git a/t/t9200-git-cvsexportcommit.sh b/t/t9200-git-cvsexportcommit.sh
index 14cbe96527..581cf3d28f 100755
--- a/t/t9200-git-cvsexportcommit.sh
+++ b/t/t9200-git-cvsexportcommit.sh
@@ -11,8 +11,7 @@ if ! test_have_prereq PERL; then
        test_done
 fi

-cvs >/dev/null 2>&1
-if test $? -ne 1
+if ! cvs version >/dev/null 2>&1
 then
     skip_all='skipping git cvsexportcommit tests, cvs not found'
     test_done

Patrick
