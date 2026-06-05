Received: from grace.univie.ac.at (grace.univie.ac.at [131.130.3.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35FBA1A6810
	for <git@vger.kernel.org>; Fri,  5 Jun 2026 11:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=131.130.3.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780660245; cv=none; b=rSRXV2y1V6drGPIi8XOpUkf5z5vnyJMSpUCFbaEQQfTDvtoGaGEQ+Y/Uoo472UqbHJD6Fu63/XA6tJHg5Tm1H6G/6xk6Vmr45p2bkZn1+CeowZiW4ZVypVbDp5sWxy3K0D6pGn3Dtb2tM+4u/gywkpmjI/n5NrTPz+9/7F5LB2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780660245; c=relaxed/simple;
	bh=qDqvdA6CyE2HhZhvkDmPPPfe3EuzEvYo/W2pxp6TFhU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kUXOf52UgdEU5QlaXHzwtJRnStg0bH3lrIUDRjiKr+DbY40c052RnkOtmJlVRwPtDnUE26Z7+eNn2gBSDZT90BOZ6KytEMmRoZiy/ycYxIwHZPRWSw1XC3fsAdQlVgy8s/wXS+QBmg7/11Xmk9hypMmeTuHIjdehNOYAPOfyupk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=univie.ac.at; spf=pass smtp.mailfrom=univie.ac.at; dkim=pass (2048-bit key) header.d=univie.ac.at header.i=@univie.ac.at header.b=IWO2zhZZ; arc=none smtp.client-ip=131.130.3.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=univie.ac.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=univie.ac.at
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=univie.ac.at header.i=@univie.ac.at header.b="IWO2zhZZ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=univie.ac.at; s=rev4; h=In-Reply-To:Content-Type:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=vajcZuj59F3mYjSpVPH9tigZum7CBKol8pkH3hcmDCM=; b=IWO2zhZZkI/vI/1HIAL37OTmjB
	uxhYuxaxqkvTwcmiuriZTF2ZZ37J1D5aaTGzm1IG1nevL0bwpUIj3IRCKW+cICpUYoL8Hx8aw67aY
	BGSFlFEgCFE2XhOR+Twq8aM0gc9pouc2X0l0hnRP/q0Tv51YWesczZZuXIfZgd9AuhhhT/1IewLfj
	I7svDSFOUN1ILjt/+cmUfXu1XTgLiyTwH15WdX1vw0Lr4+7tHy845vIsbiV6+fvVGImMXwhgDzZD3
	7apicyr8WvyLQWTUQ8suUt3DUCKJNwOMvzLDJgxa/Z2bUU6ZYdAKf7Xf4D7jqOELOtp/1wWtWHmtr
	gJ1xzSBQ==;
Received: from justin.univie.ac.at ([131.130.3.111] helo=justin.univie.ac.at)
	by grace.univie.ac.at with esmtps (TLS1.3:TLS_AES_256_GCM_SHA384:256:X25519MLKEM768)
	(Exim 4.99.4)
	(envelope-from <dominik.loidolt@univie.ac.at>)
	id 1wVT4S-00000007bOf-0FYE;
	Fri, 05 Jun 2026 13:50:40 +0200
Received: from 84-115-215-81.cable.dynamic.surfer.at ([84.115.215.81] helo=four.local)
	by justin.univie.ac.at with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256:X25519MLKEM768)
	(Exim 4.99.4)
	(envelope-from <dominik.loidolt@univie.ac.at>)
	id 1wVT4R-00000004kIe-3Wfl;
	Fri, 05 Jun 2026 13:50:40 +0200
Date: Fri, 5 Jun 2026 13:50:29 +0200
From: Dominik Loidolt <dominik.loidolt@univie.ac.at>
To: Patrick Steinhardt <ps@pks.im>
Cc: gitster@pobox.com, git@vger.kernel.org, asedeno@mit.edu,
	asedeno@google.com, avarab@gmail.com
Subject: Re: [PATCH v2] compat/posix.h: enable UNUSED warning messages for
 Clang
Message-ID: <aiK4BR86cuq5bmCe@four.local>
References: <20260503151210.36036-1-dominik.loidolt@univie.ac.at>
 <20260605094647.94805-1-dominik.loidolt@univie.ac.at>
 <aiKnqlI7WdcskDAs@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aiKnqlI7WdcskDAs@pks.im>
X-Univie-Virus-Scan: scanned by ClamAV on justin.univie.ac.at

Thanks for the review!

I noticed that the version-check style now differs between GCC and the newly
introduced Clang checks, would it make sense to make them consistent? Like:

diff --git a/compat/posix.h b/compat/posix.h
index faaae1b655..e20f8ec61e 100644
--- a/compat/posix.h
+++ b/compat/posix.h
@@ -17,7 +17,8 @@
 */
 #if defined(__GNUC__) && defined(__GNUC_MINOR__)
 # define GIT_GNUC_PREREQ(maj, min) \
-	((__GNUC__ << 16) + __GNUC_MINOR__ >= ((maj) << 16) + (min))
+	((__GNUC__ > (maj)) || \
+	(__GNUC__ == (maj) && (__GNUC_MINOR__ >= (min))))
 #else
  #define GIT_GNUC_PREREQ(maj, min) 0
 #endif

I think the current GCC bit-shift check is harder to read.
If you agree, I could send a 2-patch v3 series, which would also clean up the
comment style nit.

 Dominik

