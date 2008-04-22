From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: git-gui hangs on read
Date: Tue, 22 Apr 2008 19:25:30 -0400
Message-ID: <20080422232530.GK29771@spearce.org>
References: <b3889dff0804210723s620363fdscba43c79dbb62d55@mail.gmail.com> <20080422001311.GS29771@spearce.org> <b3889dff0804220634u58a5ed21yf8a4f369471c6534@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Benjamin Collins <ben.collins@acm.org>
X-From: git-owner@vger.kernel.org Wed Apr 23 01:26:20 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JoRsR-0003OJ-Vl
	for gcvg-git-2@gmane.org; Wed, 23 Apr 2008 01:26:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752143AbYDVXZe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2008 19:25:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752057AbYDVXZe
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Apr 2008 19:25:34 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:36330 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751880AbYDVXZd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Apr 2008 19:25:33 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JoRrV-000729-Pp; Tue, 22 Apr 2008 19:25:21 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id B31C720FBAE; Tue, 22 Apr 2008 19:25:30 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <b3889dff0804220634u58a5ed21yf8a4f369471c6534@mail.gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80174>

Benjamin Collins <ben.collins@acm.org> wrote:
> On Mon, Apr 21, 2008 at 7:13 PM, Shawn O. Pearce <spearce@spearce.org> wrote:
> >  From the strace it looks like your aspell is not giving us a
> >  reply to the "$$cr master" command.  What does this give you?
> 
> $ aspell --mode=none --encoding=UTF-8 pipe <<EOF
> > !
> > $$cr master
> > EOF
> @(#) International Ispell Version 3.1.20 (but really Aspell 0.50.5)
> & cr 70 5: Cr, cry, RC, CPR, CRT, Car, car, ctr, cur, CT, Ct, ct, C, R, c, r, Ce
> , cir, Gr, Jr, Kr, gr, qr, NCR, OCR, VCR, CA, CO, Ca, Co, Cu, RR, ca, cc, ck, co
> , cu, cw, yr, BR, Br, CB, CD, CF, CV, CZ, Cb, Cd, Cf, Cl, Cm, Cs, Dr, Fr, HR, Lr
> , Mr, PR, Pr, Sr, Zr, cf, cg, cl, cm, cs, fr, hr, pr, tr
> 

Awww hell.  I think I see two issues.  The first is $$ maybe
was expanded by your shell so aspell didn't see it as a command?
I should have used <<'EOF' to avoid that, but I uh, forgot.

Can you upgrade aspell to 0.60.5?  Everywhere that I have used
git-gui 0.10 that's the version I have had available.  I wonder
if 0.50.5 has an issue here, or just doesn't support the "$$cr"
command I was trying to use.  In which case I can try to make
git-gui 0.10.2 detect the aspell version and avoid using $$cr
if its an old version.

-- 
Shawn.
