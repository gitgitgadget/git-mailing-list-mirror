From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add userdiff patterns for Ada
Date: Sat, 15 Sep 2012 23:07:11 -0700
Message-ID: <7vboh6zek0.fsf@alter.siamese.dyndns.org>
References: <50554D67.1020204@redneon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Adrian Johnson <ajohnson@redneon.com>
X-From: git-owner@vger.kernel.org Sun Sep 16 08:07:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TD80s-00011F-Pk
	for gcvg-git-2@plane.gmane.org; Sun, 16 Sep 2012 08:07:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751486Ab2IPGHR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Sep 2012 02:07:17 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35611 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751412Ab2IPGHQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Sep 2012 02:07:16 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EB3065EA4;
	Sun, 16 Sep 2012 02:07:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3lNBMTzkIFV6fwZsooUm0VCwXiI=; b=OfJhQR
	cjkFOT+HN0a6iNUJXwAOWJKUpraLPerel+8Cz9RUOlSDoJvSse+LgHNQXAnWZgY+
	a3j/fBFxJbSYP8PaU0LqeSAsNZ7ofhe/QE3KtQuMYjJBkLudrTN74OPVLIBvDhLU
	Zk9EO7YXUV0BaMIw0Ew9Q3jwdmLu1rE5xeSI4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CxToF8guikblW8Kg19GrMX5wvTyXqdWP
	fj7CuCmgpy4FXtLX56tCpl212m41RX955eqb+F22YVD3om4VUxvlxmr05W+9Z6Y6
	xLSMpp+MpPkOYoQHWzdfJ5GrZqjnaTDrfU6pjjBKtN/BXjrWxfcpPcYJWuvc3hFR
	qyGLV7w5eEk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D92D55EA3;
	Sun, 16 Sep 2012 02:07:15 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9831B5EA0; Sun, 16 Sep 2012
 02:07:12 -0400 (EDT)
In-Reply-To: <50554D67.1020204@redneon.com> (Adrian Johnson's message of
 "Sun, 16 Sep 2012 13:24:15 +0930")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C1B45046-FFC4-11E1-93C1-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205595>

Adrian Johnson <ajohnson@redneon.com> writes:

> Add Ada xfuncname and wordRegex patterns to the list of builtin
> patterns.
>
> Signed-off-by: Adrian Johnson <ajohnson@redneon.com>
> ---

Interesting.  I do not read Ada, but in this "expect" file,...

> diff --git a/t/t4034/ada/expect b/t/t4034/ada/expect
> new file mode 100644
> index 0000000..be2376e
> --- /dev/null
> +++ b/t/t4034/ada/expect
> @@ -0,0 +1,27 @@
> +<BOLD>diff --git a/pre b/post<RESET>
> +<BOLD>index d96fdd1..df21bb0 100644<RESET>
> +<BOLD>--- a/pre<RESET>
> +<BOLD>+++ b/post<RESET>
> +<CYAN>@@ -1,13 +1,13 @@<RESET>
> +Ada.Text_IO.Put_Line("Hello World<RED>!<RESET><GREEN>?<RESET>");
> +1 1e<RED>-<RESET>10 16#FE12#E2 3.141_592 '<RED>x<RESET><GREEN>y<RESET>'
> +<RED>a<RESET><GREEN>x<RESET>+<RED>b a<RESET><GREEN>y x<RESET>-<RED>b<RESET>
> +<RED>a<RESET><GREEN>y<RESET>
> +<GREEN>x<RESET>*<RED>b a<RESET><GREEN>y x<RESET>/<RED>b<RESET>
> +<RED>a<RESET><GREEN>y<RESET>
> +<GREEN>x<RESET>**<RED>b<RESET>
> +<RED>a<RESET><GREEN>y<RESET>
> +<GREEN>x<RESET>(<RED>b<RESET><GREEN>y<RESET>)
> +<RED>a<RESET><GREEN>x<RESET>:=<RED>b<RESET>
> +<RED>a<RESET><GREEN>y<RESET>
> +<GREEN>x<RESET>=<RED>b a<RESET><GREEN>y x<RESET>/= <RED>b<RESET>
> +<RED>a<RESET><GREEN>y<RESET>
> +<GREEN>x<RESET><<RED>b a<RESET><GREEN>y x<RESET><=<RED>b a<RESET><GREEN>y x<RESET>><RED>b a<RESET><GREEN>y x<RESET>>=<RED>b<RESET>
> +<RED>a<RESET><GREEN>y<RESET>
> +<GREEN>x<RESET>,<RED>b<RESET>
> +<RED>a<RESET><GREEN>y<RESET>
> +<GREEN>x<RESET>=><RED>b<RESET>
> +<RED>a<RESET><GREEN>y<RESET>
> +<GREEN>x<RESET>..<RED>b<RESET>
> +<RED>a<RESET><GREEN>y<RESET>
> +<GREEN>x<RESET><><RED>b<RESET><GREEN>y<RESET>

I do not seem to find anything interesting after @@, which means
that xfuncname is not tested at all even though the log message
claims the patch adds some.

Puzzled...
