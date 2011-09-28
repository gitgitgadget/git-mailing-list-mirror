From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-completion: offer remotes for 'git remote update'
Date: Tue, 27 Sep 2011 17:47:17 -0700
Message-ID: <7v8vp9trvu.fsf@alter.siamese.dyndns.org>
References: <347b845858abcc62551d83df324e5c10@schrijnen.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
To: Auke Schrijnen <auke@schrijnen.nl>
X-From: git-owner@vger.kernel.org Wed Sep 28 02:47:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8iJ9-0004KI-8J
	for gcvg-git-2@lo.gmane.org; Wed, 28 Sep 2011 02:47:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751731Ab1I1ArV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Sep 2011 20:47:21 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50877 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751565Ab1I1ArU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Sep 2011 20:47:20 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E731D6183;
	Tue, 27 Sep 2011 20:47:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=by8QjBLYNjvzxoPfLiyIw+dagac=; b=U+XYnCQ21qCnpCufpRrM
	PcD0lUF5wR7kkDmKAXrTQVAYqpys0yJGKQsRE10vA5LTNZG/BVl+3l0nIp+6SpKD
	rnioeyAKAijohlyPkelZQs7ZSBkb8qVWNq5GVz3mhcqMvpViUM+igz8fNLPu9rQ/
	4qnPBWc7PAq2QkfpyKttD9A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=s6Ruw/LiY8C+tPs7t0Qms0WUBdd8+pQ8cCv/7Cm9q3YxoX
	rdvMw2oMbKOc0mYc+wxS/8G2WRISiqY71vUA2pPdzXZqD3ALdUFpptpshRRtSiIQ
	NYxEeB+FSaE7F329Dvw9ghC9ccwDkN42OiZrDl5aOW8/44D1h/Xu2iMmyu4Ns=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DE5FF6182;
	Tue, 27 Sep 2011 20:47:19 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5CAB96181; Tue, 27 Sep 2011
 20:47:19 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6B6883A8-E96B-11E0-8697-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182283>

Auke Schrijnen <auke@schrijnen.nl> writes:

> Completion for 'git remote update' only offers configured remote
> groups.

I have this suspicion that it might even be a feature. I am a bad person
to make the judgement, as I do not use the "grouping" feature at all.

If you throw in individual remotes that are not grouped in the mix, the
users of "git remote update" auto-completion, who have been happily
relying on seeing only the configured groups, suddenly will start seeing
many individual repositories offered, cluttering the available choices.
Besides, if you want to fetch from a single source, why not use "git
fetch" directly?

Back when "git fetch" didn't allow fetching from multiple repositories in
one go, "remote update" was written as a wrapper for the explicit purpose
of fetching from more than one remote by defining remote groups. Since
late 2009, "git fetch" can update from multiple remotes itself, and I
suspect "git remote update" outlived its usefulness in some sense, but
that is a tangent.
