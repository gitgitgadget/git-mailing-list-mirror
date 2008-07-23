From: "Benjamin Kudria" <ben@kudria.net>
Subject: Git's config core.pager doesn't respect color.pager
Date: Tue, 22 Jul 2008 22:10:17 -0400
Message-ID: <d129c0140807221910j37f40e72se9f411d6424077de@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 23 04:11:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLTp2-0008Uc-2j
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 04:11:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752741AbYGWCKT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jul 2008 22:10:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752012AbYGWCKT
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jul 2008 22:10:19 -0400
Received: from rv-out-0506.google.com ([209.85.198.224]:33352 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751916AbYGWCKS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jul 2008 22:10:18 -0400
Received: by rv-out-0506.google.com with SMTP id k40so2167266rvb.1
        for <git@vger.kernel.org>; Tue, 22 Jul 2008 19:10:18 -0700 (PDT)
Received: by 10.141.37.8 with SMTP id p8mr278398rvj.256.1216779017745;
        Tue, 22 Jul 2008 19:10:17 -0700 (PDT)
Received: by 10.141.66.5 with HTTP; Tue, 22 Jul 2008 19:10:17 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89599>

I'm seeing a problem with git.  It's easier to demonstrate than
explain.  The relevant parts of my .gitconfig:

[core]
	pager = tig

[color]
	diff = auto
	pager = false

tig is a console-based git client that can also act as a pager,
colorizing git output.

So, with the above config, when I do:

git diff | tig

Everything works correctly - git sends no color codes, because of
color.pager = false.

However, if I do just:

git diff

git uses core.pager to display the output, but still sends color
codes, which is OK for, say, less, bit not so good for tig, which does
it's own colorizing, and displays the color codes git sends as-is.

Shouldn't core.pager respect color.pager, and not send the color codes?

Benjamin Kudria

-- 
http://ben.kudria.net | Jabber: ben@kudria.net
