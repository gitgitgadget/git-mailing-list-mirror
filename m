From: Samuel Tardieu <sam@rfc1149.net>
Subject: Re: Remotes order in "git remote update"
Date: Mon, 10 Mar 2008 09:17:33 +0100
Organization: RFC 1149 (see http://www.rfc1149.net/)
Message-ID: <2008-03-10-09-17-33+trackit+sam@rfc1149.net>
References: <2008-03-09-11-22-34+trackit+sam@rfc1149.net> <7vbq5op4gt.fsf@gitster.siamese.dyndns.org> <2008-03-09-12-21-35+trackit+sam@rfc1149.net> <alpine.LSU.1.00.0803092148480.3975@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Mar 10 09:18:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JYdDG-00006L-3l
	for gcvg-git-2@gmane.org; Mon, 10 Mar 2008 09:18:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751269AbYCJIRl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Mar 2008 04:17:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751232AbYCJIRl
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Mar 2008 04:17:41 -0400
Received: from zaphod.rfc1149.net ([88.191.14.223]:58580 "EHLO
	mail.rfc1149.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751261AbYCJIRk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Mar 2008 04:17:40 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.rfc1149.net (Postfix) with ESMTP id 0CB28E04D6;
	Mon, 10 Mar 2008 09:17:39 +0100 (CET)
X-Virus-Scanned: amavisd-new at rfc1149.net
Received: from mail.rfc1149.net ([127.0.0.1])
	by localhost (zaphod.rfc1149.net [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4ZiuNLkBc-Bq; Mon, 10 Mar 2008 09:17:34 +0100 (CET)
Received: from dawn.rfc1149.net (unknown [192.168.9.2])
	by mail.rfc1149.net (Postfix) with ESMTP id 2CC98E0478;
	Mon, 10 Mar 2008 09:17:34 +0100 (CET)
Received: by dawn.rfc1149.net (Postfix, from userid 1000)
	id D5AF180AF; Mon, 10 Mar 2008 09:17:33 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <alpine.LSU.1.00.0803092148480.3975@racer.site>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-WWW: http://www.rfc1149.net/sam
X-Jabber: <sam@rfc1149.net> (see http://www.jabber.org/)
X-OpenPGP-Fingerprint: 79C0 AE3C CEA8 F17B 0EF1  45A5 F133 2241 1B80 ADE6 (see http://www.gnupg.org/)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76705>

On  9/03, Johannes Schindelin wrote:

| Well, technically this is a regression.
| 
| If you really want to order your remotes, why not add something like
| 
| [remotes]
| 	default = my-first-remote my-second-remote [...]
| 
| to the config?  That is what the (recently fixed in builtin-remote) remote 
| groups are for...

I could do that, but it means that if I add a new remote, it won't enter
the default group by itself since I defined it explicitely. I think
respecting the order given in the .git/config file when not using a
group doesn't hurt and may help.

Or maybe we should add a remotes.reference configuration variable which
lists the remote to use first if it belongs to the list of remotes we
are going to fetch from. Or at least, make origin the first fetched
remote, but I know some projects where origin uses a dumb protocol while
other contributors have up-to-date non-dumb public repositories.
