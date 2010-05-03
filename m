From: Gelonida <gelonida@gmail.com>
Subject: Re: how to squash a few commits in the past
Date: Mon, 03 May 2010 23:20:03 +0200
Message-ID: <hrnem4$1m0$1@dough.gmane.org>
References: <loom.20100503T112508-677@post.gmane.org> <4BDEA0D7.9090201@drmicha.warpmail.net> <hrncm3$pg8$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 03 23:20:32 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O933y-00055a-Am
	for gcvg-git-2@lo.gmane.org; Mon, 03 May 2010 23:20:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756195Ab0ECVUV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 May 2010 17:20:21 -0400
Received: from lo.gmane.org ([80.91.229.12]:47607 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755639Ab0ECVUU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 May 2010 17:20:20 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1O933k-0004xV-06
	for git@vger.kernel.org; Mon, 03 May 2010 23:20:12 +0200
Received: from unicorn.dungeon.de ([81.56.82.123])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 03 May 2010 23:20:11 +0200
Received: from gelonida by unicorn.dungeon.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 03 May 2010 23:20:11 +0200
X-Injected-Via-Gmane: http://gmane.org/
connect(): No such file or directory
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: unicorn.dungeon.de
User-Agent: Thunderbird 2.0.0.24 (X11/20100411)
In-Reply-To: <hrncm3$pg8$1@dough.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146261>

Hi Michael,

Gelonida wrote:
> Hi Michael,
> 
> Michael J Gruber wrote:
>> Gelonida venit, vidit, dixit 03.05.2010 11:33:
>>>
>>> The plan would be:
>>> - create a new git repository without the huge file
>>> - let everybody clone the new repository and continue working.
>>>
>>>
>>> I thought, that I could squash the commit adding the file, removing the file and
>>> the commits in between into one commit.
>> You don't need to squash the commits in between. Use git rebase -i A^ if
>> A is the commit introducing the large file. Then, either edit that first
>> commit (to not add the file) or reorder so that the removal commit is
>> squashed into A.
> 
> 
> I seem to misunderstand your suggestion.
> 
> git rebase -i 740ebdf9b^
> returns following output
>> fatal: Needed a single revision
>> Invalid base


Please ignore me previous reply.
It is very embarassing, but I tried it in the wrong window and therefore
wrong directory.


Now I'm back to other errors.
What I did was:

git rebase -i 740ebdf9^
# as a very first test I tried to modify nothing at all.
# So I just quit the editor window (with about 270 entries)
# where I could choose what to pick, squash or ignore


The result:
the counter counts to about 50 of my 270 commits and then
command aborts then

> Automatic cherry-pick failed.  After resolving the conflicts,
> mark the corrected paths with 'git add <paths>', and
> run 'git rebase --continue'
> Could not apply 67f3f6d... preparation for #241

I guess, that the problem might be. that the version tree looks roughly
like this:

# first line of tree
A-B-C-<forksoff>-D-E-F-G-<all_joined>-H-I-J-<forks_off>--K-


#tree continues after

K-L-<all_joined>-M-N


However, the commit, that I want to fix is commit I,

I think git gets lost somehow between J and L

Is it normal, that git gets lost wehn rebasing such a structure.
