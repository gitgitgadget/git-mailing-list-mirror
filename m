From: Junio C Hamano <gitster@pobox.com>
Subject: Re: remote's HEAD not detected correctly
Date: Mon, 28 Feb 2011 15:10:46 -0800
Message-ID: <7vk4gjhi15.fsf@alter.siamese.dyndns.org>
References: <AANLkTimWieViK4JcJQuTDiRiAdyvHuwkwy8fL+XUV+i-@mail.gmail.com>
 <AANLkTimqTa24QSWACFX9GErt-Tn+wLda1s_AvH7dzEpm@mail.gmail.com>
 <20110228214207.GA5854@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Shawn Pearce <spearce@spearce.org>,
	Jeffrey Middleton <jefromi@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 01 00:11:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PuCFB-00063k-Ts
	for gcvg-git-2@lo.gmane.org; Tue, 01 Mar 2011 00:11:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753398Ab1B1XLE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Feb 2011 18:11:04 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:50461 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753104Ab1B1XLD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Feb 2011 18:11:03 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A4F764576;
	Mon, 28 Feb 2011 18:12:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=JmrPYNP5YK9ZtAweGuUgS7yWZ8w=; b=K5j+Ev
	TymfrBBLB1zmd5bfhQ40/+SOkwSZmE9EUcZaU3YJVWo19GPJdTP+TfhYm/ORTD03
	0dNiL3IzKfbRWbu+6uh5KdVTU5d8Kh+Nt+VlyZnpMbyVdsMoBJ1Keq6Y+MHq/nfp
	VPvQvsNEeUD9S8M7y3eKXDOUf7ezUaK3rGUrE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=avsc6xTspMiNmmc2alt6X0lgCyhq1Ets
	nw/i3FyAsN7aOfu5YA8lW+joigayFRhpmIcNEyaRJPX44NoR0PMIxG8r4/+qO47q
	4UYmYgggugSFjn96PsDYvJ59V00yuNirawWHjHj9qDZgt76YaX9GGs/t6dkwzUvJ
	xtc8REF+pyU=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 63CA74575;
	Mon, 28 Feb 2011 18:12:11 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 1B7D84574; Mon, 28 Feb 2011
 18:12:05 -0500 (EST)
In-Reply-To: <20110228214207.GA5854@sigill.intra.peff.net> (Jeff King's
 message of "Mon\, 28 Feb 2011 16\:42\:07 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 2C00551E-4390-11E0-855B-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168161>

Jeff King <peff@peff.net> writes:

> It depends on the transport protocol. It actually works over dumb http,
> though I suspect that is not getting used much these days. I also
> implemented a quick-and-dirty patch for local repositories here:
>
>   http://article.gmane.org/gmane.comp.version-control.git/110049
>
> which would make Jeffrey's test pass, but I have a feeling it was just a
> simple test case and that he actually cares about real remotes.
>
> -Peff
>
> PS I think the "send-HEAD-explicitly" patch series was here:
>
>      http://thread.gmane.org/gmane.comp.version-control.git/102039
>
>    I had some complaints at the time, but re-reading it I don't see
>    anything that would prevent us from revisiting the topic now.

Good digging.
