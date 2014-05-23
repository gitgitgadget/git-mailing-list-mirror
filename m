From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [RFC/PATCH] replace: add --graft option
Date: Fri, 23 May 2014 08:39:54 +0200 (CEST)
Message-ID: <20140523.083954.56876133762506067.chriscool@tuxfamily.org>
References: <20140518182939.5260.91202.chriscool@tuxfamily.org>
	<5379D1EF.8040203@alum.mit.edu>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, git@vger.kernel.org, peff@peff.net
To: mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Fri May 23 08:40:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wnj9T-0004FV-AJ
	for gcvg-git-2@plane.gmane.org; Fri, 23 May 2014 08:40:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752092AbaEWGkR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 May 2014 02:40:17 -0400
Received: from [194.158.98.15] ([194.158.98.15]:44029 "EHLO mail-2y.bbox.fr"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751904AbaEWGkQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 May 2014 02:40:16 -0400
Received: from localhost (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-2y.bbox.fr (Postfix) with ESMTP id 97F3834;
	Fri, 23 May 2014 08:39:54 +0200 (CEST)
In-Reply-To: <5379D1EF.8040203@alum.mit.edu>
X-Mailer: Mew version 6.3 on Emacs 23.3 / Mule 6.0 (HANACHIRUSATO)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249976>

From: Michael Haggerty <mhagger@alum.mit.edu>

> On 05/18/2014 08:29 PM, Christian Couder wrote:
>> The usage string for this option is:
>> 
>> git replace [-f] --graft <commit> [<parent>...]
>> 
>> First we create a new commit that is the same as <commit>
>> except that its parents are [<parents>...]
>> 
>> Then we create a replace ref that replace <commit> with
>> the commit we just created.
>> 
>> With this new option, it should be straightforward to
>> convert grafts to replace refs, with something like:
>> 
>> cat .git/info/grafts | while read line
>> do git replace --graft $line; done
> 
> I love the functionality; I think it's a great step towards making
> grafts obsolete.
> 
> I haven't worked with Git's object reading/writing code much, but it
> surprised me that you are editing the commit object basically as a
> string, using hard-coded length constants and stuff.  It seems
> error-prone, and we already have a commit parser.
> 
> Would it be possible to program this at a higher layer of abstraction
> based on the commit object produced by the existing commit parser?
> E.g., edit the object it produces, and write the result?  Or create a
> new commit object out of the parsed commit object and write that?

I tried to program this at a higher layer of abstraction first, but it
was not easy to properly write the new commit.

> It's great that you're working on this!

Thanks,
Christian.
