From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] docs: give more hints about how "add -e" works
Date: Fri, 22 Oct 2010 14:54:31 -0700
Message-ID: <7v8w1plwq0.fsf@alter.siamese.dyndns.org>
References: <20101021143034.GA16083@sigill.intra.peff.net>
 <7v4ocftbww.fsf@alter.siamese.dyndns.org>
 <20101022192529.GA13059@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Miklos Vajna <vmiklos@frugalware.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Oct 22 23:54:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9PZY-0007Q8-2w
	for gcvg-git-2@lo.gmane.org; Fri, 22 Oct 2010 23:54:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752736Ab0JVVym (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Oct 2010 17:54:42 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:63348 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752310Ab0JVVyl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Oct 2010 17:54:41 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 4436BDFFD2;
	Fri, 22 Oct 2010 17:54:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PY4HXbAkyw6LNmTpAULntd9yc+w=; b=GNPCvr
	BZTHUEk9jDriTn7eunsVS6NYHUNXJ3j4QN2y+87RARandf8O8LRoYFh2gLGPn5R9
	A1Q+s1DY51nRQ6EeFWJhhtWX2aEqltKyeXRvMrDt6IA6fPTHI1yt+iJJd5SQNkM/
	b/0PFw3IE3ptSw91hGdOhThBAldsSUF/UZ028=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=f4PzZ7JY3e5JlqhHFhRdg2z3xk7xsP53
	3IphBET0A8wpWBphqSSISlZplLr1jkRAqBnTe6wSNH4JV9ud1o+792tCPgBWXXJy
	G6MY2gc/3YNgjQve2wbikOqWmgdecLte/C+3DwSrvktdfMg4zrGRTI5L5REm/v5T
	jwVF1Fz9MbM=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 108E5DFFCD;
	Fri, 22 Oct 2010 17:54:37 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 351D1DFFCC; Fri, 22 Oct
 2010 17:54:33 -0400 (EDT)
In-Reply-To: <20101022192529.GA13059@sigill.intra.peff.net> (Jeff King's
 message of "Fri\, 22 Oct 2010 15\:25\:29 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: F6844CFC-DE26-11DF-9F2F-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159757>

Jeff King <peff@peff.net> writes:

> Perhaps the list should be structured not as "what you can do to each
> line" but rather "here are some _concepts_ you might see, here's how
> they are represented, and how you might want to edit them". So
> basically:
>
>   - added lines; represented by "+" lines. You can prevent staging any
>     addition lines by deleting them.
>
>   - removed lines; represented by "-" lines. You can prevent staging any
>     removal lines by converting "-" to " ".
>
>   - modified lines; represented by "-" followed by "+". You can prevent
>     staging the modification by converting the "-" to a " ", and
>     removing the "+" lines. And this would be a good place to warn that
>     just deleting half of the pair is going to cause problems.
>
>   - existing lines; represented by " " lines. You can:
>
>       - remove them, by converting " " to "-".
>
>       - modify them, by converting " " to "-", and adding a new "+" line
>         with the new content.
>
>   - adding new lines; do not yet exist in the patch. You can add new
>     lines by inserting "+" lines with the new content.
>
> which is perhaps better, as it directs the user according to what they
> actually want to accomplish.

Yes, the above reads much better than starting from "when you see a '+'
you can do..." (which I think is a wrong approach that is backwards).

>> Is there a way to move this note way upwards?  Once the reader understands
>> what this paragraph teaches, it becomes much easier to understand the
>> implication of "remove addition".
>
> I agree it would be better at the top, but I think formatting it as I
> just wrote above would mean we can actually explain the issue in a more
> appropriate place. And then this bottom warning can just go away.

Agreed, again.
