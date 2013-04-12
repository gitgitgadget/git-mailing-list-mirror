From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fast-export: fix argument name in error messages
Date: Fri, 12 Apr 2013 09:50:11 -0700
Message-ID: <7vy5cnelrw.fsf@alter.siamese.dyndns.org>
References: <43FA6C2A-A2C3-474F-889A-8059CE24175A@astro.princeton.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Paul Price <price@astro.princeton.edu>
X-From: git-owner@vger.kernel.org Fri Apr 12 18:50:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQhBA-00006L-2W
	for gcvg-git-2@plane.gmane.org; Fri, 12 Apr 2013 18:50:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753620Ab3DLQuR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Apr 2013 12:50:17 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47312 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751183Ab3DLQuQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Apr 2013 12:50:16 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A894315501;
	Fri, 12 Apr 2013 16:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qUBfCr3Em2h5PzfRw9V26n6LIfs=; b=n/tcbk
	gGSSMZ2fohFIrDintUc/PReTfmTrwzwtFkdSoMs9QB1/N2xL9Sft1awXasImDxkJ
	Rxkffvfb8miFsGZTOZ/tqI10HU11NJpdjWvNTwVHeL6Paja8aFej0TG9/GlPb+U8
	0aWRNOaERz+1aIKzsoP079OVUdzUDSrnYzXR4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=T2pkAlzvPdfc5tGiJcDZGM427aHlempe
	C5pg1FxT6eKuNCMdmKSObGtrgcz6QLcwSmUFXRDXEIC8QmLWZeVHSl+oaxFqzOc8
	ws/BwJyDs+N9SQoEStZvWEpvII1fTKOLTDYOFZchbF4dCkOblPpu3fAZinhLZ0yM
	FzvxaScfPnQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A054915500;
	Fri, 12 Apr 2013 16:50:13 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0E1B2154FE; Fri, 12 Apr
 2013 16:50:12 +0000 (UTC)
In-Reply-To: <43FA6C2A-A2C3-474F-889A-8059CE24175A@astro.princeton.edu> (Paul
 Price's message of "Fri, 12 Apr 2013 10:05:55 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0B5B3488-A391-11E2-88A5-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221000>

Paul Price <price@astro.princeton.edu> writes:

> The --signed-tags argument is plural, while error messages referred
> to --signed-tag (singular).  Tweak error messages to correspond to the
> argument.
>
> Signed-off-by: Paul Price <price@astro.princeton.edu>
> ---
> First submission; please report any formatting or style errors privately.

The patch is trivially whitespace-damaged but was easy enough to
correct locally here.

Applied; thanks.

>
> builtin/fast-export.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/fast-export.c b/builtin/fast-export.c
> index 77dffd1..ad9d0c4 100644
> --- a/builtin/fast-export.c
> +++ b/builtin/fast-export.c
> @@ -43,7 +43,7 @@ static int parse_opt_signed_tag_mode(const struct option *opt,
> 	else if (!strcmp(arg, "strip"))
> 		signed_tag_mode = STRIP;
> 	else
> -		return error("Unknown signed-tag mode: %s", arg);
> +		return error("Unknown signed-tags mode: %s", arg);
> 	return 0;
> }
>
> @@ -416,7 +416,7 @@ static void handle_tag(const char *name, struct tag *tag)
> 			switch(signed_tag_mode) {
> 			case ABORT:
> 				die ("Encountered signed tag %s; use "
> -				     "--signed-tag=<mode> to handle it.",
> +				     "--signed-tags=<mode> to handle it.",
> 				     sha1_to_hex(tag->object.sha1));
> 			case WARN:
> 				warning ("Exporting signed tag %s",
