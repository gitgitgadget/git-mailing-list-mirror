From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] diff: don't retrieve binary blobs for diffstat
Date: Mon, 21 Feb 2011 15:33:05 -0800
Message-ID: <7v62sdhsjy.fsf@alter.siamese.dyndns.org>
References: <20110219080307.GA18039@sigill.intra.peff.net>
 <20110219081631.GB18056@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 22 00:33:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PrfFs-0002YV-9N
	for gcvg-git-2@lo.gmane.org; Tue, 22 Feb 2011 00:33:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751429Ab1BUXdT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Feb 2011 18:33:19 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:49918 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751015Ab1BUXdS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Feb 2011 18:33:18 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 855573FC2;
	Mon, 21 Feb 2011 18:34:29 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=zSWnszaWGFl/QrTA2uUkeItTNcg=; b=yEGNbJ5/fEHdZmIxJxRRiJA
	PqVmUN3la56HJ0BiGTVK0WX+a2AOsNOTVI+beOX1LYnp1bmNS9XgapUf3sWnwn1d
	Z9BDOY3Y+1zpPO5NLhjrqvDd6LddEgZvh2xKSJEDZI2jofhi3L1OmEB1PYiqODdL
	fMo2/jom3s0WWUZLhkNY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=FhPAIoLW/3Se8Wu1jTCfoJtShEJoB7HNpyMxl5fYTpKEyvVW0
	P4tBSB97pIZIctLyoj4CJ2aGcZYQSQZ6B7bERguHZ0E740zG9xcOAtiS6Of7CKcv
	cVhKLeOmhzFVd8w9qL5vEZvFb489faTTHQv0OT/NhDHqExAxGObxHeAIBA=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 44ABA3FC0;
	Mon, 21 Feb 2011 18:34:25 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 064BF3FB9; Mon, 21 Feb 2011
 18:34:17 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 1E28EB90-3E13-11E0-8A72-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167511>

Jeff King <peff@peff.net> writes:

> We only need the size, which is much cheaper to get,
> especially if it is a big binary file.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---

Nice ;-)  Do we want a test or two for 1/2 by the way?
