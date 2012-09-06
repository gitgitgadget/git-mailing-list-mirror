From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] ls-remote: document the '--get-url' option
Date: Thu, 06 Sep 2012 13:49:03 -0700
Message-ID: <7v7gs63mio.fsf@alter.siamese.dyndns.org>
References: <1346952441-20666-1-git-send-email-stefan.naewe@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
	<u.kleine-koenig@pengutronix.de>
To: Stefan Naewe <stefan.naewe@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 06 22:49:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T9j0t-0005EV-2z
	for gcvg-git-2@plane.gmane.org; Thu, 06 Sep 2012 22:49:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759967Ab2IFUtI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Sep 2012 16:49:08 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55504 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759865Ab2IFUtG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Sep 2012 16:49:06 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 012F78E37;
	Thu,  6 Sep 2012 16:49:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7WOijLxdAxC7Fj5g7/Hpg5TI/WI=; b=M3IvtE
	3ATmiSYr8t3ROgTcEICsgfEVp5KqfAgYlAWUlx3ngS15h0DPcAn7nbczB3fM8ffW
	9pqnYAKihpTJFIdVMRC7/y+G2XXWeWPa0a3hnC0CDeHy+utKECTVJ+qgPX/WI868
	dJEAz+Iqaq49/YsQbHVQXq2pwo2l+8TZibJ20=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VON02YepNGC5FChazKWeAYzVfU68jzA6
	hrA/1NlS+DEm9AUZro8AOHK2Hgm+IWfDz48v52G4GxZZncKkbXP5mbgTTwr8gdaY
	mlmv2jWEtF+D2Z+4afQ0LvD/1Ev3n+FzIE9rQ8ubzTsTvdBP40icJMHDQLDeL+sO
	uqX411tD3xo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DFA3F8E36;
	Thu,  6 Sep 2012 16:49:05 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2205D8E32; Thu,  6 Sep 2012
 16:49:05 -0400 (EDT)
In-Reply-To: <1346952441-20666-1-git-send-email-stefan.naewe@gmail.com>
 (Stefan Naewe's message of "Thu, 6 Sep 2012 19:27:21 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4BE3E4F6-F864-11E1-BF74-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204921>

Stefan Naewe <stefan.naewe@gmail.com> writes:

> While looking for a way to expand the URL of a remote
> that uses a 'url.<name>.insteadOf' config option I stumbled
> over the undocumented '--get-url' option of 'git ls-remote'.
> This adds some minimum documentation for that option.
>
> Signed-off-by: Stefan Naewe <stefan.naewe@gmail.com>
> ---
>  Documentation/git-ls-remote.txt | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/Documentation/git-ls-remote.txt b/Documentation/git-ls-remote.txt
> index 7a9b86a..5819ead 100644
> --- a/Documentation/git-ls-remote.txt
> +++ b/Documentation/git-ls-remote.txt
> @@ -42,6 +42,10 @@ OPTIONS
>  	it successfully talked with the remote repository, whether it
>  	found any matching refs.
>  
> +--get-url::
> +	Expand the URL of the given remote repository taking into account any 
> +	"url.<base>.insteadOf" config setting (See linkgit:git-config[1]).
> +
>  <repository>::
>  	Location of the repository.  The shorthand defined in
>  	$GIT_DIR/branches/ can be used. Use "." (dot) to list references in

OK.  Do we want to also add this to the "git ls-remote -h" output,
or is it used so infrequently that it is not worth cluttering the
help text there?
