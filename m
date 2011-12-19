From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] push: --ignore-stale option
Date: Sun, 18 Dec 2011 21:33:46 -0800
Message-ID: <7vliq9nn0l.fsf@alter.siamese.dyndns.org>
References: <7vobvct58u.fsf@alter.siamese.dyndns.org>
 <20111215073816.GD1327@sigill.intra.peff.net>
 <7vmxatofvr.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 19 06:34:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RcVrS-0005TJ-E2
	for gcvg-git-2@lo.gmane.org; Mon, 19 Dec 2011 06:34:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751063Ab1LSFdu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Dec 2011 00:33:50 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58316 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750734Ab1LSFdt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Dec 2011 00:33:49 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BAB0D6BF3;
	Mon, 19 Dec 2011 00:33:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2EyQf1ImjJtKnQwfb0kQjojMCyU=; b=QgZdkK
	WrwHw9iEpylAWgdaLFv0ZorTnG8vN+l1suJioR4Gvc6v+YBxlKjppDdUCADP+6fo
	ESs2RI1ymNDsE/PoVRkkJEs0fNdoHKPWAdEFCb33vk+A794ByejMdlxhM1e9wIJw
	9z0ftrLeeJ9XES5DUTbdlSkhkuf2N/MYm+FPE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BDVlLLIfB04RANZRs6nCGOdsavlpUxd6
	iVO0Q+Z7RsYFgx7flh3I6/ELIvxr6Q0HjOOy9WI9Q7393MUltBd1tH5v98YheU63
	gPAYMwJSL/UpjnMcAMheAUk0YTu295PUFISvpOArbwFBOaAAB8vY0fwp96mk+vxW
	zQo75tVEMoM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B13C06BF2;
	Mon, 19 Dec 2011 00:33:48 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 44F3D6BF1; Mon, 19 Dec 2011
 00:33:48 -0500 (EST)
In-Reply-To: <7vmxatofvr.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu, 15 Dec 2011 10:21:12 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 06AA7BAA-2A03-11E1-84BB-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187435>

Junio C Hamano <gitster@pobox.com> writes:

> Jeff King <peff@peff.net> writes:
>
>> But I still see this as solving the wrong problem, and encouraging a
>> dangerous workflow.
>
> Yes, that is what I meant, so we are in total agreement that these people
> should be encouraged not to use the matching semantics.
>
> How that encouragement is made we may differ, though.

So here is my idea of how best to implement such an encouragement.

The first patch is a documentation update/clean-up to prepare for the main
one which is the second.
