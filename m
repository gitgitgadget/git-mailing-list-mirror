From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fsck: print progress
Date: Thu, 03 Nov 2011 13:56:13 -0700
Message-ID: <7vwrbhdixe.fsf@alter.siamese.dyndns.org>
References: <20111103033325.GA10230@sigill.intra.peff.net>
 <1320310234-11243-1-git-send-email-pclouds@gmail.com>
 <20111103193826.GB19483@sigill.intra.peff.net>
 <7vd3d9f0u8.fsf@alter.siamese.dyndns.org>
 <20111103195147.GA21318@sigill.intra.peff.net>
 <7v8vnxeyrp.fsf@alter.siamese.dyndns.org>
 <20111103202954.GC19483@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Nov 03 21:56:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RM4Kk-0006TI-2w
	for gcvg-git-2@lo.gmane.org; Thu, 03 Nov 2011 21:56:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751655Ab1KCU4Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Nov 2011 16:56:16 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46867 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751588Ab1KCU4P (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Nov 2011 16:56:15 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4BEB46552;
	Thu,  3 Nov 2011 16:56:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5uUOl8zGEGkY8Ir5+EvYLrK52W4=; b=Bkbn8O
	LeigW+1sAgWPqfrZgMhPMgyzQ/YER4GFGq49EkPV/OtYy13wyPcbuuEdnjIHqAfP
	NXnZeSwbKBgKeMYK4cjm+U3KPprDZcoHfGYOuBGMbDNh3fVZC0WEMmRxr7jmoCFu
	NShlBkNtWkacc+dg6eszRRtOgE2KBnVlaPwrI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=T5nDyUn6dDw63zT+oj3Ccsom8qXARzzB
	MdvQi0VyD9UcE16bOkKlLVr9fs/H3rS0vqEx1pSCkuZpOKTycyqgESMzokOaeR5C
	0ELfs8BHNEr4HVfa52CaGMvpyGARhdMi6qlPHCeRUPGV+zMUeWkZdnhqpOKFl7wt
	rkU8lyD3R5g=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 43B376551;
	Thu,  3 Nov 2011 16:56:15 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D1F59654F; Thu,  3 Nov 2011
 16:56:14 -0400 (EDT)
In-Reply-To: <20111103202954.GC19483@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 3 Nov 2011 16:29:54 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 44CB8668-065E-11E1-A559-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184747>

Jeff King <peff@peff.net> writes:

> So you would agree that we are better summing the objects for all packs
> and showing one big progress bar?

If it can be done without sacrificing the clarity of the code, compared to
the "we will do new and smaller ones first so in practice it does not
matter" approach taken by the patch in question, I would not mind it, but
to be honest, I do not deeply care either way.
