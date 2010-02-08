From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] filter-branch: Fix error message for --prune-empty --commit-filter
Date: Mon, 08 Feb 2010 11:10:45 +0100
Message-ID: <4B6FE325.5000909@drmicha.warpmail.net>
References: <1265596587-9949-1-git-send-email-jacob.helwig@gmail.com> <1265596681-10561-1-git-send-email-jacob.helwig@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jacob Helwig <jacob.helwig@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 08 11:13:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NeQc3-0003DR-CY
	for gcvg-git-2@lo.gmane.org; Mon, 08 Feb 2010 11:13:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755292Ab0BHKM5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Feb 2010 05:12:57 -0500
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:47854 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754678Ab0BHKM4 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Feb 2010 05:12:56 -0500
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id BE4A7DEB11;
	Mon,  8 Feb 2010 05:12:55 -0500 (EST)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Mon, 08 Feb 2010 05:12:55 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=xOzU0DSimLsvvckE1nUcAW6aBXc=; b=OrWXRHDf/ObOFr/Eqy73NxAIILCKUJ/1IbMSqQYfBSfiR2hQlLPEenz8sT5HgGARWrOPhTAd4p0ZY3JU7k3TkPTzc8aUXaRF5dR0zSjIdui3m7KDiareuOIWprkNwXx657jbf46esKfqUfoCOfgzALW7lFU+Kp0G6we2EC2kyPY=
X-Sasl-enc: GoPZmvJ/IW00ZegTqsfv3Oht56iirDPVdvevBVFlo/C2 1265623975
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 1A4F93B3E1;
	Mon,  8 Feb 2010 05:12:54 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.8pre) Gecko/20100201 Lightning/1.0b2pre Shredder/3.0.2pre
In-Reply-To: <1265596681-10561-1-git-send-email-jacob.helwig@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139283>

Jacob Helwig venit, vidit, dixit 08.02.2010 03:38:
> Running filter-branch with --prune-empty and --commit-filter, no longer
> incorrectly reports that you had tried to run '--filter-commit' in
> combination with '--prune-empty'.

In order to understand this sentence, I had to look twice at the patch text.

What's going on is that that typo was there from the beginning, right?
(Induced from the name of a script variable, I see.) How about:

Running filter-branch with --prune-empty and --commit-filter reports
"Cannot set --prune-empty and --filter-commit at the same time".

Change it to use the correct name "--commit-filter" of the option.


> Signed-off-by: Jacob Helwig <jacob.helwig@gmail.com>
> ---
> 
> Sorry for the re-send.  Forgot the SOB...
> 
>  git-filter-branch.sh |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/git-filter-branch.sh b/git-filter-branch.sh
> index e95845c..88fb0f0 100755
> --- a/git-filter-branch.sh
> +++ b/git-filter-branch.sh
> @@ -207,7 +207,7 @@ t,)
>  ,*)
>  	;;
>  *)
> -	die "Cannot set --prune-empty and --filter-commit at the same time"
> +	die "Cannot set --prune-empty and --commit-filter at the same time"
>  esac
>  
>  case "$force" in
