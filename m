From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] config: introduce GIT_GLOBAL_CONFIG to override
 ~/.gitconfig
Date: Thu, 27 Sep 2012 12:57:13 -0700
Message-ID: <7vtxujp7c6.fsf@alter.siamese.dyndns.org>
References: <CALkWK0nYnyaoOsH_x8U96ADZT7VuP-pR36+RRcjTw39Kp1qCnw@mail.gmail.com>
 <1348757171-3223-1-git-send-email-artagnon@gmail.com>
 <20120927173532.GD1547@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>,
	David Aguilar <davvid@gmail.com>,
	Anurag Priyam <anurag08priyam@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Sep 27 21:57:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1THKD9-0004jk-ER
	for gcvg-git-2@plane.gmane.org; Thu, 27 Sep 2012 21:57:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754505Ab2I0T5Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Sep 2012 15:57:16 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56772 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752578Ab2I0T5Q (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Sep 2012 15:57:16 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 92A289EF5;
	Thu, 27 Sep 2012 15:57:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=iixwauJNz//MmT7ddSFdU8THE5M=; b=c0PlSX
	WjgyB0t7VOcK1esD/7pe8yAoueCP5qVHphTquTSsrrkHKhvwM+zi0/y1Yxh+YTv0
	F7iXBD6Vw9J+wL1Dz3Wlogr5jFxJEfF9beAZDBDy1dT2O8paMEG6KKDNgiYW63sY
	p2NHSXQMJ7UhREs68MNPisYV3dmBu0EpdIZ0Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iLphmucgujkWYaUOt1leMoT4zZ2Al0E/
	mVTTcmm0V3LgTexRXEKsUOj8/UQfweYuUPksNuhhHHuSNUt+2kgayQ9edtbqjxEp
	gtmWoEoxLWXMRsUHYSPCUBdi1sOe/K+9f/0+JIIf7LjhRK4CLhx17YeSYqTu4aQp
	t+OTW3GyIoE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7F6559EF3;
	Thu, 27 Sep 2012 15:57:15 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 041F39EF2; Thu, 27 Sep 2012
 15:57:14 -0400 (EDT)
In-Reply-To: <20120927173532.GD1547@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 27 Sep 2012 13:35:32 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 88CDF76A-08DD-11E2-8E3C-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206515>

Jeff King <peff@peff.net> writes:

> Also, have you considered using a config include? Like:
>
>   $ echo '[include]path = ~/my-dotfiles/gitconfig' >~/.gitconfig

Very good suggestion.

> ... you have to bootstrap
> somehow (e.g., you're going to have to copy a .profile or similar to get
> the GIT_GLOBAL_CONFIG variable set).

Exactly my thought ;-)
