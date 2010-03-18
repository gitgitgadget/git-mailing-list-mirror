From: Reece Dunn <msclrhd@googlemail.com>
Subject: Re: What's in a name? Let's use a (uuid,name,email) triplet
Date: Thu, 18 Mar 2010 22:06:28 +0000
Message-ID: <3f4fd2641003181506s7797f01eub2d74e6fd556c990@mail.gmail.com>
References: <alpine.LFD.2.00.1003181022040.18017@i5.linux-foundation.org>
	 <4ba2293f.c5c2f10a.5e9c.5c4a@mx.google.com>
	 <4ba27424.9804cc0a.4b1f.11b1@mx.google.com>
	 <20100318204416.GM8256@thunk.org>
	 <b4087cc51003181412s78d153c8t48984eb87eb75e0e@mail.gmail.com>
	 <46a038f91003181419n5d076bdbv18e32e292d7937a8@mail.gmail.com>
	 <b4087cc51003181429v2998b95ei3f08360e6d2a5aa7@mail.gmail.com>
	 <46a038f91003181439lc343dafl6b9321a0b620de84@mail.gmail.com>
	 <b4087cc51003181446r6bd89371q9f2e7a14bfa4d557@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Martin Langhoff <martin.langhoff@gmail.com>, tytso@mit.edu,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Nicolas Pitre <nico@fluxnic.net>,
	Wincent Colaiuta <win@wincent.com>, git@vger.kernel.org
To: Michael Witten <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 18 23:06:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NsNrR-0003IB-Fa
	for gcvg-git-2@lo.gmane.org; Thu, 18 Mar 2010 23:06:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752383Ab0CRWGb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Mar 2010 18:06:31 -0400
Received: from mail-ww0-f46.google.com ([74.125.82.46]:35612 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751790Ab0CRWGa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Mar 2010 18:06:30 -0400
Received: by wwe15 with SMTP id 15so1441913wwe.19
        for <git@vger.kernel.org>; Thu, 18 Mar 2010 15:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=UPfm8dNj/7ck7xp+VNL1NAUqF5vTp1lan/LvHiWO7dM=;
        b=DM7HMOFPF9aNZuDSUsquA/r0CLmTeHDP7AAAf8PdxKCjHMKwUP9Z9nMimAEDrUn9O3
         Gh/rj4jNP1r2XUctjhLq3abKl0dtWRYaB8mFgjM1twQa2omeUUj0sYIq6M+HDUXlduDw
         eDVOQhLKyyN1xKNLfS8mbUBQwaRH6JRfFFCqo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=v5lo9xc5e1HXNbpYhGr/aBpZCCdpnhu7ifDWZR865b2xt+9EpL9PQb8IS+gL4CVfuZ
         yvZ0EknSK7jBp4Fzqx/jUvJRjv1ULvEH3aacUP/9FUJvf8Wd+maN6uYLNPzFv4PpEQC8
         EslkdOeiRsoD2MORIzyxNucFgAOFs9hXeLVbU=
Received: by 10.216.89.130 with SMTP id c2mr1860669wef.44.1268949988697; Thu, 
	18 Mar 2010 15:06:28 -0700 (PDT)
In-Reply-To: <b4087cc51003181446r6bd89371q9f2e7a14bfa4d557@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142529>

On 18 March 2010 21:46, Michael Witten <mfwitten@gmail.com> wrote:
> On Thu, Mar 18, 2010 at 16:39, Martin Langhoff
> <martin.langhoff@gmail.com> wrote:
>>
>> Here's a hint: using your "uuid" model, I'll get some commits into a
>> project with the wrong uuid. Because I made a typo, or changed
>> machines (and a random uuid got created), whatever reason. So now in
>> my project I appear under 2 uuids.
>>
>> What should we do in that case? Use mailmap to map the stray uuid to
>> the "real" one?... Have we done a lot of work to get back to square 0?
>
> Again:
>
>>> At worst, things will be just like they have always been.
>>>
>>> Most likely, all that will happen is identification entropy won't
>>> increase nearly so rapidly and there might be other benefits
>>> such as shortlog speed improvements.

You have 3 pieces of information that can change by adding uuid instead of 2.

Are people going to remember that they need to set a uuid when
checking things into git? Different uuids? Forgetting the key string
to generate the hash for the uuid?

The uuid is another source of permutations that will see an increase
in identity triples. It is also another thing that needs to be stored
in a commit on disk and in memory, printed out in the shortlog and
checked by people.

Even if you generate a SHA-1 hash from a memorable bit of data, the
resulting hash is not readable. It is something that could cause
collisions with partial hashes in treeish queries (does 12ab34 refer
to a commit, or to a persons uuid?). It is also meaningless to the
user: I want to find Ted Ts'o's (I hope I've got the apostrophe in the
correct place) commits - how do I know what uuid refers to his
commits? How can I find it out?

It is just adding more resistance, whereas with a well-configured
.mailmap I could use one of his known email addresses, something that
is easy to find and remember.

>From what Linus and others have said, .mailmap is the way to fix name
and/or email changes. It may need more work to expose it to more
commands, but that is the simplest, cleanest and most elegant approach
to fixing the problem you specified.

What about .mailmap does not solve your problem? Is it that it does
not work for `git log`? If so, then write a patch to allow `git log`
to use that information when you specify a certain flag (or pretty
format string).

NOTE: It is not just the author/committer that needs to remember/use
the uuid - it is people doing analysis on commits, curious people,
automated scripts and many others.

- Reece
