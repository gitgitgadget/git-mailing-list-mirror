From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC/PATCH 2/4] Add git-sequencer prototype documentation
Date: Tue, 1 Jul 2008 20:04:10 +0200
Message-ID: <200807012004.11563.jnareb@gmail.com>
References: <1214879914-17866-1-git-send-email-s-beyer@gmx.net> <m34p79hhy9.fsf@localhost.localdomain> <20080701160322.GC5301@leksak.fem-net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Tue Jul 01 20:01:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDkAg-0000vi-Rb
	for gcvg-git-2@gmane.org; Tue, 01 Jul 2008 20:01:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752271AbYGASA3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jul 2008 14:00:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751279AbYGASA3
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Jul 2008 14:00:29 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:38030 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752765AbYGASA1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jul 2008 14:00:27 -0400
Received: by nf-out-0910.google.com with SMTP id d3so316nfc.21
        for <git@vger.kernel.org>; Tue, 01 Jul 2008 11:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=9J+Qg0ODCaemvQCygCawJZCJ6a8tO05mmqLjU4NY4n0=;
        b=IReI+d3Ajkd2q6AWfAIuQEP1xh46+Lw4P4a/SCK5DyviZUiQIg5NtWJSLZQIy27CJB
         cbDiDlXpUYctglB1cNhgohOqbBL7GG3ZegcaUk5GZl/o6yhzT2LziPoTG5S2Y4pQeQwk
         iC3w+M6U+7tMiYbeSDZKPih3nLByxEAjOQIHg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=kqBzipqF+VhUZvtqmUoSajEvh/vp/DGPpGu7kVIIbdhENmgpvTZ6CJOaGCq//wPj6f
         mys4G9jqn0N52SLZeK6NaLgT+ehSLMbkgxyuu/HR2Z8MV6drkAvnR1bRPyzyRA8JFtmZ
         x5wUzsbNRrlFv/50wcZf3t+mIptYp3Ut2PV9U=
Received: by 10.210.87.14 with SMTP id k14mr5646201ebb.60.1214935225879;
        Tue, 01 Jul 2008 11:00:25 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.248.226])
        by mx.google.com with ESMTPS id c24sm8883567ika.4.2008.07.01.11.00.22
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 01 Jul 2008 11:00:24 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20080701160322.GC5301@leksak.fem-net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87058>

Hi,

On Tue, 1 Jul 2008, Stephan Beyer wrote:
> On Tue, Jul 01, 2008 at 06:02:54AM -0700,
> Jakub Narebski <jnareb@gmail.com> wrote:
>> Stephan Beyer wrote:
>>>
>>> +git-sequencer will usually be called by another git porcelain, like
>>> +linkgit:git-am[1] or linkgit:git-rebase[1].
>> 
>> I hope that it could be also used by git-cherry-pick and git-revert,
>> so it would be possible to pick more than one commit...
> 
> Right, you've already mentioned it several times. ;-)

:blush: I'm sorry about that...

> But I haven't included it currently, because git-sequencer currently *uses*
> cherry-pick/revert to pick/revert commits, and I think this can lead to
> some confusion.
[...]
> So I'm only concentrating on rebase and am users until the builtin sequencer
> is in good shape.

Ah, I understand.  It _is_ quite reasonable.

>>> +merge [options] <commit-ish1> <commit-ish2> ... <commit-ishN>::
>>> +	Merge commits into HEAD.
>> 
>> Nice.
>> 
>> "HEAD" mean last picked up / created commit, isn't it?
> 
> Right. This is used throughout the document...
> I thought it is clear and better to use than always describing around it
> by "last created commit".

O.K.

>>> +ref <ref>::
>>> +	Set ref `<ref>` to the current HEAD, see also
>>> +	linkgit:git-update-ref[1].
>> 
>> So this functions like "git reset --soft <ref>", isn't it?
> 
> No. Why do you think that? `ref` is set, and not HEAD.
> I think the description makes that clear.

Ah.  I'm sorry.  So it is like "git branch <ref>", isn't it?

What is important is: does it update reflog (correctly)?
 
>>> +squash [options] --from <mark>::
>>> +	Squash all commits from the given mark into one commit.
>>> +	There must not be any `merge` instructions between the
>>> +	`mark` instruction and this `squash --from` instruction.
>> 
>> Can you use <commit> instead of <mark> here?
> 
> I wanted to make it clear that you can only specify a mark:
> a commit that has been somehow used in this sequencer session.
> 
> Or have you meant that you think it is a bad restriction to only
> allow marks and no commits?
> I think this is a useful thing, because it's user-safe and I
> cannot imagine a case where you want to give a sha1 or a
> tag or branch or something.
> 
> Here an example why it is useful for user-editing:
> 
> (on commit f00babe)
> 	mark :1
> 	pick badcebab
> 	patch foo
> 	pick dadadada
> 	squash -m "Foo the cebab" --signoff --from :1
> 
> This squashes all between the mark and the squash into one commit,
> on top of f00babe.
 
Ah, so squash --from <mark> picks up everything since "mark <mark>",
but does not include marked commit!  Clever!  In this case allowing
only <mark> is a good idea, IMVHO.
 
>>> +	--include-merges;;
>>> +		Sanity check does not fail if you have merges
>>> +		between HEAD and <mark>.
>> 
>> How do you squash merges?  Creating merge with an union of parents,
>> excluding commits which got squashed?
> 
> My squashes are realized using git reset --soft ... and then commit.
> I think this makes only sense when there are no merges in between,
> so I added the check, but if someone wants to squash merges, he should
> be able to do it.
>
> To somehow answer your question: I do not care what the result is,
> because I do not know what the result "should be".

O.K.  I guess that is something left for later, especially that
forbidding merges in squashed commit is default (and you can always
do without merges, I think).

>>> +RETURN VALUES
>>> +-------------
>>> +* any other value on error, e.g.
>>> +  running git-sequencer on a bare repository.
>> 
>> Don't you enumerate those return values?
> 
> In one of the very first spec versions, it was value 1, but:
[...]
> 	$ grep -m 1 -A 4 die_builtin usage.c
> 	static NORETURN void die_builtin(const char *err, va_list params)
> 	{
> 		report("fatal: ", err, params);
> 		exit(128);
> 	}

Perhaps stating that it returns 128 on fatal error, or rewording
that any other return value means some fatal error (does it?)
would be better.  But that are details...

-- 
Jakub Narebski
Poland
