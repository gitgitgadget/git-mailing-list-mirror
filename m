From: Olivier Marin <dkr+ml.git@free.fr>
Subject: remote show/prune: strange -n(--dry-run) option.
Date: Sun, 08 Jun 2008 02:54:43 +0200
Message-ID: <484B2DD3.8050307@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 08 02:55:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K59CQ-0002Hq-OQ
	for gcvg-git-2@gmane.org; Sun, 08 Jun 2008 02:55:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755238AbYFHAyg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Jun 2008 20:54:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755223AbYFHAyg
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Jun 2008 20:54:36 -0400
Received: from smtp2-g19.free.fr ([212.27.42.28]:54882 "EHLO smtp2-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755199AbYFHAyf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Jun 2008 20:54:35 -0400
Received: from smtp2-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp2-g19.free.fr (Postfix) with ESMTP id 488D812B6AF
	for <git@vger.kernel.org>; Sun,  8 Jun 2008 02:54:34 +0200 (CEST)
Received: from [10.253.21.40] (hhe95-1-82-225-56-14.fbx.proxad.net [82.225.56.14])
	by smtp2-g19.free.fr (Postfix) with ESMTP id 2925F12B6AC
	for <git@vger.kernel.org>; Sun,  8 Jun 2008 02:54:34 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.14 (X11/20080505)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84238>

Hello,

The git-remote documentation talks about a mysterious -n option for show
and prune that comes from the old git-remote.perl script. This flag was
used to prevent the script from calling ls-remote more than once, FWIU.
Today, the builtin accept an (un)?related -n(--dry-run) flag that does
nothing, actually. It seems broken.

So, is it safe to drop it entirely or is it better to just remove it
from the documentation for compatibility? In the second case, how long
should we wait before using --dry-run for something different?

I would like to make "git remote prune" more verbose and use --dry-run
to really prevent it from deleting stale tracking branches.

$ git remote prune origin -n
Pruning origin
From: git://.../myproject.git
  * [stale branch]    bla
  * [stale branch]    bli
  * [stale branch]    blu

What about something like that ?

Olivier.
