From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Does anyone use git-notes?
Date: Wed, 25 Aug 2010 15:42:00 -0700
Message-ID: <7vhbiipb5z.fsf@alter.siamese.dyndns.org>
References: <AANLkTin=VXp2BU0vhTLUy6MpJ7spXRs1dZC1wygoN6T-@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>
To: Scott Chacon <schacon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 26 00:42:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OoOfi-0000Gc-1U
	for gcvg-git-2@lo.gmane.org; Thu, 26 Aug 2010 00:42:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754340Ab0HYWmJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Aug 2010 18:42:09 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:64181 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754167Ab0HYWmI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Aug 2010 18:42:08 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 6A45FD08E2;
	Wed, 25 Aug 2010 18:42:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=taFYDGQ/S0Ip7ANwWuzK+3GdCrY=; b=xdqad8
	MS8KB/y+1IHVAxDRbgMMXF6oW7WOxDwyDuhtK6elCoHS5Z9C/pSRyzPui2Xq2a7y
	oOCEy8NbncZwevWk8FH7Yjwq6fLndlsp7avl/KZQm3243MVJb3SL3dugehNE6Nor
	CQMDX78Yd6grKk1wZ/GXYZWKGbt1dYOU7kUmw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EzqFl7tydG7Ia3Q18a066fEef3MInAVY
	MMxI25rWi8sJi4F+cb92vQU4GBh1w3k9B5z/YLKxSjhTH9500fnEqivV+SvaGDRt
	Q/OpgSmLlJH6ErSThbwYJY3kK1xoSR8xgCJMbYe0B4n+XMz0IWWMN4RgaSy4RJqS
	/LbNly5xrEw=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 134BDD08E1;
	Wed, 25 Aug 2010 18:42:05 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DF4B6D08E0; Wed, 25 Aug
 2010 18:42:01 -0400 (EDT)
In-Reply-To: <AANLkTin=VXp2BU0vhTLUy6MpJ7spXRs1dZC1wygoN6T-@mail.gmail.com>
 (Scott Chacon's message of "Wed\, 25 Aug 2010 11\:15\:31 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: FC14E13C-B099-11DF-9D38-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154491>

Scott Chacon <schacon@gmail.com> writes:

> I would like to write a post on how to use them, but I'm a bit
> confused as to how people actually use them on a day to day basis.  I
> appears to me in trying to work out a flow for them that the lack of
> an ability to merge them makes them very difficult to use for anything
> practical.  Can someone share with me how they use them and what the
> cycle is?

I have a custom post-applypatch hook (see my "todo" branch) enabled and
then use the amlook script (again, see my "todo" branch) script to inspect
the corresponding notes tree.

After applying a received patch e-mail, the result is annotated with
enough information to identify which message it came from by the hook.
When I am scouring the mailing list backlog to see if I have missed
something interesting (sometimes I find interest in a topic that I thought
totally uninteresting earlier), the amlook script is used to see if the
patch has been already applied.

Looking through millions of notes this way won't scale (iow, amlook is a
bad example of using this feature, as the notes tree is used as a database
index in the wrong direction), by the way, so you may probably not want to
use it as a good example.
