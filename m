From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [kernel.org users] [RFD] On deprecating "git-foo" for builtins
Date: Tue, 26 Aug 2008 10:03:25 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0808260959000.3363@nehalem.linux-foundation.org>
References: <7vprnzt7d5.fsf@gitster.siamese.dyndns.org> <1219664940.9583.42.camel@pmac.infradead.org> <alpine.DEB.1.00.0808252018490.24820@pacific.mpi-cbg.de.mpi-cbg.de> <7vy72kek6y.fsf@gitster.siamese.dyndns.org> <20080826145719.GB5046@coredump.intra.peff.net>
 <1219764860.4471.13.camel@gaara.bos.redhat.com> <1219766398.7107.87.camel@pmac.infradead.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: =?ISO-8859-15?Q?Kristian_H=F8gsberg?= <krh@redhat.com>,
	Jeff King <peff@peff.net>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>, users@kernel.org
To: David Woodhouse <dwmw2@infradead.org>
X-From: git-owner@vger.kernel.org Tue Aug 26 19:11:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KY24D-0006QP-9X
	for gcvg-git-2@gmane.org; Tue, 26 Aug 2008 19:10:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753564AbYHZRJt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Aug 2008 13:09:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753139AbYHZRJs
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Aug 2008 13:09:48 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:52924 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750755AbYHZRJs (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Aug 2008 13:09:48 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m7QH3Qe0020004
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 26 Aug 2008 10:03:27 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m7QH3PMc017092;
	Tue, 26 Aug 2008 10:03:25 -0700
In-Reply-To: <1219766398.7107.87.camel@pmac.infradead.org>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.929 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93766>



On Tue, 26 Aug 2008, David Woodhouse wrote:
> 
> Nice emotive response, especially the subtle but unsubstantiated 'silent
> majority in favour' bit -- but you forgot the part where you were
> supposed to actually point out a tangible benefit which is achieved by
> breaking compatibility like this.

Umm. The 'git-xyzzy' thing has been one of the #1 complaints since pretty 
much day#1. The number of people complaining about it going away has 
literally been _much_ smaller than the people who complained about it 
being there.

Also, like it or not, it's done. So the argument about "compatibility" is 
TOTAL AND UTTER BULLSHIT. There is no compatibility, because we already 
released a major version without them.

So live with it, and just add the 

	PATH="$PATH:$(git --exec-path)"

as a "compatibility layer" to your own setup already. There is no 
downside, and I think there _is_ a big upside, and no, it's not just about 
"/usr/bin" being smaller.

In case you wonder, the upside is:

 - new people don't even learn the mistakes

 - the people who _did_ complain are happier

 - this model allows a per-user-preference model even on the same machine 
   (ie even on something like master.kernel.org, everybody can choose 
   _individually_ whether they want to see 'git-xyzzy' or not!)

and there really is zero downside apart from the _trivial_ downside of you 
just having to add a single PATH thing to your .bashrc or something.

			Linus
