From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] man: git pull -r is a short for --rebase
Date: Thu, 16 Aug 2012 09:22:14 -0700
Message-ID: <7v1uj63iyx.fsf@alter.siamese.dyndns.org>
References: <20120816095018.GD5489@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Miklos Vajna <vmiklos@suse.cz>
X-From: git-owner@vger.kernel.org Thu Aug 16 18:22:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T22pz-0005b7-MP
	for gcvg-git-2@plane.gmane.org; Thu, 16 Aug 2012 18:22:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932904Ab2HPQWS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Aug 2012 12:22:18 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51608 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932811Ab2HPQWR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Aug 2012 12:22:17 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DA9168290;
	Thu, 16 Aug 2012 12:22:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=g9br9tS5RJXehz9/s5XU5oGBI/I=; b=nUEi+L
	1wofAMTl26LlaGcHLO7sTqSYSHxBr972bso/zRGlz5zOivZCKFZbMjJs5GIs6dVC
	qN1Txx60i6kWk0XkPLV5h3BtQPwVuuyo7BUjXF3rbuANQ+ujTc2fGZOfLpv3rG9U
	EHz8LSFfOIfV6SEImReiEBLQ2KHM7Vn2ROvsw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SAyWwBMa68aZfu549hKB5DmeG4Op87Cq
	dirkyZ8+8q4Z/JzCXeVxz5QRUXvZgOrL3lqoaqEDRhlxWWd/L0ma3tSQ4bHD8+V5
	69KAxFj/ofvPMlbFuoWhe1Am8VJkOcuvg400vNjSy6wnc7tAX4Y0n8ZHz4dZcKjR
	73cFoUu99l8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C47D9828F;
	Thu, 16 Aug 2012 12:22:16 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1F10B828E; Thu, 16 Aug 2012
 12:22:16 -0400 (EDT)
In-Reply-To: <20120816095018.GD5489@suse.cz> (Miklos Vajna's message of "Thu,
 16 Aug 2012 11:50:18 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8B19B292-E7BE-11E1-B773-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Miklos Vajna <vmiklos@suse.cz> writes:

> ---
>  Documentation/git-pull.txt |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
> index defb544..67fa5ee 100644
> --- a/Documentation/git-pull.txt
> +++ b/Documentation/git-pull.txt
> @@ -101,6 +101,7 @@ include::merge-options.txt[]
>  
>  :git-pull: 1
>  
> +-r::
>  --rebase::
>  	Rebase the current branch on top of the upstream branch after
>  	fetching.  If there is a remote-tracking branch corresponding to

I am not sure if this is worth it, as it comes from a natural
"abbreviated options" support, i.e.

	-r|--r|--re|--reb|--reba|--rebas|--rebase)
		rebase=true

And I do not think we particularly want to do

    +-r::
    +--r::
    +--re::
    +--reb::
    +--reba::
    +--rebas::
     --rebase::
            Rebase the current...

for obvious reasons.
