From: Junio C Hamano <gitster@pobox.com>
Subject: Re: confusion with git diff-tree output
Date: Fri, 23 Oct 2009 23:36:59 -0700
Message-ID: <7vvdi58fhw.fsf@alter.siamese.dyndns.org>
References: <117f2cc80910211043q3a92a7b6o15464cc049ee33dc@mail.gmail.com>
 <20091021195103.01cef9c4@perceptron>
 <117f2cc80910211523m5c1399aej594398fb6597e5de@mail.gmail.com>
 <20091023005426.GA2431@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Roundy <roundyd@physics.oregonstate.edu>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Oct 24 08:37:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N1aFZ-0008L5-4a
	for gcvg-git-2@lo.gmane.org; Sat, 24 Oct 2009 08:37:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751985AbZJXGhG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Oct 2009 02:37:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751886AbZJXGhF
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Oct 2009 02:37:05 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:34519 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751525AbZJXGhE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Oct 2009 02:37:04 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 08C6883D0A;
	Sat, 24 Oct 2009 02:37:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=NC3U/LLvqgUN+SRhthnxAsEX0v8=; b=YNmzrd
	08S7UBxDkV1urwoKNIvIhaZ4eXjLcyDTduRJKykXIwK4yJ5271TnFbhCkxqzlzyx
	vCnqCIxl6udr88EqGrXzlDhyi07aobk9k1fVdDNgQv1DAuqKjLx5plKBLggDKq/8
	1kMu7NkkF2tHEFV4M/2zY2Zqz8/uJaBRBwz9I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WmLGdOA1tTDaH4xO+ZfDqUBvnEJv2skb
	XTQVrIxL1vetCylBjOGXmQvFe4DskvnomNBsTkUPcKY2qJGl0HP07Yn/GpXi7Pxh
	qJhR+xsMpfMNWT5ea+EHWEjkWBplQjmjaJutW3OdrMR4j2WtakWLZX63GHozZfx4
	ZS+EFhuz0nQ=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D163E83D09;
	Sat, 24 Oct 2009 02:37:05 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 7513083D08; Sat, 24 Oct 2009
 02:37:01 -0400 (EDT)
In-Reply-To: <20091023005426.GA2431@sigill.intra.peff.net> (Jeff King's
 message of "Thu\, 22 Oct 2009 20\:54\:26 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: A57B1468-C067-11DE-A982-A67CBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131144>

Jeff King <peff@peff.net> writes:

> On Wed, Oct 21, 2009 at 06:23:08PM -0400, David Roundy wrote:
>
>> You're right.  I figured I must be overlooking something obvious, and
>> that was it.  What surprised me was that -p implies -r, which is not
>> documented.  Since the -p output was recursive, I incorrectly presumed
>> that this was the default.
>
> It's due to hysterical raisins:
>
>   http://article.gmane.org/gmane.comp.version-control.git/54078

Just to make sure, the Porcelain "diff" does recurse even with --raw 
and "diff-tree" doesn't for historical reasons, right?
