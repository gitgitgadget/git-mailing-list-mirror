From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t0000: modernise style
Date: Thu, 01 Mar 2012 13:54:09 -0800
Message-ID: <7vpqcwkmwu.fsf@alter.siamese.dyndns.org>
References: <8dc3b95f0d2511b1598f006df3a54c166a3b4b8c.1330637527.git.stefano.lattarini@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Stefano Lattarini <stefano.lattarini@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 01 22:54:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S3DxA-0006uV-Dh
	for gcvg-git-2@plane.gmane.org; Thu, 01 Mar 2012 22:54:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965554Ab2CAVyQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Mar 2012 16:54:16 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55140 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965421Ab2CAVyM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Mar 2012 16:54:12 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6AD7478E1;
	Thu,  1 Mar 2012 16:54:11 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MQO4VIqzfUPu6ul+TVse1YYPEAQ=; b=yOwx9H
	NFZIQb8HI9AK1gGWE5cwKmsl8Z48wtTZNyDsT999KhjMMRbvzFU7oGeYqyfDldxG
	u+ScNtoV49vISh4rFeZLuc8d85CsM4YhQY1k/6139j8R/2H1DWaSxzTqPws9L2O4
	o9/QtGw3JsQU4FEL2xn4COMgIFV4T6KxGOJGo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ljhVg6gu4yEZG5TV0kpHYCW44y3/Q8h5
	Xyh+hyGv9CQLz0u4E2XEF4NQfXS67NMRqhsTY4Z/yEvJ5LAs6v9eFe8LK4uOb14A
	V94oq9lS0I0PjuX2M2CLD73gdnM9ZNK4gXsY932XJt3dSBkrhd2zAj8A0MisV7rp
	k58Z16YJfkY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5FAE478E0;
	Thu,  1 Mar 2012 16:54:11 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E53AF78DD; Thu,  1 Mar 2012
 16:54:10 -0500 (EST)
In-Reply-To: <8dc3b95f0d2511b1598f006df3a54c166a3b4b8c.1330637527.git.stefano.lattarini@gmail.com> (Stefano Lattarini's message of "Thu, 1 Mar 2012 22:37:55 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 13DB590A-63E9-11E1-8274-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191978>

Stefano Lattarini <stefano.lattarini@gmail.com> writes:

> Match the style to more modern test scripts, namely:
>
>  - Prefer tabs for indentation.
>
>  - The first line of each test has prereq, title and opening sq for the
>    script body.
>
>  - Move cleanup or initialization of data used by a test inside the test
>    itself.
>
>  - Put a newline before the closing sq for each test.
>
>  - Don't conclude the test descriptions with a full stop.
>
>  - Prefer 'test_line_count FILE COUNT' over 'test $(wc -l <FILE) = COUNT'
>
>  - Use '<<-EOF' style for here documented, so that they can be indented

s/documented,/document,/;

>    as well.  Bot don't do that in case the resulting lines would be too
>    long.
>
>  - Don't redirect the output of commands to /dev/null unconditionally,
>    the git testing framework should already take care of handling test
>    verbosity transparently and uniformly.
>
> Signed-off-by: Stefano Lattarini <stefano.lattarini@gmail.com>
> ---
>
>  Not sure whether a cosmetic-only patch like this coming from an
>  "outsider" will be well-received or regarded as noise, but I guess
>  the best way to find out is to try and send it.

A pair of good rule of thumb:

 (1) who the sender is does not matter.

 (2) an area that saw high activity recently tends to repel cosmetic-only
     patches.

> diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
> index f4e8f43..fa2c5f4 100755
> --- a/t/t0000-basic.sh
> +++ b/t/t0000-basic.sh
> @@ -34,69 +34,69 @@ fi
>  # git init has been done in an empty repository.
>  # make sure it is empty.
>  
> -find .git/objects -type f -print >should-be-empty
> -test_expect_success \
> -    '.git/objects should be empty after git init in an empty repo.' \
> -    'cmp -s /dev/null should-be-empty'
> +test_expect_success '.git/objects should be empty after git init in an empty repo' '
> +	find .git/objects -type f -print >should-be-empty &&
> +	cmp -s /dev/null should-be-empty

It might be even better to do this

	>empty
        test_cmp empty should-be-empty

when there is a behaviour change under "-v" option?

Or be consistent with the next one and use test_line_count for zero?

I'll backburner the remainder of the patch.
