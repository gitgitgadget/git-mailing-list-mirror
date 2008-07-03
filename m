From: Samuel Tardieu <sam@rfc1149.net>
Subject: Re: Cherry picking instead of merges.
Date: Thu, 03 Jul 2008 23:18:40 +0200
Organization: RFC 1149 (see http://www.rfc1149.net/)
Message-ID: <2008-07-03-23-18-40+trackit+sam@rfc1149.net>
References: <20080703182650.GA11166@old.davidb.org>
	<32541b130807031315j3d9b7d77y277e3cb994ab0964@mail.gmail.com>
	<20080703205329.GA17923@old.davidb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Cc: Avery Pennarun <apenwarr@gmail.com>, git@vger.kernel.org
To: David Brown <git@davidb.org>
X-From: git-owner@vger.kernel.org Thu Jul 03 23:31:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KEWOd-00076z-OM
	for gcvg-git-2@gmane.org; Thu, 03 Jul 2008 23:31:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753965AbYGCVaW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jul 2008 17:30:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753725AbYGCVaV
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Jul 2008 17:30:21 -0400
Received: from zaphod.rfc1149.net ([88.191.14.223]:57106 "EHLO
	mail.rfc1149.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753557AbYGCVaU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jul 2008 17:30:20 -0400
X-Greylist: delayed 690 seconds by postgrey-1.27 at vger.kernel.org; Thu, 03 Jul 2008 17:30:20 EDT
Received: from localhost (localhost [127.0.0.1])
	by mail.rfc1149.net (Postfix) with ESMTP id 5E314E2FF6;
	Thu,  3 Jul 2008 23:18:47 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rfc1149.net
Received: from mail.rfc1149.net ([127.0.0.1])
	by localhost (zaphod.rfc1149.net [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iIhvzitH6OCC; Thu,  3 Jul 2008 23:18:42 +0200 (CEST)
Received: from mail2.rfc1149.net (unknown [IPv6:2a01:e35:1382:f950::3])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail2.rfc1149.net", Issuer "rfc1149.net" (verified OK))
	by mail.rfc1149.net (Postfix) with ESMTPS id 1EEF0E2AF9;
	Thu,  3 Jul 2008 23:18:42 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mail2.rfc1149.net (Postfix) with ESMTP id 59F2FC4097;
	Thu,  3 Jul 2008 23:18:41 +0200 (CEST)
Received: from mail2.rfc1149.net ([127.0.0.1])
	by localhost (localhost [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id N3aZ+IKEQ72v; Thu,  3 Jul 2008 23:18:41 +0200 (CEST)
Received: by mail2.rfc1149.net (Postfix, from userid 1000)
	id 1FB01C40B9; Thu,  3 Jul 2008 23:18:41 +0200 (CEST)
In-Reply-To: <20080703205329.GA17923@old.davidb.org> (David Brown's message of "Thu\, 3 Jul 2008 13\:53\:29 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-WWW: http://www.rfc1149.net/sam
X-Jabber: <sam@rfc1149.net> (see http://www.jabber.org/)
X-OpenPGP-Fingerprint: 79C0 AE3C CEA8 F17B 0EF1  45A5 F133 2241 1B80 ADE6 (see http://www.gnupg.org/)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87323>

>>>>> "David" == David Brown <git@davidb.org> writes:

David> It's only sitting in a private developer's branch.  I want to
David> do the merge properly, but I'm just trying to figure out how to
David> get the conflict resolution out of his work.

Why don't you create a commit which has both your (A) and company B
branch head (B) as parent with the same content as the private
developer's branch (P) which contains the succesful merge?

Something like that: (totally untested)

% git checkout A
% git merge --no-commit -s ours B
% git checkout P .
% git commit -a
