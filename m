From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: [PATCH v3 3/7] config: teach the fetch.recurseSubmodules option
 the 'on-demand' value
Date: Wed, 02 Mar 2011 11:02:11 -0500
Message-ID: <4D6E6A03.2090902@xiplink.com>
References: <4D6D7A50.5090802@web.de> <4D6D7B00.1020807@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Wed Mar 02 17:01:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PuoUb-0006Z5-SQ
	for gcvg-git-2@lo.gmane.org; Wed, 02 Mar 2011 17:01:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754708Ab1CBQBc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Mar 2011 11:01:32 -0500
Received: from smtp112.iad.emailsrvr.com ([207.97.245.112]:52774 "EHLO
	smtp112.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751384Ab1CBQBb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Mar 2011 11:01:31 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp51.relay.iad1a.emailsrvr.com (SMTP Server) with ESMTP id 5128420BAC;
	Wed,  2 Mar 2011 11:01:31 -0500 (EST)
X-Virus-Scanned: OK
Received: by smtp51.relay.iad1a.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id 7EC6920C0E;
	Wed,  2 Mar 2011 11:01:30 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.13) Gecko/20101208 Thunderbird/3.1.7
In-Reply-To: <4D6D7B00.1020807@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168316>

On 11-03-01 06:02 PM, Jens Lehmann wrote:
> To enable the user to change the default behavior of "git fetch" and "git
> pull" regarding submodule recursion add the new "on-demand" value which
> has just been added to the "--recurse-submodules" command line option.
> 
> Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
> ---
>  Documentation/config.txt    |   10 +++++++---
>  submodule.c                 |    2 +-
>  t/t5526-fetch-submodules.sh |   28 ++++++++++++++++++++++++++++
>  3 files changed, 36 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 96ce272..7b06fe5 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -900,9 +900,13 @@ diff.wordRegex::
>  	characters are *ignorable* whitespace.
> 
>  fetch.recurseSubmodules::
> -	A boolean value which changes the behavior for fetch and pull, the
> -	default is to not recursively fetch populated submodules unless
> -	configured otherwise.
> +	This option can be either set to a boolean value or to 'on-demand'.
> +	Setting it to a boolean changes the behavior of fetch and pull to
> +	unconditionally recurse into submodules when set to true or to not
> +	recurse at all when set to false. When set to 'on-demand' (the default
> +	value), it tells fetch and pull to recurse only into those submodules
> +	where new commits are recorded in the commmits fetched for the
> +	superproject.

Nit: Replace the last sentence with

	When set to 'on-demand' (the default value), fetch and pull will
	only recurse into a populated submodule when its superproject
	retrieves a commit that updates the submodule's reference.

		M.
