From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 07/16] t5304: use test_path_is_* instead of "test -f"
Date: Fri, 03 Oct 2014 15:12:42 -0700
Message-ID: <xmqqwq8gkdk5.fsf@gitster.dls.corp.google.com>
References: <20141003202045.GA15205@peff.net>
	<20141003202512.GG16293@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Oct 04 00:12:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XaB5o-0003W0-5n
	for gcvg-git-2@plane.gmane.org; Sat, 04 Oct 2014 00:12:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757656AbaJCWMr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Oct 2014 18:12:47 -0400
Received: from smtp.pobox.com ([208.72.237.35]:57574 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757652AbaJCWMp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Oct 2014 18:12:45 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D84AB3F58F;
	Fri,  3 Oct 2014 18:12:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vCI2l3Hypina+UsCF8v4aaCLWZc=; b=SmO+5q
	fQ7ZFSuLPo1ufR65sMEpHPfaJavssCFgtBugRAdxalchSv8rvfN9ZSAfQCRqXNej
	oDl10AuPklq8omerUQHkjI+dIl//4+ZN/QKBj9KVy7cNQ8dI3rgwe5Opnxc5T1+6
	uaEjYweoLPw9mOK3WOJ/hz6mKHkWU+QYMn4VU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kTghkh5HH+2kde8s65fbz1+QY38oHpWX
	mr+tr20Met5Wr+37qk2eZFunvHLmecaoCCA+egrI4T0OI6yuJcnlrD/r5+r4VdxG
	DSrmwAaPcI6QGUzGslmL5xulOcdsEWKw7ZXLfqbMXArcT5vq8Xi3KVO+zl7AtAPE
	iILFS0PMr9g=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id CED493F58E;
	Fri,  3 Oct 2014 18:12:44 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 325643F57E;
	Fri,  3 Oct 2014 18:12:44 -0400 (EDT)
In-Reply-To: <20141003202512.GG16293@peff.net> (Jeff King's message of "Fri, 3
	Oct 2014 16:25:13 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 6631F89E-4B4A-11E4-91DC-9E3FC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257873>

Jeff King <peff@peff.net> writes:

> This is slightly more robust (checking "! test -f" would not
> notice a directory of the same name, though that is not
> likely to happen here). It also makes debugging easier, as
> the test script will output a message on failure.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> This patch is totally optional. I did it while debugging t5304 (strange
> how badly prune works when you accidentally invert the mtime check!)
> and figured it might be worth keeping as a cleanup.

Looks sensible; thanks.
