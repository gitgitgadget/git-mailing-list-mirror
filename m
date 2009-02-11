From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/4] completion: Use consistent if [...] convention. No
 test.
Date: Wed, 11 Feb 2009 10:14:26 -0800
Message-ID: <7v63jgg7st.fsf@gitster.siamese.dyndns.org>
References: <1234375406-27099-1-git-send-email-ted@tedpavlic.com>
 <1234375406-27099-2-git-send-email-ted@tedpavlic.com>
 <1234375406-27099-3-git-send-email-ted@tedpavlic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: spearce@spearce.org, git@vger.kernel.org
To: Ted Pavlic <ted@tedpavlic.com>
X-From: git-owner@vger.kernel.org Wed Feb 11 19:16:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXJcu-0003dB-Ty
	for gcvg-git-2@gmane.org; Wed, 11 Feb 2009 19:16:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755610AbZBKSOe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Feb 2009 13:14:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755066AbZBKSOd
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Feb 2009 13:14:33 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:64664 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753942AbZBKSOd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Feb 2009 13:14:33 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id BB4782AEB6;
	Wed, 11 Feb 2009 13:14:31 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id E7C9E2AE50; Wed,
 11 Feb 2009 13:14:27 -0500 (EST)
In-Reply-To: <1234375406-27099-3-git-send-email-ted@tedpavlic.com> (Ted
 Pavlic's message of "Wed, 11 Feb 2009 13:03:24 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: D4439D38-F867-11DD-A1D7-6F7C8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109471>

Ted Pavlic <ted@tedpavlic.com> writes:

> -		if [ -d "$g/rebase-apply" ]
> -		then
> -			if test -f "$g/rebase-apply/rebasing"
> -			then
> +		if [ -d "$g/rebase-apply" ]; then
> +			if [ -f "$g/rebase-apply/rebasing" ]; then
>  				r="|REBASE"
> -			elif test -f "$g/rebase-apply/applying"
> -			then
> +            elif [ -f "$g/rebase-apply/applying" ]; then
>  				r="|AM"
>  			else

What's with this funny indentation?

As a general rule, it usually is a good idea to apply clean-up to the
codebase before starting substantial work, but that holds true only when
the clean-up is undisputed.  Otherwise you would end up holding the later,
more "interesting" work a hostage to an earlier potentially controversial
"clean-up".

I think this particular clean-up makes the odd-ball __git_ps1 more
consnstent with the rest of the script, but it ultimately is Shawn's
call.
