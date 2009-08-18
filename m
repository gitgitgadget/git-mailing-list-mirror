From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] stash: reject stash name starting with a dash.
Date: Tue, 18 Aug 2009 16:55:28 -0700
Message-ID: <7vfxbo3cen.fsf@alter.siamese.dyndns.org>
References: <7vbpmcc1sc.fsf@alter.siamese.dyndns.org>
 <1250631523-10524-1-git-send-email-Matthieu.Moy@imag.fr>
 <1250631523-10524-2-git-send-email-Matthieu.Moy@imag.fr>
 <1250631523-10524-3-git-send-email-Matthieu.Moy@imag.fr>
 <1250631523-10524-4-git-send-email-Matthieu.Moy@imag.fr>
 <20090818233535.GB6304@sigill.intra.peff.net>
 <7vocqc3cuz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Matthieu Moy <Matthieu.Moy@imag.fr>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 19 01:55:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdYWt-0003Dh-CP
	for gcvg-git-2@lo.gmane.org; Wed, 19 Aug 2009 01:55:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751662AbZHRXzh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Aug 2009 19:55:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751231AbZHRXzg
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Aug 2009 19:55:36 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:54601 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750900AbZHRXzg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Aug 2009 19:55:36 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id CD4F1F448;
	Tue, 18 Aug 2009 19:55:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=E/Tpj/LfD9g5VOEjty49zthHgwY=; b=mUq0/p
	BqAAn8CSDd8KtVaGzHUDEkBnDhwo63iLuhNKHAnVk0/ArdExFHsbb0RelrfrKY7T
	ExC8i6O1/aYAjgrPkSP6MLJUZH1gTPoopJm3Jq41AqJZ3rckRtVV4b9zUvDD88em
	xhBh5lStFjx6QcPQKq9vLYXRidQt/x9fWKzmE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LkzlzAT8ViN+DLvDdVhTLvZ59mCshtLz
	qEIuoarX0sdihyFv80Ntgce5fAplLca3FbA6w7Bk/SzpK6C3WG6OsnjL3/lzH0No
	mdM3Y7LQ1vdelN2oBHYcjmB8BO+IttjZL2uKgXvJjQSddSjOocXRJG49CmcgEqLC
	QwC4cq+Mrys=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A09DDF447;
	Tue, 18 Aug 2009 19:55:34 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C6D70F446; Tue, 18 Aug
 2009 19:55:29 -0400 (EDT)
In-Reply-To: <7vocqc3cuz.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Tue\, 18 Aug 2009 16\:45\:40 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 9EC00366-8C52-11DE-90CF-0D381FFB4A78-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126488>

Junio C Hamano <gitster@pobox.com> writes:

> It would be ideal if
>
> 	git stash save --invalid-option
>
> failed, while
>
> 	git stash --invalid-option should be trapped
>
> and/or
>
> 	git stash "--invalid-option should be trapped"
>
> are accepted as valid quickie ways to name a WIP stash before attending to
> an unrelated emergency.

Meh, let me take it back.  I somehow was living in 13 months ago for a
short while when I wrote the above.

9488e87 (git-stash: require "save" to be explicit and update
documentation, 2007-07-01) made the latter two invalid.
