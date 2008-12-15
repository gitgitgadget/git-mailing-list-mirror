From: Bruce Stephens <bruce.stephens@isode.com>
Subject: "git gc" doesn't seem to remove loose objects any more
Date: Mon, 15 Dec 2008 12:52:34 +0000
Message-ID: <808wqhzjl9.fsf@tiny.isode.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 15 13:54:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LCCxT-0005s8-QX
	for gcvg-git-2@gmane.org; Mon, 15 Dec 2008 13:54:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751379AbYLOMwi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Dec 2008 07:52:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751337AbYLOMwi
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Dec 2008 07:52:38 -0500
Received: from rufus.isode.com ([62.3.217.251]:44113 "EHLO rufus.isode.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751271AbYLOMwh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Dec 2008 07:52:37 -0500
Received: from tiny.isode.net (shiny.isode.com [62.3.217.250]) 
          by rufus.isode.com (smtp internal) via TCP with SMTP 
          id <SUZTEgB05cRa@rufus.isode.com> for <git@vger.kernel.org>;
          Mon, 15 Dec 2008 12:52:35 +0000
Received: by tiny.isode.net (sSMTP sendmail emulation);
          Mon, 15 Dec 2008 12:52:34 +0000
X-Hashcash: 1:20:081215:git@vger.kernel.org::XVjlrcIgxwWhzXod:0000000000000000000000000000000000000000000gwg
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103160>

I couldn't see a test for this, but perhaps I'm just missing it?

    brs% git count-objects
    161 objects, 1552 kilobytes
    brs% git gc
    Counting objects: 80621, done.
    Compressing objects: 100% (22372/22372), done.
    Writing objects: 100% (80621/80621), done.
    Total 80621 (delta 57160), reused 80305 (delta 56884)
    brs% git count-objects
    207 objects, 2048 kilobytes


And I see lots of directories under .git/objects which confirms
things.

I don't think I've changed any relevant configuration.

This is with 8befc50c49e8a271fd3cd7fb34258fe88d1dfcad (also whatever
version I used before, erm, probably
de0db422782ddaf7754ac5b03fdc6dc5de1a9ae4), and possibly earlier
versions---I've just started noticing now that the number of loose
objects has started causing git gui to complain.

(Hmm, I note that git gui reports a larger number of loose objects
than git count-objects.  Ah, OK, it really is just an approximation,
so no surprise.)
