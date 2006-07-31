From: Juergen Ruehle <j.ruehle@bmiag.de>
Subject: Re: [PATCH] pager: config variable pager.color
Date: Mon, 31 Jul 2006 10:55:42 +0200
Message-ID: <17613.50574.56000.861072@lapjr.intranet.kiel.bmiag.de>
References: <E1G6xHb-0008Rw-G2@moooo.ath.cx>
	<Pine.LNX.4.63.0607300112340.29667@wbgn013.biozentrum.uni-wuerzburg.de>
	<E1G6zPH-00062L-Je@moooo.ath.cx>
	<7vd5bmbo46.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Matthias Lederhofer <matled@gmx.net>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jul 31 10:56:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G7TZW-0004mh-MZ
	for gcvg-git@gmane.org; Mon, 31 Jul 2006 10:56:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751332AbWGaI4J (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 31 Jul 2006 04:56:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751310AbWGaI4I
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Jul 2006 04:56:08 -0400
Received: from bilbo.bmiag.de ([62.154.210.131]:24330 "HELO bilbo.bmiag.de")
	by vger.kernel.org with SMTP id S1751332AbWGaI4H (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 31 Jul 2006 04:56:07 -0400
Received: (qmail 11977 invoked by uid 106); 31 Jul 2006 08:56:05 -0000
Received: from eotheod.intranet.kiel.bmiag.de(10.130.2.1)
 via SMTP by bilbo.bmiag.de, id smtpdaoZx4n; Mon Jul 31 10:55:57 2006
Received: from localhost (localhost.localdomain [127.0.0.1])
	by eotheod.intranet.kiel.bmiag.de (Postfix) with ESMTP id E21F83BB4C;
	Mon, 31 Jul 2006 10:55:56 +0200 (CEST)
Received: from eotheod.intranet.kiel.bmiag.de ([127.0.0.1])
	by localhost (eotheod [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 03960-04; Mon, 31 Jul 2006 10:55:50 +0200 (CEST)
Received: from LAPJR (lapjr.intranet.kiel.bmiag.de [10.191.7.182])
	by eotheod.intranet.kiel.bmiag.de (Postfix) with ESMTP id B52113AF51;
	Mon, 31 Jul 2006 10:55:42 +0200 (CEST)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vd5bmbo46.fsf@assigned-by-dhcp.cox.net>
X-Mailer: VM 7.19 under Emacs 21.3.1
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at eotheod.intranet.kiel.bmiag.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24503>

Junio C Hamano writes:
 > Matthias Lederhofer <matled@gmx.net> writes:
 > 
 > > Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
 > >> Why? The three users of cmd_log_walk() need to call setup_pager() 
 > >> explicitely, when cmd_log_walk() can do it for them?
 > >
 > > The explanation is below the commit message:
 > > "setup_pager has to be called before git_diff_ui_config because the
 > > latter uses pager_use_color initialized by setup_pager."
 > 
 > If that is the reason, perhaps we could restructure the setting
 > and use of of diff_use_color_default like the attached, which
 > would be cleaner.

AFAICS Matthias' patch has the added benefit of moving setup_pager to
before large files (i.e. packs) are mapped. This helps non-COW-fork
(i.e. cygwin) tremendously. Actually with Linus' setup refactoring
this could probably be easily moved to the wrapper, but I'm too stupid
so I just deleted setup_pager from my version:-)

  jr
