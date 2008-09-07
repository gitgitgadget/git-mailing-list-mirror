From: Andreas Ericsson <ae@op5.se>
Subject: Re: How can I track a template?
Date: Sun, 07 Sep 2008 21:35:58 +0200
Message-ID: <48C42D1E.8000805@op5.se>
References: <48C3FB9E.8090404@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Mike Sharov <msharov@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Sun Sep 07 21:37:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KcQ4Z-0001xj-8N
	for gcvg-git-2@gmane.org; Sun, 07 Sep 2008 21:37:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755102AbYIGTgN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Sep 2008 15:36:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755193AbYIGTgN
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Sep 2008 15:36:13 -0400
Received: from mail.op5.se ([193.201.96.20]:35677 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755013AbYIGTgM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Sep 2008 15:36:12 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 91C821B80007;
	Sun,  7 Sep 2008 21:42:09 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WUEb+lVAoBp4; Sun,  7 Sep 2008 21:42:01 +0200 (CEST)
Received: from clix.int.op5.se (unknown [172.27.78.22])
	by mail.op5.se (Postfix) with ESMTP id 1B44224B003A;
	Sun,  7 Sep 2008 21:41:59 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
In-Reply-To: <48C3FB9E.8090404@users.sourceforge.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95166>

Mike Sharov wrote:
> I am trying to create a standard module to be included into many
> projects. Specifically, the build system skeleton, but I have other uses
> for the same mechanism. The idea is to have a repository with the
> skeleton itself, and have other projects include it somehow and keep
> up-to-date by pulling from the template repository.
> 
> The straightforward approach of using 'git pull' does not work very
> well. At each merge, all the things changed show up. For example, I
> would change the project name in the configure template. This change
> creates a merge conflict on every pull even if that particular line did
> not change in the template. Somehow it just doesn't seem to establish a
> base for the merges. Another problem is that the tags get pulled and
> become tags on the project, which is undesirable.
> 
> What sort of a solution would you recommend for this, if any?

Enable rerere, the merge resolution recorder/replayer.
Pull from skeleton repo with --no-tags, and remove the tag-fetching
refspec from your .git/config (note that everyone has to do it, but
if only you integrate the updated skeleton that won't be a problem).

Or unconditionally include a project.mak (or some such) from the build
skeleton which sets all the project-specific details.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
