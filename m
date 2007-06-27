From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-send-email: Add --threaded option
Date: Tue, 26 Jun 2007 22:21:59 -0700
Message-ID: <7vvedaq8eg.fsf@assigned-by-dhcp.pobox.com>
References: <11828981103069-git-send-email-aroben@apple.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Adam Roben <aroben@apple.com>
X-From: git-owner@vger.kernel.org Wed Jun 27 07:22:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I3Pyo-0001ab-Mt
	for gcvg-git@gmane.org; Wed, 27 Jun 2007 07:22:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753018AbXF0FWD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Jun 2007 01:22:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753234AbXF0FWC
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Jun 2007 01:22:02 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:42200 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752978AbXF0FWB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jun 2007 01:22:01 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070627052201.MVVM17683.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Wed, 27 Jun 2007 01:22:01 -0400
Received: from assigned-by-dhcp.pobox.com ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id GVMz1X00G1kojtg0000000; Wed, 27 Jun 2007 01:22:00 -0400
In-Reply-To: <11828981103069-git-send-email-aroben@apple.com> (Adam Roben's
	message of "Tue, 26 Jun 2007 15:48:30 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51016>

Adam Roben <aroben@apple.com> writes:

> The --threaded option controls whether the In-Reply-To header will be set on
> any emails sent. The current behavior is to always set this header, so this
> option is most useful in its negated form, --no-threaded. This behavior can
> also be controlled through the 'sendemail.threaded' config setting.
>
> Signed-off-by: Adam Roben <aroben@apple.com>

Thanks.  I've always felt that send-email has too much built-in
policy; I think this is a sensible change.

> @@ -138,8 +141,8 @@ my (@to,@cc,@initial_cc,@bcclist,@xh,
>  	$initial_reply_to,$initial_subject,@files,$from,$compose,$time);
>  
>  # Behavior modification variables
> -my ($chain_reply_to, $quiet, $suppress_from, $no_signed_off_cc,
> -	$dry_run) = (1, 0, 0, 0, 0);
> +my ($threaded, $chain_reply_to, $quiet, $suppress_from, $no_signed_off_cc,
> +	$dry_run) = (1, 1, 0, 0, 0, 0);

While we are at it, you might want to make everything other than
quiet and dry_run overridable the same way.
