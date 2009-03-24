From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: started a cvsps testsuite Was: Re: [PATCH v3 0/2] cvsimport:
 add	test illustrating a bug in cvsps
Date: Tue, 24 Mar 2009 05:50:03 +0100
Message-ID: <49C8667B.5050506@alum.mit.edu>
References: <49A2EFC6.5000104@hvoigt.net> <49A37ED1.5090506@alum.mit.edu> <49AC1E88.1010709@hvoigt.net> <49B4FCDA.4030106@hvoigt.net> <49B52F74.1090006@alum.mit.edu> <49C13062.4020400@hvoigt.net> <7vfxhag07g.fsf@gitster.siamese.dyndns.org> <49C22166.3000807@drmicha.warpmail.net> <49C47DF7.9000601@alum.mit.edu> <20090323181110.GB26678@macbook.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Junio C Hamano <gitster@pobox.com>,
	Heiko Voigt <git-list@hvoigt.net>, ydirson@altern.org,
	git@vger.kernel.org, CVSps@dm.cobite.com
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Tue Mar 24 05:52:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Llycq-00025h-90
	for gcvg-git-2@gmane.org; Tue, 24 Mar 2009 05:52:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750960AbZCXEuq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Mar 2009 00:50:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750806AbZCXEuq
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Mar 2009 00:50:46 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:45849 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750781AbZCXEup (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Mar 2009 00:50:45 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.69.129] (77-20-65-209-dynip.superkabel.de [77.20.65.209])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id n2O4o5Te007451
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 24 Mar 2009 05:50:06 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.21) Gecko/20090318 Thunderbird/2.0.0.21 Mnenhy/0.7.6.666
In-Reply-To: <20090323181110.GB26678@macbook.lan>
X-Enigmail-Version: 0.95.0
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114401>

Heiko Voigt wrote:
> I just started a very simple but hopefully effective testsuite to 
> collect all the issues we found with cvsps. [...]
> 
> Maybe Michael can add his tests as well. You should just need to 
> construct the expected cvsps output.

Please note that the cvsps output format itself is not rich enough to
represent all of the information needed, so it is not trivial to
construct the "expected" output.  The following is from an email that I
sent to the Mercurial mailing list [1]:

> I spent some time looking into cvsps, and I don't think that its
> output format, let alone the output itself, is suitable for
> industrial-strength conversion from CVS.  For example, as far as I
> can tell from my brief investigation:
> 
> * log messages are not unambiguously separable from the metadata
> 
> * it seems to only allow a single tag per changeset
> 
> * it seems to only apply tags to single changesets, whereas in CVS
>   files can be added to a tag at different times.
> ...
> 
> * it seems to completely ignore a branch tag if no commits were
>   ever made on that branch.
> 
> * it seems to ignore the effect that a second import to a vendor
>   branch has on the main branch.

You might also be interested to know that there has been some work in
the Mercurial project on a Python-based "cvsps".  I believe they use
their own version for their cvsimport extension.  I don't know how
different their cvsps is from the original.

Michael

[1] http://selenic.com/pipermail/mercurial-devel/2008-February/004975.html
