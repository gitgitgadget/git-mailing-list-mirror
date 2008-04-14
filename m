From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH v2.1] Teach rebase interactive the mark command
Date: Mon, 14 Apr 2008 19:29:58 -0400
Message-ID: <20080414232958.GE20979@spearce.org>
References: <1208132469-26471-3-git-send-email-joerg@alea.gnuu.de> <1208169584-15931-1-git-send-email-joerg@alea.gnuu.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com
To: =?utf-8?B?SsO2cmc=?= Sommer <joerg@alea.gnuu.de>
X-From: git-owner@vger.kernel.org Tue Apr 15 01:30:51 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JlY8Q-0001TS-2t
	for gcvg-git-2@gmane.org; Tue, 15 Apr 2008 01:30:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755020AbYDNXaF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Apr 2008 19:30:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751618AbYDNXaE
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Apr 2008 19:30:04 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:52655 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752612AbYDNXaD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Apr 2008 19:30:03 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JlY7R-0004E0-0P; Mon, 14 Apr 2008 19:29:49 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 1599C20FBAE; Mon, 14 Apr 2008 19:29:58 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <1208169584-15931-1-git-send-email-joerg@alea.gnuu.de>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79540>

Jrg Sommer <joerg@alea.gnuu.de> wrote:
> The format of the marks is as close as possible to the format of the
> marks used by fast-export and fast-import,

Yay.

> i.e. :001 =3D=3D :1 and
> =E2=80=9C:12a=E2=80=9D=C2=A0=3D=3D=C2=A0:12. It differs from the form=
at of fast-import in that point
> that it requires a digit after the colon, i.e. =E2=80=9C:abc=E2=80=9D=
 !=3D :0 and =E2=80=9C:-12=E2=80=9D
> and =E2=80=9C:+12=E2=80=9D aren't allowed.

Uh, that's a bug in fast-import.  ":4abc" is _not_ a mark if you
read the language specification.  Only ":4" is a mark.  So we are
accepting crap and reading it in odd ways.  Not good.

--=20
Shawn.
