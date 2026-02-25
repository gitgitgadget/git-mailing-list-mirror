Received: from mail.delayed.space (delayed.space [195.231.85.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5CFF381AF
	for <git@vger.kernel.org>; Wed, 25 Feb 2026 00:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.231.85.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771978776; cv=none; b=NL1NR/68hgoYLRRPqpLP+XiwyVfsZ0CTui7m8S5aWDq0mQRQd3Lj3FKJ27XQf+DQMnqY9TWYKOyMda5Ul8w6578puAymCF3jguWHV02FRzA55QRcbGzajbKGOvTPu9FG1ss85tYrIoLU/PgYQDS9HZR1n7rJNEUPl6M8smeN5Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771978776; c=relaxed/simple;
	bh=FhnCavsnJwxZ8sMn968/zvSexdntcuTL6fvXmB9R5LE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GRGkjHcyPdhedEVIXfbQvfb/IxTpQQ6k8bmxIrpVnlWHNC1jbYecLkcEKJq5+rQV6jYr+f0WvLAk9+mxxTfC031fSWlx3su7/dD+JI7vBKiB3cZXQr3P9qeMB2K8bJC4jYsL/B70OOjgjFk4Da57J7WDGb5u0uAseknc65IgV0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space; spf=pass smtp.mailfrom=delayed.space; dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b=Y0/zwVPx; arc=none smtp.client-ip=195.231.85.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delayed.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b="Y0/zwVPx"
Date: Wed, 25 Feb 2026 01:19:31 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=delayed.space;
	s=dkim; t=1771978773;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FhnCavsnJwxZ8sMn968/zvSexdntcuTL6fvXmB9R5LE=;
	b=Y0/zwVPxZvIavPH34iRf9eOLy3q+FfVhxlCd6PAvlMEIdNW1jrFZJxTkXFNRl5pxjyJQSN
	yKx4K59b59iahtQE7iM4d4YkmO9iHxT9+tkyjaSGepo2KkK43iz3WKCf+f56SgrI/QC796
	X4DnlrQIkrsBE7UXrA00cDQGr0HiVImpqOI3ZLow1p9DSPcfw2W46fzdFRAu36WRCwAGyq
	qlmHBlU43Gn6Y+RtRL8PNiJ6vchq5bhA8E71sk3ngmSaUa4UtT4XYCuzsxH7vApVENeIlJ
	IAbY7dlWCSFBdjP6/v6YUVe+EXrXfwzSHFH7Fb5rF2vTwBFcAVb8eKBQcxeaLg==
Authentication-Results: mail.delayed.space;
	auth=pass smtp.mailfrom=mroik@delayed.space
From: Mirko Faina <mroik@delayed.space>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>, 
	Mirko Faina <mroik@delayed.space>
Subject: Re: [PATCH v2 0/2] format-patch: add cover-letter-format option
Message-ID: <aZ4-_jmFS8yS4g49@exploit>
X-Developer-Signature: v=1; a=openpgp-sha256; l=575; i=mroik@delayed.space;
 h=from:subject:message-id; bh=FhnCavsnJwxZ8sMn968/zvSexdntcuTL6fvXmB9R5LE=;
 b=owEBbQKS/ZANAwAKAUh5fqGcGb7RAcsmYgBpnkAGLH/7LWtsmtjwUJ4yuwjq+4kKHKz2Eyf6W
 8RceBv5IqqJAjMEAAEKAB0WIQT/Ky37K0pSwmwsybZIeX6hnBm+0QUCaZ5ABgAKCRBIeX6hnBm+
 0YbxD/9ovW4zH6+xFQq8/ZyQhttH2x4T/e1D/raeHHI6/DBk1eeiNpBb60dZqrV59+pehryleCX
 WgTJUF3taFiW6xzyX36DHcDZ+SAH3Xzn5rR2s/hBcqqQixL5oT5lmLqrMKTlhOspk3tUNzt3YoF
 yVIGkaCTMVqdOCnfm03eRrj/yiGWXpDuuWlp7lc9P6cJBOmnLjm4D29y0ojPH8Cgid4HggwmXMF
 rr25uEvROZzhcr6OcfkfYd5SY6bGGybUDH8qzZF92xF4gPnXVj0aVliK3T5kLDM48UgfD76jh6B
 uf7U2GWMQq+gFLEQIJUaNYrhuHTk2PeERLivAFiTGDZDsQ1k8m6ike8dKsR1m5EtGDRUqcUkCmy
 bcYgvTpqYR+llDreFkHUBFagxYDRSR8/TVL3jbE/JwrN8XIyJ/STC+J8hQf/Zw7jpm6HsoVsCEr
 IVnZr7OmxDGqn+gAGGdwXca8mL6NlOmQdocqc3BvmTTZMUEf0WNKDgk8ZM42O/h5RBrHhGBNY6N
 31D1BUiaUEoPLPLRYKuVqlSfuWOU05qYL5vxJxeBzz1Y2PwM5vNI8lqyycsRX/KV9wc/2ZJGC3f
 NAOrRQG0SwkuxgC53fehQixVErBkAGIvz0NrpDO6ut9bxOJwZyWs/Du0cSA+zfE4gGvLgnS6jAY
 TUDn2JsfENX7jlQ==
X-Developer-Key: i=mroik@delayed.space; a=openpgp;
 fpr=FF2B2DFB2B4A52C26C2CC9B648797EA19C19BED1
References: <20260224040400.751247-1-mroik@delayed.space>
 <cover.1771925291.git.mroik@delayed.space>
 <xmqqjyw1g9m5.fsf@gitster.g>
 <xmqq1pi9g6sb.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq1pi9g6sb.fsf@gitster.g>
X-Spamd-Bar: --

On Tue, Feb 24, 2026 at 01:39:48PM -0800, Junio C Hamano wrote:
> I found another change that is needed to make the tests pass, so the
> commit object name for the squash fixup is no longer a85e8e535d;
> fetching my 'seen' from any of the mirrors should let you find these
> commits near the tip of 'seen'.

Didn't notice the test failing, I only ran *format-patch* tests.
Thinking about it more carefully there are other related tests that
could fail due to the nature of format-patch being used in preparation
for other commands.

Will run all tests next time.
