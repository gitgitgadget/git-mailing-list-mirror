From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: What's in git.git tonight
Date: 06 Nov 2005 04:08:35 -0800
Message-ID: <868xw2t1vg.fsf@blue.stonehenge.com>
References: <7v3bmayu2r.fsf@assigned-by-dhcp.cox.net>
	<86acgiujuk.fsf@blue.stonehenge.com>
	<87y8427zvn.fsf@briny.internal.ondioline.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 06 13:09:54 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EYjKC-0008Sl-6M
	for gcvg-git@gmane.org; Sun, 06 Nov 2005 13:08:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750798AbVKFMIh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 6 Nov 2005 07:08:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750809AbVKFMIh
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Nov 2005 07:08:37 -0500
Received: from blue.stonehenge.com ([209.223.236.162]:24728 "EHLO
	blue.stonehenge.com") by vger.kernel.org with ESMTP
	id S1750798AbVKFMIg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Nov 2005 07:08:36 -0500
Received: from localhost (localhost [127.0.0.1])
	by blue.stonehenge.com (Postfix) with ESMTP id 073718F9D4;
	Sun,  6 Nov 2005 04:08:36 -0800 (PST)
Received: from blue.stonehenge.com ([127.0.0.1])
 by localhost (blue.stonehenge.com [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 07269-04-12; Sun,  6 Nov 2005 04:08:35 -0800 (PST)
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id 93DEC8F9E6; Sun,  6 Nov 2005 04:08:35 -0800 (PST)
To: Paul Collins <paul@briny.ondioline.org>
x-mayan-date: Long count = 12.19.12.13.18; tzolkin = 2 Etznab; haab = 16 Zac
In-Reply-To: <87y8427zvn.fsf@briny.internal.ondioline.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11207>

>>>>> "Paul" == Paul Collins <paul@briny.ondioline.org> writes:

Paul> It seems to require libexpat now.  I got the same error here on Debian.
Paul> With libexpat-dev installed it builds.

Well, there's no standard libexpat for OSX, so if you install it
after-market, it can end up in various directories.

For example, on my machine, I've installed it with fink, so I need
"-I/sw/include -L/sw/lib" added to CFLAGS.

If you install it with darwinports, it will end up under
"/opt/local/{lib,include}" instead.

I suppose you could add those four things to CFLAGS for OSX and it
won't mess too many things up, but you'll also need to add a note that
says "git requires expat, which can be obtained through fink or
darwinports.  If you install expat manually, you may have to adjust
CFLAGS in the Makefile".

As a separate problem, why make git depend on expat if the only part
of this is for DAV pushing?  Can http-push simply refuse DAV URLs if
built without expat?

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
