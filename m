From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH RFC 2/6] send-email: --smtp-server-port should take an
 integer
Date: Sat, 11 Apr 2009 12:22:29 -0700
Message-ID: <7vvdpbf11m.fsf@gitster.siamese.dyndns.org>
References: <1239139522-24118-1-git-send-email-mfwitten@gmail.com>
 <1239139522-24118-2-git-send-email-mfwitten@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael Witten <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 11 21:24:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LsioF-0004cm-7l
	for gcvg-git-2@gmane.org; Sat, 11 Apr 2009 21:24:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758794AbZDKTWh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Apr 2009 15:22:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758507AbZDKTWg
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Apr 2009 15:22:36 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:50087 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757445AbZDKTWg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Apr 2009 15:22:36 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 9150DA9E58;
	Sat, 11 Apr 2009 15:22:34 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 91F0AA9E57; Sat,
 11 Apr 2009 15:22:31 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 1C2FE9FA-26CE-11DE-B7C0-C121C5FC92D5-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116323>

Michael Witten <mfwitten@gmail.com> writes:

> Signed-off-by: Michael Witten <mfwitten@gmail.com>
> ---
>  git-send-email.perl |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/git-send-email.perl b/git-send-email.perl
> index 273c8c7..63d6063 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -251,7 +251,7 @@ my $rc = GetOptions("sender|from=s" => \$sender,
>  		    "chain-reply-to!" => \$chain_reply_to,
>  		    "delay=i" => \$delay,
>  		    "smtp-server=s" => \$smtp_server,
> -		    "smtp-server-port=s" => \$smtp_server_port,
> +		    "smtp-server-port=i" => \$smtp_server_port,
>  		    "smtp-user=s" => \$smtp_authuser,
>  		    "smtp-pass:s" => \$smtp_authpass,
>  		    "smtp-ssl" => sub { $smtp_encryption = 'ssl' },

Hmm, I have to wonder if there somebody who is using symbolic names for
ports, e.g. --smtp-server-port=ssmtp which this patch may start
rejecting.
