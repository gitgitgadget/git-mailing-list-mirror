From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: Git is not scalable with too many refs/*
Date: Mon, 26 Sep 2011 18:25:39 +0200
Message-ID: <201109261825.39831.trast@student.ethz.ch>
References: <4DF6A8B6.9030301@op5.se> <4E809AFE.6010901@alum.mit.edu> <201109260942.08299.mfick@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Michael Haggerty <mhagger@alum.mit.edu>, <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>
To: Martin Fick <mfick@codeaurora.org>
X-From: git-owner@vger.kernel.org Mon Sep 26 18:25:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8E03-0004Py-7D
	for gcvg-git-2@lo.gmane.org; Mon, 26 Sep 2011 18:25:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751558Ab1IZQZm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Sep 2011 12:25:42 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:10602 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751172Ab1IZQZm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Sep 2011 12:25:42 -0400
Received: from CAS10.d.ethz.ch (172.31.38.210) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.1.339.1; Mon, 26 Sep
 2011 18:25:38 +0200
Received: from thomas.inf.ethz.ch (129.132.149.88) by cas10.d.ethz.ch
 (172.31.38.210) with Microsoft SMTP Server (TLS) id 14.1.339.1; Mon, 26 Sep
 2011 18:25:39 +0200
User-Agent: KMail/1.13.7 (Linux/3.0.4-43-desktop; KDE/4.6.5; x86_64; ; )
In-Reply-To: <201109260942.08299.mfick@codeaurora.org>
X-Originating-IP: [129.132.149.88]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182127>

Martin Fick wrote:
> 
> I suspect that there are several commands in git 
> which inadvertently scan all the refs when they probably 
> shouldn't. [...] I feel like git checkout is one of those cases, 
> it does not seem like git checkout should be affected by the 
> number of refs in a repo?

git-checkout checks whether you are leaving any unreferenced
(orphaned) commits behind when you leave a detached HEAD, which
requires that it scan the history of all refs for the commit you just
left.

So unless you disable that warning it'll be pretty expensive
regardless.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
