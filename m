From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] templates/hooks--*: don't refer to contrib hooks
Date: Mon, 26 Sep 2011 10:52:23 -0700
Message-ID: <7vbou742eg.fsf@alter.siamese.dyndns.org>
References: <20110926125932.27854.qmail@804c778e7e6607.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Gerrit Pape <pape@smarden.org>
X-From: git-owner@vger.kernel.org Mon Sep 26 19:52:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8FLy-0005YY-BP
	for gcvg-git-2@lo.gmane.org; Mon, 26 Sep 2011 19:52:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751377Ab1IZRw0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Sep 2011 13:52:26 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61915 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751246Ab1IZRwZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Sep 2011 13:52:25 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5AEA24FC6;
	Mon, 26 Sep 2011 13:52:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=t6wCNCO2P+GC7OPFZObPrky9yx0=; b=YyT+K1
	2xJF0A8Jkl2yJrppHzXklFzytBSB4UQvhDXeOV6+zZ/uc6C7yhjHORzowj11SyoR
	sNfeFZnQs+dbu3/vZTOk56rmLC0Zy/uAyN98JmL9A0omAbcOUXcLhwRgv+q1QN9h
	IKgA7ZYLWdj6kzhhjORu91vMjSadDafbQdCHk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=REe87Fh/96onT7FlPUHQoA0tmnMhtHAN
	xUeZsCFlDGIfvyVRC1cF2q38wiw2vD6D4nV3uUr44uH5f1Z4l3C8YGPSxUcCRp21
	SHYMmJXKMvhqjYwpHxA4GoFGFvVKarbhxOFZV2zb4jC3ypzbS5sdeSRh06JI6v9j
	49jInWWm/aM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 526EE4FC5;
	Mon, 26 Sep 2011 13:52:25 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AC8754FC4; Mon, 26 Sep 2011
 13:52:24 -0400 (EDT)
In-Reply-To: <20110926125932.27854.qmail@804c778e7e6607.315fe32.mid.smarden.org> (Gerrit
 Pape's message of "Mon, 26 Sep 2011 12:59:32 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4A9D239E-E868-11E0-9E4A-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182142>

Gerrit Pape <pape@smarden.org> writes:

> Simplify the sample post-receive hook to not refer to some location of a
> contrib hook that might be installed in different locations on different
> systems.  Instead simply provide a sample file that does nothing just as
> the post-commit sample hook.
>
> Signed-off-by: Gerrit Pape <pape@smarden.org>
> ---
>  templates/hooks--post-receive.sample |   12 ++----------
>  1 files changed, 2 insertions(+), 10 deletions(-)
>
> diff --git a/templates/hooks--post-receive.sample b/templates/hooks--post-receive.sample
> index 7a83e17..5b1771f 100755
> --- a/templates/hooks--post-receive.sample
> +++ b/templates/hooks--post-receive.sample
> @@ -2,14 +2,6 @@
>  #
>  # An example hook script for the "post-receive" event.
>  #
> +# To enable this hook, rename this file to "post-receive".
>  
> +: Nothing

I removed the "-" lines above. Looking at the result, I really have to
wonder if it makes much sense to keep the file here. It is not even an
example anymore, and the user does not gain anything by enabling it,
following the suggestion.

Let's instead remove the file altogether, Ok?
