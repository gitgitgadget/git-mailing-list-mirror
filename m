From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Allow 'git blame rev path' to work on bare repository
Date: Sat, 03 Nov 2007 22:21:53 -0700
Message-ID: <7vabpuvb4e.fsf@gitster.siamese.dyndns.org>
References: <1194092575-7133-1-git-send-email-mh@glandium.org>
	<1194092575-7133-2-git-send-email-mh@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Sun Nov 04 06:22:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IoXw4-0004Sj-KO
	for gcvg-git-2@gmane.org; Sun, 04 Nov 2007 06:22:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752863AbXKDFV6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Nov 2007 01:21:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752513AbXKDFV6
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Nov 2007 01:21:58 -0400
Received: from sceptre.pobox.com ([207.106.133.20]:53048 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751458AbXKDFV6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Nov 2007 01:21:58 -0400
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 297D52F0;
	Sun,  4 Nov 2007 01:22:19 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id B695E90031;
	Sun,  4 Nov 2007 01:22:16 -0400 (EDT)
In-Reply-To: <1194092575-7133-2-git-send-email-mh@glandium.org> (Mike Hommey's
	message of "Sat, 3 Nov 2007 13:22:54 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63349>

Mike Hommey <mh@glandium.org> writes:

> While 'git blame rev -- path' works, 'git blame rev path' didn't.
>
> Signed-off-by: Mike Hommey <mh@glandium.org>
> ---
>  builtin-blame.c |    4 ----
>  1 files changed, 0 insertions(+), 4 deletions(-)
>
> diff --git a/builtin-blame.c b/builtin-blame.c
> index aedc294..141287e 100644
> --- a/builtin-blame.c
> +++ b/builtin-blame.c
> @@ -2294,10 +2294,6 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
>  			}
>  			else if (i != argc - 1)
>  				usage(blame_usage); /* garbage at end */
> -
> -			if (!has_path_in_work_tree(path))
> -				die("cannot stat path %s: %s",
> -				    path, strerror(errno));
>  		}
>  	}
>  

Sorry but a NAK; at least limit the removal of the test only to a bare
repository case.
