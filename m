From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v9 3/5] t4205, t6006, t7102: make functions more readable
Date: Thu, 04 Jul 2013 23:45:57 -0700
Message-ID: <7v61wpbj2y.fsf@alter.siamese.dyndns.org>
References: <cover.1372939482.git.Alex.Crezoff@gmail.com>
	<cover.1372719264.git.Alex.Crezoff@gmail.com>
	<cover.1372939482.git.Alex.Crezoff@gmail.com>
	<aeb5182a691105600edc181c08020cfaa350c7df.1372939482.git.Alex.Crezoff@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, John Keeping <john@keeping.me.uk>,
	Johannes Sixt <j.sixt@viscovery.net>
To: Alexey Shumkin <alex.crezoff@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 05 08:46:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UuzmR-0007kL-N3
	for gcvg-git-2@plane.gmane.org; Fri, 05 Jul 2013 08:46:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757054Ab3GEGqC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jul 2013 02:46:02 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45349 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756941Ab3GEGqB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jul 2013 02:46:01 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 26A7828C6D;
	Fri,  5 Jul 2013 06:46:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/kA2B8Z0MaQvkz6eGjxk/I9lViU=; b=TsdM9Z
	L7h7hmOsAH+AErKXR9nJ8X+sQdsL9LffbZZWY/2gKfQWt23Eu0Gc+DjIKaFjEWyQ
	bJKQ4M5kdxoz4p25OgNlmjANdi7JRrnSoHV+a1exSsdqK+UYtPeQB5h9UrExq6Y4
	TUnLHK9ZIexhke2gx+DssVnGEleSL/1nqRUwA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ix8wOwFb+WzS3anOSAPBhfvnWBRX9I/q
	sZjHj4gfM6/7F1UTzDoD3thigYe8WrjFgsDl60aGH70EuKwMjZD5ddvlP/26gRsm
	cjQ3Y8OvPT0VWlcdUnasLAqxCDZl5qCB9PV/RinDrpVwDuxWB7IGFzfbIPzxYxHD
	q50nZY7UUCI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1BD1328C6C;
	Fri,  5 Jul 2013 06:46:00 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 61C7A28C67;
	Fri,  5 Jul 2013 06:45:59 +0000 (UTC)
In-Reply-To: <aeb5182a691105600edc181c08020cfaa350c7df.1372939482.git.Alex.Crezoff@gmail.com>
	(Alexey Shumkin's message of "Thu, 4 Jul 2013 16:45:48 +0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8D318EFA-E53E-11E2-9D34-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229625>

Alexey Shumkin <alex.crezoff@gmail.com> writes:

> Function 'test_format' is become hard to read after its change in
> de6029a2d7734a93a9e27b9c4471862a47dd8123. So, make it more elegant.
> Also, change 'commit_msg' function to make it more pretty.

I do not know where you pick up these "more elegant" and "more
pretty" from, but please refrain from using _only_ such vague and
subjective phrases to describe the change in the log message.
Saying "make it <<better>> by doing X" (with various subjective
adjectives to say "better") is fine, but make sure you have "doing
X" part in the explanation.

Perhaps like this.

    Function 'test_format' has become harder to read after its
    change in de6029a2 (pretty: Add failing tests: --format output
    should honor logOutputEncoding, 2013-06-26).  Simplify it by
    moving its "should we expect it to fail?" parameter to the end.

I cannot read why you think the updated commit_msg is "more pretty"
in the message or in the patch.

> -commit_msg () {
> -	# String "initial. initial" partly in German (translated with Google Translate),
> +commit_msg() {

Style.  Have SP on both sides of () in a shell function definition.

> +	# String "initial. initial" partly in German
> +	# (translated with Google Translate),
>  	# encoded in UTF-8, used as a commit log message below.
>  	msg=$(printf "initial. anf\303\244nglich")
>  	if test -n "$1"

This is not "more pretty" but "better commented".

> diff --git a/t/t7102-reset.sh b/t/t7102-reset.sh
> index 2ef96e9..73a1bdb 100755
> --- a/t/t7102-reset.sh
> +++ b/t/t7102-reset.sh
> @@ -9,15 +9,17 @@ Documented tests for git reset'
>  
>  . ./test-lib.sh
>  
> -commit_msg () {
> -	# String "modify 2nd file (changed)" partly in German(translated with Google Translate),
> +commit_msg() {
> +	# String "modify 2nd file (changed)" partly in German
> +	# (translated with Google Translate),
>  	# encoded in UTF-8, used as a commit log message below.
> -	msg=$(printf "modify 2nd file (ge\303\244ndert)")
> +	printf "modify 2nd file (ge\303\244ndert)" |
>  	if test -n "$1"
>  	then
> -		msg=$(echo $msg | iconv -f utf-8 -t $1)
> +		iconv -f utf-8 -t $1
> +	else
> +		cat
>  	fi
> -	echo $msg

Is it "more pretty"?  The "we have to have cat only because we want
to pipe into a conditional" look somewhat ugly.

	msg="modify 2nd file (ge\303\244ndert)"
        if test -n "$1"
	then
		printf "$msg" | iconv -f utf-8 -t "$1"
	else
		printf "$msg"
	fi

>  }
>  
>  test_expect_success 'creating initial files and commits' '
