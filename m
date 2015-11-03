From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/4] diff-highlight: add `less -r` to cmd in README
Date: Tue, 03 Nov 2015 13:51:54 -0800
Message-ID: <xmqqwptybvk5.fsf@gitster.mtv.corp.google.com>
References: <1446516334-27652-1-git-send-email-jonathan.lebon@gmail.com>
	<1446516334-27652-2-git-send-email-jonathan.lebon@gmail.com>
	<20151103211435.GA22484@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jonathan Lebon <jonathan.lebon@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Nov 03 22:52:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZtjUo-0005Zi-7p
	for gcvg-git-2@plane.gmane.org; Tue, 03 Nov 2015 22:52:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755391AbbKCVv6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Nov 2015 16:51:58 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:54705 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754871AbbKCVv5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Nov 2015 16:51:57 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 85F1A2679D;
	Tue,  3 Nov 2015 16:51:56 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=iobOjS6xaikEXoJfAndPti4wEvE=; b=WUVcVX
	9JicJKVJLByu4AmMUgmN2ihRMaET9pBTBl4h1zw19O2vogCi+8wyTZ+ALCTuQFMy
	Hn+HXv8Cw9yVcZWCsRdVLo3FkPvwuHxDw8ewLaY7y6qG96+R2kwRjVZ57Uwouhx7
	KCwfdBYAZtYAUgciEIHaQGUQZxGCgTs6KW5gA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CFyyhHhPv2pBtJiMw4UisZd2dM7v3eGh
	AphGvfeSQW9CtKjjvNCHYPvNW717FXfJRRynI3MWBCjFOm8bXlK2dqS5YTqp0BzY
	GO73AOB3aMHFwpcV9HVf29esYZ6HDxHo2GOEEt9B8Puvessu5nMb+Q0mnlXdCjrm
	DUOy2gXpeQY=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7B2AD2679C;
	Tue,  3 Nov 2015 16:51:56 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id EB6312679A;
	Tue,  3 Nov 2015 16:51:55 -0500 (EST)
In-Reply-To: <20151103211435.GA22484@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 3 Nov 2015 16:14:36 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 19C4D838-8275-11E5-95DF-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280824>

Jeff King <peff@peff.net> writes:

> I agree with Junio that "-R" is a more sensible default, but I don't
> think that should be necessary. We already set LESS when running the
> pager (and if you are overriding it, you are already in trouble, because
> git itself will generate ANSI codes by default).

I do not quite understand this part.  Inside git itself when we
spawn the pager we export LESS with a sensible default, exactly to
help users who do not have LESS set and exported.  This one however
is not spawned by git but the end-user piping output of diff-hilite.

I agree that if the user has LESS exported without -R that would not
be pretty while viewing coloured output.
