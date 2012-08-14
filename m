From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rev-list docs: clarify --topo-order description
Date: Tue, 14 Aug 2012 07:54:27 -0700
Message-ID: <7vmx1x8qxo.fsf@alter.siamese.dyndns.org>
References: <7vsjbqbfhm.fsf@alter.siamese.dyndns.org>
 <CAOeW2eGoNvgpbQ9iM0xHpSD1Z4XyC-J8VNVW0bVw3p9qOeijjg@mail.gmail.com>
 <7vobmebdfc.fsf@alter.siamese.dyndns.org>
 <CAOeW2eE63JQbo+x7ZTDupt=auvo2_4Df790TPOtTEynCBK6z5g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 14 16:54:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T1IVx-0001Li-Mn
	for gcvg-git-2@plane.gmane.org; Tue, 14 Aug 2012 16:54:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756234Ab2HNOyb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Aug 2012 10:54:31 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60919 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753191Ab2HNOya (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Aug 2012 10:54:30 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4190975E1;
	Tue, 14 Aug 2012 10:54:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3V4ey3MLpTrDtoCJa38tH7c54sg=; b=rXKYEh
	tk33UMNZcvvJV1oomyMGQxI5p0BXsogMCuEFT0RHCTtmtpzwotI5qXFXZ2d+TBu8
	kLRB/y+5p6aKasPTYP7LR5ySmP12JMs4qbW0hYYsz7pE6RCoXuC8FQ9cp/BtpEcK
	vt559YMYbkCTaTjj4qNVDsTjsQdDCClzH9OEs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=U6RjptW0B/dLtQCRt1KElvYVhdXZQu7D
	egJwPPOaAV1z19wIgnFyv5d+1wvH4hKJdWElCX94J8fVPr3Z2uFC4nqpJcJZSPxH
	kJRhVPCN+AW8DQkuaZZPMORmxSiZDMNrnW7Fb1yE7E68WkpUP6XYY45wCQpDSvad
	nS5Pd7//KBk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2CB8675E0;
	Tue, 14 Aug 2012 10:54:30 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8AE8175DF; Tue, 14 Aug 2012
 10:54:29 -0400 (EDT)
In-Reply-To: <CAOeW2eE63JQbo+x7ZTDupt=auvo2_4Df790TPOtTEynCBK6z5g@mail.gmail.com> (Martin
 von Zweigbergk's message of "Mon, 13 Aug 2012 22:33:22 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F32934A2-E61F-11E1-AD1B-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203402>

Martin von Zweigbergk <martin.von.zweigbergk@gmail.com> writes:

> Still, the "Even without this option" strongly suggests to me that
> what follows ("descendant commits are shown before parents") applies
> to the "By default" case. Would it be correct to say something like
> "By default, the commits are shown in reverse chronological order.
> When commit limiting is in effect, descendant commits are shown before
> parents."?

I wonder if spelling out that level of detail is unnecessarily
overspecifying the behaviour.

In general, I'd prefer to keep the insn to end users to the minimum:
i.e. use the default when you do not care too deeply about the order
but you want to get commits in the range in reverse time order in
general and let the default take care of the detail, and use one of
the --foo-order options if a script wants to be more specific about
the order.  That way we do not have to get our hands tied to an
unnecessary degree and keep the door open for us to improve the
implementation.
