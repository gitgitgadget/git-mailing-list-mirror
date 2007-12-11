From: Ingo Molnar <mingo@elte.hu>
Subject: Re: git-bisect feature suggestion: "git-bisect diff"
Date: Tue, 11 Dec 2007 11:17:25 +0100
Message-ID: <20071211101725.GB14372@elte.hu>
References: <20071207093439.GA21896@elte.hu> <200712080636.12982.chriscool@tuxfamily.org> <20071211092446.GA4703@elte.hu> <20071211092916.GF30948@artemis.madism.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Pierre Habouzit <madcoder@debian.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 11 11:18:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J22Bp-0001gY-Dq
	for gcvg-git-2@gmane.org; Tue, 11 Dec 2007 11:18:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751273AbXLKKRv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Dec 2007 05:17:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751187AbXLKKRv
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Dec 2007 05:17:51 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:51989 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751180AbXLKKRu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Dec 2007 05:17:50 -0500
Received: from elvis.elte.hu ([157.181.1.14])
	by mx2.mail.elte.hu with esmtp (Exim)
	id 1J22BA-0002nS-KH
	from <mingo@elte.hu>; Tue, 11 Dec 2007 11:17:38 +0100
Received: by elvis.elte.hu (Postfix, from userid 1004)
	id 49CDB3E2193; Tue, 11 Dec 2007 11:17:22 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20071211092916.GF30948@artemis.madism.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Received-SPF: neutral (mx2: 157.181.1.14 is neither permitted nor denied by domain of elte.hu) client-ip=157.181.1.14; envelope-from=mingo@elte.hu; helo=elvis.elte.hu;
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -1.5
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.5 required=5.9 tests=BAYES_00 autolearn=no SpamAssassin version=3.2.3
	-1.5 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67834>


* Pierre Habouzit <madcoder@debian.org> wrote:

> On Tue, Dec 11, 2007 at 09:24:46AM +0000, Ingo Molnar wrote:
> > ---------{ git-authors }--------->
> > #!/bin/bash
> > 
> > git-log $@ | grep Author: | cut -d: -f2 | sort | uniq -c | sort -n
> 
> You mean:
>     git shortlog -n -s HEAD -- "$@"
> to do exactly the same right ? :)

didnt know about that - i guess i wrote git-authors before even 
git-shortlog existed ;-)

but i still prefer this format:

      2  Serge E. Hallyn <serue@us.ibm.com>
     10  Eric W. Biederman <ebiederm@xmission.com>
     10  Pavel Emelyanov <xemul@openvz.org>
     10  Sukadev Bhattiprolu <sukadev@us.ibm.com>

because i'm not just interested in the stats, i'm also interested in an 
email address to pick. Also, the number should be the first column and 
aligned, it's easier to read for humans that way. (and this summary 
output is for humans.)

	Ingo
