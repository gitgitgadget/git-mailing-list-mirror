From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/5] git-merge: add support for branch.<name>.mergeoptions
Date: Sat, 22 Sep 2007 17:51:26 -0700
Message-ID: <7vps0adx0x.fsf@gitster.siamese.dyndns.org>
References: <1190421186-21784-1-git-send-email-hjemli@gmail.com>
	<1190421186-21784-2-git-send-email-hjemli@gmail.com>
	<1190421186-21784-3-git-send-email-hjemli@gmail.com>
	<1190421186-21784-4-git-send-email-hjemli@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Lars Hjemli <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 23 02:51:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IZFh9-0003Ep-3e
	for gcvg-git-2@gmane.org; Sun, 23 Sep 2007 02:51:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751861AbXIWAv2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Sep 2007 20:51:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752013AbXIWAv1
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Sep 2007 20:51:27 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:65318 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751614AbXIWAv1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Sep 2007 20:51:27 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070923005127.TEHE18654.fed1rmmtao102.cox.net@fed1rmimpo01.cox.net>;
          Sat, 22 Sep 2007 20:51:27 -0400
Received: from localhost ([68.225.240.77])
	by fed1rmimpo01.cox.net with bizsmtp
	id rcrS1X0011gtr5g0000000; Sat, 22 Sep 2007 20:51:26 -0400
In-Reply-To: <1190421186-21784-4-git-send-email-hjemli@gmail.com> (Lars
	Hjemli's message of "Sat, 22 Sep 2007 02:33:04 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58947>

Lars Hjemli <hjemli@gmail.com> writes:

> diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
> index 144bc16..b1771a1 100644
> --- a/Documentation/git-merge.txt
> +++ b/Documentation/git-merge.txt
> @@ -58,6 +58,10 @@ merge.verbosity::
>  	above outputs debugging information.  The default is level 2.
>  	Can be overriden by 'GIT_MERGE_VERBOSITY' environment variable.
>  
> +branch.<name>.mergeoptions::
> +	Sets default options for merging into branch <name>. The syntax and
> +	supported options are equal to that of git-merge, but option values
> +	containing whitespace characters are currently not supported.

I think this is a sensible thing to do in general.

> +branch=$(git-symbolic-ref HEAD | sed -e 's|^refs/heads/||')
> +mergeopts=$(git config "branch.$branch.mergeoptions")
> +parse_config $mergeopts

What should happen when your head is detached?
