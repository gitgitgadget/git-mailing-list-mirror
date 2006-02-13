From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: Prune-safe StGIT (was Re: Two crazy proposals for changing git's
 diff commands)
Date: Mon, 13 Feb 2006 22:00:14 +0000
Message-ID: <43F1016E.5070203@gmail.com>
References: <87slqtcr2f.wl%cworth@cworth.org> <7vfymtl43b.fsf@assigned-by-dhcp.cox.net> <87bqxgxfl7.wl%cworth@cworth.org> <7vr76c5avd.fsf@assigned-by-dhcp.cox.net> <87fymst399.wl%cworth@cworth.org> <7vfyms0x4p.fsf@assigned-by-dhcp.cox.net> <slrnduphvr.2i8.mdw@metalzone.distorted.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 13 23:00:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F8lk7-0001iB-C5
	for gcvg-git@gmane.org; Mon, 13 Feb 2006 23:00:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030200AbWBMWAU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 13 Feb 2006 17:00:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964871AbWBMWAU
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Feb 2006 17:00:20 -0500
Received: from mta07-winn.ispmail.ntl.com ([81.103.221.47]:19076 "EHLO
	mta07-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S964870AbWBMWAT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Feb 2006 17:00:19 -0500
Received: from aamta09-winn.ispmail.ntl.com ([81.103.221.35])
          by mta07-winn.ispmail.ntl.com with ESMTP
          id <20060213220017.CQWX15056.mta07-winn.ispmail.ntl.com@aamta09-winn.ispmail.ntl.com>;
          Mon, 13 Feb 2006 22:00:17 +0000
Received: from [192.168.1.101] (really [86.15.186.141])
          by aamta09-winn.ispmail.ntl.com with ESMTP
          id <20060213220017.LNVT1154.aamta09-winn.ispmail.ntl.com@[192.168.1.101]>;
          Mon, 13 Feb 2006 22:00:17 +0000
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
To: Mark Wooding <mdw@distorted.org.uk>
In-Reply-To: <slrnduphvr.2i8.mdw@metalzone.distorted.org.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16084>

Mark Wooding wrote:
> (I really look forward to a StGIT which can withstand git-prune.)

Since there were a few requests for this feature, I pushed it to the
public repository (and also included it in the latest snapshot).

As it was discussed a few months ago, the top id of each patch
(including the popped ones) is added to the
.git/refs/patches/<branch>/<patch> file. The git-prune command will
preserve these objects and their referents, making even the unapplied
patches safe. There is another advantage with this approach - gitk shows
the patch name for every corresponding commit.

Running any command (apart from help) on the current branch would create
the initial references. You would need to do the same with all the other
branches. Since this is a new feature, make sure you have backups before
pruning (though it worked OK for me).

--
Catalin
