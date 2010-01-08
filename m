From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] base85: No need to initialize the decode table in
 encode_85
Date: Fri, 08 Jan 2010 07:55:09 -0800
Message-ID: <7v3a2giobm.fsf@alter.siamese.dyndns.org>
References: <alpine.LFD.2.00.1001071253400.21025@xanadu.home>
 <1262958000-27181-2-git-send-email-agruen@suse.de>
 <4B475361.60506@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andreas Gruenbacher <agruen@suse.de>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Jan 08 16:55:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NTHBO-0004qi-CH
	for gcvg-git-2@lo.gmane.org; Fri, 08 Jan 2010 16:55:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753486Ab0AHPzW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Jan 2010 10:55:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752518Ab0AHPzW
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jan 2010 10:55:22 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:39038 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751797Ab0AHPzV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jan 2010 10:55:21 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B74CB8FF2D;
	Fri,  8 Jan 2010 10:55:17 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8487YdixbhPQ2Fl1+egl9ZpKsqk=; b=WsUe6v
	pI87q9qDdxBlwmHHcfhpBfOSf5JWQUmpqhq+4ZXWFCURs+RNMwSu6AfCf+kk19xi
	3sxBHntJViQKPQQGPPv3kGUJnpX73cdL+bzTsu02aM4BqIE2QO8AUbu1pUpYvftm
	70mTHjzGK8Xsh6Tgl+8FOOMVHVFUjkvfwixZM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nL/7i71NDvQh5hEsvwk4H8E0dKGTcYlA
	8DFT6wBWZgapUVf/alMgPbX0aFo7rcJ1+iaJD/1x2uj8ojxFgfHypW4iLaGq/EL3
	kKMm33iqUYLkX3rz30UO+lEzHxNtZ39Hm/2Ct0qnRyIdqKF+81MM550Nh7DhYMEo
	PfNMGhf0Vt0=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 82D118FF2B;
	Fri,  8 Jan 2010 10:55:14 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B8CF58FF2A; Fri,  8 Jan
 2010 10:55:10 -0500 (EST)
In-Reply-To: <4B475361.60506@drmicha.warpmail.net> (Michael J. Gruber's
 message of "Fri\, 08 Jan 2010 16\:46\:41 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 35AFC5DC-FC6E-11DE-9267-9D59EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136447>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> Andreas Gruenbacher venit, vidit, dixit 08.01.2010 14:39:
>> Signed-off-by: Andreas Gruenbacher <agruen@suse.de>
>> ---
>
> For the less informed it may be worthwhile to have an explanation in the
> commit message why encode_85() does not need to initialize the table. (I
> strongly suspect it's a matter of de vs. en, i.e. "because it only
> encodes but does not decode."...)

The title can be reworded to

    base85: encode85() does not use the decode table
