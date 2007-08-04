From: david@lang.hm
Subject: possible bug in git apply?
Date: Sat, 4 Aug 2007 12:45:23 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0708041243070.6905@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: rob@landley.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 04 21:47:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHPas-0008N8-Kj
	for gcvg-git@gmane.org; Sat, 04 Aug 2007 21:47:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765714AbXHDTrS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Aug 2007 15:47:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765695AbXHDTrS
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Aug 2007 15:47:18 -0400
Received: from dsl081-033-126.lax1.dsl.speakeasy.net ([64.81.33.126]:51268
	"EHLO bifrost.lang.hm" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933365AbXHDTrR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Aug 2007 15:47:17 -0400
Received: from asgard (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id l74Jl5Uw014257;
	Sat, 4 Aug 2007 12:47:05 -0700
X-X-Sender: dlang@asgard.lang.hm
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54898>

since git doesn't track directories, only content (per the big discussion 
recently) I beleive that doing a checkout would leave Rob without the 
directories that he emptied out, so shouldn't git apply also clear the 
directories to end up in the same state?

David Lang

---------- Forwarded message ----------
Date: Sat, 4 Aug 2007 15:19:54 -0400
From: Rob Landley <rob@landley.net>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Roland Dreier <rdreier@cisco.com>,
     Linux Kernel <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org,
     Andrew Morton <akpm@linux-foundation.org>, Paul Mundt <lethal@linux-sh.org>
Subject: Re: [PATCH 1/2] Group architecture Documentation under
     Documentation/arch.

On Saturday 04 August 2007 2:03:59 pm Rob Landley wrote:
> Signed-off-by: Rob Landley <rob@landley.net>
> Amiga part Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
>
> Move architecture-specific Documentation into a common subdirectory.

I really, really, really hate git.

Ok, on my laptop I just noticed that "git apply" of the patch didn't complain
but it also left the empty subdirectories it moved stuff out of.  (I don't
believe this happened on the version of git I was using on my previous
laptop, which ate itself a month and change ago, but obviously I can't
check.)

There is no "git rmdir".  "git rm" refuses to delete the directory
without -r.  "git rm -r Documentation/x86_64" listed (as just deleted) all
the files that the patch already moved out of the directory.

Am I missing something obvious here?

Rob
-- 
"One of my most productive days was throwing away 1000 lines of code."
   - Ken Thompson.
