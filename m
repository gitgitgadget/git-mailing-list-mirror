From: Hannu Koivisto <azure@iki.fi>
Subject: Re: Errors when updating an old git.git repository
Date: Wed, 27 Dec 2006 02:45:11 +0200
Organization: NOYB
Message-ID: <877iwew4iw.fsf@trews52.bothi.fi>
References: <87d566ww3r.fsf@trews52.bothi.fi> <8c5c35580612260737vae2669dkac6a81fe863484d4@mail.gmail.com>
 <87ac1awjh0.fsf@trews52.bothi.fi>
 <Pine.LNX.4.63.0612262350070.19693@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Dec 27 01:45:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GzMv9-0001Vl-A5
	for gcvg-git@gmane.org; Wed, 27 Dec 2006 01:45:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932866AbWL0ApY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Dec 2006 19:45:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932871AbWL0ApY
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Dec 2006 19:45:24 -0500
Received: from main.gmane.org ([80.91.229.2]:38360 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932866AbWL0ApX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Dec 2006 19:45:23 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GzMuz-0003U0-Ss
	for git@vger.kernel.org; Wed, 27 Dec 2006 01:45:17 +0100
Received: from her-gw.ionific.com ([195.197.73.226])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 27 Dec 2006 01:45:17 +0100
Received: from azure by her-gw.ionific.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 27 Dec 2006 01:45:17 +0100
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: her-gw.ionific.com
User-Agent: Gnus/5.090014 (Oort Gnus v0.14) Emacs/22.0.50
 (i686-pc-linux-gnu)
Cancel-Lock: sha1:gvlpBENeZUzdsvAvPfjeTFIEgLQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35440>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Tue, 26 Dec 2006, Hannu Koivisto wrote:
>
> Git works quite as expected here, so there is nothing to fix.

Since the documentation didn't seem to specify what happens when a
remote branch is deleted (I'm assuming that's the case), _I_ didn't
expect it.

>> error: no such remote ref refs/heads/jc/bind
>> error: no such remote ref refs/heads/jc/bind-2
>> error: no such remote ref refs/heads/gb/diffdelta
>
> Since you said it is an older git repository, I guess that in your 
> .git/remotes/origin are some lines like this:
>
> 	Pull: refs/heads/jc/bind:refs/heads/jc/bind
>
> So, you _asked_ git to fetch these three branches!

Well, that's true from a technical standpoint, but I didn't add
those lines to .git/remotes/origin, git did when I cloned the
repository.  When one updates tracking branches and a branch has
been deleted in the remote repository, I think it wouldn't be
insane to expect git also to remove the line (if not the actual
branch).  If that is not desired, I'd rather the message wasn't an
error but something along the lines of "note: remote branch jc/bind
no longer exists, please update .git/remotes/origin".  It's bit odd
to get errors in a situation that (given the assumption) isn't
erroneous.

-- 
Hannu
