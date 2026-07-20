Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB7942A80
	for <git@vger.kernel.org>; Mon, 20 Jul 2026 21:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784583345; cv=none; b=AxPlJvaw/eUEVdiY7i+gUZkyFtQJviHVoEg9VWvn2/8KI3eda/KpQOJC0s12/jJP/Tge+H1sFsJzYpPYObgx473QBp7osBLj3iTPkQYxBY33UgMxe7R5m57S2/LtLwRa2tPmmP3KEp51hBLahYOdNqCU4+qaMJ9EQ/iUrDKsbOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784583345; c=relaxed/simple;
	bh=KpmLnvSqCcZYOBO2MZ/0xiSDhu55Kz/8HrQT/A24aI8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YxzNbwrRgHZsuA+G0TvRtm5mvrR6BxSXs71lmJwn7H7nZkZ48YwVKZJtg8n7Yhn0i8qbNtqvyXc96M4QLiCv66Xo1fybFkDhrwsdvRtUDIYN9CkvEl3BHpX/Q90IfNI+06fPXxXnJ+/e7VPd1BnQ8NpxnrPIyQtfYUWt+yTEqbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=oswald.buddenhagen@gmx.de header.b=t2YdOyF2; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=oswald.buddenhagen@gmx.de header.b="t2YdOyF2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1784583339; x=1785188139;
	i=oswald.buddenhagen@gmx.de;
	bh=GZ3QxZi8MmWwihRLPqiSV56KNrRTz1D/1SVOfPDnssE=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=t2YdOyF2TllJgzn+N7tGqt4b6mFlGdddyC8bP+ilelcRbZmz5MXZvr/WmEw+CcN+
	 H+6PXNUK+1iHN4FpIr1nglQaGCAHfXRl7GofAckXKlz7Y7LafgT/dfc2ac/GaxTcZ
	 2LPpQrO2OGNFMbdk+bxendY8+6L2NRHEegS+CsMTsujqexI8DeZisCWMpTGPZ+enO
	 Hudvxj3moA9CCbGne59XJaOXj3Igwhjv2eYnKyPRP1dZ3hLWD/yL3lYE+rcNSBbL6
	 FpJl9xYah/jlIgBXCpxCmMETqBbGO0VbBX09FS5VCvNkDbjuvaQwpO5xYofj/N2Uv
	 9wLGeUrzpSnw2R/Vfw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N95e9-1x6V253LqZ-00rIAF; Mon, 20
 Jul 2026 23:35:38 +0200
Received: by ugly.fritz.box (MasqMail 1.0.0, from userid 1000)
	id 1wlveE-3Em-00; Mon, 20 Jul 2026 23:35:38 +0200
Date: Mon, 20 Jul 2026 23:35:38 +0200
From: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: gerrit code review once more (was: Re: [PATCH v3 0/9] sequencer: do
 not record dropped commits as) rewritten
Message-ID: <al6UqtgUtZb3bqMi@ugly.lan>
References: <cover.1782833268.git.phillip.wood@dunelm.org.uk>
 <cover.1784128921.git.phillip.wood@dunelm.org.uk>
 <xmqqecgyn5gk.fsf@gitster.g>
 <al4RYuWKqAr-IlFC@ugly.lan>
 <xmqqy0f5d25g.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <xmqqy0f5d25g.fsf@gitster.g>
X-Provags-ID: V03:K1:0XY8jJJ2PlCQCugMDpZAaRBVaM4OXxD3O/6S3raCuRkcI5xZtcw
 tdkeNzl52OkltqqowsiPqFj/0cTSGbmG+Q0g6CgLb74qpH2P6yebj6+KG0mbest9RNZ4Dai
 SmY7TkH7vM4mD+ILG5PZQLrvg3AcxgZxN0On95Gep6fsjatlFQnIsvL1b6dY7H8mX2SlpbZ
 iqFCrWYu+77191l1A1dwg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:A3IMPBzsN5o=;ew/+Rj7o5VpW3uJh1em3oGHynuo
 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
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 20, 2026 at 10:03:23AM -0700, Junio C Hamano wrote:
>Actually, reducing the signal to a single bit, 'did I or did I not
>see a +1 from them?', means Gerrit users see less 'spam' but must
>make decisions based on too little signal.  I do not know whether
>that is an advantage.
>
>With your email, we can at least discern that your comment is much
>closer to an 'Acked-by' than a 'Reviewed-by', and we can respect
>that distinction when judging whether there is sufficient consensus
>on the list to move the topic forward.
>
gerrit discerns from -2 to +2 (*), so that angle is covered (**).
https://gerrit-review.googlesource.com/Documentation/config-labels.html#la=
bel_Code-Review

(*) actually however many levels the project chooses to configure,=20
though things aren't as smooth when deviating from the defaults

(**) mostly - https://issues.gerritcodereview.com/issues/40000793
