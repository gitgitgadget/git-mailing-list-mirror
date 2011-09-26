From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git is not scalable with too many refs/*
Date: Mon, 26 Sep 2011 13:07:25 -0700
Message-ID: <7vvcsf130i.fsf@alter.siamese.dyndns.org>
References: <4DF6A8B6.9030301@op5.se>
 <201109261207.52736.mfick@codeaurora.org>
 <88a00eadcbb4a7946dbe8d70dd0e933d@quantumfyre.co.uk>
 <201109261401.38624.mfick@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Julian Phillips <julian@quantumfyre.co.uk>, git@vger.kernel.org
To: Martin Fick <mfick@codeaurora.org>
X-From: git-owner@vger.kernel.org Mon Sep 26 22:07:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8HSf-0005Yd-Og
	for gcvg-git-2@lo.gmane.org; Mon, 26 Sep 2011 22:07:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752957Ab1IZUH3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Sep 2011 16:07:29 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34987 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751622Ab1IZUH2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Sep 2011 16:07:28 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CD6F35113;
	Mon, 26 Sep 2011 16:07:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=d/0mim/Jy/asN1JxI/BqIyGVQ98=; b=WpY543
	kREz1SNzkIqv9b0EMwTyT/r3gMlxS2PnmM3cAyu8jEGex2B7QpEybuXsfrmfg7Gt
	tKNoQNa1PoNM+fwg5DUMvRx5TkWe/O8ngn0FZVeMKEKx1f+qaC3nRgNIhSh+vfHb
	OQ7vmEVIrfqDWchnFmpC2kAu2EAovLi3BQBBk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QJhVQD3GCDA5fK87du5my9y1CBa5p5Kj
	Fkn65Uv8V8V9d9pJ2z7Ft8KoxyongmslwIXiyZP9jg0IhxaA3jJh1I0PII5iptjr
	T4H8qC+jHAUWYma43BkzyrY5NE+cUpHWnto/dOPvDXldoo40miIZrSg2Z2B0pu4K
	MtWc+w5EXis=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C48955111;
	Mon, 26 Sep 2011 16:07:27 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 54257510F; Mon, 26 Sep 2011
 16:07:27 -0400 (EDT)
In-Reply-To: <201109261401.38624.mfick@codeaurora.org> (Martin Fick's message
 of "Mon, 26 Sep 2011 14:01:38 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2829C444-E87B-11E0-BC07-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182160>

Martin Fick <mfick@codeaurora.org> writes:

> After a gc, the repo does perform the similar to the 
> uncompressed one (which was achieved via gc).  After gc, it 
> takes ~.05s do to a 'git branch' with 1.7.6 and 
> git.1.7.7.rc0.72.g4b5ea.  It also takes a bit more than 15s 
> with the patch reverted.  So it appears that compression is 
> not likely the culprit, but rather the need to be gced.

Isn't packing refs part of "gc" these days?
