From: Junio C Hamano <gitster@pobox.com>
Subject: Re: measuring the % change between two commits
Date: Thu, 23 Feb 2012 12:13:32 -0800
Message-ID: <7vpqd52tqr.fsf@alter.siamese.dyndns.org>
References: <CAMK1S_gXQaE+RZxe4S7vqAyPka9N9PAoe+557FaLO+JJoJFshA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Sitaram Chamarty <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 23 21:13:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S0f2p-0001MD-8q
	for gcvg-git-2@plane.gmane.org; Thu, 23 Feb 2012 21:13:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756562Ab2BWUNf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Feb 2012 15:13:35 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51187 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756012Ab2BWUNe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Feb 2012 15:13:34 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DF8416164;
	Thu, 23 Feb 2012 15:13:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9xvf5tDbmUS9ZeZRBKm/bsa7zSc=; b=Riq5WM
	gaW06CsauhFjx9mueFXdxrZyS3Fsoufkf+DIRAPZYxp9oo9VIr68Sk+tyRkVsCAx
	lh/hR+M919Ms9COVxMAaL1NZANIZAugGGkmCRr6e5hPQFhtPdxuzp9QKX7DMZeI8
	arkJus4TLE8NNwZCI/w0ZfBNZTNsramUEEc0E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Rj/tsE4vhDmNiQl7/UaAy53DgzyAuTBn
	NY+DnS7QnNLIeWFjNg9TkTOUQyyjJ37m5NMttDOw4HwNqXfYw21Qm4iQ7Oi9tY3U
	Z8vwrTIM7h2mEQmoyve7UnIPLFC4BJAmaTU6ripNXqHbTLJikPtE8uG2ObAO9XaR
	BvEl5iMaPZ8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D682A6163;
	Thu, 23 Feb 2012 15:13:33 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 674526162; Thu, 23 Feb 2012
 15:13:33 -0500 (EST)
In-Reply-To: <CAMK1S_gXQaE+RZxe4S7vqAyPka9N9PAoe+557FaLO+JJoJFshA@mail.gmail.com> (Sitaram
 Chamarty's message of "Thu, 23 Feb 2012 17:00:40 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DC5353F4-5E5A-11E1-BDB4-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191393>

Sitaram Chamarty <sitaramc@gmail.com> writes:

> I could do a --numstat and then do a 'wc -l' on each file I guess, but
> I was hoping to avoid that.
>
> --dirstat gives you a percentage but does not count the top level directory.

Note that dirstat is not about "how much damage was caused to the entire
codebase".  It only measures "How is the damage this patch causes
distributed across directories it touches".  It was unclear from your "a %
measure for the changes between two commits" which one you meant, but I am
guessing from your "--numstat and wc -l" reference that you are asking for
the former, e.g. we have 300,000 lines of code and between these two
commits 10,000 lines changed, hence we updated 3% of the codebase during
that period".
