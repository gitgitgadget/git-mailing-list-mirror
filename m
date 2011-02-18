From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 0/3] Thinning the git toplevel directory
Date: Fri, 18 Feb 2011 10:55:04 -0800
Message-ID: <7vei75p3zr.fsf@alter.siamese.dyndns.org>
References: <7vmxm4onwk.fsf@alter.siamese.dyndns.org>
 <1297304069-14764-1-git-send-email-pclouds@gmail.com>
 <20110218022701.GA23435@elie>
 <AANLkTik8wUrUnjTiUxUZbg3paaQEc7UERQ6J6jUzA2u5@mail.gmail.com>
 <20110218092518.GB30648@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org,
	Nicolas Pitre <nico@fluxnic.net>, Jeff King <peff@peff.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 18 19:55:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqVUE-0005Iw-Tm
	for gcvg-git-2@lo.gmane.org; Fri, 18 Feb 2011 19:55:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756032Ab1BRSzW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Feb 2011 13:55:22 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:50645 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753810Ab1BRSzU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Feb 2011 13:55:20 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 346084F60;
	Fri, 18 Feb 2011 13:56:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1Qh+hCqv368/nrTzxd837+GYE8Y=; b=M+VR3J
	48L6lbOb9wcI2EyhhRJWDuuozR6BMjGKuYHIV15zACwMuala7zyY57HTvcpb+yC+
	NUXin3QjwypZwaak/sdRFsalF//sWa/HOXHrddnbAGuVo9+WbzZk0VtBg+eQz1wx
	wrObRkJMa7IB4ATqVX1dZ69+WXk9k4ptltUR0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=r91VxJdKzdtiHeyiMV2V5yHaieWxtylY
	2LHR6o3m21itCCWW3/m1KvkMFqQqZMuqUkAxq430DW5V/a0jBQoVFul44sHmMslY
	qvanLGHB3+rYSRrZbzxlxnJpVB+cXeqS1yhtSOpNumtwFod2k2lYqs1t2JxdR2jB
	hCdZwRa3T5M=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D74634F59;
	Fri, 18 Feb 2011 13:56:21 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 29CB24F4D; Fri, 18 Feb 2011
 13:56:14 -0500 (EST)
In-Reply-To: <20110218092518.GB30648@elie> (Jonathan Nieder's message of
 "Fri\, 18 Feb 2011 03\:25\:18 -0600")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: C6D70DC4-3B90-11E0-837D-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167224>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Thanks again for both of your help.  I've put up an updated series at
>
>  git://repo.or.cz/git/jrn.git flatten-source

Huh?  Did you mean deepen or unflatten?

> Changes since the series sent to the list:
>
>  - put headers in libgit/ with the source files.  I don't
>    know what I was thinking before.

Nicer; I liked Jeff's "lib/" even better, though.

>  - renamed nonbuiltin/ to commands/.  Names like
>    commands/add--interactive.perl even seem to make a kind of sense.

Yes. "nonbuiltin/" made me stop reading the patches ;-).

>  - moved the http support mini-library to http/.

I don't understand the motivation behind this---wouldn't it belong to
"libgit/" and if not why not?

>  - renamed git_remote_helpers to python/, though I'm not very happy
>    about that.

I am not fond of naming a directory after a language _unless_ the contents
of the directory is _all_ about laying the foundation of something else
that happens to be implemented in that language.  Existing "perl/" is all
about providing the Git.pm module to be used by Perl scripts that live
outside the directory and is a very good example of naming the directory
after the language.  Does the contents of the new "python/" directory
satisfy that criteria?  If so, then it is fine.  If we plan to add more
remote-helpers and if we plan to allow these helpers written in other
languages, you might need to resurrect a separate "remote-helpers/"
directory, move some parts of the files you placed in "python/" that are
not "foundations for talking to git from Python" but are about "being a
remote-helper" to a subdirectory of it, so that new helper implementations
written in other languages can live next to that subdirectory.

For exactly the same reason "scripts/" is a name I am not entirely happy
about in your tree.  "test-programs/" is a very good name, but "scripts/"
only tells us that the contents _happen to be_ done as scripts, and does
not tell us _what they are for_; perhaps "build-helpers/" might be more
understandable.

Thanks.
