From: Junio C Hamano <junkio@cox.net>
Subject: My Itchlist
Date: Fri, 05 Aug 2005 18:52:06 -0700
Message-ID: <7v8xzfde7t.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Aug 06 03:52:52 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E1DrR-0005PL-7M
	for gcvg-git@gmane.org; Sat, 06 Aug 2005 03:52:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262294AbVHFBwL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 5 Aug 2005 21:52:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262326AbVHFBwL
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Aug 2005 21:52:11 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:7834 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S262294AbVHFBwK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Aug 2005 21:52:10 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050806015207.WUWU15197.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 5 Aug 2005 21:52:07 -0400
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Here is a short list of itches I would like to get scratched
before 1.0.  I may be forgetting something big, though, so if
your favorite feature request is not included in the list please
speak up.

- Teach send-pack to use get_sha1() on the source side.

  In addition to a pattern that matches one reference on the
  source side, we should be able to use anything get_sha1() can
  grok.  Hopefully I'll be looking into this over the weekend.

- Teach fetch-pack reference renaming.

  On the push side, send-pack now knows updating arbitrary
  remote references from local references.  We need something
  similar for fetching.  I personally do not feel we need it for
  cloning but my cursory reading of clone-pack indicates the
  command is meant to work reasonably even in an already
  populated repository.  If somebody have a good use case for
  it and a clean patch, I may be tempted to accept it.

- Glossary documentation Johannes Schindelin is working on.

  I think coming up with the concensus of terms would come
  fairly quickly on the list.  Updating docs to match the
  concensus may take some time.  Help is greatly appreciated.

- Makefile variables updates from Pasky.

  While I do not have objections to rename dest to DESTDIR and
  such Pasky proposes, I want to have a matching change to RPM
  and deb generation.  I can speak basic debian/rules, but I am
  reluctant to touch RPM side of the things.

  Whether we do the dest/DESTDIR rename or not, we need to tweak
  binary packaging anyway, or stop installing the default
  templates.  I can be talked into either way.


My tentative plan is for 0.99.4 to finish send-pack, 0.99.5
to enhance fetch-pack, 0.99.6 to finish the first pass for the
documentation updates and stabilizing the binary packaging.


These are not 1.0 showstopper items but what I personally would
love to see.

- teach mailsplit/mailinfo basic MIME (attachments and quoted-printable)

  Some people send patches in MIME quoted-printable.  I could
  drop them on the floor and ask the sender to resend, but I've
  been being a nice guy, which currently involves manual
  intervention.

- teach git-apply "reverse" and possibly "fuzz".

  I think this might help Porcelain; currently they have to
  interpret git extended diff headers themselves.

- commit template filler discussed with Pasky some time ago.

- "rev-list a...b" should mean "rev-list `merge-base a b`..b"
