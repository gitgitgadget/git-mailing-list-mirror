From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Enable setting attach as the default in .gitconfig
 for git-format-patch.
Date: Thu, 12 Feb 2009 13:01:25 -0800
Message-ID: <7vljsbl68q.fsf@gitster.siamese.dyndns.org>
References: <4994459B.8090002@codeweavers.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeremy White <jwhite@codeweavers.com>
X-From: git-owner@vger.kernel.org Thu Feb 12 22:03:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXii3-0007hH-Ed
	for gcvg-git-2@gmane.org; Thu, 12 Feb 2009 22:02:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758755AbZBLVBb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Feb 2009 16:01:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758227AbZBLVBb
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Feb 2009 16:01:31 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:36024 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757201AbZBLVBb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Feb 2009 16:01:31 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 99A552AFF6;
	Thu, 12 Feb 2009 16:01:29 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id F3D3B2AA64; Thu,
 12 Feb 2009 16:01:26 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 51C9EB64-F948-11DD-A4E0-6F7C8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109649>

Jeremy White <jwhite@codeweavers.com> writes:

> diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
> index 11a7d77..f89f73c 100644
> --- a/Documentation/git-format-patch.txt
> +++ b/Documentation/git-format-patch.txt
> @@ -10,7 +10,8 @@ SYNOPSIS
>  --------
>  [verse]
>  'git format-patch' [-k] [-o <dir> | --stdout] [--thread]
> -		   [--attach[=<boundary>] | --inline[=<boundary>]]
> +		   [--attach[=<boundary>] | --inline[=<boundary>] |
> +		     [--noattach]]

Hmph, don't we usually do this with --no-attach?  Especially when
format-patch starts using parse_options, I suspect that would be how the
API gives negated options natively.

If there are no other issues people find in this patch, I'll amend it to
use dash between no and attach and apply (hence no need to resend).

Thanks.
