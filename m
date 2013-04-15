From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] clone: introduce clone.submoduleGitDir to relocate
 $GITDIR
Date: Mon, 15 Apr 2013 13:56:05 -0700
Message-ID: <7v8v4jqzru.fsf@alter.siamese.dyndns.org>
References: <1365881007-25731-1-git-send-email-artagnon@gmail.com>
 <7vy5ck4m6b.fsf@alter.siamese.dyndns.org>
 <CALkWK0mvtRhFc0_4883ATNaYpb+kDwpV9VxeAoqJy5HxNQ6vgg@mail.gmail.com>
 <516C21CF.5080705@xiplink.com> <7vvc7nu1hu.fsf@alter.siamese.dyndns.org>
 <516C4A52.1080908@xiplink.com> <7va9ozsk60.fsf@alter.siamese.dyndns.org>
 <516C63DA.4080209@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junio@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>, Duy Nguyen <pclouds@gmail.com>,
	Jeff King <peff@peff.net>
To: Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Mon Apr 15 22:56:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URqRj-0007mn-7X
	for gcvg-git-2@plane.gmane.org; Mon, 15 Apr 2013 22:56:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933639Ab3DOU4J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Apr 2013 16:56:09 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47251 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752971Ab3DOU4H (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Apr 2013 16:56:07 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4209715F9D;
	Mon, 15 Apr 2013 20:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=AHLyIsE05ZXRlaIifOlpxaZieGg=; b=lpvVqw
	wnR6Bbqr/2Af4pABww2cPjYuJsidVhr2qt7wg1k1+KJUj80OIMHVjA9mr6LjDjkV
	z7iRFapyg7Qg+Pf6DWaA4c0NoCmedC9AIUWznrPRm+l5j78qnchXHn1TMu56M3NQ
	JdGXjJA/moSVPh8JCbW7kj+spdo9xV4M2GEKQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Rry/2yqbfW0raPALV2CMBE8D91IuKsVz
	i9mUuYL1XW8zpbe9Zm+J85qQLFFMV0cKi+A7PyyBlIeT9ecp9fW898OXwIG2UiEl
	2pIKgQSeyiOpyQVXmkfv0zeNfrHJfFrOmqzeWd4IFGmVHkYcFudC9H/P0UulV66o
	A7Idmgb1IRs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 34CA815F9C;
	Mon, 15 Apr 2013 20:56:07 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B150B15F97; Mon, 15 Apr
 2013 20:56:06 +0000 (UTC)
In-Reply-To: <516C63DA.4080209@xiplink.com> (Marc Branchaud's message of
 "Mon, 15 Apr 2013 16:32:26 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E47825B2-A60E-11E2-92F5-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221315>

Marc Branchaud <marcnarc@xiplink.com> writes:

> So it looks like the proposed change to git-clone provides no benefit to the
> submodule-adding machinery, which still needs to know when and how to
> relocate .git directories.
>
> Ram, assuming Junio's explanations match your intentions, if the whole

That is a huge assumption, given that I have a proven track record
of guessing Ram's intention wrong ;-).

> motivation for this change is "to make 'git add' DTRT wrt submodules, and
> deprecate 'git submodule add'" then I don't think it's bringing you any
> closer to that goal.
