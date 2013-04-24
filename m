From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-imap-send.txt: remove the use of sslverify=false
Date: Wed, 24 Apr 2013 10:18:05 -0700
Message-ID: <7vr4hzetki.fsf@alter.siamese.dyndns.org>
References: <20130420140802.GC29454@ruderich.org> <51758EE8.7030800@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Barbu Paul - Gheorghe <barbu.paul.gheorghe@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 24 19:18:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UV3Kn-0005G1-4F
	for gcvg-git-2@plane.gmane.org; Wed, 24 Apr 2013 19:18:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756234Ab3DXRSL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Apr 2013 13:18:11 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36623 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756213Ab3DXRSI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Apr 2013 13:18:08 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B45F319062;
	Wed, 24 Apr 2013 17:18:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=jxAsaDZQnhNnsXKJoNmFbP9Ud/s=; b=mQgtfW9UoxlKzpS/WbjR
	4jQVanX2R66B2f3TxLCAepbdD3xpIaZo5zccjo0zWpqngxL17w1dBDGQ8MHA+gmJ
	+BxKw0MyN3RJH9DcUXbxTgFEsw6HLauUgLCynm7dMftM5MelMfSl5hhZpc1fL/7Q
	IMbKmZiJK20P7H1ymeetymg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=TGNzYmwZBqx58A1EWoJoMT5FEDIJm3gf5qb59S8bYS7b5o
	CLbUdzIkJ9xYjmRpkHzQ/V8DgnACR3Co0iazMG2JVIf24AqO8Zs+21yD/C52E//C
	94fxazx0UvUdREfWe5hTI9iAkYG8DR5xL1+UQNnHwzVlAAqRRFkFbADCFElhA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AB50119061;
	Wed, 24 Apr 2013 17:18:07 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2ADFE1905F;
	Wed, 24 Apr 2013 17:18:07 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EE2AE392-AD02-11E2-9FB3-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222273>

Barbu Paul - Gheorghe <barbu.paul.gheorghe@gmail.com> writes:

> Since SSL provides no protection if the certificates aren't verified it's
> better not to include sslverify=false in the examples.
> Also in the post 1.8.2.1 era git is able to properly verify the validity of a
> certificate as well it's origin.
>
> Signed-off-by: Barbu Paul - Gheorghe <barbu.paul.gheorghe@gmail.com>
> ---
>  Documentation/git-imap-send.txt | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/Documentation/git-imap-send.txt b/Documentation/git-imap-send.txt
> index 875d283..0d72977 100644
> --- a/Documentation/git-imap-send.txt
> +++ b/Documentation/git-imap-send.txt
> @@ -108,7 +108,6 @@ Using direct mode with SSL:
>      user = bob
>      pass = p4ssw0rd
>      port = 123
> -    sslverify = false
>  ..........................
>   @@ -123,7 +122,6 @@ to specify your account settings:
>  	host = imaps://imap.gmail.com
>  	user = user@gmail.com
>  	port = 993
> -	sslverify = false
>  ---------
>   You might need to instead use: folder = "[Google Mail]/Drafts" if you get an error

It is amusing that an MTA can mangle such a short patch this badly.

Count the number of preimage lines in the first hunk and you see
only 5 lines but you claim it has 7.  Where did the other two go?
The second hunk has the same problem.  "@@" that introduces the
second hunk is not at the leftmost column.  Where did the leading SP
come from?

The examples in the documentation are primarily to demonstrate how
the supported configurations and options can be used and for what
purpose. its secondary purpose is to nudge the readers into the best
practice.

So I'd suggest a patch that does these things instead of just
removing these two:

 (0) Remove the duplication between the Examples header with ~~~~~~
     underline and the EXAMPLE header with ------ underline.

 (1) Use the second hunk of your patch to remove sslverify=false
     from that imap.gmail.com example.  As a public service, it is
     unlikely that the server side is configured to throw a
     certificate that does not verify at you.

 (2) Instead of removing sslverify=false in the imap.example.com
     example, comment it out like this:

     -	sslverify = false
     +	; sslverify = false

     Then mention that the user may want to use sslverify=false
     while troubleshooting, if he suspects that the reason he is
     having trouble connecting is because the certificate he uses at
     the private server at example.com he is trying to set up (or
     has set up) may not be verified correctly.
