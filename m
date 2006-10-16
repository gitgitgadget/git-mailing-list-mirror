From: Davide Libenzi <davidel@xmailserver.org>
Subject: Re: git-diff-tree inordinately (O(M*N)) slow on files with many
 changes
Date: Mon, 16 Oct 2006 11:30:59 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0610161129350.7697@alien.or.mcafeemobile.com>
References: <87slhopcws.fsf@rho.meyering.net> <Pine.LNX.4.64.0610160838200.3962@g5.osdl.org>
 <Pine.LNX.4.64.0610160904400.3962@g5.osdl.org> <87mz7wp6ek.fsf@rho.meyering.net>
 <Pine.LNX.4.64.0610160941270.7697@alien.or.mcafeemobile.com>
 <87ejt8p5l9.fsf@rho.meyering.net> <Pine.LNX.4.64.0610161038200.3962@g5.osdl.org>
 <873b9op19n.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@osdl.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Oct 16 20:31:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZXF0-000149-Hb
	for gcvg-git@gmane.org; Mon, 16 Oct 2006 20:31:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422789AbWJPSbF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Oct 2006 14:31:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422791AbWJPSbF
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Oct 2006 14:31:05 -0400
Received: from x35.xmailserver.org ([69.30.125.51]:21987 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id S1422789AbWJPSbC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Oct 2006 14:31:02 -0400
X-AuthUser: davidel@xmailserver.org
Received: from alien.or.mcafeemobile.com
	by xmailserver.org with [XMail 1.23 ESMTP Server]
	id <S1F52E9> for <git@vger.kernel.org> from <davidel@xmailserver.org>;
	Mon, 16 Oct 2006 11:31:00 -0700
X-X-Sender: davide@alien.or.mcafeemobile.com
To: Jim Meyering <jim@meyering.net>
In-Reply-To: <873b9op19n.fsf@rho.meyering.net>
X-GPG-FINGRPRINT: CFAE 5BEE FD36 F65E E640  56FE 0974 BF23 270F 474E
X-GPG-PUBLIC_KEY: http://www.xmailserver.org/davidel.asc
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28981>

On Mon, 16 Oct 2006, Jim Meyering wrote:

> IMHO, my "&& vs. ||" patch is still worth applying.
> If not, then the existing code doesn't make sense, and
> there can be significant simplification in the affected loops.
> With my patch, I get an additional 3x speed-up: diff-tree takes 0.7s

No, the patch is broken. It will discard *any* line seen at least two 
times, that is an extremely low threashold.



- Davide
