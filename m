From: Andreas Ericsson <ae@op5.se>
Subject: Re: files missing after converting a cvs repository to git
Date: Tue, 07 Oct 2008 08:08:47 +0200
Message-ID: <48EAFCEF.8030907@op5.se>
References: <799406d60810061502y417ec53o1a1f5cef800dfe45@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: =?UTF-8?B?R0lU77u/77u/77u/77u/?= <git@vger.kernel.org>
To: Adam Mercer <ramercer@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 07 08:10:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kn5lo-0007xC-UD
	for gcvg-git-2@gmane.org; Tue, 07 Oct 2008 08:10:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751164AbYJGGI4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Oct 2008 02:08:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751294AbYJGGI4
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Oct 2008 02:08:56 -0400
Received: from mail.op5.se ([193.201.96.20]:49179 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750914AbYJGGIz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Oct 2008 02:08:55 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 7629C1B8006C;
	Tue,  7 Oct 2008 08:00:55 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.77
X-Spam-Level: 
X-Spam-Status: No, score=-2.77 tagged_above=-10 required=6.6
	tests=[AWL=-0.271, BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mK1PB5JFZUWs; Tue,  7 Oct 2008 08:00:50 +0200 (CEST)
Received: from clix.int.op5.se (unknown [172.27.78.6])
	by mail.op5.se (Postfix) with ESMTP id 42C5E1B80061;
	Tue,  7 Oct 2008 08:00:50 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
In-Reply-To: <799406d60810061502y417ec53o1a1f5cef800dfe45@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97669>

Adam Mercer wrote:
> Hi
> 
> One of the prrojects I am involved with is currently looking into
> migrating from cvs to git, therefore we have been investigating this
> by setting up a git repository that tracks cvs, however there are some
> very strange things going on and I was hoping someone could offer some
> insight into what is going on.
> 
> I use the following git cvsimport command to import the repository:
> 
> $ git cvsimport -v -a -i -k
> -d:pserver:user@server:port/path/to/cvs/repo -C /path/to/new/git/repo
> module
> 
> this ran successfully with no warnings or errors. However, when I
> checkout the new git repository that are several files missing from
> the git checkout that are present in the cvs checkout.
> 
> Does anyone know why this would happen, or how to find out?

Has the CVS repo been tampered with in the past? If so, it's entirely
possible that checking out and working with CVS works just fine, but
getting history into coherent changesets is impossible.

Can you checkout the offending (old) revisions using CVS? If so, there
is indeed a bug in the cvs-importer. Otherwise, your CVS repo is hosed
and you're reduced to running whatever conversion tool does the best
job if you want to maintain history.

cvs2svn is apparently quite good at getting even the weirdest history
right. Perhaps you can try that and then running "git svn" on the
resulting svn repo?

Good luck. You'll probably need it :-/

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
