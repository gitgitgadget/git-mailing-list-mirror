From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 3/3] Add a command "fix" to rebase --interactive.
Date: Fri, 4 Dec 2009 17:57:46 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0912041755220.21557@intel-tinevez-2-302>
References: <cover.1259934977.git.mhagger@alum.mit.edu> <6d779d2c244bf5d5b7924cdc5daf66a8186e4bc7.1259934977.git.mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, gitster@pobox.com
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri Dec 04 17:58:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NGbTh-0007zy-6h
	for gcvg-git-2@lo.gmane.org; Fri, 04 Dec 2009 17:57:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756960AbZLDQ5q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Dec 2009 11:57:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756935AbZLDQ5p
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Dec 2009 11:57:45 -0500
Received: from mail.gmx.net ([213.165.64.20]:58463 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756926AbZLDQ5o (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Dec 2009 11:57:44 -0500
Received: (qmail invoked by alias); 04 Dec 2009 16:57:50 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp067) with SMTP; 04 Dec 2009 17:57:50 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/gOhUPRV/gUqgMtTh2vZsg29KI2hivZFqZiNMbaB
	woVgYZI69dyzvd
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <6d779d2c244bf5d5b7924cdc5daf66a8186e4bc7.1259934977.git.mhagger@alum.mit.edu>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.52
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134537>

Hi,

On Fri, 4 Dec 2009, Michael Haggerty wrote:

> The command is like "squash", except that it discards the commit message
> of the corresponding commit.
> 
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>

The only part which made me a bit uneasy was this one:

> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> index 0bd3bf7..539413d 100755
> --- a/git-rebase--interactive.sh
> +++ b/git-rebase--interactive.sh
> @@ -302,7 +302,7 @@ nth_string () {
>  
>  make_squash_message () {
>  	if test -f "$SQUASH_MSG"; then
> -		COUNT=$(($(sed -n "s/^# This is [^0-9]*\([1-9][0-9]*\).*/\1/p" \
> +		COUNT=$(($(sed -n "s/^# Th[^0-9]*\([1-9][0-9]*\)\(th\|st\|nd\|rd\) commit message.*:/\1/p" \
>  			< "$SQUASH_MSG" | sed -ne '$p')+1))
>  		echo "# This is a combination of $COUNT commits."
>  		sed -e 1d -e '2,/^./{

But it is fine.  (Took this idiot a couple of seconds to figure out why; 
I'd have put "th" last, being a mathematician instead of a computer 
scientist, so my natural numbers start with 1, not 0 ;-)

To be honest, I never thought of "fix" as something I want, but patiently 
deleted the respective commit messages of my fixup commits (usually called 
"amend" or "amend.<something helpful>").

This is brilliant.

ACK
