From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-sh-setup.sh: use dashdash with basename call
Date: Mon, 24 Nov 2014 16:28:18 -0800
Message-ID: <xmqq3898unrx.fsf@gitster.dls.corp.google.com>
References: <1416870211-13959-1-git-send-email-danwyand@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Dan Wyand <danwyand@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 25 01:28:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xt3zU-0003lq-T1
	for gcvg-git-2@plane.gmane.org; Tue, 25 Nov 2014 01:28:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750836AbaKYA2V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Nov 2014 19:28:21 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:59554 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750784AbaKYA2U (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Nov 2014 19:28:20 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D1EB3211F9;
	Mon, 24 Nov 2014 19:28:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=b5f/m1jRdPsxETZRYgNocQs1aVQ=; b=UNWyyI
	B+J94xatCf1igJB3qxmGPDz5uHiY3dOLt7j9fSUAT1JC1e+riJ2TGPXRZvvhbDBE
	whlkJbrpNs/ebHbAmsyCrqLxjLIy2/gWr/o7KgDE+zgSaZNbGFlBCSo5HhYHStk2
	dhfkIdL3TShORUsGvxbM9v4FVjSOoqYOut0CI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YsewoZDZT/ZWCBLZNvVTTySLNSjq4WIc
	/62F2oXVZqKpBRdyAAHMQ9ybL58AzBHvk9LiOCcGreh3EYbrvatvKx2ZvA1YRDKD
	3XvphnFdfZjfW/Hk7rtJVqVwEp7mwyus/bbFxJEkRH+69no8SCXftyVed8WP59hE
	IGtUcUo14CQ=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C3754211F8;
	Mon, 24 Nov 2014 19:28:19 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 420FD211F7;
	Mon, 24 Nov 2014 19:28:19 -0500 (EST)
In-Reply-To: <1416870211-13959-1-git-send-email-danwyand@gmail.com> (Dan
	Wyand's message of "Mon, 24 Nov 2014 18:03:31 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: F48CF4FA-7439-11E4-B195-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260175>

Dan Wyand <danwyand@gmail.com> writes:

> Calling basename on a argument that starts with a dash, like a login shell,
> will result in an error. This patch adds '--' before the argument so that the
> argument is interpreted properly.
> ---

Makes sense.

Please sign-off your patch (see Documentation/SubmittingPatches).

>  git-sh-setup.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/git-sh-setup.sh b/git-sh-setup.sh
> index 9447980..5cdae33 100644
> --- a/git-sh-setup.sh
> +++ b/git-sh-setup.sh
> @@ -81,7 +81,7 @@ if test -n "$OPTIONS_SPEC"; then
>  		echo exit $?
>  	)"
>  else
> -	dashless=$(basename "$0" | sed -e 's/-/ /')
> +	dashless=$(basename -- "$0" | sed -e 's/-/ /')
>  	usage() {
>  		die "usage: $dashless $USAGE"
>  	}
