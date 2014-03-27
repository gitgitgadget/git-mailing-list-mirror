From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC 0/6] reuse deltas found by bitmaps
Date: Thu, 27 Mar 2014 09:36:38 -0700
Message-ID: <xmqq8urvfvjd.fsf@gitster.dls.corp.google.com>
References: <20140326072215.GA31739@sigill.intra.peff.net>
	<xmqq7g7gkgp6.fsf@gitster.dls.corp.google.com>
	<20140326181300.GA7087@sigill.intra.peff.net>
	<20140327011323.GA9266@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ben Maurer <bmaurer@fb.com>,
	Siddharth Agarwal <sid0@fb.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 27 17:36:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WTDIM-00041k-4p
	for gcvg-git-2@plane.gmane.org; Thu, 27 Mar 2014 17:36:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755024AbaC0Qgm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Mar 2014 12:36:42 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59348 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754903AbaC0Qgl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Mar 2014 12:36:41 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B353B76F42;
	Thu, 27 Mar 2014 12:36:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bQdRHQ7/yQ84Vpu8Ao6akPL/Etg=; b=wpfI6g
	jlZG3FSitSgJRy2HTe0T6zIbZNwk0dhEw25uU6ghfj5Gp//I8BY5mbzKoXdvEROR
	cKKrmWZ/Nf6OEKNQ8EOCHy0biN6ypMx7XpMFGjPUm3mlSpV2TMCRAQO94bUGBhbf
	53s7OVanwFWkL/dgmZ2fBkIet/1VRHuuKkB+A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ekDy8SyX3QT37pblABfg/w1GvRmI2Nfa
	OmnjxotsxOz9WxWb9lkYq9k0VAJnwVSrnm5nFFnmOxDYQIdLmoF4SAd2MPmUOzNS
	c34lS1va1GN7PcAzYQI17JFwUUVO18DnuWfqw7w182JK/TJJ+mjs+A78pQKxUzq5
	BdtEa+TuJns=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 96E4676F3B;
	Thu, 27 Mar 2014 12:36:40 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C2BF876F36;
	Thu, 27 Mar 2014 12:36:39 -0400 (EDT)
In-Reply-To: <20140327011323.GA9266@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 26 Mar 2014 21:13:23 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: F8C90084-B5CD-11E3-9654-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245291>

Jeff King <peff@peff.net> writes:

> But for a small fetch...
>
>   5311.3: server   (1 days)    0.20(0.17+0.03)   4.39(4.03+6.59) +2095.0%
>   5311.4: size     (1 days)              57.2K             59.5K +4.1%
>   5311.5: client   (1 days)    0.08(0.08+0.00)   0.08(0.08+0.00) +0.0%

Nice ;-)

> So this is a dead end, but I think it was good to double-check that.

Thanks.
