From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation: Strip texinfo anchors to avoid duplicates
Date: Wed, 03 Apr 2013 13:07:48 -0700
Message-ID: <7vppyb4bu3.fsf@alter.siamese.dyndns.org>
References: <1365018873-22503-1-git-send-email-Martin.vGagern@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Martin von Gagern <Martin.vGagern@gmx.net>
X-From: git-owner@vger.kernel.org Wed Apr 03 22:08:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNTyn-0006L8-2Z
	for gcvg-git-2@plane.gmane.org; Wed, 03 Apr 2013 22:08:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932396Ab3DCUHw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Apr 2013 16:07:52 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33982 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762404Ab3DCUHv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Apr 2013 16:07:51 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CC1A312A9F;
	Wed,  3 Apr 2013 20:07:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=L/c53Ydluq0sC9I0ojqQciqBQb8=; b=hZ68qK
	Xskin4EaScIY7RqFI3LRPy29XmFDHlk5m7sGf7XsHvHR4TYHjGqLfFTwjwkm2ZD5
	ue96ui2l73meK2iSH+MVFKLZErCcG2LcXFkLTQFU5mKX0cx+3XQAChy0fB+gCjti
	6XMdUFMSgGtvATvtu4adO4p5fThejis1I3i1I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=V5RsRaPjQRw/ec5wsuG8VPy+PS8Lnm0M
	PN5OJ9dU0S8SMdDHs5ULV9gHKEXaK0L34rXUaY0pO4w5D+KE7KNHXutcC6+5nc+g
	jV5pGdPP4OX16ZZoeoOBv8k3cOAxtRMmkPoVV7h3KVlLaOnJBAevxcg7WG3+0pmH
	4w5dXGmtjg0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C114A12A9E;
	Wed,  3 Apr 2013 20:07:50 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3E7A912A9D; Wed,  3 Apr
 2013 20:07:50 +0000 (UTC)
In-Reply-To: <1365018873-22503-1-git-send-email-Martin.vGagern@gmx.net>
 (Martin von Gagern's message of "Wed, 3 Apr 2013 21:54:33 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 29145304-9C9A-11E2-B31A-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219968>

Martin von Gagern <Martin.vGagern@gmx.net> writes:

> This keeps texinfo 5.x happy. See https://bugs.gentoo.org/464210.

I see why duplicates are bad, but does that mean not having any is
better?

>
> Signed-off-by: Martin von Gagern <Martin.vGagern@gmx.net>
> ---
>  Documentation/cat-texi.perl | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/cat-texi.perl b/Documentation/cat-texi.perl
> index dbc133c..b52660d 100755
> --- a/Documentation/cat-texi.perl
> +++ b/Documentation/cat-texi.perl
> @@ -12,6 +12,7 @@ while (<STDIN>) {
>  		push @menu, $1;
>  	}
>  	s/\(\@pxref{\[(URLS|REMOTES)\]}\)//;
> +	s/\@anchor\{[^{}]*\}//g;
>  	print TMP;
>  }
>  close TMP;
