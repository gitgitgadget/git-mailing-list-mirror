From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] format-patch: introduce format.defaultTo
Date: Mon, 06 Jan 2014 13:37:07 -0800
Message-ID: <xmqqlhyshjwc.fsf@gitster.dls.corp.google.com>
References: <1389028732-27760-1-git-send-email-artagnon@gmail.com>
	<1389028732-27760-3-git-send-email-artagnon@gmail.com>
	<xmqqlhythrzq.fsf@gitster.dls.corp.google.com>
	<CALkWK0kZn44x98td9YXNT5VfhVs=ueeSty9M7Vh08bdoGjGQYg@mail.gmail.com>
	<xmqqa9f8j2n8.fsf@gitster.dls.corp.google.com>
	<20140106201854.GA28162@sigill.intra.peff.net>
	<CAEBDL5UaS2Hd-Yb417W+Fw_7j1+5sRAgszko-PbU7z901_X+cw@mail.gmail.com>
	<20140106204203.GI3881@google.com>
	<CAEBDL5VD9C8DXFUS9VawxZhAC0AnR=abV-FEVTdi25NVBPvDVg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>
To: John Szakmeister <john@szakmeister.net>
X-From: git-owner@vger.kernel.org Mon Jan 06 22:37:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0HrQ-0002Qz-Ea
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jan 2014 22:37:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755563AbaAFVhR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jan 2014 16:37:17 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54765 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755441AbaAFVhQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jan 2014 16:37:16 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1DDF45F905;
	Mon,  6 Jan 2014 16:37:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=asP2UE0Z8YGAfMTH3bR6Kb+MQnQ=; b=TWtZIi
	wvdIOsBl+DDvS9u9jDDgN28PUVPcEwshoVvgdRHU4mwNVKNh5/pfqKIr3Ppr/kl8
	uatOhMFnsP4tQVFf5iF8+ofr69QgEMA6W5jOFelHjVefqjNqi/ZSEeuZUNxImF4R
	1uuwtwflTaLKijwuIiOEEWYnlOghYOotTN6QQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UnepGNnabMa5n3KLL+ou25YNGC6FUXd1
	5dJ7UFTVsAKXNwxoqeDxs06uBoZB5ruMAw3qyI00zm+jFrUXvjgZy9mCLibujeL3
	2DmHG/AGhHpEWih818LOzirSdEKo+DXgvSEYpwBpAiXLOJ9bSZrwGrNkpkhF8Tpn
	lhj6L14CvNw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 96FC55F902;
	Mon,  6 Jan 2014 16:37:14 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CA9995F900;
	Mon,  6 Jan 2014 16:37:11 -0500 (EST)
In-Reply-To: <CAEBDL5VD9C8DXFUS9VawxZhAC0AnR=abV-FEVTdi25NVBPvDVg@mail.gmail.com>
	(John Szakmeister's message of "Mon, 6 Jan 2014 16:13:44 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: B3AA75CE-771A-11E3-8989-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240068>

John Szakmeister <john@szakmeister.net> writes:

> Am I missing something?  If there is something other than @{u} to
> represent this latter concept, I think `git push` should default to
> that instead.  But, at least with my current knowledge, that doesn't
> exist--without explicitly saying so--or treating @{u} as that branch.
> If there's a better way to do this, I'd love to hear it!

I see Ram who worked on landing the remote.pushdefault feature is
CC'ed; this work was started in early April 2013 and your config and
workflow may not have been adjusted to it.
