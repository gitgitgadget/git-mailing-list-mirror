From: Markus Schiltknecht <markus@bluegap.ch>
Subject: Re: cvs import
Date: Fri, 15 Sep 2006 09:37:02 +0200
Message-ID: <450A581E.2050509@bluegap.ch>
References: <45084400.1090906@bluegap.ch> <9e4733910609131201q7f583029r72dac66cd0dd098f@mail.gmail.com> <46a038f90609131341se42b2dcne73c017cf757d13a@mail.gmail.com> <450872AE.5050409@bluegap.ch> <9e4733910609131438n686b6d72u4d5799533c7473d7@mail.gmail.com> <4508EA78.5030001@alum.mit.edu> <20060914155003.GB9657@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Jon Smirl <jonsmirl@gmail.com>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	monotone-devel@nongnu.org, dev@cvs2svn.tigris.org
X-From: git-owner@vger.kernel.org Fri Sep 15 09:37:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GO8GB-00059I-AG
	for gcvg-git@gmane.org; Fri, 15 Sep 2006 09:37:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751203AbWIOHhL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 15 Sep 2006 03:37:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751260AbWIOHhK
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Sep 2006 03:37:10 -0400
Received: from ns1.bugaboo.mu ([213.133.111.57]:60308 "EHLO bugaboo.mu")
	by vger.kernel.org with ESMTP id S1751203AbWIOHhJ (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 Sep 2006 03:37:09 -0400
Received: from [192.168.0.242] (berlin.programmfabrik.de [::ffff:213.221.101.147])
  (AUTH: CRAM-MD5 markus@bluegap.ch)
  by bugaboo.mu with esmtp; Fri, 15 Sep 2006 09:37:07 +0200
  id 02804676.450A5823.00004D48
User-Agent: Thunderbird 1.5.0.5 (X11/20060812)
To: Shawn Pearce <spearce@spearce.org>
In-Reply-To: <20060914155003.GB9657@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27065>

Hi,

Shawn Pearce wrote:
> I don't know how the Monotone guys feel about it but I think Git
> is happy with the data in any order, just so long as the dependency
> chains aren't fed out of order.  Which I think nearly all changeset
> based SCMs would have an issue with.  So we should be just fine
> with the current chronological order produced by cvs2svn.

I'd vote for splitting into file data (and delta / patches) import and 
metadata import (author, changelog, DAG).

Monotone would be happiest if the file data were sent one file after 
another and (inside each file) in the order of each file's single 
history. That guarantees good import performance for monotone. I imagine 
it's about the same for git. And if you have to somehow cache the files 
anyway, subversion will benefit, too. (Well, at least the cache will 
thank us with good performance).

After all file data has been delivered, the metadata can be delivered. 
As neigther monotone nor git care much if they are chronological across 
branches, I'd vote for doing it that way.

Regards

Markus
