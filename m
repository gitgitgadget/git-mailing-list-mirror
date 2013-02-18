From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 8/9] user-manual: Flesh out uncommitted changes and
 submodule updates
Date: Sun, 17 Feb 2013 18:53:59 -0800
Message-ID: <7vfw0ucoxk.fsf@alter.siamese.dyndns.org>
References: <20130217170606.GA3432@odin.tremily.us>
 <cover.1361146398.git.wking@tremily.us>
 <6219cb47a0a5b7428ae6c729e9a1a55344f47428.1361146398.git.wking@tremily.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git <git@vger.kernel.org>, Jonathan Nieder <jrnieder@gmail.com>
To: "W. Trevor King" <wking@tremily.us>
X-From: git-owner@vger.kernel.org Mon Feb 18 03:54:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7Gs8-0005Gx-Vy
	for gcvg-git-2@plane.gmane.org; Mon, 18 Feb 2013 03:54:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756840Ab3BRCyE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Feb 2013 21:54:04 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55350 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756595Ab3BRCyC (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Feb 2013 21:54:02 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 45F57BD92;
	Sun, 17 Feb 2013 21:54:02 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=cbAvIdYmGiyEaI/hV2Tz2uq6d0Y=; b=nDHsL1
	bsRqytVnq+s+KZHCS2Sj0T3XSaFX5oou/4hg9Qhhwj8FwxEo0NT0u+ohV/UkANxp
	OEytqo0UdeYYRon/SOixwWRLAQchCm095k3lYaQ39im3utoo4iMDIz2YPnpQaK0c
	+g8syKtTLAnoaM/b/JqozLjtMXsLcGpi5r2NU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ldCsIPXb6J1F3SZHf588JVsKfnwk0mc/
	9fk5mxXPL6Q7bVv8cv71Dn/fTjh97DImg0n04vdZsGkcKliJJ2H6W7em4r7E1bL8
	87A0Z70wvYmuehciPTKJGo9kJprWzZLZ5NaW2/1VXqYpmNlyiKQB8nrnUCJXcGLr
	O4eSmOu2m4I=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 36CF3BD91;
	Sun, 17 Feb 2013 21:54:02 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 67428BD90; Sun, 17 Feb 2013
 21:54:01 -0500 (EST)
In-Reply-To: <6219cb47a0a5b7428ae6c729e9a1a55344f47428.1361146398.git.wking@tremily.us>
 (W. Trevor King's message of "Sun, 17 Feb 2013 19:16:00 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 72D6AD4E-7976-11E2-8E47-ACA62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216435>

"W. Trevor King" <wking@tremily.us> writes:

> From: "W. Trevor King" <wking@tremily.us>
>
> If you try and update a submodule with a dirty working directory, you
> get an error message like:
>
>   $ git submodule update
>   error: Your local changes to the following files would be overwritten by checkout:
>   ...
>   Please, commit your changes or stash them before you can switch branches.
>   Aborting
>   ...
>
> Mention this in the submodule notes.  The previous phrase was short
> enough that I originally thought it might have been referring to the
> reflog note (obviously, uncommitted changes will not show up in the
> reflog either ;).
>
> Signed-off-by: W. Trevor King <wking@tremily.us>
> ---
>  Documentation/user-manual.txt | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
> index cf09ddf..3381c22 100644
> --- a/Documentation/user-manual.txt
> +++ b/Documentation/user-manual.txt
> @@ -3729,7 +3729,9 @@ module a
>  
>  NOTE: The changes are still visible in the submodule's reflog.
>  
> +If you did not commit your submodule changes, the changes will *not*
> +be silently overwritten.  Instead, you get the usual warning about not
> +being able switch from a dirty branch.

The scenario this talks about is to commit changes in the
superproject and then to run "submodule update".  I think the above
clarification is still incomplete.  You may have committed in the
submodule some changes but not all.

	If you have uncommitted changes in your submodule working
	tree, "git submodule update" will not overwrite them.
	Instead...

would be an improvement, I think.

>  
>  [[low-level-operations]]
>  Low-level Git operations
