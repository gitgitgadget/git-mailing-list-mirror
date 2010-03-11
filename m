From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Clarifications for merge workflows
Date: Thu, 11 Mar 2010 04:08:45 -0800
Message-ID: <7v63532h82.fsf@alter.siamese.dyndns.org>
References: <4B98D015.40401@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Markus Elfring <Markus.Elfring@web.de>
X-From: git-owner@vger.kernel.org Thu Mar 11 13:09:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NphCc-00035T-Fz
	for gcvg-git-2@lo.gmane.org; Thu, 11 Mar 2010 13:09:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757751Ab0CKMI4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Mar 2010 07:08:56 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:50725 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757740Ab0CKMIw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Mar 2010 07:08:52 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 74A54A00C5;
	Thu, 11 Mar 2010 07:08:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=sHSbg6p4kX6U8V3L/xi7GPEWNQ8=; b=WaohDN
	RcbwDw6bOHwpCt1qNO7jjBDxe9sjwWdfvgOr83Jxpo9y4TSVqUQmFfJFgZNbq5lw
	7n+WKvnRHVB1qm6+G+SdBJ5E/myzIkZAJoAhmM/OARGUCUs5egtpNjTSCzF/DoaW
	w2SpqeVuRgL1nvVOv7iM8pkcE7Fdy7zQ0QHcQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DmE1YOzBxv5wFf35DcOXikcxgy+hUDi7
	Neu5ElQYIAdgBJKFYUq0gZJaFTk+tH4WjZVAypg/YzUng72EUfDm+k+6VujzM0Gp
	D11loa4Z4dm2aw9+qgNXaSbcRYMZly1zGdsmGo05PLBbR6BMSd8gfzb/d5pnvOjr
	dTdkhcOVyas=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 49A64A00C4;
	Thu, 11 Mar 2010 07:08:49 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A7188A00C3; Thu, 11 Mar
 2010 07:08:46 -0500 (EST)
In-Reply-To: <4B98D015.40401@web.de> (Markus Elfring's message of "Thu\, 11
 Mar 2010 12\:12\:21 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D9DE059C-2D06-11DF-B29E-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141955>

Markus Elfring <Markus.Elfring@web.de> writes:

> - Log-in to the server and integrate the updates there.
>   or
> - Fetch the remote topic branch into the integrator's own local repository
> "XYZ", merge there and push the result back to the server.
>
> Which ways do you recommend to select the storage location where a merge will be
> applied first?

Personally, I would find the latter a more natural (and perhaps the only
natural) solution to me.

Being distributed is just that.  When I do my work, whether it is
developing new things myself, reviewing others' patches or reviewing
others' pull requests and accepting them (either "am", or "pull"),
everything is done "locally" at the most convenient place for "me", and
that convenient place happens to be where I primarily do my work.  The
tools, test procedures, and everything necessary for my work is already
there.

And then the procedure to publish the result out, whether it is what I did
myself, or what I helped to integrate into my history from others, is the
same.  I push the result out from that "local" place to the "public" one.

Of course, if you are always working on that "server", the fact that you
are always working there makes it the most convenient place to do all of
your work for you.  But even in that case, you would not want to publish a
half-integrated state out to the public only to confuse people, so the
actual integration work may happen phisically on the "server" machine, but
most likely you would be working in a repository on that machine that is
separate from the one you let others to pull from, i.e. your public
repository.
