From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: What's cooking in git.git (topics)
Date: Sun, 2 Mar 2008 09:02:10 -0500
Message-ID: <20080302140210.GZ8410@spearce.org>
References: <7v7ihmuwzi.fsf@gitster.siamese.dyndns.org> <7vodavd9qw.fsf@gitster.siamese.dyndns.org> <7vbq6tset4.fsf@gitster.siamese.dyndns.org> <7vmyq9gk94.fsf@gitster.siamese.dyndns.org> <7vk5la4oxq.fsf@gitster.siamese.dyndns.org> <7vejbc44hu.fsf@gitster.siamese.dyndns.org> <7v8x1fymei.fsf@gitster.siamese.dyndns.org> <7vpruljunl.fsf@gitster.siamese.dyndns.org> <7v1w6xoqnm.fsf@gitster.siamese.dyndns.org> <7vy792yzd6.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 02 15:03:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVomT-0000D3-W2
	for gcvg-git-2@gmane.org; Sun, 02 Mar 2008 15:03:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751934AbYCBOCP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Mar 2008 09:02:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751988AbYCBOCO
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Mar 2008 09:02:14 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:40930 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751634AbYCBOCO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Mar 2008 09:02:14 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JVolT-0003yG-Ps; Sun, 02 Mar 2008 09:02:07 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id E418920FBAE; Sun,  2 Mar 2008 09:02:10 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <7vy792yzd6.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75778>

Junio C Hamano <gitster@pobox.com> wrote:
> * sp/fetch-optim (Sat Mar 1 00:25:38 2008 -0500) 7 commits
>  - Teach git-fetch to grab a tag at the same time as a commit
>  - Make git-fetch follow tags we already have objects for sooner
>  - Teach upload-pack to log the received need lines to fd 3
>  - Allow builtin-fetch's find_non_local_tags to append onto a list
>  - Ensure tail pointer gets setup correctly when we fetch HEAD only
>  - Remove unnecessary delaying of free_refs(ref_map) in builtin-fetch
>  - Remove unused variable in builtin-fetch find_non_local_tags
> 
> A few existing tests in 5515 need to be adjusted as they expect tags not
> to be fetched early, but the point of this series is to optimize to allow
> them to, under some conditions.  Otherwise slated for 1.5.5.

Really?  I thought 5515 was passing when I sent the v2 series in.
I'll double check it later today.  Prior to my "Teach upload-pack
to log" change I'm not sure *how* the tests in 5515 would notice
that tags were fetched on the first connection and not the second.
Its still in the same git-fetch process.
 
-- 
Shawn.
