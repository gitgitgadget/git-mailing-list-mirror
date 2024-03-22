Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE493D9E
	for <git@vger.kernel.org>; Fri, 22 Mar 2024 02:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711073174; cv=none; b=pq/JxHaPvrtEEqaFjwNe6Sagt6p51KtzRyv5w124TO+KFeXhawLjdqF7AB9qPikz0t7AaKE3fghisyKnybpWLJwINGYFl/sZocl0ulkUe1es77WsSyeKD+uzb/fLCTO9+Fa1mQ4hDNuo1vw6GK1xAT75in1M3IdkNXb1c617IQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711073174; c=relaxed/simple;
	bh=i3ZtY5vszH2l+Iza4J8qAJUHSP98+2EuKPrRExY+JH0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=m77X3Vy9RGIedkTjngxBLjVEuyWYc2/EClDRKmgb4EbNkFErhqRaTTFFiocZx0Nv2xDCy4UBi9mazGiPMf09QanWoRZVaZiyIgRktTuFn9AHOuFaRIgQEVTy5Ly6/b5tVp6O7TWaU6tIyc1873Age6ZMaIxWQouWtZtzfGiPoGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=IQ0KXETs; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="IQ0KXETs"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E7B851F3CC7;
	Thu, 21 Mar 2024 22:06:10 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=i3ZtY5vszH2l+Iza4J8qAJUHSP98+2EuKPrREx
	Y+JH0=; b=IQ0KXETsvsML7+0f7JtXmfi8v/XzCRBMm9hfoP9LpSYmQbIgFIyctH
	pny0u0ZlyMztQ4/sy0rbWG+EmRAnAtXwB3gkWK12+kmQehE+1mazEJ/NB1sOjdBp
	NblqK8mHUP1RSdimsDXctSGVHD4tROO/zrlG5kuYuI8iP8UtSvxzw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DFD341F3CC6;
	Thu, 21 Mar 2024 22:06:10 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 426B31F3CC4;
	Thu, 21 Mar 2024 22:06:10 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Brian Lyles" <brianmlyles@gmail.com>
Cc: <git@vger.kernel.org>
Subject: Re: A note from the maintainer
In-Reply-To: <17bef1274bfb2614.70b1dd9aae081c6e.203dcd72f6563036@zivdesk>
	(Brian Lyles's message of "Fri, 22 Mar 2024 01:14:19 +0000")
References: <17bef1274bfb2614.70b1dd9aae081c6e.203dcd72f6563036@zivdesk>
Date: Thu, 21 Mar 2024 19:06:09 -0700
Message-ID: <xmqq7chv58by.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 C080492A-E7F0-11EE-ADC7-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

"Brian Lyles" <brianmlyles@gmail.com> writes:

> Thank you for clarifying. I will let you decide if some updated wording
> is warranted in future notes from the maintainer, or if I simply
> interpreted things in a way that you do not think others would.

Perhaps like this, then?

diff --git a/MaintNotes b/MaintNotes
index 57aa6dd..18d8bcb 100644
--- a/MaintNotes
+++ b/MaintNotes
@@ -34,8 +34,8 @@ and Documentation/CodingGuidelines to familiarize yourself with the
 project convention.
 
 If you sent a patch and you did not hear any response from anybody for
-several days, it could be that your patch was totally uninteresting,
-but it also is possible that it was simply lost in the noise.  Please
+several days, it does not necessarily mean that your patch was totally
+uninteresting; it may mearly mean that it was lost in the noise.  Please
 do not hesitate to send a reminder message in such a case.  Messages
 getting lost in the noise may be a sign that those who can evaluate
 your patch don't have enough mental/time bandwidth to process them
