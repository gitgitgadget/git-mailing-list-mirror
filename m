From: Hannu Koivisto <azure@iki.fi>
Subject: Re: Errors when updating an old git.git repository
Date: Tue, 26 Dec 2006 21:22:19 +0200
Organization: NOYB
Message-ID: <87ac1awjh0.fsf@trews52.bothi.fi>
References: <87d566ww3r.fsf@trews52.bothi.fi> <8c5c35580612260737vae2669dkac6a81fe863484d4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue Dec 26 20:22:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GzHsq-0007tY-KO
	for gcvg-git@gmane.org; Tue, 26 Dec 2006 20:22:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932763AbWLZTWl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Dec 2006 14:22:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932765AbWLZTWl
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Dec 2006 14:22:41 -0500
Received: from main.gmane.org ([80.91.229.2]:34727 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932763AbWLZTWl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Dec 2006 14:22:41 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GzHsc-0004of-T0
	for git@vger.kernel.org; Tue, 26 Dec 2006 20:22:30 +0100
Received: from her-gw.ionific.com ([195.197.73.226])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 26 Dec 2006 20:22:30 +0100
Received: from azure by her-gw.ionific.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 26 Dec 2006 20:22:30 +0100
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: her-gw.ionific.com
User-Agent: Gnus/5.090014 (Oort Gnus v0.14) Emacs/22.0.50
 (i686-pc-linux-gnu)
Cancel-Lock: sha1:qcf/subVZ66/ETQHwajRGrzci8U=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35429>

"Lars Hjemli" <hjemli@gmail.com> writes:

> On 12/26/06, Hannu Koivisto <azure@iki.fi> wrote:

> I guess you have some branch references in the file
> .git/remotes/origin that shouldn't be there, so you can just remove
> the lines that mention  'jc/bind', 'jc/bind-2' and 'gb/diffdelta' from
> that file.

Thanks, but I don't need to fix the repository since a clean clone
works, I just wanted to report it so that git can be fixed, if
possible.

>> * refs/heads/pu: not updating to non-fast forward branch 'pu' of git://git.kernel.org/pub/scm/git/git
>>   old...new: 0c9951a...f959571
>
> The pu branch is rebased all the time so it needs a '+' in
> .git/remotes/origin to be automatically updated, like this:
>
> Pull: +pu:pu
>
> (or you can run 'git pull -f' to force the update)

I ran 'git pull -f' and it gave me this:

-------------------------------------------------------------------
remote: Generating pack...
remote: Done counting 293 objects.
remote: Result has 214 objects.
remote: Deltifying 214 objects.
remote:  100% (214/214) done
Unpacking 214 objects
remote: Total 214, written 214 (delta 156), reused 181 (delta 123)
 100% (214/214) done
error: no such remote ref refs/heads/jc/bind
error: no such remote ref refs/heads/jc/bind-2
error: no such remote ref refs/heads/gb/diffdelta
* refs/heads/pu: forcing update to non-fast forward branch 'pu' of git://git.kernel.org/pub/scm/git/git
  old...new: 0c9951a...f959571
* refs/heads/man: fast forward to branch 'man' of git://git.kernel.org/pub/scm/git/git
  old..new: 55beec2..da0e8b5
* refs/heads/todo: fast forward to branch 'todo' of git://git.kernel.org/pub/scm/git/git
  old..new: a94df75..32e72b6
* refs/heads/next: fast forward to branch 'next' of git://git.kernel.org/pub/scm/git/git
  old..new: 50dae10..9c0d79d
* refs/heads/html: fast forward to branch 'html' of git://git.kernel.org/pub/scm/git/git
  old..new: 30e1db1..d793de5
Fetch failure: git://git.kernel.org/pub/scm/git/git.git
Already up-to-date.
-------------------------------------------------------------------

Now further 'git pull's also display "Fetch failure:
git://git.kernel.org/pub/scm/git/git.git".  It no longer mentions
the 'pu' branch, though.

-- 
Hannu
