From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Teach/Fix pull/fetch -q/-v options
Date: Mon, 17 Nov 2008 02:51:54 -0800
Message-ID: <7vy6ziy69h.fsf@gitster.siamese.dyndns.org>
References: <1226776980-9674-1-git-send-email-tuncer.ayaz@gmail.com>
 <4ac8254d0811170237o78060cb3k4a64dceaa3a475d0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: "Tuncer Ayaz" <tuncer.ayaz@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 17 11:53:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L21jk-0003E2-8B
	for gcvg-git-2@gmane.org; Mon, 17 Nov 2008 11:53:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753131AbYKQKw3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Nov 2008 05:52:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753135AbYKQKw2
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Nov 2008 05:52:28 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:55283 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753129AbYKQKw1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Nov 2008 05:52:27 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 74C7B7EDC7;
	Mon, 17 Nov 2008 05:52:25 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 198627ED9C; Mon,
 17 Nov 2008 05:52:02 -0500 (EST)
In-Reply-To: <4ac8254d0811170237o78060cb3k4a64dceaa3a475d0@mail.gmail.com>
 (Tuncer Ayaz's message of "Mon, 17 Nov 2008 11:37:07 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: D1D76162-B495-11DD-BD57-9CEDC82D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101217>

"Tuncer Ayaz" <tuncer.ayaz@gmail.com> writes:

> I think you need to have something like the following applied on top of
> what's in pu to be able to use "pull -v -v -v" and be able to count the
> occurrences via parse-options.c. What do you think?

Makes sense, except that as a futureproofing we may be better off doing
the same for -q as well.

> --- git-pull.sh 2008-11-17 11:32:19.000000000 +0100
> +++ git-pull.sh.b       2008-11-17 11:33:03.000000000 +0100
> @@ -26,7 +26,7 @@
>         -q|--quiet)
>                 verbosity=-q ;;
>         -v|--verbose)
> -               verbosity=-v ;;
> +               verbosity="$verbosity -v" ;;
>         -n|--no-stat|--no-summary)
>                 no_stat=-n ;;
>         --stat|--summary)
>
> Signed-off-by: Tuncer Ayaz <tuncer.ayaz@gmail.com>
