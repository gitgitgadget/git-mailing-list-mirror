From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation typo.
Date: Wed, 06 Jun 2007 14:16:36 -0700
Message-ID: <7v4plkzsuj.fsf@assigned-by-dhcp.cox.net>
References: <11810823561507-git-send-email-madcoder@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Pierre Habouzit <pierre.habouzit@m4x.org>
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Wed Jun 06 23:16:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hw2s4-00068g-Qg
	for gcvg-git@gmane.org; Wed, 06 Jun 2007 23:16:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761076AbXFFVQi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Jun 2007 17:16:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934493AbXFFVQi
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jun 2007 17:16:38 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:43336 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761076AbXFFVQh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jun 2007 17:16:37 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070606211637.JDJT12556.fed1rmmtao107.cox.net@fed1rmimpo02.cox.net>;
          Wed, 6 Jun 2007 17:16:37 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 8MGc1X00c1kojtg0000000; Wed, 06 Jun 2007 17:16:37 -0400
In-Reply-To: <11810823561507-git-send-email-madcoder@debian.org> (Pierre
	Habouzit's message of "Wed, 6 Jun 2007 00:25:56 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49315>

Pierre Habouzit <madcoder@debian.org> writes:

> From: Pierre Habouzit <pierre.habouzit@m4x.org>
>
> Signed-off-by: Pierre Habouzit <madcoder@debian.org>
> ---
>  Documentation/pull-fetch-param.txt |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/Documentation/pull-fetch-param.txt b/Documentation/pull-fetch-param.txt
> index 8d4e950..5bcdbc8 100644
> --- a/Documentation/pull-fetch-param.txt
> +++ b/Documentation/pull-fetch-param.txt
> @@ -4,7 +4,7 @@
>  
>  <refspec>::
>  	The canonical format of a <refspec> parameter is
> -	`+?<src>:<dst>`; that is, an optional plus `+`, followed
> +	`\+?<src>:<dst>`; that is, an optional plus `+`, followed
>  	by the source ref, followed by a colon `:`, followed by
>  	the destination ref.
>  +

Not really.  I suspect you are using AsciiDoc 8?

Your patch does make AsciiDoc 8 keep '+' in the HTML output, but
manual page output gets an extra backslash, so it is not really
an improvement.

Unfortunately our documentation pages were written with AsciiDoc
7, and are not AsciiDoc 8 compatible.

With -aasciidoc7compatible, AsciiDoc 8 is _supposed_ to behave
compatibly, but in reality it does not format our documentation
correctly.  It certainly is possible that AsciiDoc 7 "happens to
work" with our documentation pages, and maybe the way we abuse
mark-ups can be argued the bug in _our_ documentation, but
nobody on our end worked on finding a satisfactory solution to
make our documentation format correctly with _both_ versions of
AsciiDoc yet.

I wrote about the differences between AsciiDoc 7, and AsciiDoc 8
with the "compatiblity" I found a few weeks ago on this list;
the most problematic was that 'asciidoc -aasciidoc7compatible'
loses carets in our description where they matter X-<.  The list
archive may know more about the details,
