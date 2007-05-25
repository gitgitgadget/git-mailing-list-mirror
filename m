From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Split packs from git-repack should have descending timestamps
Date: Thu, 24 May 2007 20:46:10 -0400
Message-ID: <20070525004610.GP28023@spearce.org>
References: <465612CE.4080605@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: Dana How <danahow@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 25 02:46:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HrNwh-0006vm-HQ
	for gcvg-git@gmane.org; Fri, 25 May 2007 02:46:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751048AbXEYAqP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 24 May 2007 20:46:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751004AbXEYAqP
	(ORCPT <rfc822;git-outgoing>); Thu, 24 May 2007 20:46:15 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:57467 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750751AbXEYAqP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 May 2007 20:46:15 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HrNwQ-0004Bk-3v; Thu, 24 May 2007 20:46:02 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id DE63E20FBAE; Thu, 24 May 2007 20:46:10 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <465612CE.4080605@gmail.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48318>

Dana How <danahow@gmail.com> wrote:
> 
> If git-repack produces multiple split packs because
> --max-pack-size was in effect,  the first pack written
> should have the latest timestamp because:
> (1) sha1_file.c:rearrange_packed_git() puts more recent
>     pack files at the beginning of the search list;  and
> (2) the most recent objects are written out first
>     while packing.
> 
> This is based on next rather than master to avoid merge
> conflicts with changes already in git-repack.sh due to
> the --max-pack-size patchset.

Ack.  Given our mtime based sorting routine, even without your
recent patch to improve it, I think we definately want this type
of behavior built into git-repack.sh.  Good follow-on to your
--max-pack-size series.

-- 
Shawn.
