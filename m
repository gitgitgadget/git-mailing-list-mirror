From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [Patch v3 0/8] Create single PDF for all HTML files
Date: Tue, 16 Oct 2012 15:11:31 -0700
Message-ID: <7vd30iqd7w.fsf@alter.siamese.dyndns.org>
References: <1213313884.154031.1350407865830.JavaMail.ngmail@webmail15.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, philipoakley@iee.org, peff@peff.net,
	git@drmicha.warpmail.net
To: Thomas Ackermann <th.acker66@arcor.de>
X-From: git-owner@vger.kernel.org Wed Oct 17 00:11:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TOFMX-0007Fi-9o
	for gcvg-git-2@plane.gmane.org; Wed, 17 Oct 2012 00:11:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755286Ab2JPWLe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2012 18:11:34 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55731 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753976Ab2JPWLd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2012 18:11:33 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2D3059A57;
	Tue, 16 Oct 2012 18:11:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=U4ubocjNZ7bI0baXzugDYeeDLEw=; b=xf6C9h
	R7pClzdjPfyqaK3O6M/FfcwHKYQSOO2NLe+4Xwctjqzb+tqf45aIci73TSsQYHok
	JRlPVTlgwz/P7HzVOJqYkiD5Tfc11WrkN59Xr+N4o35DL8D4KL+yviuov/jkIXcy
	AnqC4skSJbNt0qyFhcNKvq4/YP8jpq/ZzyIAo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WYajUGp4pFwmAL4J5gXtG73xVZlfJbhN
	ih0ysUHKj++9ksPq3EaT3cA+fMle6Mvy9ttesIGn8xHNw/G5fldRQQicYX8ud8ze
	zbt71Tjw2sDhTmY8oMzcPPvY+Gqf1fEF6xxfbSjAodCEiwbTTXC2/LthUjRkA4RM
	oohIjKvGuho=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 18B499A56;
	Tue, 16 Oct 2012 18:11:33 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 759FE9A54; Tue, 16 Oct 2012
 18:11:32 -0400 (EDT)
In-Reply-To: <1213313884.154031.1350407865830.JavaMail.ngmail@webmail15.arcor-online.net>
 (Thomas Ackermann's message of "Tue, 16 Oct 2012 19:17:45 +0200 (CEST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7142CC5A-17DE-11E2-9181-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207883>

Thomas Ackermann <th.acker66@arcor.de> writes:

> this is v3 of my patch series for creating a single PDF for all
> git documentation files.
>
> There are only 2 changes since v2 (thanks to Junio for pointing me at these issues) :
> - The over-long lines in git-bisect-lk2009.txt where shortened by abbreviating the SHA1s.
> - Pretty-printing the shell script in update-hook-example.txt was fixed.
>
> To sum up, this patch series provides the following new "features":
> - Make target "html" now creates HTML for ALL files in ./Documentation/howto and ./Documentation/technical
> - New make target "fullpdf" first creates HTML for all files in ./Documentation/RelNotes and then collates all HTML 
> files in ./Documentation and its subdirs (except user-manual.html) in one single PDF file.
>
> This approach is of course not an optimal one but by using wkhtmltopdf
> it could be carried out easily.

I am not interested in adding a build target that requires (a
patched version of) wkhtmltopdf at all, but the earlier parts of
this series do look like good clean-ups and useful conversions to
asciidoc, regardless of which tool we end up deciding to use to
produce the final output.  Thanks for working on this.

I (and other people who wrote documentation, I suspect, as well)
feel somewhat offended by the word "fix" here and there in the
message in commits that turn files that so far have been plain text
into asciidoc, though ;-).
