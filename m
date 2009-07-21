From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Show the presence of untracked files in the bash
	prompt.
Date: Tue, 21 Jul 2009 10:19:52 -0700
Message-ID: <20090721171952.GS11191@spearce.org>
References: <20090721171445.GA25762@bug.science-computing.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Daniel Trstenjak <Daniel.Trstenjak@online.de>
To: Daniel Trstenjak <daniel.trstenjak@science-computing.de>
X-From: git-owner@vger.kernel.org Tue Jul 21 19:20:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MTJ0S-00083b-8i
	for gcvg-git-2@gmane.org; Tue, 21 Jul 2009 19:20:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755808AbZGURTx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jul 2009 13:19:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755736AbZGURTw
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Jul 2009 13:19:52 -0400
Received: from george.spearce.org ([209.20.77.23]:35492 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755646AbZGURTw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jul 2009 13:19:52 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 9A4A4381FD; Tue, 21 Jul 2009 17:19:52 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20090721171445.GA25762@bug.science-computing.de>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123678>

Daniel Trstenjak <daniel.trstenjak@science-computing.de> wrote:
> Added the envvar GIT_PS1_SHOWUNTRACKEDFILES to 'git-completion.bash'.
> When set to a nonempty value, then the char '%' will be shown next
> to the branch name in the bash prompt.
> @@ -156,12 +161,19 @@ __git_ps1 ()
>  			if [ -n "${GIT_PS1_SHOWSTASHSTATE-}" ]; then
>  			        git rev-parse --verify refs/stash >/dev/null 2>&1 && s="$"
>  			fi
> +
> +			if [ -n "${GIT_PS1_SHOWUNTRACKEDFILES-}" ]; then
> +			   local num_untracked_files=$(git ls-files --others --exclude-standard | wc -l)
> +			   if [ $num_untracked_files -gt "0" ]; then

Wouldn't using -n be easier here?

   if [ -n "$(git ls-files --others --exclude-standard)" ]; then

-- 
Shawn.
