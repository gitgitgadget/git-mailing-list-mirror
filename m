From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/4] Rework redo_merge
Date: Sun, 23 Mar 2008 23:29:25 +0100 (CET)
Message-ID: <alpine.LSU.1.00.0803232327330.4353@racer.site>
References: <1206308562-31489-1-git-send-email-joerg@alea.gnuu.de> <1206308562-31489-2-git-send-email-joerg@alea.gnuu.de>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323584-1192314126-1206311370=:4353"
Cc: git@vger.kernel.org, gitster@pobox.com, B.Steinbrink@gmx.de
To: =?ISO-8859-15?Q?J=F6rg_Sommer?= <joerg@alea.gnuu.de>
X-From: git-owner@vger.kernel.org Sun Mar 23 23:30:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JdYhc-0001h7-Jl
	for gcvg-git-2@gmane.org; Sun, 23 Mar 2008 23:30:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755706AbYCWW32 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Mar 2008 18:29:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755686AbYCWW32
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Mar 2008 18:29:28 -0400
Received: from mail.gmx.net ([213.165.64.20]:47007 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755588AbYCWW32 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Mar 2008 18:29:28 -0400
Received: (qmail invoked by alias); 23 Mar 2008 22:29:26 -0000
Received: from host86-148-26-43.range86-148.btcentralplus.com (EHLO racer.home) [86.148.26.43]
  by mail.gmx.net (mp003) with SMTP; 23 Mar 2008 23:29:26 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/XYp8M3YjXWkvQWGbkPBOWQP0DZUjOQ6FWWTkmT1
	5l2kBiOGewJwMY
X-X-Sender: gene099@racer.site
In-Reply-To: <1206308562-31489-2-git-send-email-joerg@alea.gnuu.de>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77968>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323584-1192314126-1206311370=:4353
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT

Hi,

On Sun, 23 Mar 2008, Jörg Sommer wrote:

> 
> Signed-off-by: Jörg Sommer <joerg@alea.gnuu.de>

"Rework" is not really informative.

> -		output git merge $STRATEGY -m "$msg" \
> -			$new_parents
> +		output git merge $STRATEGY -m "$msg" "$@"

This should rather go into 1/4.

> @@ -197,8 +199,7 @@ pick_one_preserving_merges () {
>  		case "$new_parents" in
>  		' '*' '*)
>  			# No point in merging the first parent, that's HEAD
> -			new_parents=${new_parents# $first_parent}
> -			redo_merge
> +			redo_merge $sha1 ${new_parents# $first_parent}

Likewise.

Sidenote: it is a bit of cheating to set sha1=$1 in redo_merge(), since it 
is _not_ a local variable there, but the code _relies_ on sha1 being the 
same after calling redo_merge().

Ciao,
Dscho

--8323584-1192314126-1206311370=:4353--
