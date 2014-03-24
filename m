From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 03/12] t: drop useless sane_unset GIT_* calls
Date: Mon, 24 Mar 2014 15:06:04 -0700
Message-ID: <xmqqwqfjntf7.fsf@gitster.dls.corp.google.com>
References: <20140320231159.GA7774@sigill.intra.peff.net>
	<20140320231433.GC8479@sigill.intra.peff.net>
	<xmqqy503s0s0.fsf@gitster.dls.corp.google.com>
	<20140324215638.GH13728@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Tran <unsignedzero@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Mar 24 23:06:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSD0a-0001MS-Jl
	for gcvg-git-2@plane.gmane.org; Mon, 24 Mar 2014 23:06:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751437AbaCXWGK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Mar 2014 18:06:10 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52724 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751131AbaCXWGJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Mar 2014 18:06:09 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B23567607C;
	Mon, 24 Mar 2014 18:06:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=YVnRcYqLK+1BY20aTSMiMwfx7hY=; b=P4YXZS
	/2si0OP5qxIV4ujRZzoHm4CGU6dKpylfcpRbUHTRYsGS5ExrxRyseGULE1blPVqp
	VSnGeq2+h5+dUWyak1tTlsJm5PJF4D8sbm+2bhghIOBQ8Kf9vbpB+HwG1yotrRFl
	GHuVOC6NdQ7qR3HMnZP90KAL/aikLhWuXW4hc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=yISUC56l5yyDJoGNFFckzO1Pot8Ivi6V
	/oo1ViSVT6aLr2D9wl6DwXNW+i/N6bWhmMiThGygzGT52KSealpb5PY9TrWZj7uK
	B0izIvBxoOYYC4x0VjsfmF89LvP+NJMn1FUCp2tzXfjvZErW3HU2Iw52vpdEP9lJ
	mj84OPQ4tds=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A115E7607B;
	Mon, 24 Mar 2014 18:06:08 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E510F7607A;
	Mon, 24 Mar 2014 18:06:07 -0400 (EDT)
In-Reply-To: <20140324215638.GH13728@sigill.intra.peff.net> (Jeff King's
	message of "Mon, 24 Mar 2014 17:56:38 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 8046AA00-B3A0-11E3-A804-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244889>

Jeff King <peff@peff.net> writes:

> I do not have a problem with that, as it implicitly covers all of the
> tests following it. I do not think it is particularly necessary, though.
> Assuming we start with a known test environment and avoiding polluting
> it for further tests are basic principles of _all_ test scripts.

They should be, but I suspect majority of tests, especially the
older ones, do have dependencies on earlier test pieces X-<.
