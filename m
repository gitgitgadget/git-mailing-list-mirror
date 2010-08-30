From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH 0/2] Teach fetch and pull to recursively fetch
 submodules too
Date: Sun, 29 Aug 2010 22:58:05 -0700
Message-ID: <7vocckhcb6.fsf@alter.siamese.dyndns.org>
References: <4C7A819B.3000403@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Mon Aug 30 07:58:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OpxNt-0006OS-CF
	for gcvg-git-2@lo.gmane.org; Mon, 30 Aug 2010 07:58:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752061Ab0H3F6Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Aug 2010 01:58:16 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:39863 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750760Ab0H3F6P (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Aug 2010 01:58:15 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A6D20D1FAA;
	Mon, 30 Aug 2010 01:58:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0bo1KL1PWhqJemWRqENqE0K4plw=; b=o+NSno
	7I9sbJTFw+ljDfH/gofNGDpNO9Py08oKSf2xdFlazFL6Usq5Qz2YnoWfm7a4iklF
	h6VTAK7xeAefAgghMNF9tQiIal1OaLOrtssiTLsBFsTHR8ZV0OCsZ/D3njA1EOzV
	RVUp/zZXDf370BFa1dNcbh7PS4LjPTbifl5Zw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TQtSmjfXbwhP1MEP95bj/c8ERXmv9+tB
	bgVllB1IhIqfynYSlOYwduIgRjHIr5HstUb5DQCg1Bm/ft4stCU/NL8lx2xdCQXq
	he4eXAWcUKmj0uotDAQyRlc+BaO2y/tSYisTTfLL70SZdXyqq1VhvyWyZ5K+Vyvr
	4NLrZwjd5xM=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 706C4D1FA9;
	Mon, 30 Aug 2010 01:58:11 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AC35FD1FA4; Mon, 30 Aug
 2010 01:58:07 -0400 (EDT)
In-Reply-To: <4C7A819B.3000403@web.de> (Jens Lehmann's message of "Sun\, 29
 Aug 2010 17\:49\:47 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 9221A430-B3FB-11DF-97D1-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154767>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> So I extended the fetch command to fetch populated submodules too. I
> also added a command line option to fetch and pull and the second patch
> introduces a per submodule config option to give users the chance to
> control that behavior.
>
> And maybe we need a config option to customize that behavior
> for all submodules or all repos too?
>
> Opinions?

I think your "if a particular submodule is already initialized, recursing
into it is more likely than not what the user wants" is a sound heuristic.

I am not sure what you mean by "all submodules" nor "all repos", though.
In order to trigger the feature this series introduces, users have a means
to initialize all submodules in one go (update --recursive --init), and
wouldn't that be sufficient?
