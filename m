From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] git send-email: make the message file name more
 specific.
Date: Sat, 01 Nov 2008 23:18:08 -0700
Message-ID: <7vwsfm3b33.fsf@gitster.siamese.dyndns.org>
References: <1225450632-7230-1-git-send-email-madcoder@debian.org>
 <1225456609-694-1-git-send-email-madcoder@debian.org>
 <1225456609-694-2-git-send-email-madcoder@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Sun Nov 02 07:23:27 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KwWMs-00077k-UQ
	for gcvg-git-2@gmane.org; Sun, 02 Nov 2008 07:23:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752347AbYKBGSZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Nov 2008 01:18:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752327AbYKBGSZ
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Nov 2008 01:18:25 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:36259 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752058AbYKBGSY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Nov 2008 01:18:24 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 7D56C77BE0;
	Sun,  2 Nov 2008 01:18:19 -0500 (EST)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 742BE77BDF; Sun,  2 Nov 2008 01:18:14 -0500 (EST)
In-Reply-To: <1225456609-694-2-git-send-email-madcoder@debian.org> (Pierre
 Habouzit's message of "Fri, 31 Oct 2008 13:36:47 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 0B15F17E-A8A6-11DD-9A70-9CEDC82D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99817>

Pierre Habouzit <madcoder@debian.org> writes:

> This helps editors choosing their syntax hilighting properly.

Even though I agree this is the right direction to go, unfortunately this
can break people's existing setup.

Having said that, if we were to do this, let's do it the right way and put
these "temporary" files under $GIT_DIR.

>
> Signed-off-by: Pierre Habouzit <madcoder@debian.org>
> ---
>  git-send-email.perl |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/git-send-email.perl b/git-send-email.perl
> index 65c254d..4ca571f 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -127,7 +127,7 @@ sub unique_email_list(@);
>  sub cleanup_compose_files();
>  
>  # Constants (essentially)
> -my $compose_filename = ".msg.$$";
> +my $compose_filename = ".gitsendemail.msg.$$";
>  
>  # Variables we fill in automatically, or via prompting:
>  my (@to,@cc,@initial_cc,@bcclist,@xh,
> -- 
> 1.6.0.3.763.g0275.dirty
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
