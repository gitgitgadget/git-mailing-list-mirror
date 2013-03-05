From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] push: --follow-tag
Date: Tue, 05 Mar 2013 10:15:20 -0800
Message-ID: <7vobexu30n.fsf@alter.siamese.dyndns.org>
References: <7vd2vewu24.fsf@alter.siamese.dyndns.org>
 <7v6216wtrk.fsf@alter.siamese.dyndns.org>
 <20130305082204.GB13552@sigill.intra.peff.net>
 <7vlia1vnwq.fsf@alter.siamese.dyndns.org>
 <20130305172233.GA9379@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 05 19:15:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UCwP0-0005lo-21
	for gcvg-git-2@plane.gmane.org; Tue, 05 Mar 2013 19:15:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757964Ab3CESPY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Mar 2013 13:15:24 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44904 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756303Ab3CESPX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Mar 2013 13:15:23 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B4839B492;
	Tue,  5 Mar 2013 13:15:22 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vwuOT1WL0nvDrTvA66toljozjvk=; b=vB+ZUB
	03KMP12vPwCuUgnzXcR6ESNyOESZg9J/aOJ0yMkfIpYWwnCZEUeKxWe9ZWMNeq/5
	oMbQXnkiSVilQthxC+GV93IcOCKjcAL4RE20Tl8jBBtlf7/IRquURf8IOKWBbta/
	JOpwIEnQWpbuQApHVgT85jFG7zENV2W65ongw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XxcHZ5DZETEOI7xdzdjdXLRH1v4sdNxz
	ntsVF55hugblpXZpVppC5w0RwJUQYfT8ZegzJyfRwLrcueje4uSg5pyJn6FD9tUD
	6plaSOBROv3Qqy+EunnEfVDQfCCnD/X0ialiideXwlT3lqg0hQDeueG1YTSzZnoG
	t0myfz1lFJc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A97BEB491;
	Tue,  5 Mar 2013 13:15:22 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 217CCB48E; Tue,  5 Mar 2013
 13:15:22 -0500 (EST)
In-Reply-To: <20130305172233.GA9379@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 5 Mar 2013 12:22:33 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A4E85C50-85C0-11E2-A2A9-70782E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217470>

Jeff King <peff@peff.net> writes:

> But I wonder if fetching and pushing are different in that respect. You
> are (usually) fetching from a public publishing point, and it is assumed
> that whatever is there is useful for sharing. The only reason to limit
> it is to save time transferring objects the user does not want.

There are those who have to emulate "git fetch" with a reverse "git
push" (or vice versa) due to network connection limitations, so I do
not think hardcoding such a policy decision in the direction is
necessarily a good idea.

> ... But I also don't want to introduce a feature
> that causes people to accidentally publish cruft. It may not be a
> problem in practice; I'm just thinking out loud at this point.

Likewise.
