From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] octopus: remove dead code
Date: Fri, 11 Dec 2009 17:01:18 -0800
Message-ID: <7viqcdxaxt.fsf@alter.siamese.dyndns.org>
References: <87zl5p1gsp.fsf@jondo.cante.net>
 <1260578339-30750-3-git-send-email-bebarino@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 12 02:02:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NJGN4-0006D2-Hc
	for gcvg-git-2@lo.gmane.org; Sat, 12 Dec 2009 02:02:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763084AbZLLBBy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Dec 2009 20:01:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763066AbZLLBBw
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Dec 2009 20:01:52 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:60024 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934416AbZLLBBW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Dec 2009 20:01:22 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id BDE7F87264;
	Fri, 11 Dec 2009 20:01:25 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=n2Ug0LfSWtGiwonWdC6QTBCIvI0=; b=i0yWSp
	QsaQcPUDVyGnfocn/HbNPbC+AH4NkGnVTHkQ6a5RiGrQ5DcOuktgPGexFQ6HLze/
	hM9aM8Fzg1mgeSs2UCEhW5eJYlGtIQNadyLCpbJhDUkpBMqMhi+Dnak2Yg+AOMXy
	Lx6OAZoNGivOK/KsuA/A07Ne9DfG45em5T3eM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WZYz9cwxJJtwMyxae8moEhJHKwvNQzcY
	kyo++WgodWLtW4JA+HvkEDu8xun/upYnYqnXW59/VRl/xkDnpfuTmrKjPq5gusi4
	AeV49ObGY82hdxt7QqE3EDVm3967GsqmGSFRNUbUOoGCngnTpsoZmiynuhYgtXXB
	f/pRxydZtFc=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 977EB87263;
	Fri, 11 Dec 2009 20:01:23 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D980487261; Fri, 11 Dec
 2009 20:01:19 -0500 (EST)
In-Reply-To: <1260578339-30750-3-git-send-email-bebarino@gmail.com> (Stephen
 Boyd's message of "Fri\, 11 Dec 2009 16\:38\:59 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: DE0543BC-E6B9-11DE-B653-DC0DEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stephen Boyd <bebarino@gmail.com> writes:

> MSG, PARENT, and CNT are never used, just assigned to.
>
> Signed-off-by: Stephen Boyd <bebarino@gmail.com>
> ---
>
> I don't know if this is wanted. Looks like maybe they're used
> as simple debug aides?

No, thanks for spotting.  It is the right thing to do to just get rid of
them.

IIRC, they are remnants of ancient logic of the script, even before
91063bb (Multi-backend merge driver., 2005-09-08) that added it to the
official git history, and were used to update MRC and to come up with the
end result (experimental versions of the script used to run "commit-tree"
itself).
