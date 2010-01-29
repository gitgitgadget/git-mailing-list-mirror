From: Junio C Hamano <gitster@pobox.com>
Subject: Re: master^ is not a local branch -- huh?!?
Date: Fri, 29 Jan 2010 15:12:47 -0800
Message-ID: <7vk4v0fqts.fsf@alter.siamese.dyndns.org>
References: <ron1-2E17EF.12204629012010@news.gmane.org>
 <op.u7a909hf4oyyg1@alvarezp-ws> <ron1-1F1799.13340029012010@news.gmane.org>
 <op.u7bfjni44oyyg1@alvarezp-ws> <ron1-0EE62E.14474929012010@news.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ron Garret <ron1@flownet.com>
X-From: git-owner@vger.kernel.org Sat Jan 30 00:13:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nb01N-0005pY-KT
	for gcvg-git-2@lo.gmane.org; Sat, 30 Jan 2010 00:13:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752803Ab0A2XM4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Jan 2010 18:12:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752700Ab0A2XM4
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jan 2010 18:12:56 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:46671 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752661Ab0A2XMz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jan 2010 18:12:55 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 6274895B1C;
	Fri, 29 Jan 2010 18:12:53 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tlcjNMw0lDOAceRiw1uhLfmAWDI=; b=QaY95H
	QkLX5xYBkJgy4PTXfkyMVHpVwq5wTsbZEhcsXKAPhyES5yf+DxCnEUaq3lH8Gamq
	g8nyUu7Q2RnaAW/Glf/tmdwaN1id18W9iLcF1SlJcoKBNHN+5PLmMOfQh17L8X2d
	BnBKsxMUhY8NrgBeOJ+OPBv8RuBINrFDXkBjk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jvr96Bzvsn4p6yEKGEID9fdSKWqkQngG
	idP+VJ3Ufx3fsrQfKWJU4GebTGuaqLzlO8sx7PTeNNnW2z5wN7vAvKmZHjfBVpoy
	9KE4JZ5AC2NELtEcB05J92oRuDdZXGH4WQoQfamD1NIdrvGCBRclv8mbyjQnGr/B
	zMfcUubwb6Y=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 40FC695B1B;
	Fri, 29 Jan 2010 18:12:51 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9F18995B1A; Fri, 29 Jan
 2010 18:12:48 -0500 (EST)
In-Reply-To: <ron1-0EE62E.14474929012010@news.gmane.org> (Ron Garret's
 message of "Fri\, 29 Jan 2010 14\:47\:49 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D298A120-0D2B-11DF-AB90-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138398>

Ron Garret <ron1@flownet.com> writes:

> My actual use case is very complicated, but here's a simplified version:
>
> Suppose I'm using git as a back-end for a wiki.  I want to look at the 
> state of the entire wiki as it was in some point in the past, and I also 
> want to be able to look at the diffs between individual pages as they 
> were then and as they are now.

Don't think you are so special ;-) "git checkout $that_old_commit" was
invented _exactly_ for that use case.  You can look around from that
state, and when you are done sightseeing, you can come back by doing a
"git checkout master" (or whichever branch you want to be on).

You don't necessarily have to check out an old state if the only thing
you are interested in is to review how the contents changed over time.
Use "git log -p" (from the current tip) for that.

If you chose to have an old checkout and then traverse the changes over
time leading to the current tip, you would say "git log -p ..master"
instead.
