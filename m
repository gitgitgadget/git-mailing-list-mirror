From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] rebase--interactive: do not use one-or-more (\+) in sed.
Date: Sat, 1 Sep 2007 23:24:39 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709012324240.28586@racer.site>
References: <200709010925.27926.johannes.sixt@telecom.at>
 <7vmyw6u5ca.fsf@gitster.siamese.dyndns.org> <7vejhiu565.fsf_-_@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Sixt <johannes.sixt@telecom.at>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Sep 02 00:25:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IRbPC-0004bl-7N
	for gcvg-git@gmane.org; Sun, 02 Sep 2007 00:25:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932119AbXIAWZV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 1 Sep 2007 18:25:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757336AbXIAWZV
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Sep 2007 18:25:21 -0400
Received: from mail.gmx.net ([213.165.64.20]:38218 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757151AbXIAWZU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Sep 2007 18:25:20 -0400
Received: (qmail invoked by alias); 01 Sep 2007 22:25:18 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp033) with SMTP; 02 Sep 2007 00:25:18 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18pv+kGhZ8pd47aZT83k6bblNGYpoIS4e6I7uUoO5
	R73T1SPuSCcfVT
X-X-Sender: gene099@racer.site
In-Reply-To: <7vejhiu565.fsf_-_@gitster.siamese.dyndns.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57284>

Hi,

On Sat, 1 Sep 2007, Junio C Hamano wrote:

> This is a continuation of the other one to avoid one-or-more operator
> in sed.  At the same time, it actually tightens error checking,
> because the numbers in the squash messages are not padded with
> leading zero and cannot begin with 0.
> 
> With this, I think we do not have any more use of one-or-more
> (\+) in sed scripts.
> 
> ---
> 
>  git-rebase--interactive.sh |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> index ec798a1..abc2b1c 100755
> --- a/git-rebase--interactive.sh
> +++ b/git-rebase--interactive.sh
> @@ -190,7 +190,7 @@ nth_string () {
>  
>  make_squash_message () {
>  	if test -f "$SQUASH_MSG"; then
> -		COUNT=$(($(sed -n "s/^# This is [^0-9]*\([0-9]\+\).*/\1/p" \
> +		COUNT=$(($(sed -n "s/^# This is [^0-9]*\([1-9][0-9]*\).*/\1/p" \

Looks obviously correct to me... Ack.

Ciao,
Dscho
