Received: from mail.delayed.space (delayed.space [195.231.85.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D905D229B38
	for <git@vger.kernel.org>; Fri, 27 Feb 2026 21:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.231.85.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772229123; cv=none; b=H7KDVeearCNG4jDMP6VcdS333IVEF00WgKNJXOQfb36/Bj6fkU8ZUEhbm5J4BdSpgEwWGHeJ4Zh7t4K04o4UIs76ZWxGJNXf+6pG/RWtG45knhdy7Zx4dQLdXDT5UCj0je3q4OZ8wt8ANmTAje7MY84KvDqQpvZ3R115OWYUWQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772229123; c=relaxed/simple;
	bh=bFUGJB1GhfkiJlxnK79ZlXReDW/IkZLneqzuEe1+JhI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=apkSOuy34gNOokkkZ3LYuvdwTn5Jh9CmwMUwsALStV3UqwTMSFH/tyoPWbaOI+aUjIjXGG/WEzRf4XYAOnv1xyJZ0O5tMV5xroBYNNeDsfNXbO9PYuTuP6RmzVKb8Il6XjPBvONTjIs+DHmHBZLC9qfJw7TqIri5ICSU7q1Pr94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space; spf=pass smtp.mailfrom=delayed.space; dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b=UHJQ3gWZ; arc=none smtp.client-ip=195.231.85.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delayed.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b="UHJQ3gWZ"
Date: Fri, 27 Feb 2026 22:51:57 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=delayed.space;
	s=dkim; t=1772229119;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Y04bbK+IjNuG/sISEqDnTGifoZxivwwmSzmtqDDM00U=;
	b=UHJQ3gWZ3Avy6wQe7Vcrc8IX4nfNdsNbzWWhVKe0H0wgw1/2DXKG5MudpyGIXr86hSR9ux
	dxecSxfekkuugpRvsNqL1mz5ZMV2/2+0klKTAd3SSgIXHN6GBYhHjxoAR/sEbbxosUhkZI
	Sqd9vx82ncq3WXQ3T4P2Mol/oObYeZsnXTgJdxYfp9k/zwu1O1EvfBDq+NvwRYTLzxjaMA
	9qzBPhtJEZw/i9KLJDdLCk79qbglbxqIPhgUba4r4XzScra8Xzn2p1VW2c2mT929XdAqvN
	VuHTHfuALqQyvdYwtdr4ENIZt/u506NBHrIVhLOHBZ0PP/xflUdSpeiXcqffAQ==
Authentication-Results: mail.delayed.space;
	auth=pass smtp.mailfrom=mroik@delayed.space
From: Mirko Faina <mroik@delayed.space>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>, 
	Mirko Faina <mroik@delayed.space>
Subject: Re: [PATCH v4 4/4] format-patch: add commitListFormat config
Message-ID: <aaIQcXgOVLHXP_WM@exploit>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2299; i=mroik@delayed.space;
 h=from:subject:message-id; bh=bFUGJB1GhfkiJlxnK79ZlXReDW/IkZLneqzuEe1+JhI=;
 b=owEBbQKS/ZANAwAKAUh5fqGcGb7RAcsmYgBpohHqnNendM7lMkBoZ2Ks/QKXlmXeiiElahr9r
 cHTXUR/422JAjMEAAEKAB0WIQT/Ky37K0pSwmwsybZIeX6hnBm+0QUCaaIR6gAKCRBIeX6hnBm+
 0X4gEAC6lvpyktYnjofeUQsswAw4zXX7O+ggWRCDRf9JxGwDMDXSTVh1krh/nmfXCaHZdtuhGaR
 NBavVniK7kPL7uRhgTIWGKoe7V+800jKHNWC6Tlq6jT+TIUfpAQLoKBAWk+ryyUOnv9uowORwh9
 Nph0iIZdCajkerxqh+wxtI+1XgjAme+EdOEY3hmSgQ/3T7SrJIqnU+KmKhqTyenkB/Xu+EzpbsP
 TZ6ekAmER20u6wWuiHM1IgtOhIXDutiAD/VdB9YhYrfGvgiwI5+jHdaMWeAVe7ZtDHEjw31WbkL
 Ko98UnU/OXEQHccqwBVd/Jmvy7QZILZcM74U9rInbIR0ktwA1DtqhzfULfVzIocgOcq14+1agtS
 jWSVqyUArQm5AqQ9CYUKuZmEguoiERkq9VBsGFn12AmmaKV2LEH6K3xlpMiy4u2A8MKHutlSxui
 MXUc3KjKcr+fA1CrbR0rREw4bfWMkoT8TF6tKIDhXLHGgoDsmgre25SV//RjAahX6NUIlTpHhfD
 oALH5y87YtjmrOAAo+RkltOJJR4R3/VeFULmR+5xVm8Pz3z+lqMCY1K2wQq+BBNgKL3sl7BVelQ
 Z8LEYqdVRNApg0Mf8nWMy5n5QGb0eX0SfoMUu6tyU2sXNa0Ah0V9mBTwAlsT7Xd0ZJLBrQm0dyS
 lxWB3WbqsMVsDAw==
X-Developer-Key: i=mroik@delayed.space; a=openpgp;
 fpr=FF2B2DFB2B4A52C26C2CC9B648797EA19C19BED1
References: <cover.1772156996.git.mroik@delayed.space>
 <cover.1772196510.git.mroik@delayed.space>
 <f9ee8e24001aa16e5df3dc0bbfccd1b381e37d85.1772196510.git.mroik@delayed.space>
 <xmqqecm6rs6s.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqecm6rs6s.fsf@gitster.g>
X-Spamd-Bar: --

On Fri, Feb 27, 2026 at 09:51:07AM -0800, Junio C Hamano wrote:
> Some sort of DWIM (e.g., it is not "shortlog", so it must be "log:"
> as there is nothing else supported) can be beneficial to help make
> it less cumbersome for users to type for command line options, just
> like we did for "git log --pretty=X" where we take a string with '%'
> in it as a cue to default to "--pretty=tformat:".  But as "set and
> forget" facility, there is no strong need to prefer "%s (%an)" over
> "log:%s (%an)" on the configuration variable side (other than being
> consistent to the command line option parsing).  We would probably
> want to give an escape hatch in the design to avoid painting
> ourselves into a corner we cannot get out of (imagine what happens
> when later others want to use something completely different from
> the log-pretty machinery, making "not a shortlog, must be log:"
> assumption invalid).
> 
> Something like
> 
>   "log:" is prefixed to the string value, UNLESS the value matches
>   "^[-a-z0-9]*$" or the value matches "^[-a-z0-9]*:".
> 
> would probably be extensible enough.  To avoid exposing regexp to
> the users, we can say "a string that is not an alphanumeric token,
> nor an alphanumeric token followed by a colon, is prefixed with
> 'log:'", or something.
> 
> WIth such rules in place, a new fixed format other than "shortlog"
> can be introduced (e.g., "middlelog") without getting munged into
> nonsense "log:middlelog", and a new parameterized format other than
> "log:" can be introduced (e.g., "pretty:%(subject) %(author)")
> without turning into a nonsense "log:pretty:%(subject) %(author)".
> 
> Or we do not have to worry about these if we just use what the user
> gives us without any DWIM.  I just do not think we want to see the
> "not a shortlog?  must be log" burned into the syntax that will have
> to stay with us forever.

Since we already require the prefix in the command line might as well
just make it the same for the configuration file. That way, if someone
will ever introduce a new preset format other than shortlog we just
check for "log:" first and then cascade into checking the rest of the
presets.

Please confirm that you like this and I'll start making changes to the
patch.

Thank you
