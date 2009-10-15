From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] git-gui: adjust the minimum height of diff pane for
 shorter screen height
Date: Thu, 15 Oct 2009 12:57:17 -0700
Message-ID: <7voco84ehu.fsf@alter.siamese.dyndns.org>
References: <1255583127-14893-1-git-send-email-vietor@vxwo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Vietor Liu <vietor@vxwo.org>
X-From: git-owner@vger.kernel.org Thu Oct 15 22:05:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MyWZp-0000wr-OL
	for gcvg-git-2@lo.gmane.org; Thu, 15 Oct 2009 22:05:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935361AbZJOT6N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Oct 2009 15:58:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935349AbZJOT6N
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Oct 2009 15:58:13 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:61102 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933262AbZJOT6M (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Oct 2009 15:58:12 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id CF6C778709;
	Thu, 15 Oct 2009 15:57:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6mUjXK8S2nPnW0YQG3fuh3lLJIg=; b=Yhe9mm
	mew9COoGUokSDWvTY5KbqTHwaWlZyzG1ILwOxN16UKc4EF2BZdO2qObqZor5KrqZ
	vcuii182dlmwO3VpfkRHcb2T5uQ7X0B8jWabvdcA1FNjoBJfCS6lwm+/HwgiL2PK
	58ReXNlnmxhXnfVfSNeEbDaF1Ilj3AQU1cmB0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AZ2RWp6HHuxdoxcBnbMkJr+YH/z2vd1s
	9xeBzPaFVNDnh5E1gazKdenrxkBRhiRwGaMNlFoo3n4lGctHn6hBLlHSmXq+uqkY
	5ntOjO9YgRnEDp1h3gkwx8NUQEjyqhL+Zjm8tH6EPjXmqIbY8FcKwTECWA1VU9jj
	97B5U7URUEI=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 9506378706;
	Thu, 15 Oct 2009 15:57:24 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id ED2EF78701; Thu, 15 Oct 2009
 15:57:18 -0400 (EDT)
In-Reply-To: <1255583127-14893-1-git-send-email-vietor@vxwo.org> (Vietor
 Liu's message of "Thu\, 15 Oct 2009 13\:05\:27 +0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: F52A82F4-B9C4-11DE-B1CE-A67CBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130417>

Vietor Liu <vietor@vxwo.org> writes:

> When the screen height is shorter (e.g. Netbook screen 1024x600), both the
> partial commit pane and the status bar will hide. This patch adjust the
> minimum height of the diff pane, allowing the overall window to be shorter
> and still display both the entire commit pane and status bar.

Ah, I finally can parse and understand what this s/15/5/ change was about
;-).  Perhaps with "s/will hide/are hidden/" it would be perfect?

>
> Signed-off-by: Vietor Liu <vietor@vxwo.org>
> ---
>  git-gui.sh |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/git-gui.sh b/git-gui.sh
> index 09b2720..037a1f2 100755
> --- a/git-gui.sh
> +++ b/git-gui.sh
> @@ -3083,7 +3083,7 @@ frame .vpane.lower.diff.body
>  set ui_diff .vpane.lower.diff.body.t
>  text $ui_diff -background white -foreground black \
>  	-borderwidth 0 \
> -	-width 80 -height 15 -wrap none \
> +	-width 80 -height 5 -wrap none \
>  	-font font_diff \
>  	-xscrollcommand {.vpane.lower.diff.body.sbx set} \
>  	-yscrollcommand {.vpane.lower.diff.body.sby set} \
> -- 
> 1.6.5
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
