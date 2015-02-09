From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] sha1_file.c: make sure open_sha1_file does not open a directory
Date: Mon, 09 Feb 2015 10:48:40 -0800
Message-ID: <xmqqpp9ic453.fsf@gitster.dls.corp.google.com>
References: <b0993cc1fcac290d7506b24942af300@74d39fa044aa309eaea14b9f57fe79c>
	<20150209005444.GA16827@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "Kyle J. McKay" <mackyle@gmail.com>,
	Jonathon Mah <me@jonathonmah.com>,
	Git mailing list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 09 19:48:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YKtO4-0008SV-GY
	for gcvg-git-2@plane.gmane.org; Mon, 09 Feb 2015 19:48:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933727AbbBISso (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Feb 2015 13:48:44 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:62518 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932199AbbBISsn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Feb 2015 13:48:43 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C5C8136DF2;
	Mon,  9 Feb 2015 13:48:42 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=x9NZMrc0YQFdQLSs5EPu7epl7kM=; b=vDLdBR
	9oiEnwyGFNoBfbsQkSGj3u5IQVlNcXG75Oad/unvT4ozGXkQJnmHznthnTxYHGxh
	3tBuZyy1bUNE4ZG8JnFjjA+TfoaR39kqft71BZ8WjCwx48ScfAC2e+jbmPAsHLeP
	FEio/x4B1Brg+Jm5PzxZrHIKDA8ftqtZ0RMSc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RqkaIsYCGs4+jBQfJX5HBM6HTT1Nu1hb
	9ll9DhZJ8OLKOle6A4bsObf6L4aDtBRJDYF8oHMg8NGUmyS53wXGaqclTwaJQEgv
	Ux+a+qSExEE6koTvbNtFyIzjWjXaWuivHJlOPsI5clIVEWsX6p7ZYyyf2R+rSTOI
	CdZixnzHIYs=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id BBB3336DF1;
	Mon,  9 Feb 2015 13:48:42 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2DFD336DF0;
	Mon,  9 Feb 2015 13:48:42 -0500 (EST)
In-Reply-To: <20150209005444.GA16827@peff.net> (Jeff King's message of "Sun, 8
	Feb 2015 19:54:44 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 44AC3836-B08C-11E4-9DB2-7BA29F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263580>

Jeff King <peff@peff.net> writes:

> However, the first thing for_each_loose_file_in_objdir is going to do is
> stick the path into a strbuf. So perhaps the most sensible thing is to
> just teach it to take a strbuf from the caller. I'll work up a patch.
>
> It looks like a1b47246 isn't even in "next" yet, so I'll build it
> directly on what is already in master, dropping Jonathan's patch.

Thanks; looks very sensible.
