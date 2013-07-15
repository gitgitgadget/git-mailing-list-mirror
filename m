From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Jul 2013, #05; Fri, 12)
Date: Mon, 15 Jul 2013 12:32:38 -0700
Message-ID: <7vy597aaax.fsf@alter.siamese.dyndns.org>
References: <7vk3kvie4h.fsf@alter.siamese.dyndns.org>
	<vpqd2qkgr19.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Jul 15 21:32:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UyoVq-0003BA-9s
	for gcvg-git-2@plane.gmane.org; Mon, 15 Jul 2013 21:32:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754740Ab3GOTcm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jul 2013 15:32:42 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38582 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754358Ab3GOTcl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jul 2013 15:32:41 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 21FC43155C;
	Mon, 15 Jul 2013 19:32:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3GxJZXoMLgw+QYC2A9I0y0tuJk0=; b=jmnO5G
	UUZ1u8TsIJgOAKYJVFEwn+oVnRLiMeXh7t7KllWW01+iXzfcWabNxAeg0tmY3kME
	coRonMyf5L7z2OIaHrB0LZNYxojN9R3zOHFusu/7QrE2RY5NTkHtXWwjmkpnHs2k
	1rUxUPuT3KMm01vZH8c67G9koD7F3EV/OMjUU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=a0wv7EFHpiefw9M5RE7nUBQ7C6DJkMwh
	P+zZNlHumxU/PZQXiJ6eRd4sPg6g2kjRHcL58egg4VT6njoQ0aZal5eiWcwhrO6U
	2KcbKB2MdZlONKL1b7Gx0XrLeSneJFIyggIcNF1Jb2zTAyq5atJVYI2wb7rv4PhB
	eU25vhA31A4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1308B3155A;
	Mon, 15 Jul 2013 19:32:41 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 543FF31555;
	Mon, 15 Jul 2013 19:32:40 +0000 (UTC)
In-Reply-To: <vpqd2qkgr19.fsf@anie.imag.fr> (Matthieu Moy's message of "Mon,
	15 Jul 2013 10:34:42 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 50060E3A-ED85-11E2-A736-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230517>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> * bp/mediawiki-preview (2013-07-08) 7 commits
>>   (merged to 'next' on 2013-07-12 at 870890a)
>>  + git-remote-mediawiki: add preview subcommand into git mw
>>  + git-remote-mediawiki: add git-mw command
>>  + git-remote-mediawiki: factoring code between git-remote-mediawiki and Git::Mediawiki
>>  + git-remote-mediawiki: update tests to run with the new bin-wrapper
>>  + git-remote-mediawiki: add a git bin-wrapper for developement
>>  + wrap-for-bin: make bin-wrappers chainable
>>  + git-remote-mediawiki: introduction of Git::Mediawiki.pm
>>
>>  Add a command to allow previewing the contents locally before
>>  pushing it out, when working with a MediaWiki remote.
>>
>>  I personally do not think this belongs to Git.  If you are working
>>  on a set of AsciiDoc source files, you sure do want to locally
>>  format to preview what you will be pushing out, and if you are
>>  working on a set of C or Java source files, you do want to test it
>>  before pushing it out, too.  That kind of thing belongs to your
>>  build script, not to your SCM.
>
> There's one big difference: when you use AsciiDoc/C/Java/... your build
> system works locally. "git mw preview" uses the remote wiki to do the
> rendering.
>
> It doesn't do so with the remote-helper interface, but uses
> the same remote and same configuration as the remote-helper, and it
> shares some code with it. It seems logical to let it leave next to the
> remote-helper (but clearly in contrib/, not in the core Git).

Hmph, I do not see it fundamentally different from using distcc to
compile not locally.

Your build infrastructure can (ab)use the configuration mechanism
for Git to store necessary information to find out what workers are
willing to help your compilation.  The mediawiki-preview program is
talking over MediaWiki protocol, and it may reuse the same
credential information stored in the config to talk to the same
MediaWiki installation in connect_maybe() and sending the updated
page contents to ask it to render, but I do not see a fundamental
reason why the worker has to be the same MediaWiki installation as
your "repository".

So, no, I do not see a "big" difference there.

That does not mean I'd retract what I already said in the previous
issue of "What's cooking", i.e.

>> But I'll let it pass, as this is only a contrib/ thing.

;-)
