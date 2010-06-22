From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v4] Do not decode url protocol.
Date: Tue, 22 Jun 2010 23:39:46 +0200
Message-ID: <vpqmxumu4pp.fsf@bauges.imag.fr>
References: <4C211A39.2080207@obry.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>
To: pascal@obry.net
X-From: git-owner@vger.kernel.org Tue Jun 22 23:40:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ORBCJ-0005Lb-Rv
	for gcvg-git-2@lo.gmane.org; Tue, 22 Jun 2010 23:40:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751099Ab0FVVjx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jun 2010 17:39:53 -0400
Received: from mx2.imag.fr ([129.88.30.17]:39874 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750777Ab0FVVjx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jun 2010 17:39:53 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id o5MLVLev020642
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 22 Jun 2010 23:31:21 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1ORBC7-0004xd-AO; Tue, 22 Jun 2010 23:39:47 +0200
In-Reply-To: <4C211A39.2080207@obry.net> (Pascal Obry's message of "Tue\, 22 Jun 2010 22\:16\:57 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 22 Jun 2010 23:31:21 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o5MLVLev020642
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1277847084.42474@vZeuwOysaR7unzd0HuVklQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149494>

Pascal Obry <pascal.obry@gmail.com> writes:

> When using the protocol git+ssh:// for example we do not want to
> decode the '+' as a space. The url decoding must take place only
> for the server name and parameters.
>
> This fixes a regression introduced in 9d2e942.
> ---
>  url.c |   19 +++++++++++++++----
>  1 files changed, 15 insertions(+), 4 deletions(-)
>
> Ok, so this is the fourth version of this patch. Thanks again Matthieu
> for the review. I think this time I got the place for the message
> right :)

Hmm, what's so unclear in "between the --- (tripple) and the
diffstat." ;-) ? (especially the "between" part)

> +       /* Skip protocol if present. */
> +       if (with_protocol) {
> +         first_slash = strchr(*query, '/');
> +
> +         while (q < first_slash)
> +               strbuf_addch(&out, *q++);
> +       }

Nothing personal, but you messed up indentation. Git indents with tabs
(8 chars width), not 2 spaces.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
