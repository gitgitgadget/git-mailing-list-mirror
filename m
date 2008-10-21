From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH 2/3] Add -n/--no-prompt option to mergetool
Date: Tue, 21 Oct 2008 13:49:30 +0200
Message-ID: <48FDC1CA.2080800@op5.se>
References: <1224583999-26279-1-git-send-email-charles@hashpling.org> <1224583999-26279-2-git-send-email-charles@hashpling.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	William Pursell <bill.pursell@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Theodore Ts'o <tytso@mit.edu>
To: Charles Bailey <charles@hashpling.org>
X-From: git-owner@vger.kernel.org Tue Oct 21 13:50:57 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KsFlI-0006bk-6d
	for gcvg-git-2@gmane.org; Tue, 21 Oct 2008 13:50:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753024AbYJULtm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Oct 2008 07:49:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752965AbYJULtm
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Oct 2008 07:49:42 -0400
Received: from mail.op5.se ([193.201.96.20]:47628 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752846AbYJULtk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Oct 2008 07:49:40 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id C29201B800B2;
	Tue, 21 Oct 2008 13:43:12 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -3.893
X-Spam-Level: 
X-Spam-Status: No, score=-3.893 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, AWL=0.506, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4aYw9MFV+JBJ; Tue, 21 Oct 2008 13:43:07 +0200 (CEST)
Received: from clix.int.op5.se (unknown [192.168.1.20])
	by mail.op5.se (Postfix) with ESMTP id A4BBD1B8006E;
	Tue, 21 Oct 2008 13:43:05 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
In-Reply-To: <1224583999-26279-2-git-send-email-charles@hashpling.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98782>

Charles Bailey wrote:
> This option lets git mergetool invoke the conflict resolution program
> without waiting for a user response each time.
> 
> Also added a mergetool.prompt (default true) configuration variable
> controlling the same behaviour.
> 
> Signed-off-by: Charles Bailey <charles@hashpling.org>
> ---
>  Documentation/config.txt        |    3 +++
>  Documentation/git-mergetool.txt |   11 ++++++++++-
>  git-mergetool.sh                |   16 +++++++++++++---
>  3 files changed, 26 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 29369d0..b4e4ee4 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -976,6 +976,9 @@ mergetool.keepBackup::
>  	is set to `false` then this file is not preserved.  Defaults to
>  	`true` (i.e. keep the backup files).
>  
> +mergetool.prompt::
> +	Prompt before each invocation of the merge resolution program.
> +
>  pack.window::
>  	The size of the window used by linkgit:git-pack-objects[1] when no
>  	window size is given on the command line. Defaults to 10.
> diff --git a/Documentation/git-mergetool.txt b/Documentation/git-mergetool.txt
> index e0b2703..6d6bfe0 100644
> --- a/Documentation/git-mergetool.txt
> +++ b/Documentation/git-mergetool.txt
> @@ -7,7 +7,7 @@ git-mergetool - Run merge conflict resolution tools to resolve merge conflicts
>  
>  SYNOPSIS
>  --------
> -'git mergetool' [--tool=<tool>] [<file>]...
> +'git mergetool' [--tool=<tool>] [-n|--no-prompt|--prompt] [<file>]...
>  
>  DESCRIPTION
>  -----------
> @@ -60,6 +60,15 @@ variable `mergetool.<tool>.trustExitCode` can be set to `true`.
>  Otherwise, 'git-mergetool' will prompt the user to indicate the
>  success of the resolution after the custom tool has exited.
>  
> +-n or --no-prompt::
> +	Don't prompt before each invocation of the merge resolution
> +	program.
> +

There is discussion already about "-n should be for dry-run!" and git's
inconsistencies in such matters. Wouldn't -y ("assume yes on prompt")
be better?

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
