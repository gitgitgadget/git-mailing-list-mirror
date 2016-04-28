From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 2/2] submodule: pass on http.extraheader config settings
Date: Thu, 28 Apr 2016 12:53:44 -0700
Message-ID: <xmqqk2jh4iif.fsf@gitster.mtv.corp.google.com>
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
	<xmqqoa8t4il8.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, Jacob Keller <jacob.keller@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git mailing list <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Apr 28 21:53:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avs0W-0001ja-SM
	for gcvg-git-2@plane.gmane.org; Thu, 28 Apr 2016 21:53:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753021AbcD1Txs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Apr 2016 15:53:48 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61771 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752522AbcD1Txs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2016 15:53:48 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8D41C16485;
	Thu, 28 Apr 2016 15:53:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4hS08PaJ2hBW4yiAdX2e/8sfAbc=; b=vNVcNk
	b/51vqcemf/eZ0mnDkcop1qvbw9aMP3KoTLo9o3jaehtDobiucnyevtI4UVtvylF
	lkCubBuIxErGLaCf5V7yD15yUCQioU2JDiq9IGcjOGFIPD6ptBownXEzI5TqAmKC
	f7FeOp2ecQXTZpKYW+NOjN32243gh+DFB/aAc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rdYMINeIK4w5hPya6nRlEVWx/1ShYeoV
	BAAQX0NzrtazX1rGQ8ywNUstI3wfxeUcuFCa4ItgUZkW+/5ql/mj2Ob8u+gfmbpM
	uo4mUmhBnopxP9uX27CEhdB/HC0rEaFBgq6iZhmk2ooEZ1nRsKscbeqSVM4SEuiN
	hewObWEc7Jw=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 81A0516484;
	Thu, 28 Apr 2016 15:53:46 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DF85C16483;
	Thu, 28 Apr 2016 15:53:45 -0400 (EDT)
In-Reply-To: <xmqqoa8t4il8.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Thu, 28 Apr 2016 12:52:03 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: EAE2EDDE-0D7A-11E6-A5B3-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292943>

Junio C Hamano <gitster@pobox.com> writes:

> Users use "git -c" and hope to affect what happens in submodules,
> only because "git submodule" support is still immature and does not
> have options to do that.  You certainly smell a linkage between
> "pass options to a selected subset of submodules" and your recent
> "give labels to submodules so that they can be named with *group
> syntax" topic, no?

By "options to do that", I meant "options to specify 'these
configurations are passed down to part of this command that operates
on these submodules'".
