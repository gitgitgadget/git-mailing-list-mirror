From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] submodule+shallow clone feature request
Date: Wed, 10 Feb 2010 14:14:27 -0800
Message-ID: <7vsk983fi4.fsf@alter.siamese.dyndns.org>
References: <4B73277C.9010801@columbia.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Schuyler Duveen <sky@columbia.edu>
X-From: git-owner@vger.kernel.org Wed Feb 10 23:14:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NfKpV-00047g-9g
	for gcvg-git-2@lo.gmane.org; Wed, 10 Feb 2010 23:14:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756586Ab0BJWOg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Feb 2010 17:14:36 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:61631 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756240Ab0BJWOf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Feb 2010 17:14:35 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E2FC598BF6;
	Wed, 10 Feb 2010 17:14:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Yd51bSD6jCo6HPF6TxjXvfSC9tQ=; b=T5blFb
	KRpugRm/Z+XDAOn0FZztmN8/ebQBnqRh/oimgUgKSWaabGC3KkiDMWGdyuKrrfzg
	OLR3Wpro9n+cKAUvkNyCx2sblbTsciXRz2lSmc9Pk04hqMd7O9P9HfK68xNwBRQk
	QCYSGSt5p72iZjmh1Bo3aQ4NaHoxOissREby8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PxewXc3046Uc75NmDQbg/GwyX5A6NO2D
	TzjT8y+rtLn+JsQgsLAvJA3EF87GTzr1dj9gTPgxryBWDkD5coo8W/idfwzv982a
	fiCW71a8dabS50IE/jafYHgBe2tadghH40CO+nyx5zq7r00fHPRnETakyJ0yE0cq
	addaBUvO0TE=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B022398BF4;
	Wed, 10 Feb 2010 17:14:31 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EF0CF98BEE; Wed, 10 Feb
 2010 17:14:28 -0500 (EST)
In-Reply-To: <4B73277C.9010801@columbia.edu> (Schuyler Duveen's message of
 "Wed\, 10 Feb 2010 16\:39\:08 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: A9A75A76-1691-11DF-92C3-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139557>

Schuyler Duveen <sky@columbia.edu> writes:

> My use case is deploying from a git repository, which would be even more
> graceful with the following features:
>
> 1. When 'git clone' has both --recursive and --depth, then submodules
> are also checked out shallow (for speed/bandwidth).
>
> 2. Some way to specify an override on .gitmodules sources.  This is
> because our .gitmodules includes public, read-only sources (github),
> rather than our local repos we would prefer to deploy from (for the
> purpose of reliability).

These should be doable if you do not use --recursive, so I don't think
they are insurmountable issues.  I suspect many people would welcome such
enhancements to the "git submodule" potty.

I think the current implementation of "--recursive" is an attempt to help
people with a particular view (all submodules are interesting and the user
needs an access to them immediately) while not trying to help others with
different needs.  Contribution from the latter class of users to change
the situation would be good.
