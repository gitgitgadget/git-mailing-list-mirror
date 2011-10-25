From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git Bug - diff in commit message.
Date: Tue, 25 Oct 2011 07:11:33 -0700
Message-ID: <7vr52140ve.fsf@alter.siamese.dyndns.org>
References: <1315493353942-6772145.post@n2.nabble.com>
 <CAMOZ1BtbpbG+19G6Hfau_2_F5L3Ad+x-Payd9aKajJxU_V_tyA@mail.gmail.com>
 <7vpqj9vh87.fsf@alter.siamese.dyndns.org>
 <7v62jvdthi.fsf@alter.siamese.dyndns.org>
 <CAOeW2eG_muSdbWUaPG36=1-Ay6h6-4qHgWPNdjqY5Zpb52XisQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Michael Witten <mfwitten@gmail.com>,
	anikey <arty.anikey@gmail.com>
To: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 25 16:11:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RIhjB-0001wr-F8
	for gcvg-git-2@lo.gmane.org; Tue, 25 Oct 2011 16:11:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933604Ab1JYOLg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Oct 2011 10:11:36 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35025 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756241Ab1JYOLg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Oct 2011 10:11:36 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BA04B4D5B;
	Tue, 25 Oct 2011 10:11:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WhcQpnN3tXu9INeofxv+OFqiggs=; b=ENji9B
	uBBGhKplPo64sAmNSBdzCOSX10LapLQUdeEss/FSPeYIk0gfuA8dnZnl5xSZjBwz
	kmi25cpV8OeVL3xTrCNrJLD6GsPSeQhLGk1UfNBYlNt5iHdF1indYiVDVaQ0RG/7
	iRJbEY7axR8zUrV9z5It/4wD1k5h6yJwWR16U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hchA93Gme1zVu2ujcPUCwV/DVpaVSQTT
	wBeBg+Zlna2KzhlWlYsH+T+eSCbg+dV7SmmSz5hK4I6c38RoFbjoWA57RBwXs6a6
	WFj0NbbazPqMs4wyFf37Dyul7Ao+ab5BlOXB3GmHcpm/jcO9gC9fMx8QczPVS5L7
	iBUr/Ku47j0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B243A4D5A;
	Tue, 25 Oct 2011 10:11:35 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2BC694D59; Tue, 25 Oct 2011
 10:11:35 -0400 (EDT)
In-Reply-To: <CAOeW2eG_muSdbWUaPG36=1-Ay6h6-4qHgWPNdjqY5Zpb52XisQ@mail.gmail.com> (Martin
 von Zweigbergk's message of "Mon, 24 Oct 2011 16:24:15 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3F428ACC-FF13-11E0-9838-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184207>

Martin von Zweigbergk <martin.von.zweigbergk@gmail.com> writes:

>> And here is a quick hack to do that using "log --cherry-pick --right-only".
>
> Thanks. I had done something similar. I have now adopted most of your
> changes into my patches, but  I have a few questions.

It was a quick hack and not necessarily well thought out.

> Are these braces needed?

Probably not.

> In your previous mail in this thread, this was
> ...
> I see why you dropped "-m --first-parent"; we should simply never
> receive such patches to "git-am --rebasing". But why isn't --binary
> necessary?

It may be; I somehow thought we made it a no-op but didn't check.

> Why was this part left out?

No particular reason other than I was not looking at the earlier "how
about this" patch closely. It may be needed, it may not be, I dunno, and I
didn't check when I wrote this second quick hack.

Thanks.
