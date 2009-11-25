From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] mailinfo: remove [PATCH...] prefix from Subject
 regardless of length
Date: Tue, 24 Nov 2009 17:10:57 -0800
Message-ID: <7vmy2b76ji.fsf@alter.siamese.dyndns.org>
References: <874ookp4u8.fsf@meyering.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>
To: Jim Meyering <meyering@redhat.com>
X-From: git-owner@vger.kernel.org Wed Nov 25 02:11:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ND6PW-0007xD-46
	for gcvg-git-2@lo.gmane.org; Wed, 25 Nov 2009 02:11:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933875AbZKYBK6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Nov 2009 20:10:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933863AbZKYBK6
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Nov 2009 20:10:58 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:62627 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933823AbZKYBK5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Nov 2009 20:10:57 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 82CC182605;
	Tue, 24 Nov 2009 20:11:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:in-reply-to:date:message-id:mime-version
	:content-type; s=sasl; bh=ljApFwGUVTbm98kjeVxX9ZvxE2I=; b=uwiPrC
	LbhGVB44DyhsJCtdATu14PmnjbUz34RbekMRiKh034xWbMUv7xxgyomjCC3zqB5B
	3DLN4fm/HVbjEY1ET12jZ3tbfbnbJBqGasSd3PQvkmdQ8Gp48vBtFoHZxw+8qzIR
	VP4fxlQFtmq52reRdiMu+YZUvUZ7yjwvbvfJs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:in-reply-to:date:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ImmOt1mmkUoKfORLHVFyu17TGtA5s7Ok
	YBq0UjLizmajJljNxeHw9CvT2F8SoH6V4Zx9ND+VRVSvAczqQV0jR92YvVX2QWec
	RklJYfrG+teQx1UdFCzvhxhAgzn9FDPSJO69CRxXP5g1ESU1hyI/ToFV0+zOnPoZ
	OVufR/ztLqQ=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 60F4182604;
	Tue, 24 Nov 2009 20:11:01 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BDD7082603; Tue, 24 Nov
 2009 20:10:58 -0500 (EST)
In-Reply-To: <874ookp4u8.fsf@meyering.net> (Jim Meyering's message of "Tue\,
 24 Nov 2009 11\:58\:07 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 6560D3FC-D95F-11DE-A7B3-9F3FEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133603>

Jim Meyering <meyering@redhat.com> writes:

> Before this change, a [...] prefix would be removed only as long as
> its length did not exceed 2/3 of the subject length.  Now, when the
> bracketed quantity starts with PATCH, it is removed unconditionally.
> Otherwise, the existing behavior remains unchanged.

Thanks, I think this is a good idea in general, but have two comments.

 - I am not sure how this should play with 17635fc (mailinfo: -b option
   keeps [bracketed] strings that is not a [PATCH] marker, 2009-07-15).

 - Regardless of interaction with 17635fc, Things like [RFC PATCH]
   [SECURITY PATCH] might want a similar treatment.
