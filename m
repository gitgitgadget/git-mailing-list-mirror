From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/1] Fix recipient santitization
Date: Wed, 21 May 2008 12:38:06 -0700
Message-ID: <7vzlqj1m8x.fsf@gitster.siamese.dyndns.org>
References: <1206713344-11244-1-git-send-email-vonbrand@inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 21 21:39:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jyu9R-0006mw-Ss
	for gcvg-git-2@gmane.org; Wed, 21 May 2008 21:39:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759078AbYEUTiP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 May 2008 15:38:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757102AbYEUTiP
	(ORCPT <rfc822;git-outgoing>); Wed, 21 May 2008 15:38:15 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:35342 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756231AbYEUTiO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 May 2008 15:38:14 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 95AE665A8;
	Wed, 21 May 2008 15:38:12 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id E3A0B65A5; Wed, 21 May 2008 15:38:09 -0400 (EDT)
In-Reply-To: <1206713344-11244-1-git-send-email-vonbrand@inf.utfsm.cl> (Horst
 H. von Brand's message of "Fri, 28 Mar 2008 11:09:04 -0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 730B0D88-276D-11DD-B915-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82570>

Last night I was going through old mail-logs and found this, which I think
still is needed.  Does anybody see anything wrong with the patch (aside
from missing full-stop at the end of the sentence)?

"Horst H. von Brand" <vonbrand@inf.utfsm.cl> writes:

> Need to quote all special characters, not just the first one
>
> Signed-off-by: Horst H. von Brand <vonbrand@inf.utfsm.cl>
> ---
>  git-send-email.perl |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/git-send-email.perl b/git-send-email.perl
> index f62f119..3bdd225 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -635,7 +635,7 @@ sub sanitize_address
>  
>  	# double quotes are needed if specials or CTLs are included
>  	elsif ($recipient_name =~ /[][()<>@,;:\\".\000-\037\177]/) {
> -		$recipient_name =~ s/(["\\\r])/\\$1/;
> +		$recipient_name =~ s/(["\\\r])/\\$1/g;
>  		$recipient_name = "\"$recipient_name\"";
>  	}
>  
> -- 
> 1.5.5.rc2
