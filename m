From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] branch: add optional parameter to -r to specify
 remote
Date: Mon, 20 Jun 2011 08:42:32 -0700
Message-ID: <7v1uyoecgn.fsf@alter.siamese.dyndns.org>
References: <1308511149-10933-1-git-send-email-billiob@gmail.com>
 <1308511149-10933-2-git-send-email-billiob@gmail.com>
 <7vtyble9k8.fsf@alter.siamese.dyndns.org> <4DFEEB60.5000005@viscovery.net>
 <20110620070316.GA15246@sigill.intra.peff.net>
 <4DFF2A1D.3060206@drmicha.warpmail.net>
 <20110620130945.GA19011@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Boris Faure <billiob@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jun 20 17:42:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QYgcZ-0006PT-Tz
	for gcvg-git-2@lo.gmane.org; Mon, 20 Jun 2011 17:42:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751747Ab1FTPmf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Jun 2011 11:42:35 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:36847 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751317Ab1FTPme (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jun 2011 11:42:34 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 673975424;
	Mon, 20 Jun 2011 11:44:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jcllaQlxoWrMDKDvF97g0+6C9ho=; b=tCoBXr
	sPAUn5a4B55m0qNGvz6tKwd257cUPAQQTvNbKa0wX4fABTPf5VAKzFy1ucow29zX
	JIoBIr//ymZKwfnxPKCPkef1fhD2QyBxh4/sTXFhAmicZpyMM9sB9wttC3qCJV/a
	0yWyreashOAE5bs+GCDM0yqx1qv/92Nvn1rfs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DItgZwYcwdJ4IH+7zgY1MQMO2Dg7VTEK
	ic0XP3sVuoQDoFht6wlq9LceJZQd0JBukwLHBVn0YinEDEqs+NPzDrnzC8nhY4lU
	U16ZwU0jAHjY1vfc/gNUHtOAxFwcDmkLsUHdIqjnrJMGsqQvHilnsCAa9KzjEt13
	lkfSV7G7pzg=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 4D82F5422;
	Mon, 20 Jun 2011 11:44:45 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 8727B5421; Mon, 20 Jun 2011
 11:44:44 -0400 (EDT)
In-Reply-To: <20110620130945.GA19011@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 20 Jun 2011 09:09:45 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3852C6E6-9B54-11E0-B004-5875C023C68D-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176073>

Jeff King <peff@peff.net> writes:

> ? For "tag -l", we seem to silently ignore any arguments past the first:
>
>   $ git tag -l 'v1.7.4.*' 'v1.7.5.*'
>   v1.7.4.1
>   v1.7.4.2
>   v1.7.4.3
>   v1.7.4.4
>   v1.7.4.5
>
> We should at least warn and say "your second argument is being ignored"
> or show the usage message.

I think it is just a bug; no need for "being ignored" warning.

> But perhaps it is even friendlier to accept
> a list of patterns.

Yes indeed; please make it so ;-)
