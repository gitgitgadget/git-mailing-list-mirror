From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] Hiding some refs in ls-remote
Date: Mon, 21 Jan 2013 15:33:46 -0800
Message-ID: <7v38xuf6w5.fsf@alter.siamese.dyndns.org>
References: <1358555826-11883-1-git-send-email-gitster@pobox.com>
 <20130119165042.GB12307@sigill.intra.peff.net>
 <7vpq0zn2za.fsf@alter.siamese.dyndns.org>
 <7vip6rjyn3.fsf@alter.siamese.dyndns.org>
 <20130121230108.GB17156@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, spearce@spearce.org, mfick@codeaurora.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jan 22 00:34:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TxQsV-0003XW-5U
	for gcvg-git-2@plane.gmane.org; Tue, 22 Jan 2013 00:34:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752678Ab3AUXdu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2013 18:33:50 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36212 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752418Ab3AUXdt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jan 2013 18:33:49 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F0382BB80;
	Mon, 21 Jan 2013 18:33:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=v6bo7hWuRZxzFBLOPP8Q9/T79Wo=; b=bu1o2g
	WnvHzJFchw9V3pGIHwz3BwVBzSHRPSfqGHWzxytNrZ/CiTMuaymdIGNoPDi7HACv
	QdHGU0XEgP3OfwxIPiKZxcSSGaaj4BQyk9ZIWm+2XGlmg2MlZYWmo8FfCH5mK4Ai
	nW2YFMRKTwEl2QA2zLJyVQmt5VYYJ+pNh2lOs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YpvZYUuYQ6re1Ri09bBOE0RMVOXrUQrf
	CXMogTHfQK6fiPBh3y+1+ysb9jj5FNU/nQm2qryB0dLD6z4TixuOIoYGz2VbpQ7b
	84eFSBTKEximUQaDSRYy01bfOIoTbG30X2nxCBN2B/08V0AplCmV62FXQR4nzuTY
	DQgHzNDyTBU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E51DABB7F;
	Mon, 21 Jan 2013 18:33:48 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 63F13BB7E; Mon, 21 Jan 2013
 18:33:48 -0500 (EST)
In-Reply-To: <20130121230108.GB17156@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 21 Jan 2013 18:01:08 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 015F24EC-6423-11E2-B01E-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214176>

Jeff King <peff@peff.net> writes:

>> It may even make sense to have "git push" honor it, excluding them
>> from "git push --mirror" (or "git push --all" if some of the
>> branches are hidden); I haven't thought things through, though.
>
> That is harder, as that is something that happens on the client. How
> does the client learn about the transfer.hiderefs setting on the remote?

No, I was talking about running "git push" from a repository that
has the transfer.hiderefs set, emulating a fetch from a client by
pushing out in the reverse direction.
