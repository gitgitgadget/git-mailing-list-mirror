From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] revision.c: introduce --notes-ref= to use one notes ref
 only
Date: Tue, 29 Mar 2011 11:32:24 -0700
Message-ID: <7vwrjhrd53.fsf@alter.siamese.dyndns.org>
References: <e83f8b622fba5add563fc331ae3922b79a0af008.1301392999.git.git@drmicha.warpmail.net> <201103291439.17197.johan@herland.net> <20110329143357.GA10771@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johan Herland <johan@herland.net>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 29 20:32:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4dig-0001Kn-39
	for gcvg-git-2@lo.gmane.org; Tue, 29 Mar 2011 20:32:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751911Ab1C2Scl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2011 14:32:41 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:36648 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750991Ab1C2Sck (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2011 14:32:40 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 7A53841F9;
	Tue, 29 Mar 2011 14:34:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6seivt7i7fHWHKGIQk0QunEMpX0=; b=LQjZRd
	5DXPMJOaW6HjlcGLLgZXqwDpgL09os1Un2eau4bXFyL+CT+vAF3RSaRZ3E0ceRYW
	bjStLwDPawgqdVS1Zhqn13UhPXhFAnNzq1y2gRYd2tBcjnEH0o3nMfJ5jZl/1KaD
	Krnl+1P3fz8E62KcWtIOcEd9XKETI1XtIO7xE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pzTZLMkU90qMY52Bw2p4rlseEK32RX09
	QR+GlYryz1wV27Lp6Z4gxb8d4c1BqOioWHWeeVH+Jwn9qUtggQYfjRqTjx95YZWT
	v2H1rO5l0LzwujAuQkgvh+S575P/9CHz+xjrlt+nEoNvhypcfwGVSFPZRLizTChl
	Ea9paSK3xZA=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 36F0A41F7;
	Tue, 29 Mar 2011 14:34:21 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id B20B541F6; Tue, 29 Mar 2011
 14:34:14 -0400 (EDT)
In-Reply-To: <20110329143357.GA10771@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 29 Mar 2011 10:33:57 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 29C0DDC8-5A33-11E0-969A-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170301>

Jeff King <peff@peff.net> writes:

> Speaking of which, it is kind of weird that --show-notes is negated by
> --no-notes. So maybe it makes sense to introduce "--notes[=<ref>]" to do
> what I wrote above, and deprecate --show-notes.

I think that is sensible.

I personally think that "notes" are way too premature to be used seriously
by normal people yet, and if we want to fix UI and semantics warts (it is
understandable if we had plenty of them, simply because we didn't know
enough about possible use cases during the period we prototyped the notes
feature), the time to do so is now.
