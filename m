From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Be more careful with objects directory permissions on clone
Date: Tue, 06 May 2008 09:25:03 +0200
Organization: At home
Message-ID: <fvp14f$8v0$1@ger.gmane.org>
References: <alpine.BSO.1.10.0805041234570.5819@zrgural.vwaro.pbz> <481ECCF0.6080308@viscovery.net> <alpine.BSO.1.10.0805051047260.7723@zrgural.vwaro.pbz> <481EDC4B.2010105@viscovery.net> <alpine.BSO.1.10.0805051121090.32248@zrgural.vwaro.pbz> <481EE478.9000704@viscovery.net> <alpine.BSO.1.10.0805051742020.10940@zrgural.vwaro.pbz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 06 09:26:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JtHYu-0000tl-Nw
	for gcvg-git-2@gmane.org; Tue, 06 May 2008 09:26:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753544AbYEFHZU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 6 May 2008 03:25:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753537AbYEFHZT
	(ORCPT <rfc822;git-outgoing>); Tue, 6 May 2008 03:25:19 -0400
Received: from main.gmane.org ([80.91.229.2]:47214 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752983AbYEFHZR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 May 2008 03:25:17 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1JtHY0-00045X-Ql
	for git@vger.kernel.org; Tue, 06 May 2008 07:25:12 +0000
Received: from abvy108.neoplus.adsl.tpnet.pl ([83.8.222.108])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 06 May 2008 07:25:12 +0000
Received: from jnareb by abvy108.neoplus.adsl.tpnet.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 06 May 2008 07:25:12 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: abvy108.neoplus.adsl.tpnet.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81342>

Mark Hills wrote:

> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0find objects -depth -pr=
int | cpio $cpio_quiet_flag -pumd$l "$GIT_DIR/" || \
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0# Create dirs using uma=
sk and permissions and destination
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0find objects -type d -p=
rint | (cd "$GIT_DIR" && xargs mkdir -p) &&
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0# Copy existing 0444 pe=
rmissions on content
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0find objects ! -type d =
-print | cpio $cpio_quiet_flag -pumd$l "$GIT_DIR/" || \

By the way, it is important that previous version had -depth, and
proposed one doesn't? Was it about creating directories before files?

--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
