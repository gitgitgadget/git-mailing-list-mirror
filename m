From: Geert Bosch <bosch@adacore.com>
Subject: Re: Excruciatingly slow git-svn imports
Date: Tue, 6 May 2008 07:23:30 -0400
Message-ID: <4484D251-B919-40AE-849B-1162F057550C@adacore.com>
References: <CC0F600D-71F3-493A-AA9C-AF901C1A58C4@adacore.com> <2C39C19D-0B81-4879-92DC-C0436DB6E84E@midwinter.com> <20080429071122.GG24171@muzzle> <2B9E6C04-69F1-42BD-AE60-AFCE401E093E@adacore.com> <20080506032846.GA15521@untitled> <32541b130805052056g450b69cfg46693bc3c0c5a1ed@mail.gmail.com> <20080506042508.GA23465@untitled>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Avery Pennarun <apenwarr@gmail.com>,
	Steven Grimm <koreth@midwinter.com>,
	"git@vger.kernel.org List" <git@vger.kernel.org>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Tue May 06 13:24:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JtLHS-0002Kh-8A
	for gcvg-git-2@gmane.org; Tue, 06 May 2008 13:24:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752620AbYEFLXc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 May 2008 07:23:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752202AbYEFLXc
	(ORCPT <rfc822;git-outgoing>); Tue, 6 May 2008 07:23:32 -0400
Received: from rock.gnat.com ([205.232.38.15]:53979 "EHLO rock.gnat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751453AbYEFLXc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 May 2008 07:23:32 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by filtered-rock.gnat.com (Postfix) with ESMTP id 6E2FE2A9927;
	Tue,  6 May 2008 07:23:31 -0400 (EDT)
Received: from rock.gnat.com ([127.0.0.1])
	by localhost (rock.gnat.com [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id oHS4zc4GGR0N; Tue,  6 May 2008 07:23:31 -0400 (EDT)
Received: from [172.16.1.95] (sdsl-216-220-103-157.dsl.bway.net [216.220.103.157])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rock.gnat.com (Postfix) with ESMTP id 243282A98E4;
	Tue,  6 May 2008 07:23:31 -0400 (EDT)
In-Reply-To: <20080506042508.GA23465@untitled>
X-Mailer: Apple Mail (2.919.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81351>


On May 6, 2008, at 00:25, Eric Wong wrote:

> When using "svn cp" on a top-level directory, it *should*
> just show up as a single file change in the log entry.
> Something like:
>
>  A /project/branch/my-new-branch (from /project/trunk:1234)
>
> This would not take much memory at all.
> However, I've also occasionally seen stuff like this:
>
>  A /project/branch/my-new-branch
>  A /project/branch/my-new-branch/file1 (from /project/trunk/ 
> file1:1234)
>  A /project/branch/my-new-branch/file2 (from /project/trunk/ 
> file2:1234)
>  A /project/branch/my-new-branch/file3 (from /project/trunk/ 
> file3:1234)
>  .... many more files and directories along the same lines ...

This is exactly what I'm experiencing.
> This is what I suspect Geert is seeing in his repository and causing
> problems.  Perhaps something caused by cvs2svn importing those tags  
> into
> SVN originally?

Yes, most likely. BTW, the conversion from CVS to SVN took about a day
on slightly slower hardware.

   -Geert
