From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Make gc a builtin.
Date: Wed, 14 Mar 2007 02:07:27 -0400
Message-ID: <20070314060727.GC20978@spearce.org>
References: <11738375021267-git-send-email-jbowes@dangerouslyinc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, junkio@cox.net, Johannes.Schindelin@gmx.de
To: James Bowes <jbowes@dangerouslyinc.com>
X-From: git-owner@vger.kernel.org Wed Mar 14 07:07:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HRMeS-0003Iy-TH
	for gcvg-git@gmane.org; Wed, 14 Mar 2007 07:07:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030319AbXCNGHk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Mar 2007 02:07:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030480AbXCNGHk
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Mar 2007 02:07:40 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:49211 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030319AbXCNGHi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Mar 2007 02:07:38 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HRMe4-00030L-6J; Wed, 14 Mar 2007 02:07:32 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 1A02B20FBAE; Wed, 14 Mar 2007 02:07:28 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <11738375021267-git-send-email-jbowes@dangerouslyinc.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42175>

James Bowes <jbowes@dangerouslyinc.com> wrote:
> Signed-off-by: James Bowes <jbowes@dangerouslyinc.com>

ACK.  Very nicely done.

...
> +	if (pack_refs && run_command_v_opt(argv_pack_refs, RUN_GIT_CMD))
> +		return error(FAILED_RUN, argv_pack_refs[0]);
> +
> +	if (run_command_v_opt(argv_reflog, RUN_GIT_CMD))
> +		return error(FAILED_RUN, argv_reflog[0]);
> +
> +	if (run_command_v_opt(argv_repack, RUN_GIT_CMD))
> +		return error(FAILED_RUN, argv_repack[0]);
> +
> +	if (prune && run_command_v_opt(argv_prune, RUN_GIT_CMD))
> +		return error(FAILED_RUN, argv_prune[0]);
> +
> +	if (run_command_v_opt(argv_rerere, RUN_GIT_CMD))
> +		return error(FAILED_RUN, argv_rerere[0]);

And isn't the above so much more readable than this mess?

> -test "true" != "$pack_refs" ||
> -git-pack-refs --prune &&
> -git-reflog expire --all &&
> -git-repack -a -d -l &&
> -$no_prune git-prune &&
> -git-rerere gc || exit

Which is why I like builtins, and why I think Dscho does too.

-- 
Shawn.
