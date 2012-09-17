From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation: indent-with-non-tab uses tabwidth
 setting, not just 8
Date: Sun, 16 Sep 2012 22:16:07 -0700
Message-ID: <7v392hxm94.fsf@alter.siamese.dyndns.org>
References: <1347815548-19305-1-git-send-email-wjl@icecavern.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Wesley J. Landaker" <wjl@icecavern.net>
X-From: git-owner@vger.kernel.org Mon Sep 17 07:16:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TDTh4-0007lG-Lp
	for gcvg-git-2@plane.gmane.org; Mon, 17 Sep 2012 07:16:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753270Ab2IQFQL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2012 01:16:11 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33376 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752515Ab2IQFQK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2012 01:16:10 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AD3099D91;
	Mon, 17 Sep 2012 01:16:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=dTiMGf6I/Pcm9J0Wm56AhqFqSiY=; b=lnVQOr
	TzG5OmdUoWcdoOH9f5H/aOw/GgXcfL7/hlniUr58Se+rZa4fE4Ai0Q25wX0B7/1m
	5GFEtFC8SPhwvLaHTvf33nFIGw0M7IwSI2zzOpE6CbRVhn19jRXfAIzllshRdAZY
	1ljqlW9Agv6DOkYCipZaH36zDOcJ7tt0g3rao=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=j0zvjKa/zs+1b62Hyw8qminw1b0MMdx7
	du2lT57Wo/NriUVcZcFNDhD+HWmSf6ceiG3DEhKZodhzH/dDkwdBdKi4ZYaMGzxl
	K6ya+duq+pYYNIe0yB6PbE0fcppqAhnfQZ1WJaMJNHzrNzVG+Y22uq0JI9d7idl6
	vvU5Q+ItDng=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9AAF69D90;
	Mon, 17 Sep 2012 01:16:09 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0B0AA9D8F; Mon, 17 Sep 2012
 01:16:08 -0400 (EDT)
In-Reply-To: <1347815548-19305-1-git-send-email-wjl@icecavern.net> (Wesley J.
 Landaker's message of "Sun, 16 Sep 2012 11:12:28 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CA150510-0086-11E2-A6CD-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205645>

"Wesley J. Landaker" <wjl@icecavern.net> writes:

> From: "Wesley J. Landaker" <wjl@icecavern.net>
>
> Update the documentation of the core.whitespace option
> "indent-with-non-tab" to correctly reflect that it uses the currently
> set tab width, set by the "tabwidth" option, rather than a fixed number.
>
> Signed-off-by: Wesley J. Landaker <wjl@icecavern.net>
> ---
>  Documentation/config.txt |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 6416cae..113a196 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -559,8 +559,8 @@ core.whitespace::
>  * `space-before-tab` treats a space character that appears immediately
>    before a tab character in the initial indent part of the line as an
>    error (enabled by default).
> -* `indent-with-non-tab` treats a line that is indented with 8 or more
> -  space characters as an error (not enabled by default).
> +* `indent-with-non-tab` treats a line that is indented with `tabwidth` space
> +  characters or more as an error (not enabled by default).

I would rather see this part left untouched.

Your new text will force people who are not interested in using
non-standard tab width to read through the bulletted list, only to
find "The default tab width is 8".  I think that is a regression in
the documentation for more common readers.

When somebody wants to use `indent-with-non-tab` and gets offended
by the seemingly hardcoded "8" in the description, the reader has
incentive to find out if there is a way to change that 8, and will
find `tabwidth=<n>` in the same bulletted list described, with the
effect it has on both `indent-with-non-tab` and `tab-in-indent`.

I think that should be sufficient for people who do use non-standard
tab width using tabwidth=<n>.
