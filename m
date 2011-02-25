From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] commit notes workflow
Date: Fri, 25 Feb 2011 10:59:59 -0800
Message-ID: <7v4o7saqj4.fsf@alter.siamese.dyndns.org>
References: <20110225133056.GA1026@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Feb 25 20:00:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pt2tk-0001sc-Hp
	for gcvg-git-2@lo.gmane.org; Fri, 25 Feb 2011 20:00:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756279Ab1BYTAI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Feb 2011 14:00:08 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:40622 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751325Ab1BYTAH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Feb 2011 14:00:07 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D2F024794;
	Fri, 25 Feb 2011 14:01:22 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=f09y6X0tF8UYMeFenOW37rlPIYQ=; b=lhYGyX
	VtBD74N8vwPUkmfQhsgMQA2D/oo5npDq9nqd3R5ugiwVWZ0VlLHSv1/737Ab+iOF
	W18+YLYmjoaAh9mvqqATWc7d0qSjoX/KOC8m/ZEh+Dvq3ivBEKubupOz4WQQqjyP
	MZnWRO4bxjsmTmpc2itSmOFph/mgHpjvcisUE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pGC4DwSuLYSsh8BtYuUKaDYQXJnNuFUX
	M/LParhgcqmqCf8Fv17WsPL8AAG4eZHPTi5+IioF63sAOP97l5DFI5ozEjsSoQ4q
	TORwfOmSuoiq0QH0CtrjElXwDdhcViy0fGt3T7Xek5OMEjv0LsHX/NRQtH8PN43g
	Sl6To4S8tVo=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B06F74784;
	Fri, 25 Feb 2011 14:01:20 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id BD4524780; Fri, 25 Feb 2011
 14:01:17 -0500 (EST)
In-Reply-To: <20110225133056.GA1026@sigill.intra.peff.net> (Jeff King's
 message of "Fri\, 25 Feb 2011 08\:30\:57 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: A1DAB760-4111-11E0-AE43-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167919>

Jeff King <peff@peff.net> writes:

> So your commit template looks like:
>
>   subject
>
>   commit message body
>   ---
>   notes data
>
>   # usual template stuff
>
> I'm curious what people think. Do others find this useful? Does it seem
> harmful?

As long as this is done only under "commit --notes", I don't think it
should hurt innocent bystanders.

> It's yet another magic format to worry about when writing a commit
> message. But you don't need to care unless you use "--notes" (and I
> would probably add a config option, since I would always want this on
> personally).

Then --no-notes would also be necessary, but I think you would get it for
free these days ;-).

> I only turn on --edit when we launch an editor. It seems somehow more
> confusing to me that "git commit -F file" should split notes out (or
> worse, "git commit -m").

So if you see -F -m and there is no --edit, you don't split out notes at
the divider?  That sounds like a sensible thing to me.
