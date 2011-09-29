From: Michael Witten <mfwitten@gmail.com>
Subject: Re: [PATCH v3] Docs: git checkout --orphan: `root commit' and
                                                     `branch head'
Date: Thu, 29 Sep 2011 15:52:42 -0000
Message-ID: <271cc2ed03774b4988bb61cb3e79750e-mfwitten@gmail.com>
References: <1316960136073-6829212.post@n2.nabble.com>
            <1316961212.4388.5.camel@centaur.lab.cmartin.tk>
            <7vaa9r2jii.fsf@alter.siamese.dyndns.org>
            <1317073309.5579.9.camel@centaur.lab.cmartin.tk>
            <vpq39fi9gf5.fsf@bauges.imag.fr>
            <69d6fb3199bc4f74b25dae7992a9f132-mfwitten@gmail.com>
            <vpqsjni6kkk.fsf@bauges.imag.fr>
            <553B5FA1A43748B1ADD759572EADA6FF@PhilipOakley>
            <e4f46b39e9ed4203bfab8a81e25eb600-mfwitten@gmail.com>
            <7vaa9oz9rl.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Cc: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>,
	vra5107 <venkatram.akkineni@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Eric Raible <raible@nextest.com>,
	Philip Oakley <philipoakley@iee.org>,
	Jeff King <peff@peff.net>, Jay Soffian <jaysoffian@gmail.com>,
	<git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 29 18:40:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R9JfE-0004wh-Ro
	for gcvg-git-2@lo.gmane.org; Thu, 29 Sep 2011 18:40:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757236Ab1I2Qke (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Sep 2011 12:40:34 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:50930 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757049Ab1I2Qkb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Sep 2011 12:40:31 -0400
Received: by gyg10 with SMTP id 10so695361gyg.19
        for <git@vger.kernel.org>; Thu, 29 Sep 2011 09:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=subject:date:from:to:cc:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=C4/I8QoKvwwmeH8qYttOTWB7AYut6HVULIpNylkfV9s=;
        b=aQ6nGFhudpc/s6QNDgnOumb7HYaH1CZZFw5uqZDT7RFfLMdWTUgZ5bJs0BXGjx8uyj
         yaWMXHgcAV7qyV2e9uCgLiSPykblYymnmWqK8C+eUFdU5Gfn3b2nuE8CU/WT4S/F4UlQ
         uz17zZN3OIHxz6ZGMDL+IHMzanh+rYndVxJcE=
Received: by 10.68.15.71 with SMTP id v7mr53587312pbc.11.1317314430678;
        Thu, 29 Sep 2011 09:40:30 -0700 (PDT)
Received: from gmail.com (tor-exit-router39-readme.formlessnetworking.net. [199.48.147.39])
        by mx.google.com with ESMTPS id z1sm8157763pbl.5.2011.09.29.09.40.27
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 29 Sep 2011 09:40:29 -0700 (PDT)
In-Reply-To: <7vaa9oz9rl.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182409>

On Wed, 28 Sep 2011 13:34:22 -0700, Junio C Hamano wrote:

> As to what the updated text wants to talk about, I think most of them are
> improvement, but there are a few glitches and nits.
>
>> ...
>>
>> +--orphan::
>> +	Tell git to turn the next commit you create into a root commit
>> +	(that is, a commit without any parent); creating the next commit
>> +	is similar to creating the first commit after running "git{nbsp}init",
>
> I do not think we ever used {nbsp} in our documentation set. Is it
> absolutely necessary to use it in this context, and are you absolutely
> sure this does not break various versions of documentation toolchain
> people have?

I think it's absolutely necessary, but I'm not sure about how fragile
asciidoc is across versions with regard to this... I guess I'll remove
them.

>> +	except that the new commit will be referenced by the branch head
>> +	<new_branch> rather than "master".
>
> The option works as a substitute for -B/-b in the sense that it takes a
> name of the new branch, and the only difference is that the new branch
> will start with no commit (yet).  To reduce confusion, it might make sense
> to update this part (and description of -b/-B) to begin like this:
>
> 	--orphan <new_branch>::
>
> to match the new explanation text, and the output from "git checkout -h".
> By the way, shouldn't the entry for -b in "git checkout -h" output also
> say <new branch>?

I took the "<new_branch>" from the synopsis:

  SYNOPSIS
  --------
  [verse]
  'git checkout' [-q] [-f] [-m] [<branch>]
  'git checkout' [-q] [-f] [-m] [--detach] [<commit>]
  'git checkout' [-q] [-f] [-m] [[-b|-B|--orphan] <new_branch>] [<start_point>]
  'git checkout' [-f|--ours|--theirs|-m|--conflict=<style>] [<tree-ish>] [--] <paths>...
  'git checkout' [-p|--patch] [<tree-ish>] [--] [<paths>...]

It would seem strange to include "<new_branch>" but not "<start_point>"
in each of the individual option descriptions.

In any case, I think we should leave that for another patch.

Moreover, I think it would be better to remove all `-h' output from
all git commands; they are always incomplete and/or different. Indeed,
at this point in history, programmers absolutely stink at writing
documentation, so it's probably a good idea just to centralize all
information as much as possible. Of course, I realize this suggestion
will never fly.

> Micronit: "referenced by the branch head <new_branch>" might be easier to
> read and understand with s/branch head/branch name/. Or perhaps
>
> 	except that the new commit will be made on <new_branch> branch
>         rather than "master".
>
> might be even better.

I have qualms with git's terminology, and using "branch head" as I have is
not only the closest thing to what I like, but it is also the only language
that is actually in complete agreement with git's own terminolgy as currently
defined by "git help glossary".

In the glossary, the term "branch name" only occurs once as part of:

  branch named "master"

which is undefined.

However, how skirting the whole issue:

  except that the new commit will be referenced by <new_branch>
  rather than "master".

>> +Furthermore, the working tree and index are adjusted as if you ran
>> +"git{nbsp}checkout{nbsp}<start_point>"; thus, by just running
>> +"git{nbsp}commit", you can create a root commit with a tree that is
>> +exactly the same as the tree of <start_point>.
>> ++
>> +Naturally, before creating the commit, you may manipulate the index
>> +in any way you want. ...
>
> What value does "Naturally, " add to the understanding here? I would
> understand if it were "Alternatively, ", though.

"Naturally" reassures the reader that nothing really special is happening
in terms of how the next commit can be made; there are no special cases.

"Alternatively" is too strong; these 2 paragraphs are not mutually
exclusive: The bit about running just "git commit" is only a
clarification of the preceding sentence.

Nevertheless, I have rearranged the text to use "Alternatively" in 
[PATCH v4]:

  Message-ID: <3cba6bb85bde4f96903b2b617190a2b8-mfwitten@gmail.com>
  Subject: [PATCH v4] Docs: git checkout --orphan: Copyedit,
			    and s/root commit/orphan branch/

It should be a reply to this email.

>> +... For example, if you want to create a root commit
>> +with a tree that is totally different from the tree of <start_point>,
>> +then just clear the working tree and index first: From the top level
>> +of the working tree, run "git{nbsp}rm{nbsp}-rf{nbsp}.", and then
>> +prepare your new working tree and index as desired.
>> ++
>> +There are two common uses for this option:
>> ++
>> +--
>> +	Separate history::
>> +		Suppose that for convenience, you want to maintain
>> +		the website for your project in the same repository
>> +		as the project itself. In such a case, it may not
>> +		make much sense to interleave the history of the
>> +		website with the history of the project; you can use
>> +		the "--orphan" option in order to create these two
>> +		completely separate histories.
>
> I suspect this is *not* common at all, and also because you would need a
> working tree to update both lines of histories that are not related to
> each other at all at the content level, I do not believe that "for
> convenience" supports or justifies the use case at all. It would be less
> convenient to update these two unrelated histories (switching between
> branches would need to nuke the whole working tree, and the semantics to
> carry local changes floating on top of the tip commit of the current
> branch across branch switching actively works against you).
>
> You would be better off using another repository to keep track of "the
> website for your project".
>
> In short, I do not think we would want to list the above as if we are
> somehow encouraging the use of this option for such a use. It falls into
> "because with --orphan you _could_", and definitely not "because having
> these two unrelated projects in the same repository you work in is
> convenient and/or necessary".

I was thinking of something like git's repo's "man", "html", and "todo",
but I was trying to express that along the lines of a more widely
recognizable scenario.

See [PATCH v4] for a more generic version.

>> +	Hidden history::
>> +		Suppose you have a project that has proprietary
>> +		material that is never meant to be released to the
>> +		public, yet you now want to maintain an open source
>> +		history that may be published widely.
>
> This cause does make sense; you would want the local changes floating on
> top of the tip commit of the current branch carried across branch
> switching.
>
>> +In this case, it would not be enough just to remove the proprietary
>> +material from the working tree and then create a new commit, because
>> +the proprietary material would still be accessible through the new
>> +commit's ancestry; the proprietary history must be hidden from the new
>> +commit, and the "--orphan" option allows you to do so by ensuring that
>> +the new commit has no parent.
>
> Does this "In this case" paragraph format as part of the "Hidden history"
> paragraph?

Yes. Have you no faith in me?

>> +However, removing proprietary material from ancestry is usually a task
>> +that is better performed by linkgit:git-filter-branch[1] and
>> +linkgit:git-rebase[1], especially when there are multiple commits that
>> +are already suitable for the open source history.
>> +--
>
> In general it is true, and not "especially".
> ...
> I suspect this is not exactly "filter-branch is better but you could use
> checkout --orphan" like you made it sound in the above paragraph.  If you
> are bootstrapping a new open source project from the tip of a proprietary
> tree, "checkout --orphan && edit to sanitize && commit" to start your
> history afresh would be perfectly adequate for your PR people to say "Now
> we are open", especially when you do not intend to accept fixes to older
> revisions; you could filter-branch the older proprietary history but you
> would not get much benefit out of the cost for doing so, I think.

I don't really see how what I wrote is fundamentally different. However,
I've rearranged it in [PATCH v4].

>> See:
>>
>>   Re: Can a git changeset be created with no parent
>>   Carlos Mart=C3=ADn Nieto <cmn@elego.de>
>>   Message-ID: <1317073309.5579.9.camel@centaur.lab.cmartin.tk>
>>   http://article.gmane.org/gmane.comp.version-control.git/182170
>>
>> and:
>>
>>   git help glossary
>
> I think I had to tell somebody on this list not to do this no more than a
> month ago.

What's your point?

> It is a good practice to point to earlier discussions while polishing
> patch, and it also is good to include pointers in the commit log message
> as a _supporting material_ (additional reading), but that is *NOT* a
> substitute for a properly written commit log message. You need to state
> what problem you are trying to fix and how the proposed patch fixes it.

That's a good rule of thumb. Although, interestingly, one my last code
patches for git was accompanied by a very detailed, precisely formulated
description of the problem and the solution, and yet it was dumbed down
behind my back.

In this case, though, I think the message title gives enough information,
particularly when combined with the diff: It's a commit that alters the
documentation for "git checkout --orphan", and somehow involves the terms
"root commit" and "branch head" (though no longer in [PATCH v4]); the rest
of the log message is just meant to be cake icing for the interested.

It's copyediting; it's best just to read the damn patch, particularly when
there are no subtle details to be considered beyond the exhausting game of
making everybody involved in the email thread feel like he or she has gotten
a portion of the bikeshed painted a certain color.

Hmmm... You know what? I think I'll make that last paragraph the message.

Sincerely,
Michael Witten
