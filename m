From: Juergen Ruehle <j.ruehle@bmiag.de>
Subject: Re: [PATCH 1/2] Suggest use of "git add file1 file2" when there is
	nothing to commit.
Date: Sat, 6 Jan 2007 15:02:57 +0100
Message-ID: <17823.44049.943881.536532@lapjr.intranet.kiel.bmiag.de>
References: <20061216025309.GA19955@spearce.org>
	<1168029891.11130.18.camel@ibook.zvpunry.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 06 15:03:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H3C8q-0003cK-OH
	for gcvg-git@gmane.org; Sat, 06 Jan 2007 15:03:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751392AbXAFODN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 6 Jan 2007 09:03:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751398AbXAFODN
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Jan 2007 09:03:13 -0500
Received: from meriadoc.bmiag.de ([62.154.210.133]:34606 "EHLO
	meriadoc.bmiag.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751392AbXAFODL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Jan 2007 09:03:11 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by meriadoc.bmiag.de (Postfix) with ESMTP id 28E8F3AF23;
	Sat,  6 Jan 2007 15:03:09 +0100 (CET)
Received: from meriadoc.bmiag.de ([127.0.0.1])
	by localhost (meriadoc [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 08003-10; Sat, 6 Jan 2007 15:03:08 +0100 (CET)
Received: from eotheod.intranet.kiel.bmiag.de (eotheod.intranet.kiel.bmiag.de [10.130.2.1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by meriadoc.bmiag.de (Postfix) with ESMTP id 893C33AF22;
	Sat,  6 Jan 2007 15:03:08 +0100 (CET)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by eotheod.intranet.kiel.bmiag.de (Postfix) with ESMTP id 2ED063ADCC;
	Sat,  6 Jan 2007 15:03:08 +0100 (CET)
Received: from eotheod.intranet.kiel.bmiag.de ([127.0.0.1])
	by localhost (eotheod [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 10689-09; Sat, 6 Jan 2007 15:03:04 +0100 (CET)
Received: from LAPJR (dialin5.galadriel.bmiag.de [192.168.251.5])
	by eotheod.intranet.kiel.bmiag.de (Postfix) with ESMTP id B9E3E3ADCA;
	Sat,  6 Jan 2007 15:03:02 +0100 (CET)
To: Michael Loeffler <zvpunry@zvpunry.de>
In-Reply-To: <1168029891.11130.18.camel@ibook.zvpunry.de>
X-Mailer: VM 7.19 under Emacs 21.2.1
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at eotheod.intranet.kiel.bmiag.de
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at meriadoc.bmiag.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36089>

Michael Loeffler writes:
 > Hi,
 > 
 > Am Freitag, den 15.12.2006, 21:53 -0500 schrieb Shawn O. Pearce:
 > ...
 > > @@ -292,7 +291,9 @@ void wt_status_print(struct wt_status *s)
 > >  	if (s->verbose && !s->is_initial)
 > >  		wt_status_print_verbose(s);
 > >  	if (!s->commitable)
 > > -		printf("%s\n", s->amend ? "# No changes" : "nothing to commit");
 > > +		printf("%s (%s)\n",
 > > +			s->amend ? "# No changes" : "nothing to commit",
 > > +			use_add_msg);
 > >  }
 > I don't like the new 'nothing to commit (use "git add ... message")'
 > message. I use git status very often to see if there is something to
 > commit, but now there is always this annoying "use git add ..." message.
 > I just want to see on what the branch is and if there is something to
 > commit.
 > 
 > If there is something to commit I get the list of untracked or modified
 > files with the use_add_msg and if I try to commit an empty tree as
 > initial commit I get the message from git-commit.sh.

I'd appreciate feedback on my series from the 2nd of January,
especially part 3/4 (Subject: [PATCH 3/4] Improve "nothing to commit"
part of status output). This is already part of next.

It removes the message if there really is nothing to commit and
replaces it by a generic pointer to git add and git commit if there
are pending changes in the working directory.
