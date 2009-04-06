From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Add configuration variable for sign-off to
 format-patch
Date: Mon, 06 Apr 2009 01:14:25 -0700
Message-ID: <7veiw69p26.fsf@gitster.siamese.dyndns.org>
References: <20090331185018.GD72569@macbook.lan>
 <20090331200457.GA23879@coredump.intra.peff.net>
 <20090331204338.GA88381@macbook.lan>
 <20090401102610.GC26181@coredump.intra.peff.net>
 <20090401175153.GA90421@macbook.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Mon Apr 06 10:16:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lqk0X-0006R2-6Z
	for gcvg-git-2@gmane.org; Mon, 06 Apr 2009 10:16:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753119AbZDFIOg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Apr 2009 04:14:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752940AbZDFIOg
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Apr 2009 04:14:36 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:38426 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752539AbZDFIOf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Apr 2009 04:14:35 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id DF795A8B6D;
	Mon,  6 Apr 2009 04:14:31 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 652BCA8B6C; Mon,
  6 Apr 2009 04:14:26 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: F4FB878A-2282-11DE-9DDF-BB14ECB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115775>

Heiko Voigt <hvoigt@hvoigt.net> writes:

> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index ad22cb8..27cb7f1 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -715,6 +715,13 @@ format.thread::
>  	A true boolean value is the same as `shallow`, and a false
>  	value disables threading.
>  
> +format.signoff::
> +    A boolean value which lets you enable the `-s/--signoff` option of
> +    format-patch by default. *Note:* Adding the Signed-off-by: line to a
> +    patch should be a conscious act and means that you certify you have
> +    the rights to submit this work under the same open source license.
> +    Please see the 'SubmittingPatches' document for further discussion.

I have a mixed feeling about this description.  The existing description
on the --signoff option merely talks about what it does, leaving what it
means, and it is quite deliberate.  If your project uses S-o-b, it may be
useful.  If yours doesn't, you simply just don't use it.  It does not
matter to _us_ as the document writer what that line means to your
project.

We do want to make the reader think twice iff S-o-b is used in the
reader's project with the same meaning as it means in git and the Linux
kernel project, which is what the description you added is about.  But
should we just assume if anybody uses S-o-b convention in their project
they must give it the same meaning as we give it?

The patch looks straightforward enough, and the wording we can update if
somebody can come up with a better one, so I'll apply the patch to
'master' and we will go from there.

Thanks.
