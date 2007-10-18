From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: git on afs
Date: Thu, 18 Oct 2007 16:28:01 -0500 (CDT)
Message-ID: <Pine.LNX.4.64.0710181613420.30020@torch.nrlssc.navy.mil>
References: <20071018203106.GA13518@fries.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org
To: "Todd T. Fries" <todd@fries.net>
X-From: git-owner@vger.kernel.org Thu Oct 18 23:28:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iicur-0003cB-5A
	for gcvg-git-2@gmane.org; Thu, 18 Oct 2007 23:28:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757810AbXJRV2R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2007 17:28:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757393AbXJRV2R
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Oct 2007 17:28:17 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:51521 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757351AbXJRV2Q (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2007 17:28:16 -0400
Received: from starfish.gems.nrlssc.navy.mil (localhost [127.0.0.1])
	by mail.nrlssc.navy.mil (8.13.7/8.13.7) with ESMTP id l9ILS1Jm016538;
	Thu, 18 Oct 2007 16:28:02 -0500
Received: from torch.nrlssc.navy.mil ([128.160.25.59]) by starfish.gems.nrlssc.navy.mil with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 18 Oct 2007 16:28:01 -0500
In-Reply-To: <20071018203106.GA13518@fries.net>
X-OriginalArrivalTime: 18 Oct 2007 21:28:01.0474 (UTC) FILETIME=[C2D49A20:01C811CD]
X-TM-AS-Product-Ver: : ISVW-6.0.0.2339-5.0.0.1023-15336001
X-TM-AS-Result: : Yes--5.183100-0-31-1
X-TM-AS-Category-Info: : 31:0.000000
X-TM-AS-MatchedID: : =?us-ascii?B?MTUwNTY3LTcwMDg4Ny03MDI1?=
	=?us-ascii?B?OTctNzAwMDc1LTEzOTAxMC03MDgxNDMtMTEzMjI4LTEyMTU4OC03?=
	=?us-ascii?B?MDU2MDgtNzAyMTY5LTcwMDk3MS03MDIxMTMtNzAzMTc2LTcwMTU3?=
	=?us-ascii?B?Ni0xNDgwMzktMTQ4MDUw?=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61560>

On Thu, 18 Oct 2007, Todd T. Fries wrote:

> 1) git presumes that link() works fine across subdirs; in afs land,
>   hardlinks do not succeed ever

I think this already falls back to rename() on failure.
Take a look at move_temp_to_file(), this is the only
place that calls link_temp_to_file().

link() on afs returns non-zero? and not EEXIST right?

-brandon
