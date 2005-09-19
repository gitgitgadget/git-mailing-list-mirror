From: Petr Baudis <pasky@suse.cz>
Subject: What shall we do with the GECOS field again?
Date: Mon, 19 Sep 2005 15:48:38 +0200
Message-ID: <20050919134838.GC2903@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: torvalds@osdl.org
X-From: git-owner@vger.kernel.org Mon Sep 19 15:50:54 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EHM0l-0004ot-0R
	for gcvg-git@gmane.org; Mon, 19 Sep 2005 15:48:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932397AbVISNso (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Sep 2005 09:48:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932415AbVISNso
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Sep 2005 09:48:44 -0400
Received: from w241.dkm.cz ([62.24.88.241]:38280 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S932397AbVISNsn (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Sep 2005 09:48:43 -0400
Received: (qmail 10430 invoked by uid 2001); 19 Sep 2005 15:48:38 +0200
To: git@vger.kernel.org
Content-Disposition: inline
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8860>

  Hello,

  after today's another confrontation with angry mob of real-world
Cogito users, I decided to revive the old discussion about what part of
the GECOS field should be used to prefill GIT_*_NAME. Linus stated in
<Pine.LNX.4.58.0504171636590.7211@ppc970.osdl.org> that he does not want
to cut based on ',', because it might throw away the first name of gecos
fields in the "Torvalds, Linus" name.

  Well, I have to say that from the GECOS fields I saw, none use that
format, but a lot of them used the realname,phone,something,phone,...
format. The other point is, that users usually do not expect their phone
number to end up in their name information in GIT commits, which results
in a very unpleasant surprise (doubly so due to the immutable GIT
nature). Yes, they should check after the first commit if they are happy
with everything, and yes, GECOS is world-readable and therefore they
shouldn't put information they don't want to be public to it. Still they
do and I think GIT shouldn't make them unpleasant surprises.

  So my proposal (patch will follow soon) is to cut everything after the
first , or ; from the GECOS field. These are the usual delimiters used
in the GECOS field, and hopefully this will prevent polluting the
realname fields of commit headers with crap and surprising the users.
In the (I think rather rare) situation of the "Baudis, Petr"-like GECOS
fields, this will just result in only the surname being in the realname
field, which seems to be much less harmful and comparably less evil to
me. 

  Opinions?

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
If you want the holes in your knowledge showing up try teaching
someone.  -- Alan Cox
