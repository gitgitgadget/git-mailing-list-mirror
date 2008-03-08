From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] bash: __git_find_subcommand function
Date: Fri, 7 Mar 2008 21:23:42 -0500
Message-ID: <20080308022342.GY8410@spearce.org>
References: <1204815512-18128-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Sat Mar 08 03:24:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JXojx-0004kW-8q
	for gcvg-git-2@gmane.org; Sat, 08 Mar 2008 03:24:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760391AbYCHCXr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 Mar 2008 21:23:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760392AbYCHCXq
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Mar 2008 21:23:46 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:44718 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760391AbYCHCXq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 Mar 2008 21:23:46 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JXoii-0006vZ-M6; Fri, 07 Mar 2008 21:23:32 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id E188720FBAE; Fri,  7 Mar 2008 21:23:42 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <1204815512-18128-1-git-send-email-szeder@ira.uka.de>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76544>

SZEDER Gbor <szeder@ira.uka.de> wrote:
> This enables us to remove code duplications from completion
> functions for commands having subcommands.
>=20
> Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
> ---
> This function does not return the index of the subcommand found on th=
e
> command line, which was in the $c variable previously.  However, $c w=
as
> only used in if statements, like:
> 	if [ $c -eq $COMP_CWORD -a -z "$command" ]; then
> 		__gitcomp "cmd1 cmd2 cmd3"
> 	fi
> To my understanding the only(?) purpose of those if statements was to
> prevent subcommands appearing again on the list of possible completio=
ns,
> when there was one already on the command line.  But [ -z $command ] =
is
> sufficient to detect those cases, so we can actually omit
> [ $c -eq $COMP_CWORD ].  Is it right, or am I missing something?

Yup, you understood it correctly.  You found a cluster of "copy and
paste programming" and I am happy to see it cleaned up.  Thanks.

--=20
Shawn.
