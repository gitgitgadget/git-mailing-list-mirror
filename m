From: Pete Harlan <pgit@pcharlan.com>
Subject: Re: Consistent terminology: cached/staged/index
Date: Tue, 15 Feb 2011 00:29:24 -0800
Message-ID: <4D5A3964.9090209@pcharlan.com>
References: <AANLkTi=9OWqz66Ab6O9tc4eYSrhZZ1YC_+ta9sutAn30@mail.gmail.com> <20110213193738.GA26868@elie> <7v8vxjwnhj.fsf@alter.siamese.dyndns.org> <AANLkTim4UKxYwRagCk3R20e7wsRb7CxvS_ze9b8MfWjL@mail.gmail.com> <20110214231920.GA24814@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Piotr Krukowiecki <piotr.krukowiecki.news@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 15 09:29:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PpGHs-0004WX-3r
	for gcvg-git-2@lo.gmane.org; Tue, 15 Feb 2011 09:29:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754482Ab1BOI32 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Feb 2011 03:29:28 -0500
Received: from caibbdcaaaaf.dreamhost.com ([208.113.200.5]:44561 "EHLO
	homiemail-a58.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754469Ab1BOI30 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Feb 2011 03:29:26 -0500
X-Greylist: delayed 105605 seconds by postgrey-1.27 at vger.kernel.org; Tue, 15 Feb 2011 03:29:26 EST
Received: from homiemail-a58.g.dreamhost.com (localhost [127.0.0.1])
	by homiemail-a58.g.dreamhost.com (Postfix) with ESMTP id 6C7E27D8063;
	Tue, 15 Feb 2011 00:29:25 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pcharlan.com; h=message-id:date
	:from:mime-version:to:cc:subject:references:in-reply-to
	:content-type:content-transfer-encoding; q=dns; s=pcharlan.com;
	 b=IxmLkjXJrNWCiwahk59Ufyk3h2L7CipVt9NYU5DM5hLtvdxQNCAw8OCsg+KzP
	2L+b8tTGPjY20Opy/eaTqbbhi4cklbPQBWKwfTRLJJthlhC0RMAR46yqUsFkyhQe
	ZLPx8S8zVv3zKJn4qvdb9erQbdYfFvXEc5D/2VAG3NaKec=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pcharlan.com; h=message-id
	:date:from:mime-version:to:cc:subject:references:in-reply-to
	:content-type:content-transfer-encoding; s=pcharlan.com; bh=6K19
	enWtUFg3PMNbkZU5Q1p5Prw=; b=tLFWDFb0lfOVVVL1IMZt8amK7s9dPXsrI9CV
	8eddjpRJD9N6vhxcf9oFeQe9TISYDzFtg3c0LVux9tq7ym5WRmygjvQCGO7hcjyh
	GfBIm9XkBniqiHWnBqrX391wzSnObhqTKfxXuZC4pKxYl8aeWZRwvaYkPbqIC7hJ
	rq3fI9Y=
Received: from [192.168.0.101] (185.132-78-65.ftth.swbr.surewest.net [65.78.132.185])
	(Authenticated sender: pete@tento.net)
	by homiemail-a58.g.dreamhost.com (Postfix) with ESMTPA id 36A357D8057;
	Tue, 15 Feb 2011 00:29:25 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.13) Gecko/20101208 Thunderbird/3.1.7
In-Reply-To: <20110214231920.GA24814@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166824>

On 02/14/2011 03:19 PM, Jonathan Nieder wrote:
> Hi again,
> 
> Piotr Krukowiecki wrote:
> 
>> In other places "index" is called "staging area" and act of updating the index
>> is called "staging in the index".
>>
>> I ask: why do we need the "index" term at all?
>>
>>    - instead of "index" use "staging" and "staging area"
>>    - instead of "listed in index" use "staged" or "tracked"
> 
> Unlike "staging area", the word "index" is unfamiliar and opaque.  So
> there is a sense that there is something to learn.
>
> When people talk about the staging area I tend to get confused.  I
> think there's an idea that because it sounds more concrete, there is
> less to explain --- or maybe I am just wired the wrong way.
> 
> There is a .git/index file, with a well defined file format.  And
> there is an in-core copy of the index, too.  It contains:
> 
>  - mode and blob name for paths as requested by the user with
>    "git add"
> 
>  - competing versions for paths whose proposed content is
>    uncertain during a merge
> 
>  - stat(2) information to speed up comparison with the worktree
> 
> There are some other pieces, too --- "intent-to-add" entries added
> with "git add -N", cached tree names for unmodified subtrees to
> speed up "git commit", and so on.  But the 3 pieces listed above are
> the main thing.

Thank you for that explanation.

> "Staging area" only describes the first.

...which to me means only that "staging area" isn't enough to fully
describe what Git can do.

>From the user's perspective, merge conflict resolution is a separate
process from staging a commit; where does Git's usability benefit from
blending the two concepts by referring (in command syntax and
manpages) to their common internal data structure?

One of Git's charms is the simplicity of blobs, trees, commits and
tags and how those ingredients prove tremendously useful in developing
software.  And I don't think anyone can use Git well without fully
understanding what those structures are (and are not).

But I believe the rest of Git's internals are in a different category.
Regardless of how elegant the solution may be, as a user I can use Git
well without knowing _how_ Git can tell that foo.c contains staged and
unstaged changes.  Nor do I need to know how it knows that bar.c is in
conflict.  I don't need to know precisely how it implements its packed
object database to use it effectively.

Part of the issue could be that one intimately familiar with Git's
internals may find a process oriented interface irritating ("Why must
it say 'staging area' when it's just updating the index?"), while one
unfamiliar with the internals has the opposite reaction ("Why must it
make me use the internal name of the staging area?").

Someone suggested using a different top-level name for Git to allow
for completely rewriting the interface.  I expect that it's this
difference of perspective that makes that appear necessary.  I believe
that a rewrite is the wrong approach, but I believe that abstractions
like "staging area" move the user-interface a little more toward the
user and that there's value in that.

--Pete

> All that said, I am not against formulations like "content of the next
> commit" that might be more concrete from a user's point of view.
> 
> [...]
>>  --refresh::
>>  	Don't add the file(s), but only refresh their stat()
>> -	information in the index.
>> +	information in the staging area.
> 
> git add/update-index --refresh are precisely meant for _not_ changing
> the content of the next commit, so this particular change seems
> confusing.
> 
> Hoping that is clearer.  Thanks for caring.
> Jonathan
