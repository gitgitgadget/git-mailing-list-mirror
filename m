From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] var doc: advertise current DEFAULT_PAGER and
 DEFAULT_EDITOR settings
Date: Sat, 31 Mar 2012 10:55:06 -0700
Message-ID: <7v1uo8k64l.fsf@alter.siamese.dyndns.org>
References: <20120330002543.2138.91961.reportbug@localhost6.localdomain6>
 <20120330005523.GA28519@burratino> <7v398qq1ei.fsf@alter.siamese.dyndns.org>
 <20120331084015.GC4119@burratino> <20120331084453.GE4119@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Rodrigo Silva \(MestreLion\)" <linux@rodrigosilva.com>,
	git@vger.kernel.org, Ben Walton <bwalton@artsci.utoronto.ca>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 31 19:55:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SE2WB-0005dj-Rp
	for gcvg-git-2@plane.gmane.org; Sat, 31 Mar 2012 19:55:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751494Ab2CaRzL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Mar 2012 13:55:11 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60896 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751493Ab2CaRzJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Mar 2012 13:55:09 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1141563AF;
	Sat, 31 Mar 2012 13:55:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mhpgg8dmoPfi7TixVUi37paRs98=; b=skAHWY
	iXQ9WDLZRilvKQcE59EawmKJeM1tZSemo0HXQiWMHlWBZIkKuj2pKoKvCeXw/wv9
	7MaA1mRXlbxUHUR9MlNAeBYSw0CES18sh8DKGG8vGn6j6859g5B56M32ryKNbgYa
	81+NQMjUKeG1maSZq+ZxH0xneeqbD9ONtUiKo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=yIzzmB7Vh5ajFOODBc6mZFE3WstkM/9l
	AgPQy6uXQYqw2D5ErsDlzRoAJEya2wglhpSX6l4YQyXjOzGC2fsVov24WEv99u2x
	hJAcSu13EI1BOLOY46aNBVFVbVfgG9HtuIuTGbZC7vbG+xFWe/FKQQFRWQjJHUIt
	lxMsfP0cXHk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0920463AE;
	Sat, 31 Mar 2012 13:55:09 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 830D963AA; Sat, 31 Mar 2012
 13:55:07 -0400 (EDT)
In-Reply-To: <20120331084453.GE4119@burratino> (Jonathan Nieder's message of
 "Sat, 31 Mar 2012 03:44:53 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A6EA90DE-7B5A-11E1-A70C-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194458>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Document the default pager and editor chosen at compile time in the
> git-var(1) manpage so users curious about what command _this_ copy of
> git will fall back to when EDITOR, VISUAL, and PAGER are unset can
> find the answer quickly.
>
> In builds leaving those settings uncustomized, this patch makes the
> manpage continue to say "usually vi" and "usually less" so the
> formatted documentation is usable for a wide audience including users
> of custom builds that change those settings.  If you would like your
> copy of the docs to be less noncommittal, you will need to set
> DEFAULT_PAGER=less and DEFAULT_EDITOR=vi explicitly.
>
> Suggested-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> ---
> Thanks for reading.

Thanks for a patch.

I think the Makefile patch to use "-a" takes the right approach (assuming
that the name of the EDITOR/PAGER won't have funny character that would
trip up AsciiDoc, which I think is a reasonably assumption), but I think
even the customized package should say what it is "usually" set on other
people's systems.

In other words, instead of:

>      `$VISUAL`, then `$EDITOR`, and then the default chosen at compile
> +ifndef::git-default-editor[]
>      time, which is usually 'vi'.
> +endif::git-default-editor[]
> +ifdef::git-default-editor[]
> +    time ('{git-default-editor}').
> +endif::git-default-editor[]

something like:

	... then the default chosen at compile time, which is usually 'vi'.
ifdef::git-default-editor[]
	The build you are using chose '{git-default-editor}' as the default.
endif::git-default-editor[]

may be less confusing.
