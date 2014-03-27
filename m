From: Kirill Smelkov <kirr@navytux.spb.ru>
Subject: Re: [PATCH v2 14/19] tree-diff: rework diff_tree interface to be
 sha1 based
Date: Thu, 27 Mar 2014 23:43:00 +0400
Organization: NAVYTUX.SPB.RU
Message-ID: <20140327194300.GA5510@mini.zxlink>
References: <cover.1393257006.git.kirr@mns.spb.ru>
 <0b82e2de0edee4a590e7b4165c65938aef7090f5.1393257006.git.kirr@mns.spb.ru>
 <xmqqa9cfp9d5.fsf@gitster.dls.corp.google.com>
 <20140325092215.GB3777@mini.zxlink>
 <xmqq4n2mmarr.fsf@gitster.dls.corp.google.com>
 <20140326195201.GB16002@mini.zxlink>
 <xmqq1txoiqzj.fsf@gitster.dls.corp.google.com>
 <20140327142438.GE17333@mini.zxlink>
 <xmqq1txneavo.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stefan Beller <stefanbeller@googlemail.com>, kirr@mns.spb.ru,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 27 20:39:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WTG9Y-0005Tk-4F
	for gcvg-git-2@plane.gmane.org; Thu, 27 Mar 2014 20:39:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755359AbaC0Tjr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Mar 2014 15:39:47 -0400
Received: from forward6l.mail.yandex.net ([84.201.143.139]:58784 "EHLO
	forward6l.mail.yandex.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754902AbaC0Tjp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Mar 2014 15:39:45 -0400
Received: from smtp3o.mail.yandex.net (smtp3o.mail.yandex.net [37.140.190.28])
	by forward6l.mail.yandex.net (Yandex) with ESMTP id B29BA14E0E78;
	Thu, 27 Mar 2014 23:39:42 +0400 (MSK)
Received: from smtp3o.mail.yandex.net (localhost [127.0.0.1])
	by smtp3o.mail.yandex.net (Yandex) with ESMTP id 2A7301E0FDA;
	Thu, 27 Mar 2014 23:39:42 +0400 (MSK)
Received: from unknown (unknown [93.185.17.156])
	by smtp3o.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id 3u6cLRPfUm-dbbOJ0Dw;
	Thu, 27 Mar 2014 23:39:40 +0400
	(using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
	(Client certificate not present)
X-Yandex-Uniq: e5e10c87-505a-4957-a8ab-3b8ac4e450a3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=navytux.spb.ru; s=mail;
	t=1395949181; bh=DyP1REaV4YXkjt935gUeTuU7dcEMDIY+ccJEwgQXx+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To:Organization:
	 User-Agent;
	b=nJXwX8wsvEjPoo8cP1JoAswlYOPpgtlFOFUiH81dpZ37J3tsrPziVZ/iPi1SAaF2T
	 XlMp4Mzx6gWFLAE430nXWVKsSLtTWO04sF/PQYl4cQZ0YLYBrkawtICc5ZmkW9pkMm
	 YsmkSPnwKe9wAQxlMypr57yanZCDb253vTxCt2Fk=
Authentication-Results: smtp3o.mail.yandex.net; dkim=pass header.i=@navytux.spb.ru
Received: from kirr by mini.zxlink with local (Exim 4.82)
	(envelope-from <kirr@mini.zxlink>)
	id 1WTGCa-0001Zt-TF; Thu, 27 Mar 2014 23:43:00 +0400
Content-Disposition: inline
In-Reply-To: <xmqq1txneavo.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245322>

+stefanbeller

On Thu, Mar 27, 2014 at 11:48:11AM -0700, Junio C Hamano wrote:
> Kirill Smelkov <kirr@navytux.spb.ru> writes:
> 
> > (please keep author email)
> > ---- 8< ----
> > From: Kirill Smelkov <kirr@mns.spb.ru>
> > Date: Mon, 24 Feb 2014 20:21:46 +0400
> > Subject: [PATCH v3a] tree-diff: rework diff_tree interface to be sha1 based
> 
> "git am -c" will discard everything above the scissors and then
> start parsing the in-body headers from there, so the above From:
> will be used.

Thanks.

> But you have a few entries in .mailmap; do you want to update them
> as well?

When Stefan Beller was contacting me on emails, if I recall correctly, I
told him all those kirr@... entries are mine, but the one this patch is
authored with indicates that something was done at work, and I'd prefer to
acknowledge that. So maybe

---- 8< ----
From: Kirill Smelkov <kirr@navytux.spb.ru>
Date: Thu, 27 Mar 2014 23:32:14 +0400
Subject: [PATCH] .mailmap: Separate Kirill Smelkov personal and work addresses

The address kirr@mns.spb.ru indicates that a patch was done at work and
I'd like to acknowledge that.

The address kirr@navytux.spb.ru is my personal email and indicates that
a contribution is done completely on my own time and resources.

kirr@landau.phys.spbu.ru is old university account which no longer works
(sigh, to much spam "because of me" on the server) and maps to
kirr@navytux.spb.ru which should be considered as primary.

Signed-off-by: Kirill Smelkov <kirr@navytux.spb.ru>
---
 .mailmap | 1 -
 1 file changed, 1 deletion(-)

diff --git a/.mailmap b/.mailmap
index 11057cb..0be5e02 100644
--- a/.mailmap
+++ b/.mailmap
@@ -117,7 +117,6 @@ Keith Cascio <keith@CS.UCLA.EDU> <keith@cs.ucla.edu>
 Kent Engstrom <kent@lysator.liu.se>
 Kevin Leung <kevinlsk@gmail.com>
 Kirill Smelkov <kirr@navytux.spb.ru> <kirr@landau.phys.spbu.ru>
-Kirill Smelkov <kirr@navytux.spb.ru> <kirr@mns.spb.ru>
 Knut Franke <Knut.Franke@gmx.de> <k.franke@science-computing.de>
 Lars Doelle <lars.doelle@on-line ! de>
 Lars Doelle <lars.doelle@on-line.de>
-- 
1.9.rc0.143.g6fd479e
---- 8< ----

On the other hand, it is still all me, and the main address (navytux) is
indicated correctly, so I dunno...

> By the way, in general I do not appreciate people lying on the Date:
> with an in-body header in their patches, either in the original or
> in rerolls.
> 
> Thanks.

I see. Somehow it is pity that the date of original work is lost via
this approach, as now we are only changing cosmetics etc, and the bulk
of the work was done earlier.

Anyway, we can drop the date, but please keep the email, as it is used
for the acknowledgment.

Thanks,
Kirill
