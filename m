From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] diff: add ruby funcname pattern
Date: Fri, 01 Aug 2008 00:30:36 -0700
Message-ID: <7vmyjxtco3.fsf@gitster.siamese.dyndns.org>
References: <1217488908-19692-1-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 01 09:32:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOp7d-0000u8-94
	for gcvg-git-2@gmane.org; Fri, 01 Aug 2008 09:32:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758659AbYHAHao (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Aug 2008 03:30:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758633AbYHAHan
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Aug 2008 03:30:43 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:43410 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758612AbYHAHam (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Aug 2008 03:30:42 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 14990444E6;
	Fri,  1 Aug 2008 03:30:41 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 6A731444E5; Fri,  1 Aug 2008 03:30:38 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: BE725928-5F9B-11DD-954F-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91036>

Giuseppe Bilotta <giuseppe.bilotta@gmail.com> writes:

> Provide a regexp that catches class, module and method definitions in
> Ruby scripts, since the built-in default only finds classes.
>
> Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
> ---
>  diff.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/diff.c b/diff.c
> index cbf2547..c253015 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -1381,6 +1381,7 @@ static struct builtin_funcname_pattern {
>  			"[A-Za-z_][A-Za-z_0-9]*\\)\\{2,\\}"
>  			"[ 	]*([^;]*\\)$" },
>  	{ "tex", "^\\(\\\\\\(sub\\)*section{.*\\)$" },
> +	{ "ruby", "^\\s*\\(\\(class\\|module\\|def\\)\\s.*\\)$" },
>  };
>  
>  static const char *diff_funcname_pattern(struct diff_filespec *one)

Thanks.

I do not talk Ruby, so I'll wait for a few days to hear any one of the
following happen before deciding what to do with this patch:

 (1) Yeah, this is a sufficient and necessary set of keywords, and it
     would make my Ruby life so much better;

 (2) This might be a good start but you need to cover this and that
     keywords as well;

 (3) This will misidentify a line that is not the beginning of a
     definition, and should not be applied;

Needless to say, "Here is a better patch" is appreciated if somebody says
(2) or (3).
