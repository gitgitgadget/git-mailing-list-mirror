From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Highlight keyboard shortcuts in git-add--interactive
Date: Wed, 28 Nov 2007 15:56:23 -0800
Message-ID: <7vmysx2ac8.fsf@gitster.siamese.dyndns.org>
References: <1195655278-19535-1-git-send-email-win@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Thu Nov 29 00:56:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxWlu-0005s8-Dk
	for gcvg-git-2@gmane.org; Thu, 29 Nov 2007 00:56:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757726AbXK1X4b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2007 18:56:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757547AbXK1X4b
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Nov 2007 18:56:31 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:59092 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754102AbXK1X4a (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2007 18:56:30 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 1BDC02F9;
	Wed, 28 Nov 2007 18:56:52 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 9CEDB9AD1E;
	Wed, 28 Nov 2007 18:56:49 -0500 (EST)
In-Reply-To: <1195655278-19535-1-git-send-email-win@wincent.com> (Wincent
	Colaiuta's message of "Wed, 21 Nov 2007 15:27:58 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66469>

Wincent Colaiuta <win@wincent.com> writes:

> @@ -774,14 +774,14 @@ EOF
>  }
>  
>  sub main_loop {
> -	my @cmd = ([ 'status', \&status_cmd, ],
> -		   [ 'update', \&update_cmd, ],
> -		   [ 'revert', \&revert_cmd, ],
> -		   [ 'add untracked', \&add_untracked_cmd, ],
> -		   [ 'patch', \&patch_update_cmd, ],
> -		   [ 'diff', \&diff_cmd, ],
> -		   [ 'quit', \&quit_cmd, ],
> -		   [ 'help', \&help_cmd, ],
> +	my @cmd = ([ 'status', \&status_cmd, '[s]tatus', ],
> +		   [ 'update', \&update_cmd, '[u]date', ],
> +		   [ 'revert', \&revert_cmd, '[r]evert', ],
> +		   [ 'add untracked', \&add_untracked_cmd, '[a]dd untracked', ],
> +		   [ 'patch', \&patch_update_cmd, '[p]atch', ],
> +		   [ 'diff', \&diff_cmd, '[d]iff', ],
> +		   [ 'quit', \&quit_cmd, '[q]uit', ],
> +		   [ 'help', \&help_cmd, '[h]elp', ],
>  	);

I like the general idea of making it more obvious that you can use the
unique prefix, but I think you should make list_and_choose do this
automatically without adding a redundant element in the command array.

If you do so, the same highlighting will automatically appear when you
are picking which paths to update in the update subcommand, for example.
