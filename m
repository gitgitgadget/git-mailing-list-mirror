From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] archive: let remote clients get reachable commits
Date: Fri, 22 Feb 2013 10:06:56 -0800
Message-ID: <7vfw0odxz3.fsf@alter.siamese.dyndns.org>
References: <1361456643-51851-1-git-send-email-gurugray@yandex.ru>
 <20130221155208.GA19943@sigill.intra.peff.net>
 <995301361532360@web22h.yandex.ru> <7vehg8s295.fsf@alter.siamese.dyndns.org>
 <20130222172710.GB17475@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sergey Sergeev <gurugray@yandex.ru>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Feb 22 19:07:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U8x1v-0000dF-Ij
	for gcvg-git-2@plane.gmane.org; Fri, 22 Feb 2013 19:07:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758929Ab3BVSHD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Feb 2013 13:07:03 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37275 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757466Ab3BVSG7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Feb 2013 13:06:59 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6AB18A8E0;
	Fri, 22 Feb 2013 13:06:58 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=13jSjl48pjXNXc9Nwtfu/hztaWs=; b=YMcCKH
	yktonUPSSs5UWmhI5O68OIOf27UW/P+oEw6ERY0R+V4S+sUo/JUrhx/H+aF2wk02
	Yf6aEz3gig6nUXtXCfw1odnIVZeMRQStEcUbWy3hQ1UYu6BjXQd9BoF0CZ1fO58S
	FBWKd/rR4qdaJSgzAyJM+A1FB5tNJwhi8W/24=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dKvqfm/oFFLbET4z4Z63qB/g9nmLyApk
	oTmnSwLYTbRUY9MW7Q+fO/CbCc/1OSkqoRdSABsPY/uVDZvAL80KyUYtTYI1JlqX
	puSibqU3BYn7bhvX44mpOR+2h0F3aqXWJb3QG+/fr7Abk0RBuLuVAMtQHukyAgXq
	Kql6lzwSNwY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5F8FDA8DF;
	Fri, 22 Feb 2013 13:06:58 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D39C3A8DE; Fri, 22 Feb 2013
 13:06:57 -0500 (EST)
In-Reply-To: <20130222172710.GB17475@sigill.intra.peff.net> (Jeff King's
 message of "Fri, 22 Feb 2013 12:27:10 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A5CBA64E-7D1A-11E2-A46D-27D12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216848>

Jeff King <peff@peff.net> writes:

> How are you proposing to verify master~12 in that example? Because
> during parsing, it starts with "master", and we remember that?

By not cheating (i.e. using get_sha1()), but making sure you can
parse "master" and the adornment on it "~12" is something sane.

That is why I said "this is harder than one would naively think, but
limiting will make it significantly easier".  I didn't say that it
would become "trivial", did I?
