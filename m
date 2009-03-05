From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: bisect run, was Re: More git bisect modes
Date: Thu, 5 Mar 2009 12:09:17 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0903051207480.6524@intel-tinevez-2-302>
References: <43d8ce650903050149u4ca98444w28efceb9084efa68@mail.gmail.com> <20090305190542.6117@nanako3.lavabit.com> <43d8ce650903050217m2885692dkcef08ab2a5f60082@mail.gmail.com> <7vvdqo1csl.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: John Tapsell <johnflux@gmail.com>,
	Nanako Shiraishi <nanako3@lavabit.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 05 12:11:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LfBTY-0002zG-Pg
	for gcvg-git-2@gmane.org; Thu, 05 Mar 2009 12:10:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752181AbZCELJW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Mar 2009 06:09:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751647AbZCELJV
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Mar 2009 06:09:21 -0500
Received: from mail.gmx.net ([213.165.64.20]:39317 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751240AbZCELJV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Mar 2009 06:09:21 -0500
Received: (qmail invoked by alias); 05 Mar 2009 11:09:18 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp061) with SMTP; 05 Mar 2009 12:09:18 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/+BSxg1ab+HUhNFFk2NrJo0cTZFn7tF7rZrcj8X5
	S03srFGHZ+a3h5
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <7vvdqo1csl.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.63
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112298>

Hi,

On Thu, 5 Mar 2009, Junio C Hamano wrote:

> [...] personally I never felt the need for "run" to work without any bad 
> one, as the first few rounds would almost always end up to be a 
> debugging session of the run script for me, as in:
> 
> 	... oh, somebody broke this somewhere ...
> 	... write a validate script ...
> 	$ edit runme ; chmod +x runme
>         $ ./runme
>         ... yeah, it is broken and runme script detects breakage
>         $ git checkout HEAD~200
>         $ ./runme
>         ... ok, it used to work here and runme exits Ok
>         $ git bisect good
>         $ git bisect bad @{-1}
>         $ ./runme
>         ... ok, runme script appears to be ok
>         $ git bisect run ./runme

That reminds me of a personal gripe with "bisect run": You cannot use it 
like this:

	$ git bisect run 'make test'

as it interprets 'make test' as a name of an executable.  That makes 
'bisect run' rather less useful to me.

Ciao,
Dscho
