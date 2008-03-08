From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Really make the LF after reset in fast-import optional
Date: Fri, 7 Mar 2008 21:12:10 -0500
Message-ID: <20080308021210.GX8410@spearce.org>
References: <20080305210715.GA10686@chistera.yi.org> <1204921337-5204-1-git-send-email-dato@net.com.org.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com
To: Adeodato =?utf-8?B?U2ltw7M=?= <dato@net.com.org.es>
X-From: git-owner@vger.kernel.org Sat Mar 08 03:13:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JXoYT-00021V-W4
	for gcvg-git-2@gmane.org; Sat, 08 Mar 2008 03:12:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756332AbYCHCMS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 Mar 2008 21:12:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756257AbYCHCMS
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Mar 2008 21:12:18 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:41193 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756234AbYCHCMS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 Mar 2008 21:12:18 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JXoXZ-0005jn-Q3; Fri, 07 Mar 2008 21:12:01 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id B3DD920FBAE; Fri,  7 Mar 2008 21:12:11 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <1204921337-5204-1-git-send-email-dato@net.com.org.es>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76542>

Adeodato Sim <dato@net.com.org.es> wrote:
> cmd_from() ends with a call to read_next_command(), which is needed
> when using cmd_from() from commands where from is not the last elemen=
t.
>=20
> With reset, however, "from" is the last command, after which the flow
> returns to the main loop, which calls read_next_command() again.
>=20
> Because of this, always set unread_command_buf in cmd_reset_branch(),
> even if cmd_from() was successful.
>=20
> Add a test case for this in t9300-fast-import.sh.
>=20
> Signed-off-by: Adeodato Sim=C3=B3 <dato@net.com.org.es>

Heh, this is awesome.  I got busy for a day and someone fixed
my bug for me.  Thanks.  :-)

Acked-by: Shawn O. Pearce <spearce@spearce.org>

>  fast-import.c          |    3 ++-
>  t/t9300-fast-import.sh |    2 ++
>  2 files changed, 4 insertions(+), 1 deletions(-)

--=20
Shawn.
