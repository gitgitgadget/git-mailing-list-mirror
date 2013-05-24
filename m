From: "Holger Hellmuth (IKS)" <hellmuth@ira.uka.de>
Subject: Re: first parent, commit graph layout, and pull merge direction
Date: Fri, 24 May 2013 17:05:26 +0200
Message-ID: <519F81B6.4010807@ira.uka.de>
References: <20130522115042.GA20649@inner.h.apk.li> <7v4ndukhx0.fsf@alter.siamese.dyndns.org> <20130523090657.GB23933@inner.h.apk.li> <20130523192512.GR9448@inner.h.apk.li> <519F32DC.0@ira.uka.de> <20130524134214.GA26617@inner.h.apk.li>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Andreas Krey <a.krey@gmx.de>
X-From: git-owner@vger.kernel.org Fri May 24 17:04:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UftXr-0001Id-Pv
	for gcvg-git-2@plane.gmane.org; Fri, 24 May 2013 17:04:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756427Ab3EXPEd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 May 2013 11:04:33 -0400
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:56834 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755266Ab3EXPEc (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 May 2013 11:04:32 -0400
Received: from irams1.ira.uni-karlsruhe.de ([141.3.10.5])
	by iramx2.ira.uni-karlsruhe.de with esmtps port 25 
	id 1UftXX-0006hY-CM; Fri, 24 May 2013 17:04:25 +0200
Received: from i20s141.iaks.uni-karlsruhe.de ([141.3.32.141] helo=[172.16.22.120])
	by irams1.ira.uni-karlsruhe.de with esmtpsa port 587 
	id 1UftXX-00059m-5V; Fri, 24 May 2013 17:04:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130329 Thunderbird/17.0.5
In-Reply-To: <20130524134214.GA26617@inner.h.apk.li>
X-ATIS-AV: ClamAV (irams1.ira.uni-karlsruhe.de)
X-ATIS-AV: Kaspersky (iramx2.ira.uni-karlsruhe.de)
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de 1369407865.636284000
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225360>

Am 24.05.2013 15:42, schrieb Andreas Krey:
> On Fri, 24 May 2013 11:29:00 +0000, Holger Hellmuth (IKS) wrote:
> ...
>> Here is an idea (probably already discussed in the long history of git):
>> 1) the branch name is recorded in a commit (for merges the branch that
>> is updated)
>
> The branch name is almost completely meaningless. I could just
> do my feature in my local master and never have a different name.

In which case parent switching in the commit wouldn't help you either.

But even you could keep your master always on the left side of gitk if 
you deem it special. And you could keep longer running cooperative 
branches (the main develop and the release branch of your project for 
example) in a seperate lane.

Depending on your use of branches many branches won't get any ordering, 
but at a minimum important branches can easily be "highlighted".

> Or commit something onto tmp that I then fast-forward into my
> (properly named) feature branch.

Yes, but then you would see a feature branch in its expected column in 
gitk and you would also see (even years later) that it didn't start as a 
feature but later was made into one. Cues like this help to remember 
what happened even if you forgot to mention them in the commit message

>> 2) unique identifier of repository is recorded in commit (optional)
>
> That is pure noise (in my workflow).

It is important to differentiate between branches of the same name in 
different repositories. For example if your project has a central 
repository with master getting all the release stuff you want to sort 
that master differently than your own master.

The unique identifier might be just a random number or string created at 
init time of the repo.

>> 3) simple configurable ordering and/or coloring scheme in gitk based on
>> committer,branch name and repo (with wildcards).
>
> Ok, gitk could use some features. :-)

Without additional information about the commit history gitk can do 
exactly what it does now.

> ...
>> Is this a bad idea or just no one did it yet?
>
> Possibly not bad (hg does parts of it), but un-git-ish?

Don't know. No CVS does branches as good as git. But then it drops that 
information which depending on development style could be useful or not.
Not that useful for people who keep their history clean, a lot for 
people who don't.
