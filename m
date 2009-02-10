From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Enable setting attach as the default in .gitconfig
 for git-format-patch.
Date: Mon, 09 Feb 2009 17:41:46 -0800
Message-ID: <7v3aenrrtx.fsf@gitster.siamese.dyndns.org>
References: <498E50E2.8050309@codeweavers.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeremy White <jwhite@codeweavers.com>
X-From: git-owner@vger.kernel.org Tue Feb 10 02:43:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWhei-0000PQ-VJ
	for gcvg-git-2@gmane.org; Tue, 10 Feb 2009 02:43:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752689AbZBJBlx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Feb 2009 20:41:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752351AbZBJBlx
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Feb 2009 20:41:53 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:64376 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751661AbZBJBlw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Feb 2009 20:41:52 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 5669D2ACD2;
	Mon,  9 Feb 2009 20:41:51 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 907032ACCA; Mon, 
 9 Feb 2009 20:41:48 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: FD141CBA-F713-11DD-BDD6-6F7C8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109173>

Jeremy White <jwhite@codeweavers.com> writes:

> diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
> index 11a7d77..2e8e94e 100644
> --- a/Documentation/git-format-patch.txt
> +++ b/Documentation/git-format-patch.txt
> @@ -174,7 +174,8 @@ CONFIGURATION
>  -------------
>  You can specify extra mail header lines to be added to each message
>  in the repository configuration, new defaults for the subject prefix
> -and file suffix, and number patches when outputting more than one.
> +and file suffix, control attachements, and number patches when outputting
> +more than one.
>  
>  ------------
>  [format]
> @@ -183,6 +184,7 @@ and file suffix, and number patches when outputting more than one.
>  	suffix = .txt
>  	numbered = auto
>  	cc = <email>
> +	attach [ = mime-boundary-string ]
>  ------------

Once you added this configuration, if you ever wanted to defeat it for a
single invocation, how would you do so?  Edit the configuration file
again?

Not that I am objecting to the patch, as I am unlikely to have such a
configuration, but are there people who need to send attachment sometimes
but not other times?  They can say --attach from the command line without
adding the configuraiton if they send their patch non-attached more often
than as an attachment, but if they most of the time need to attach but
sometimes need to send in-line, they do not have an easy way to do so.
