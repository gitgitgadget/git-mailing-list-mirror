From: Martin Fick <mfick@codeaurora.org>
Subject: Re: Diagnosing stray/stale .keep files -- explore what is in a pack?
Date: Tue, 14 Jan 2014 12:36:44 -0700
Organization: CAF
Message-ID: <201401141236.44393.mfick@codeaurora.org>
References: <CACPiFCLa3X-Xt5GwrHHA-PFj-Bi9_sW+=y2xidZ7tDbFfM26rA@mail.gmail.com> <CACPiFCJVx0dkkPQ=LosbAAKq7CvK6_yQL5QDHMYr5oJAS6wb6Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 14 20:36:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W39nA-0005pL-EX
	for gcvg-git-2@plane.gmane.org; Tue, 14 Jan 2014 20:36:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751861AbaANTgt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jan 2014 14:36:49 -0500
Received: from smtp.codeaurora.org ([198.145.11.231]:40163 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751693AbaANTgr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jan 2014 14:36:47 -0500
Received: from smtp.codeaurora.org (localhost [127.0.0.1])
	by smtp.codeaurora.org (Postfix) with ESMTP id 1235613F01C;
	Tue, 14 Jan 2014 19:36:47 +0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 486)
	id 0363713F10F; Tue, 14 Jan 2014 19:36:46 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on
	pdx-caf-smtp.dmz.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.3.1
Received: from mfick-lnx.localnet (mfick-lnx.qualcomm.com [129.46.10.58])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: mfick@smtp.codeaurora.org)
	by smtp.codeaurora.org (Postfix) with ESMTPSA id B2A6013F126;
	Tue, 14 Jan 2014 19:36:46 +0000 (UTC)
User-Agent: KMail/1.13.5 (Linux/2.6.32.49+drm33.21-mfick7; KDE/4.4.5; x86_64; ; )
In-Reply-To: <CACPiFCJVx0dkkPQ=LosbAAKq7CvK6_yQL5QDHMYr5oJAS6wb6Q@mail.gmail.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240408>

Perhaps the receiving process is dying hard and leaving 
stuff behind?  Out-of-memory, out of disk space?

-Martin

On Tuesday, January 14, 2014 10:10:31 am Martin Langhoff 
wrote:
> On Tue, Jan 14, 2014 at 9:54 AM, Martin Langhoff
> 
> <martin.langhoff@gmail.com> wrote:
> > Is there a handy way to list the blobs in a pack, so I
> > can feed them to git-cat-file and see what's in there?
> > I'm sure that'll help me narrow down on the issue.
> 
> git show-index  <
> /var/lib/ppg/reports.git/objects/pack/pack-22748bcca7f50a
> 3a49aa4aed61444bf9c4ced685.idx
> 
> cut -d\  -f2 | xargs -iHASH git --git-dir 
> /var/lib/ppg/reports.git/ unpack-file HASH
> 
> After a bit of looking at the output, clearly I have two
> clients, out of the many that connect here, that have
> the problem. I will be looking into those clients to see
> what's the problem.
> 
> In my use case, clients push to their own head. Looking
> at refs/heads shows that there are stale .lock files
> there. Hmmm.
> 
> This is on git 1.7.1 (RHEL and CentOS clients).
> 
> cheers,
> 
> 
> m

-- 
The Qualcomm Innovation Center, Inc. is a member of Code 
Aurora Forum, hosted by The Linux Foundation
 
