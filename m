From: Adam Flott <adam@npjh.com>
Subject: Re: Inheritance of files for parent/child branches
Date: Sat, 16 Feb 2008 12:33:42 -0600 (CST)
Message-ID: <alpine.DEB.1.00.0802161224160.32252@an.sumeria>
References: <alpine.DEB.1.00.0802161110310.32252@an.sumeria> <20080216180903.GB19506@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Feb 16 19:34:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQRro-0003Xj-KV
	for gcvg-git-2@gmane.org; Sat, 16 Feb 2008 19:34:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755247AbYBPSdy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Feb 2008 13:33:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755002AbYBPSdy
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Feb 2008 13:33:54 -0500
Received: from npjh.com ([200.46.204.250]:56574 "EHLO npjh.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754525AbYBPSdx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Feb 2008 13:33:53 -0500
Received: from localhost (unknown [200.46.204.187])
	by npjh.com (Postfix) with ESMTP id 189421351F1C;
	Sat, 16 Feb 2008 18:33:53 +0000 (UTC)
Received: from npjh.com ([200.46.204.250])
 by localhost (mx1.hub.org [200.46.204.187]) (amavisd-maia, port 10024)
 with ESMTP id 63151-04; Sat, 16 Feb 2008 14:33:51 -0400 (AST)
Received: from an.sumeria (unknown [70.124.58.159])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by npjh.com (Postfix) with ESMTP id 42B0C1351FB8;
	Sat, 16 Feb 2008 18:33:52 +0000 (UTC)
X-X-Sender: adam@an.sumeria
In-Reply-To: <20080216180903.GB19506@sigill.intra.peff.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74056>



On Sat, 16 Feb 2008, Jeff King wrote:

> On Sat, Feb 16, 2008 at 11:32:01AM -0600, Adam Flott wrote:
>
>> The only redeeming feature in AccuRev was the ability to an use
>> inheritance for files in streams (nearly analogous to branches). While
>> this idea in the SCM world sounds strange, is there anything in git land
>> that could mimic this sort of behavior?
>>
>> In case, "inheritance for files..." isn't clear, what I would like to
>> accomplish is: have a branch "parent" with multiple "children" branches
>> (which may have descendents of their own). If a file is committed to the
>> parent branch, then the all the descendents would receive the same
>> update without manually cherry-picking the commit across all the
>> branches.
>
> Wouldn't that just be a merge of the parent branch into the child
> branch? Which really isn't any different than cherry-picking, except
> that you retain the history instead of picking the one patch. In both
> cases, you are saying "take the differences in the parent tree between
> point X and point Y, and merge them into what I have now." In the case
> of cherry pick, you are saying that X is really Y^. In the case of a
> merge, you are saying that X is "the last point parent and child merged"
> (.e., git merge-base parent child).
>
> It won't happen _automatically_, though, and I don't think it should
> (since each merge may have conflicts). But you could probably accomplish
> what you want by cascading the merges. Something like:

Your example is basically the only solution I could think of that would work
with git. This repository will be for configuration files, where I want the
parent to always "win" with conflicts.

I'll use your example as a basis for something and see if I can come up with a
proof of concept that won't backfire on me in the future.


Adam
