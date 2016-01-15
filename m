From: Konstantin Khomoutov <kostix+git@007spb.ru>
Subject: Re: SChannel support in Git for Windows
Date: Fri, 15 Jan 2016 18:59:23 +0300
Message-ID: <20160115185923.1e9fe5220b623625fdbc8041@domain007.com>
References: <CA+1xWaokgVthDv-up76RP+s+r4pSv5ntmePtDVND+rsKuo+-YA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Robert Labrie <robert.labrie@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 15 16:59:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aK6mg-0002UO-EZ
	for gcvg-git-2@plane.gmane.org; Fri, 15 Jan 2016 16:59:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752418AbcAOP71 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jan 2016 10:59:27 -0500
Received: from mailhub.007spb.ru ([84.204.203.130]:48838 "EHLO
	mailhub.007spb.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750816AbcAOP70 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jan 2016 10:59:26 -0500
Received: from tigra.domain007.com (tigra.domain007.com [192.168.2.102])
	by mailhub.007spb.ru (8.14.3/8.14.3/Debian-5+lenny1) with SMTP id u0FFxN2n019277;
	Fri, 15 Jan 2016 18:59:24 +0300
In-Reply-To: <CA+1xWaokgVthDv-up76RP+s+r4pSv5ntmePtDVND+rsKuo+-YA@mail.gmail.com>
X-Mailer: Sylpheed 3.5.0beta1 (GTK+ 2.24.25; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284176>

On Fri, 15 Jan 2016 10:04:17 -0500
Robert Labrie <robert.labrie@gmail.com> wrote:

[...]
> But it would be more awesome if git just supported schannel on
> Windows. I think cURL does already.

On the one hand, yes -- that would mean tighter integration into the
system which is a good thing from the administrative standpoint.

On the other hand, IIUC, this artifically limits the capabilities of
Git to whatever set of features the schannel implementation in a
particular version of Windows supports.  As a glaring example, support
for TLS 1.1 and TLS 1.2 had never made it into Windows XP (and
supposedly Windows Server 2003, though I may be wrong) despite its
serious entrenchment.  Among other things, that included IE (6, then 7,
then 8).  I do understand the reasons MS validly has for its push on its
customers for upgrades, but ubiquitous OSes nearing their EOL become
prone to lacking of certain features in their stacks.  This well might
be true for Windows 7 some 5 years down the road or so: from where I
sit, it looks like corporate users have zero reasons to upgrade to 10.

Hence ideally there would be some switch which would make libCURL pick
the implementation at runtime.  But I'm afraid it's hardly doable.
