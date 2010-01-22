From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Remove diff machinery dependency from read-cache
Date: Thu, 21 Jan 2010 17:01:52 -0800
Message-ID: <7v3a1zhrzz.fsf@alter.siamese.dyndns.org>
References: <alpine.LFD.2.00.1001211119130.13231@localhost.localdomain>
 <7vljfrp6g2.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.1001211215080.13231@localhost.localdomain>
 <alpine.LFD.2.00.1001211355500.13231@localhost.localdomain>
 <alpine.LFD.2.00.1001211515470.13231@localhost.localdomain>
 <7v636vj7c2.fsf@alter.siamese.dyndns.org>
 <alpine.DEB.1.00.1001220158381.4985@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jan 22 02:02:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NY7ug-0006Sb-PQ
	for gcvg-git-2@lo.gmane.org; Fri, 22 Jan 2010 02:02:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752790Ab0AVBCL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Jan 2010 20:02:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752357Ab0AVBCK
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Jan 2010 20:02:10 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:40750 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751524Ab0AVBCF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jan 2010 20:02:05 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 6D20B93821;
	Thu, 21 Jan 2010 20:02:04 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=NHsfAMSH8y5xTLpsu7y9CpIve6c=; b=SmAvrz
	fEyfULdox8RgK6EzibbIaMCOdGFVn3hWR+Mvq/2HRE8OKqvFebm7HCe8nf/V1ilk
	CcQb/E43SCdtP0TLIsHuJNY3a2qwHADnEVrdDDUNPa095ldwgcUkMx5TPqFykcZx
	IB2tdujSEwribgbbAmbS958YC2KXhOp4v0TDE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DGKZaXw2r2/yRhgvFtCObpjflFnsxGPw
	QKnwQdVLcydfnk83/YCJEFPDBw1qDcOv7mmntodTO7B4rpDRoP0a7EzwyTFxTMnr
	0QFQacM2gN+s3wYaTrnjgy7jKHaKNPdxbqP5zyU+UMUvXn/v3wVdcxM6rwSlVEWb
	5pfKItmHdew=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 27C7893820;
	Thu, 21 Jan 2010 20:02:00 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 243589381F; Thu, 21 Jan
 2010 20:01:54 -0500 (EST)
In-Reply-To: <alpine.DEB.1.00.1001220158381.4985@pacific.mpi-cbg.de>
 (Johannes Schindelin's message of "Fri\, 22 Jan 2010 01\:59\:14 +0100
 \(CET\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: BEBCF9F2-06F1-11DF-8359-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137712>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Thu, 21 Jan 2010, Junio C Hamano wrote:
>
>> By the way, do you think anybody still uses "git merge-trees"?
>
> IMO this is the only viable way to a non-broken merge-recursive.  Removing 
> it would be counterproductive.

Do you mean you don't think

    Subject: Re: git-merge segfault in 1.6.6 and master
    Date: Thu, 21 Jan 2010 16:38:56 -0800
    Message-ID: <7vaaw7j7mn.fsf@alter.siamese.dyndns.org>

    ...
    In the meantime, I think applying this patch is the right thing to do.

    -- >8 --
    Subject: merge-recursive: do not return NULL only to cause segfault

would help us?
