From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 2/2] submodule: pass on http.extraheader config settings
Date: Thu, 28 Apr 2016 12:52:03 -0700
Message-ID: <xmqqoa8t4il8.fsf@gitster.mtv.corp.google.com>
References: <cover.1461837783.git.johannes.schindelin@gmx.de>
	<89d0024450b0e6e9997ad9e3d681248bde1bafc0.1461837783.git.johannes.schindelin@gmx.de>
	<20160428112912.GB11522@sigill.intra.peff.net>
	<alpine.DEB.2.20.1604281405540.2896@virtualbox>
	<20160428134953.GB25364@sigill.intra.peff.net>
	<CA+P7+xq-_D2Mszyjd11CyYLiKBBh9A2e1exaZQVmWz1qVKv7ug@mail.gmail.com>
	<20160428153902.GF31063@sigill.intra.peff.net>
	<CAGZ79kZFLTARQ25h4u4SGgNn=Q4TQi-kxFLN3sQvOmejsRmAWA@mail.gmail.com>
	<20160428165031.GA31421@sigill.intra.peff.net>
	<xmqq1t5p5z8v.fsf@gitster.mtv.corp.google.com>
	<20160428191038.GA10574@sigill.intra.peff.net>
	<xmqqwpnh4joq.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kYoRP=rkfaL+rLapmvouUdPxXGBr-KWOLhL94bYB1B2-w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, Jacob Keller <jacob.keller@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git mailing list <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Apr 28 21:52:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avrz2-00015k-Vd
	for gcvg-git-2@plane.gmane.org; Thu, 28 Apr 2016 21:52:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752634AbcD1TwJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Apr 2016 15:52:09 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58880 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751865AbcD1TwH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2016 15:52:07 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id C7E1515414;
	Thu, 28 Apr 2016 15:52:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2Y3EdVtudZlgPzMVPifH4+rYobc=; b=WjNoce
	rmx2Prs+mSPh3UdSqWNmrDXLlfcTEaZrulqvsHDpLcUnN6vl5Rt3Jg30+8PUn5Rx
	dY1CP8emr+ubX0UcFG2tk6lXbRF8O+xFHSnCWlW1EaQtKWxh/r39HOP6JdDmYjld
	3volIr50e/jkfoJ08H210kTJC3dvv6Cd16gkk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CBCGkQJ0ozGRpMpiWkmr3d9ujGk1ItBz
	ufGlmCzOoFEz455AnOoTWuuNEET5Xr4YFQ30D8Nky1MufRcNk+RPDpZxon1HByU8
	/OCuzy/4kC7MRgsckJYOFopgldUPOiNWE8XhkWD6NJLjoL/OXk5w48B710Vh6oeZ
	WvdE7NuYT5Y=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id C01D215413;
	Thu, 28 Apr 2016 15:52:05 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2865215412;
	Thu, 28 Apr 2016 15:52:05 -0400 (EDT)
In-Reply-To: <CAGZ79kYoRP=rkfaL+rLapmvouUdPxXGBr-KWOLhL94bYB1B2-w@mail.gmail.com>
	(Stefan Beller's message of "Thu, 28 Apr 2016 12:34:31 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: AED586B2-0D7A-11E6-805F-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292942>

Stefan Beller <sbeller@google.com> writes:

> So when going with that philosophy, the user might be missing
> switches like
>
>     -c-for-this-repo-only core.worktree=... -c
> submodule.worktree=align-relative-to-parent
>
> i.e. when shifting the responsibility to the user, we need to have
> switches to pass options to the repository or a subset of submodules?

I think that is an excellent illlustration of the issue by an
example of what we shouldn't do ;-)

"git" is not always about submodules, so "-c-but-not-for-submodules"
option does not belong to "git" wrapper.

Users use "git -c" and hope to affect what happens in submodules,
only because "git submodule" support is still immature and does not
have options to do that.  You certainly smell a linkage between
"pass options to a selected subset of submodules" and your recent
"give labels to submodules so that they can be named with *group
syntax" topic, no?
