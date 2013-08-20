From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH] mailmap: fix check for freeing memory
Date: Tue, 20 Aug 2013 16:23:47 +0200
Message-ID: <871u5o785o.fsf@linux-k42r.v.cablecom.net>
References: <1377004958-14489-1-git-send-email-stefanbeller@googlemail.com>
	<878uzw7a6l.fsf@linux-k42r.v.cablecom.net>
	<52137A63.3010609@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>, <peff@peff.net>, <gitster@pobox.com>
To: Stefan Beller <stefanbeller@googlemail.com>
X-From: git-owner@vger.kernel.org Tue Aug 20 16:23:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VBmqf-0004pw-SS
	for gcvg-git-2@plane.gmane.org; Tue, 20 Aug 2013 16:23:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751069Ab3HTOXu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Aug 2013 10:23:50 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:1701 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751013Ab3HTOXt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Aug 2013 10:23:49 -0400
Received: from CAS21.d.ethz.ch (172.31.51.111) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Tue, 20 Aug
 2013 16:23:43 +0200
Received: from linux-k42r.v.cablecom.net.ethz.ch (129.132.153.233) by
 CAS21.d.ethz.ch (172.31.51.111) with Microsoft SMTP Server (TLS) id
 14.2.298.4; Tue, 20 Aug 2013 16:23:47 +0200
In-Reply-To: <52137A63.3010609@googlemail.com> (Stefan Beller's message of
	"Tue, 20 Aug 2013 16:17:07 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232603>

Stefan Beller <stefanbeller@googlemail.com> writes:

> As I am resending the patch, could somebody please explain me
> the mechanism of the "# repo-abbrev:" line? Even git itself doesn't
> use it in the .mailmap file, but a quick google search shows up only
> kernel repositories.

I had no idea (we really lack documentation on this), but some history
digging shows this:

  commit 7595e2ee6ef9b35ebc8dc45543723e1d89765ce3
  Author: Junio C Hamano <junkio@cox.net>
  Date:   Sat Nov 25 00:07:54 2006 -0800

      git-shortlog: make common repository prefix configurable with .mailmap
      
      The code had "/pub/scm/linux/kernel/git/" hardcoded which was
      too specific to the kernel project.
      
      With this, a line in the .mailmap file:
      
          # repo-abbrev: /pub/scm/linux/kernel/git/
      
      can be used to cause the substring to be abbreviated to /.../
      on the title line of the commit message.
      
      Signed-off-by: Junio C Hamano <junkio@cox.net>

It apparently serves to abbreviate commits coming from pull requests,
with a subject like

  Merge branch 'release' of git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
