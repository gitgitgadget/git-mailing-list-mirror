From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/5] submodule config lookup API
Date: Thu, 12 Jun 2014 14:59:23 -0700
Message-ID: <xmqqy4x14wn8.fsf@gitster.dls.corp.google.com>
References: <20140605060425.GA23874@sandbox-ub>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jens Lehmann <jens.lehmann@web.de>,
	Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Thu Jun 12 23:59:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WvD1x-0000Hg-Qx
	for gcvg-git-2@plane.gmane.org; Thu, 12 Jun 2014 23:59:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750993AbaFLV7a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jun 2014 17:59:30 -0400
Received: from smtp.pobox.com ([208.72.237.35]:57577 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750895AbaFLV73 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jun 2014 17:59:29 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2349D1FEE2;
	Thu, 12 Jun 2014 17:59:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jGNP9sEEbs3hfobZiFHipZPj2qQ=; b=EbfkVX
	q8ZY7HMCJ+pv16JgeMNZP1JESyC1Mp42OwqdSUJlRA7KYPe7bqq+xeqQE0lu/o8R
	ejadUkfHpMn0c+sBBJFM+uJt5nIx5fxRU2NOZ5R5ug2FM/IAQqI6gw3Yt7z5ruYa
	2r+lXoYchShW3RfiWcChdIazw5oUcCpfVJIE0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CLtP8lVjvl2DuLE0T2RikwEycHnLzEm+
	UofgWWnopu9WCWWZ6DLE7cP2ge6fKj9LfqNg6c4L50HG6/ZuS/kMqkgVedZnrnOT
	+y0/4Y4nnJkj5X3wT5yZBw8nX/bLuFIQS6OVSjzKmL1MbtX1LAswhj7zA03tebnb
	OuIuPzYevgg=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 19E541FEE1;
	Thu, 12 Jun 2014 17:59:29 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 18A3F1FEDE;
	Thu, 12 Jun 2014 17:59:25 -0400 (EDT)
In-Reply-To: <20140605060425.GA23874@sandbox-ub> (Heiko Voigt's message of
	"Thu, 5 Jun 2014 08:04:25 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: D1364F40-F27C-11E3-B45C-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251499>

Heiko Voigt <hvoigt@hvoigt.net> writes:

>  t/t7410-submodule-config.sh                      | 141 ++++++++

We already use 7410 for something else in 'pu'; please avoid dups
waiting to happen.

>  test-hashmap.c                                   |   6 +-
>  test-submodule-config.c                          |  74 ++++
>  18 files changed, 791 insertions(+), 107 deletions(-)
>  create mode 100644 Documentation/technical/api-submodule-config.txt
>  create mode 100644 submodule-config.c
>  create mode 100644 submodule-config.h
>  create mode 100755 t/t7410-submodule-config.sh
>  create mode 100644 test-submodule-config.c
