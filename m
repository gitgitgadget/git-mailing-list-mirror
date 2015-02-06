From: Junio C Hamano <gitster@pobox.com>
Subject: Re: BUG: 'error: invalid key: pager.show_ref' on 'git show_ref'
Date: Fri, 06 Feb 2015 12:14:35 -0800
Message-ID: <xmqq386ihk5w.fsf@gitster.dls.corp.google.com>
References: <20150206124528.GA18859@inner.h.apk.li>
	<20150206193313.GA4220@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Andreas Krey <a.krey@gmx.de>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Feb 06 21:14:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YJpIY-0005h8-Au
	for gcvg-git-2@plane.gmane.org; Fri, 06 Feb 2015 21:14:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755451AbbBFUOi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Feb 2015 15:14:38 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:60857 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752419AbbBFUOh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Feb 2015 15:14:37 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id EACEB3522A;
	Fri,  6 Feb 2015 15:14:36 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=dG53gn98phekjl5V5fnjGK3yJpo=; b=WXm2AD
	Sa5KDEGkURCJwUYVRTAt/oR77J/xJipkcsumRLq+weHuh1jal5ZymjJN2AZWalS3
	+vwA2M9hNdl9IsNJUNX+s5VUeFj7eP/PHXSkVFBw85X17gUExOORxRFRDE+Q2Ju9
	GAf5RuirauuijugjmtDcFHghzgfack2fSI+yc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pEu2jjVxBK+nj/Apm4H118w9K8ddln+A
	cdK8Py0wBzF8lnlE+79jRFSgxTVdwMDSro7xQm5kbQSYnQZhCTtILfc2e9VQEwsl
	zggCvrAmtWm3HjbDZbqtX8+BpT0gDkwpaSS1z9SgYeF366Oh0ntdNF+YhNrgZTJd
	7yX3v8IJxZw=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E310335229;
	Fri,  6 Feb 2015 15:14:36 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 63FFE35228;
	Fri,  6 Feb 2015 15:14:36 -0500 (EST)
In-Reply-To: <20150206193313.GA4220@peff.net> (Jeff King's message of "Fri, 6
	Feb 2015 14:33:13 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: C5963C14-AE3C-11E4-B97B-7BA29F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263424>

Jeff King <peff@peff.net> writes:

> This is highlighting the problem with "pager.*" that Junio mentioned
> recently, which is that the keyname has arbitrary data,...

Yes, even if it is not "arbitrary" (imagine we limit ourselves to
the official set of commands we know about), the naming rule for the
"git" subcommand names should not be dictated by the naming rule for
the configuration variables, as they are unrelated.

That is one of the reasons why I had the "unbounded set, including
the ones under our control such as subcommand names" in the draft
update for the guideline.  I dropped that part after the discussion
to keep other "obviously agreed" parts moving, but we may have to
revisit it later.
