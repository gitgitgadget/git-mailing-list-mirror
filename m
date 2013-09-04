From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 07/11] Documentation/replace: tell that -f option bypasses the type check
Date: Wed, 04 Sep 2013 13:45:02 -0700
Message-ID: <xmqqzjrsl3jl.fsf@gitster.dls.corp.google.com>
References: <20130903070551.29838.43576.chriscool@tuxfamily.org>
	<20130903071026.29838.52710.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Philip Oakley <philipoakley@iee.org>,
	Thomas Rast <trast@inf.ethz.ch>, Johannes Sixt <j6t@kdbg.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Wed Sep 04 22:45:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VHJwx-0006oJ-Ea
	for gcvg-git-2@plane.gmane.org; Wed, 04 Sep 2013 22:45:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756214Ab3IDUpJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Sep 2013 16:45:09 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53071 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754298Ab3IDUpI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Sep 2013 16:45:08 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4E1383E84D;
	Wed,  4 Sep 2013 20:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gGovEz+rDSwv9GWa7ZUDYWTeQNA=; b=aqvNNx
	zCuPUVgt3M9U60S/6AUHqL9i6gNIaWDjq1MmbdxMbUk37yA2kqqXc4zuCGtrxJ+X
	ewUDx7nkGCGE9vWD9k3mPcsGQt/lX9qIT2+dQsu6hS5dY6m0q99RbFsocUGuu73x
	6ssp4pRcv6AS0r8wH0B4FEA9fr9vnsLsIURnY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XUPJVJGK9Qc9dsQV+ZrBYwuVZxcOkrck
	0OcEZluE+qLgzezBrQqYaMtEBdS7VktON5sqF8SatVjyJIDhRvegiE0mNEC9eSwG
	bwJRD57thFHwEVAjhlsa/CXByP2hDRZJ/wAe7PQYdXJk8i9l40niimAWosKm/VZc
	hy1lJYsGGwc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 39B0A3E84C;
	Wed,  4 Sep 2013 20:45:07 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B72993E831;
	Wed,  4 Sep 2013 20:45:05 +0000 (UTC)
In-Reply-To: <20130903071026.29838.52710.chriscool@tuxfamily.org> (Christian
	Couder's message of "Tue, 03 Sep 2013 09:10:21 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: E134C4C4-15A2-11E3-A597-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233873>

Christian Couder <chriscool@tuxfamily.org> writes:

> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
>  Documentation/git-replace.txt | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/git-replace.txt b/Documentation/git-replace.txt
> index 736b48c..a2bd2ee 100644
> --- a/Documentation/git-replace.txt
> +++ b/Documentation/git-replace.txt
> @@ -21,10 +21,12 @@ replaced. The content of the 'replace' reference is the SHA-1 of the
>  replacement object.
>  
>  The replaced object and the replacement object must be of the same type.
> -There is no other restriction on them.
> +This restriction can be bypassed using `-f`.
>  
>  Unless `-f` is given, the 'replace' reference must not yet exist.
>  
> +There is no other restriction on the replaced and replacement objects.
> +
>  Replacement references will be used by default by all Git commands
>  except those doing reachability traversal (prune, pack transfer and
>  fsck).

And this should be in the same patch as the one that makes the code
change.
