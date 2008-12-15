From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitweb: make feature_blame return a list
Date: Mon, 15 Dec 2008 14:20:03 -0800
Message-ID: <7v7i61w06k.fsf@gitster.siamese.dyndns.org>
References: <1229352709-4663-1-git-send-email-kraai@ftbfs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matt Kraai <kraai@ftbfs.org>
X-From: git-owner@vger.kernel.org Mon Dec 15 23:21:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LCLon-0001RL-H6
	for gcvg-git-2@gmane.org; Mon, 15 Dec 2008 23:21:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751337AbYLOWUL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Dec 2008 17:20:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751235AbYLOWUK
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Dec 2008 17:20:10 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:48436 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751232AbYLOWUJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Dec 2008 17:20:09 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 93E30878C4;
	Mon, 15 Dec 2008 17:20:08 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id C9F62878C3; Mon,
 15 Dec 2008 17:20:05 -0500 (EST)
In-Reply-To: <1229352709-4663-1-git-send-email-kraai@ftbfs.org> (Matt Kraai's
 message of "Mon, 15 Dec 2008 06:51:48 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 8825B150-CAF6-11DD-A23A-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103212>

Matt Kraai <kraai@ftbfs.org> writes:

> The feature defaults are expected to be a list, but feature_blame was
> returning a scalar.  This change makes it consistent with the other
> boolean feature subroutines.
>
> Signed-off-by: Matt Kraai <kraai@ftbfs.org>
> ---
>  gitweb/gitweb.perl |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 6eb370d..145e712 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -367,12 +367,12 @@ sub feature_blame {
>  	my ($val) = git_get_project_config('blame', '--bool');
>  
>  	if ($val eq 'true') {
> -		return 1;
> +		return (1);
>  	} elsif ($val eq 'false') {
> -		return 0;
> +		return (0);
>  	}
>  
> -	return $_[0];
> +	return ($_[0]);
>  }

My Perl may be getting rusty, but does the above make any difference?
How?
