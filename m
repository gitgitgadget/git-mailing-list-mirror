From: Miles Bader <miles@gnu.org>
Subject: Re: RFH: unexpected reflog behavior with --since=
Date: Thu, 10 Nov 2011 20:06:56 +0900
Message-ID: <buok4785j8v.fsf@dhlpc061.dev.necel.com>
References: <4EB9C7D1.30201@nextest.com>
 <20111109220128.GA31535@sigill.intra.peff.net>
 <20111109222032.GB31535@sigill.intra.peff.net> <4EBB8596.6040507@nextest.com>
 <20111110080851.GA28342@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Eric Raible <raible@nextest.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Nov 10 12:07:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ROSTK-0007eW-V9
	for gcvg-git-2@lo.gmane.org; Thu, 10 Nov 2011 12:07:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932395Ab1KJLHA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Nov 2011 06:07:00 -0500
Received: from relmlor1.renesas.com ([210.160.252.171]:55934 "EHLO
	relmlor1.renesas.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755790Ab1KJLG7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Nov 2011 06:06:59 -0500
Received: from relmlir1.idc.renesas.com ([10.200.68.151])
 by relmlor1.idc.renesas.com ( SJSMS)
 with ESMTP id <0LUF00CL8YVLVCE0@relmlor1.idc.renesas.com> for
 git@vger.kernel.org; Thu, 10 Nov 2011 20:06:58 +0900 (JST)
Received: from relmlac3.idc.renesas.com ([10.200.69.23])
 by relmlir1.idc.renesas.com (SJSMS)
 with ESMTP id <0LUF00BFUYVLEIA0@relmlir1.idc.renesas.com> for
 git@vger.kernel.org; Thu, 10 Nov 2011 20:06:57 +0900 (JST)
Received: by relmlac3.idc.renesas.com (Postfix, from userid 0)
	id D408A18071; Thu, 10 Nov 2011 20:06:57 +0900 (JST)
Received: from relmlac3.idc.renesas.com (localhost [127.0.0.1])
	by relmlac3.idc.renesas.com (Postfix) with ESMTP id D26571807C; Thu,
 10 Nov 2011 20:06:57 +0900 (JST)
Received: from relmlii1.idc.renesas.com [10.200.68.65]	by
 relmlac3.idc.renesas.com with ESMTP id WAC02685; Thu,
 10 Nov 2011 20:06:57 +0900
X-IronPort-AV: E=Sophos;i="4.69,488,1315148400";   d="scan'208";a="54182495"
Received: from unknown (HELO relay61.aps.necel.com) ([10.29.19.64])
 by relmlii1.idc.renesas.com with ESMTP; Thu, 10 Nov 2011 20:06:57 +0900
Received: from dhlpc061 (dhlpc061.dev.necel.com [10.114.96.242])
	by relay61.aps.necel.com (8.14.4+Sun/8.14.4) with ESMTP id pAAB6uhH021008;
 Thu, 10 Nov 2011 20:06:56 +0900 (JST)
Received: by dhlpc061 (Postfix, from userid 31295)	id 9DB1E52E237; Thu,
 10 Nov 2011 20:06:56 +0900 (JST)
System-Type: x86_64-unknown-linux-gnu
Blat: Foop
In-reply-to: <20111110080851.GA28342@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185224>

Jeff King <peff@peff.net> writes:
> The only point would be to leave "--since" to act on the commit
> timestamps, so that you don't have to resort to the external grepping I
> mentioned above. However, I'm not convinced anybody even cares about
> that use case.
>
> I think the behavior you want is much more sensible.

I think there's already confusion in this area, e.g., with @{...} using
reflog dates, but "git log --since" using commit dates.  This can be an
easy trap to fall into because _often_ the two have similar granularity
(when you're mostly pushing changes), but not _always_ (when you pull a
big batch of changes).

Soooo, being really really explicit about using reflog dates vs. commit
dates -- and e.g., having option names like "--since" _always_ refer to
commit dates -- would be a good thing, I think...

-Miles

-- 
Future, n. That period of time in which our affairs prosper, our friends
are true and our happiness is assured.
