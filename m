From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 2/2] submodule: pass on http.extraheader config settings
Date: Thu, 28 Apr 2016 12:28:21 -0700
Message-ID: <xmqqwpnh4joq.fsf@gitster.mtv.corp.google.com>
References: <cover.1461837783.git.johannes.schindelin@gmx.de>
	<89d0024450b0e6e9997ad9e3d681248bde1bafc0.1461837783.git.johannes.schindelin@gmx.de>
	<20160428112912.GB11522@sigill.intra.peff.net>
	<alpine.DEB.2.20.1604281405540.2896@virtualbox>
	<20160428134953.GB25364@sigill.intra.peff.net>
	<CA+P7+xq-_D2Mszyjd11CyYLiKBBh9A2e1exaZQVmWz1qVKv7ug@mail.gmail.com>
	<20160428153902.GF31063@sigill.intra.peff.net>
	<CAGZ79kZFLTARQ25h4u4SGgNn=Q4TQi-kxFLN3sQvOmejsRmAWA@mail.gmail.com>
	<20160428165031.GA31421@sigill.intra.peff.net>
	<xmqq1t5p5z8v.fsf@gitster.mtv.corp.google.com>
	<20160428191038.GA10574@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>,
	Jacob Keller <jacob.keller@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git mailing list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 28 21:28:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avrc1-0007nN-E9
	for gcvg-git-2@plane.gmane.org; Thu, 28 Apr 2016 21:28:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752725AbcD1T20 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Apr 2016 15:28:26 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54613 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751865AbcD1T2Z (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2016 15:28:25 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 914071604C;
	Thu, 28 Apr 2016 15:28:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=QsTMSz/5/pAvvuLr+Y6AFPOSYhM=; b=uRmr40
	8UsSOV6VO5IshAImJiEZYe7exj7/2T0SHqqM9EAeheYbSxdAzv9QJt/vgEFy2RNi
	Lyqk7DLiF4zy1dZ+fhrvqhRsxHdNtOW2zI+Ni/Kkm+LGho1Ot6kEbWSvopRiZRCD
	0bX5i4heEUeyIxCWhL+hwf4UxSHIR7IkkvyXM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rrV0kZPtw7SQTB1i5gemyU6SAjPWhJra
	wXTVEBoI1mIbvjr1S2lOdNXBEPqxzVSSFnOZebgsXPURLPn98q/gZirmtrVn1LXJ
	Hp53MtjKcegf4CX4Mrry5D33Jls0/a8ZzBs1aHmKwAu/5qxXySVYms5+MQI6dlYL
	dHZBNJ9lIFE=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 892E21604B;
	Thu, 28 Apr 2016 15:28:23 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D7D281604A;
	Thu, 28 Apr 2016 15:28:22 -0400 (EDT)
In-Reply-To: <20160428191038.GA10574@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 28 Apr 2016 15:10:38 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 5F16D016-0D77-11E6-B9BE-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292939>

Jeff King <peff@peff.net> writes:

> It's definitely sufficient, it's just annoying if a user shows up every
> week and says "I want X.Y", and then somebody else shows up a week later
> and says "I want X.Z".
>
> Are we serving any purpose in vetting each one (and if so, what)?

Personally I do not think we would need to filter _anything_ if we
can tell that the user directly said

	git -c var1=val1 -c var2=val2 $cmd ...

and "git $cmd" ended up needing to spawn another "git" subcommand,
possibly in some other repository (i.e. "$cmd" in this case is
likely to be "submodule", but in principle it does not have to be).
If the user somehow gives variables like core.worktree that are
inappropriate to be applied across repositories, that's user's
problem, i.e. "don't do it then if it hurts".

If we are doing any filtering, however, it is always hard, if not
impossible, to take away what we originally granted, even by
mistake, for any reason, even for correctness or for security, in a
later release.

We probably could sidestep it by introducing an end-user
configurable "whitelist" somewhere.
