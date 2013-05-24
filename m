From: "Holger Hellmuth (IKS)" <hellmuth@ira.uka.de>
Subject: Re: first parent, commit graph layout, and pull merge direction
Date: Fri, 24 May 2013 11:29:00 +0200
Message-ID: <519F32DC.0@ira.uka.de>
References: <20130522115042.GA20649@inner.h.apk.li> <7v4ndukhx0.fsf@alter.siamese.dyndns.org> <20130523090657.GB23933@inner.h.apk.li> <20130523192512.GR9448@inner.h.apk.li>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Andreas Krey <a.krey@gmx.de>
X-From: git-owner@vger.kernel.org Fri May 24 11:28:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UfoIE-0005kT-35
	for gcvg-git-2@plane.gmane.org; Fri, 24 May 2013 11:28:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758284Ab3EXJ2F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 May 2013 05:28:05 -0400
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:45596 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752842Ab3EXJ2E (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 May 2013 05:28:04 -0400
Received: from irams1.ira.uni-karlsruhe.de ([141.3.10.5])
	by iramx2.ira.uni-karlsruhe.de with esmtps port 25 
	id 1UfoHy-0001RO-4R; Fri, 24 May 2013 11:27:59 +0200
Received: from i20s141.iaks.uni-karlsruhe.de ([141.3.32.141] helo=[172.16.22.120])
	by irams1.ira.uni-karlsruhe.de with esmtpsa port 587 
	id 1UfoHx-0003NY-TN; Fri, 24 May 2013 11:27:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130329 Thunderbird/17.0.5
In-Reply-To: <20130523192512.GR9448@inner.h.apk.li>
X-ATIS-AV: ClamAV (irams1.ira.uni-karlsruhe.de)
X-ATIS-AV: Kaspersky (iramx2.ira.uni-karlsruhe.de)
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de 1369387679.366676000
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225335>

Am 23.05.2013 21:25, schrieb Andreas Krey:
> On Thu, 23 May 2013 11:06:57 +0000, Andreas Krey wrote:
> ...
>> ...
>>> Don't do that, then.
>
> Ouch, you're right. The problem is not actually in the
> pull; only the *last* pull into a feature branch that
> then get pushed back ff to master needs to be reversed.
>
> And at that time you don't know it's the last one
> -> swap parents before the push if necessary.

if you have to be so careful to ensure the correct ordering of parents 
it almost defeats the initial objective to make commit graphs in gitk 
look nice without re-educating/restricting other users. A solution that 
works for everyone should work without users having to think about it.

Here is an idea (probably already discussed in the long history of git):
1) the branch name is recorded in a commit (for merges the branch that 
is updated)
2) unique identifier of repository is recorded in commit (optional)
3) simple configurable ordering and/or coloring scheme in gitk based on 
committer,branch name and repo (with wildcards).

With this users could pull and push as often as they like, the main 
branches would always be ordered and straight lines. If instead you 
already do the work to keep your history clean you could just use the 
coloring scheme and see committers color coded in gitk. Further benefit: 
the history of really old commits could be more easily remembered if you 
knew in what branch they originated

Is this a bad idea or just no one did it yet?
