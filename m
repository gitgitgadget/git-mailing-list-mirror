From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 1/4] t5541-http-push: add test for chunked
Date: Wed, 04 May 2011 11:23:25 -0700
Message-ID: <7vzkn2e34y.fsf@alter.siamese.dyndns.org>
References: <1304437649-7052-1-git-send-email-rctay89@gmail.com>
 <1304503896-5988-1-git-send-email-rctay89@gmail.com>
 <1304503896-5988-2-git-send-email-rctay89@gmail.com>
 <m3wri6vg5h.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tay Ray Chuan <rctay89@gmail.com>,
	"Git Mailing List" <git@vger.kernel.org>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Dan McGee <dpmcgee@gmail.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 04 20:23:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QHgjl-0006li-FT
	for gcvg-git-2@lo.gmane.org; Wed, 04 May 2011 20:23:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751062Ab1EDSXo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 May 2011 14:23:44 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:38548 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750897Ab1EDSXn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2011 14:23:43 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id EF6954E08;
	Wed,  4 May 2011 14:25:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=swIKCYiWAIMZIoGJpx+LEXgfixo=; b=W5LbSB
	D2mTYvWq5Gok5MgP9qJYb4fk9XORGq86tJlqQa39v/Oea40bu4BYLwO09nz1PAzH
	95viAZaWMTzW3b/udEy3wUJNFwVIzshBMxp/n+xC8bbW+jz8PFgKPciSjolJKo21
	nInuBXD5GlsNPHNzyPkkFHPiZAur0Wfa/bk+k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TdpO7z8S0KAmSAxLAGq08P2ywfFp7N+J
	4eS7ENssApZD6EMitTgxhzvhWtEUZXLAmIdLJ8w2nCYJJfDzNBprqsT2THI4azur
	KfsNBkldGGCLvgYnyu28mHds/DO+jTk4U+iRsxLS/nruAtHjmn2cReMOZwuzUuOQ
	oiEPDQo36u0=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 9E5864E06;
	Wed,  4 May 2011 14:25:39 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id D4D5F4DF1; Wed,  4 May 2011
 14:25:31 -0400 (EDT)
In-Reply-To: <m3wri6vg5h.fsf@localhost.localdomain> (Jakub Narebski's message
 of "Wed, 04 May 2011 04:51:22 -0700 (PDT)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E9BD2582-767B-11E0-A996-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172757>

Jakub Narebski <jnareb@gmail.com> writes:

> It is a very minor issue, a nitpick really; but wouldn't it be better
> to use
>
>   +	git config http.postbuffer 4 &&
>   +	test_when_finished "git config --unset http.postbuffer" &&  

Not a minor issue it is.  It needs to be fixed before queued.  Thanks for
pointing it out.

It is a different matter if it needs to be rerolled. Something trivial
like this I could remember to amend/tweak before queuing.

Thanks.
