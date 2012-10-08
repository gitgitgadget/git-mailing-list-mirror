From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t/t5400-send-pack: Use POSIX options to cp for
 portability
Date: Mon, 08 Oct 2012 09:35:27 -0700
Message-ID: <7vlifgncq8.fsf@alter.siamese.dyndns.org>
References: <1349683681-18978-1-git-send-email-bdwalton@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ben Walton <bdwalton@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 08 18:35:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TLGJ6-00036T-1P
	for gcvg-git-2@plane.gmane.org; Mon, 08 Oct 2012 18:35:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754069Ab2JHQff (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Oct 2012 12:35:35 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33459 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754021Ab2JHQf3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Oct 2012 12:35:29 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3AD8F9596;
	Mon,  8 Oct 2012 12:35:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=z2F6J2/+k8ayWip0wn173te+zcE=; b=VIQY/G
	hPquXRA7U7fgSeXBZP1x8relMo2DZCmN74YLrIMj6tHwnMBTFhzmgTbgGWeGLa63
	rVVRIGX3IL5BuWQzZcuQkpiyMprI6kxXYSMatjdoaFpllYStsBkeYA7qfwbmuxtV
	rrInpWwZ4FyjMsNdZa0Ottn9Iu8D45J/DAmIU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZDEM7mrm0TrPxnWxfm2GhO3fsb3esPNf
	UwFv66xfvb4nJlrnGlZ9JDjNhkfNSm+awItCZX9E+pGTw89GO7HEM+RgJoxCQzrq
	Ef52lt3ELCjRbx6+65tiGztp89b2Ok4AQCloKQATgaJ6ftUl9c24bKRyeKYxn3Lf
	oP1uAnlwpmc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2489E9595;
	Mon,  8 Oct 2012 12:35:29 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9456C9593; Mon,  8 Oct 2012
 12:35:28 -0400 (EDT)
In-Reply-To: <1349683681-18978-1-git-send-email-bdwalton@gmail.com> (Ben
 Walton's message of "Mon, 8 Oct 2012 09:08:01 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2B595BB0-1166-11E2-AB82-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207238>

Ben Walton <bdwalton@gmail.com> writes:

> Avoid a GNU-ism in the cp options used by t5400-send-pack.  Change -a
> to -pR.
>
> Signed-off-by: Ben Walton <bdwalton@gmail.com>
> ---

Thanks, but is "-p" essential for this test to pass, or can we get
away with just "-R"?

>  t/t5400-send-pack.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/t/t5400-send-pack.sh b/t/t5400-send-pack.sh
> index 250c720..65b3b0f 100755
> --- a/t/t5400-send-pack.sh
> +++ b/t/t5400-send-pack.sh
> @@ -159,7 +159,7 @@ test_expect_success 'receive-pack runs auto-gc in remote repo' '
>  	    git commit -a -m "Second commit" &&
>  	    git repack
>  	) &&
> -	cp -a parent child &&
> +	cp -pR parent child &&
>  	(
>  	    # Set the child to auto-pack if more than one pack exists
>  	    cd child &&
