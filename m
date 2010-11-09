From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] docs: give more hints about how "add -e" works
Date: Mon, 08 Nov 2010 16:57:34 -0800
Message-ID: <7vlj53nwjl.fsf@alter.siamese.dyndns.org>
References: <20101021143034.GA16083@sigill.intra.peff.net>
 <7v4ocftbww.fsf@alter.siamese.dyndns.org>
 <20101022192529.GA13059@sigill.intra.peff.net>
 <7v8w1plwq0.fsf@alter.siamese.dyndns.org>
 <20101108223322.GA12258@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Miklos Vajna <vmiklos@frugalware.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Nov 09 01:57:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PFcX3-0005VD-W3
	for gcvg-git-2@lo.gmane.org; Tue, 09 Nov 2010 01:57:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752915Ab0KIA5s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Nov 2010 19:57:48 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:65083 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752453Ab0KIA5r (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Nov 2010 19:57:47 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0EDA42074;
	Mon,  8 Nov 2010 19:57:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=slqtoVNOcQ7INa69rGxsIH5ytyY=; b=F3Yt5t
	yb5Qu+oXiBNkmWR6ctR0pbTNyLHZcP0v2jKu2d1yHdTjkzMsQnu+NAhu/MWLCgvn
	lmI7XlC25Q428Xu+5DN/mIQIKEu4bjt4tP8LkmT3jx4P2e/CM+Wqikmy23LGVxOo
	uNFEw+ZrsRbO7zXX9HiY0fbJ/kFBAc/fCPdcQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=n7mTUrK3P0/nrMI/WaUQNJ4iqoDKH2M2
	BqJoe2S+zCYrJDjabPTmv+yzcGY3qTXiZgIIr4lG2C8/9RcEuR9RV/63YMyz8LMP
	gMOhU7SJYj8KVkedt2HGSX8qaBIT/oAUYVjsSA7I+d8zjKF12cdXA0KAu2mbOW/Q
	af45FHyy7Qg=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id BE6182073;
	Mon,  8 Nov 2010 19:57:44 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 272172071; Mon,  8 Nov 2010
 19:57:38 -0500 (EST)
In-Reply-To: <20101108223322.GA12258@sigill.intra.peff.net> (Jeff King's
 message of "Mon\, 8 Nov 2010 17\:33\:23 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 5CB745A6-EB9C-11DF-9B7A-B53272ABC92C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161007>

Jeff King <peff@peff.net> writes:

> It should replace what's in next. You can either start a new branch and
> revert what's in next, or I can prepare it on top of what's in next if
> you prefer.

I can just apply an interdiff if I wanted to, so that is no reason for
asking a resend.

The new text indeed looks much clearer, except for one part I am not
absolutely sure...

> +new content::
> +
> +You may also add new content that does not exist in the patch. Simply
> +add new lines, each starting with "{plus}".
> +
> +You can also perform more complex operations, such as modifying the
> +content to be staged by a "{plus}" line. However, note that this impacts
> +_only_ the index; the working tree file will remain unchanged, and will
> +appear to "undo" the content you have staged. Such operations should be
> +performed only if you know what you are doing.

This "However, note that" part should apply not only to newly introduced
{plus} lines but also to {plus} lines whose change were edited (lines from
"added content" and from post-image half of "modified content"), no?

I tried to be careless when reading the two paragraphs above, and managed
to get an incorrect impression that the caveat applies only to "more
complex operations", even though it actually applies not just the previous
"new content" but also "added/modified" content.

Thinking about it a bit more, it is worse than that.  Turning " " into "-"
has the same "getting reverted" issue, no?
