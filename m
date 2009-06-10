From: Scott Chacon <schacon@gmail.com>
Subject: Re: EasyGit Integration
Date: Wed, 10 Jun 2009 16:57:03 -0700
Message-ID: <d411cc4a0906101657v601aba20q5708e114fc7d4bca@mail.gmail.com>
References: <d411cc4a0906091159r51e7d16t4d66c6225322fb60@mail.gmail.com>
	 <alpine.LFD.2.01.0906091512350.6847@localhost.localdomain>
	 <51419b2c0906091530t3dfa5267s2262f979f1e9982a@mail.gmail.com>
	 <alpine.LFD.2.01.0906091535410.6847@localhost.localdomain>
	 <20090610033211.GA7411@mit.edu>
	 <alpine.LFD.2.01.0906092058430.6847@localhost.localdomain>
	 <94a0d4530906101531ja6f1deeob703f546d62e7599@mail.gmail.com>
	 <alpine.LFD.2.01.0906101555590.6847@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Theodore Tso <tytso@mit.edu>, Elijah Newren <newren@gmail.com>,
	git list <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Jun 11 01:57:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MEXfN-0008AP-Sz
	for gcvg-git-2@gmane.org; Thu, 11 Jun 2009 01:57:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755792AbZFJX5E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Jun 2009 19:57:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753845AbZFJX5D
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Jun 2009 19:57:03 -0400
Received: from an-out-0708.google.com ([209.85.132.249]:50326 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753422AbZFJX5B (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jun 2009 19:57:01 -0400
Received: by an-out-0708.google.com with SMTP id d40so1966038and.1
        for <git@vger.kernel.org>; Wed, 10 Jun 2009 16:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=PuEGRhL62/lZTqqYJFpcuN3Js37Fq3D6RLQgfbH7Q4g=;
        b=YUlxnYqnEQ1FlfDkVq1dTXIeVItIg4AoapqEKWVeDBMceOk8rArtBRfhesMxF/Wc7L
         Rp37hK0RbEzxWIrOyYMbFUm6pTVVFSLX6+/IxH6BSRWq2IPqMAcQ+vmRWSpjPSYII/8l
         0H/8fKvhv1WiuKwWbQjrI3dXCSSwZYPvRPaNY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=VPVmv3w7qOBqACxq+sutPwAJYrXrYJnoC3TaJS6HcafrlCKOteo0v0BZIuFajnB2oZ
         45kkM4+t3MMQrYwyUjkak2y300RqJKlX/pDupXCD1X6nb7e1NepysQHRdUclV4Dtxq8x
         39frBdGy+md6S6IadXAv6D26+59R19MpnwsVc=
Received: by 10.100.128.18 with SMTP id a18mr2130876and.12.1244678223509; Wed, 
	10 Jun 2009 16:57:03 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.01.0906101555590.6847@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121317>

Hey,

On Wed, Jun 10, 2009 at 4:04 PM, Linus
Torvalds<torvalds@linux-foundation.org> wrote:
>
> IOW, both would be "if you give it a commit, it acts at a commit level",
> and "if you give it pathnames, it acts on a pathname level".
>
> That is totally obvious, and not in the least confusing. They are two
> different things, but at the same time, there is no question about which
> is which.
>
>> In my mind these are 2 completely different commands.
>
> They are two different things, but they both make sense within the
> _context_.
>
> Only earthworms and FOX news have no concept of "in context". So it does
> make sense to say "git checkout filename" (and expect it to check out that
> _filename_ - surprise surprise), and also say "git checkout branch" (and
> expect it to check out that branch - again, big surprise).

The problem here is that you're using 'check out' in your descriptions
of the expectations to mean two different things.  One means 'switch
branches' and the other means 'extract content'.  If you provide both
a branch and a filename, what happens? It still means 'extract
content'.  Not everyone assumes that 'checkout' can or should mean
both of these things depending on context.  I mean honestly, the
'context' of 'git checkout branch' and 'git checkout branch file'
doesn't really look that much different, but the command completely
switches semantics from 'switch active branch' to 'extract content'.
It's not that the command assumes some subtle defaults depending on
what arguments you give it - it's that it completely changes the
nature of what it does depending on the arguments.  It only makes
sense to us because we specifically learned that it did this, not
because it makes sense intuitively.  Hell, _neither_ of these meanings
are what SVN-inbound users are used to, which they map to 'extract
content _from a remote server_'.

>
> Humans are generally _very_ good at seeing the same word in two different
> contexts, and not being confused at all. There is no confusion when I talk
> about SCM's in the context of git, even though "SCM" could also mean a
> Sceme interpreter, or "Saskatchewan College of Midwives".
>
> In fact, it is often *much* better to accept context-awareness, than to
> try too hard to be "uniquely identifying" even without context.

This may be generally true for conversational language, but that
doesn't really cleanly apply here.  If your vocabulary is only like 15
words (common porcelain commands), why would one of them be ambiguous
outside of context?  Even given proper context, we're still being
arbitrary about how that command is interpreted - what if they wanted
to 'extract content' of all the files from another branch?  Having
learned that 'git checkout <file>' extracts content of that file and
'git checkout <branch> <file>' extracts the contents of that file from
that branch, why wouldn't one assume that 'git checkout <branch>'
extracts the content of all the files in that branch?  Wouldn't that
make more sense than arbitrarily doing something completely unrelated
('switching active branch')?

I'm not just arguing for arguments sake - I'm relaying from
individuals I'm trying to teach this to that they find it confusing.
This is not a theoretical argument, it is real world user feedback. I
probably struggled with things like this a bit at first and then
learned the idiosyncrasies of the tool and just accepted it like most
of the rest of us have - but many people honestly get confused and
frustrated by it. I see many of us helping people on IRC and whatnot
with this type of thing all the time.

I understand that clarity and ease of use is not really of primary
importance to this project.  However, is it not slightly ironic that
the Git project is so obsessed with squeezing 5% or 10% of raw speed
out of each command, yet feels that the onus should be on each user to
study for hours to memorize a bunch of arbitrary idiosyncrasies of the
tool?  Can we not obsess a little about flattening the learning curve
10% as well (possibly at the slight expense of command normalization
or verb bloat)?

Scott
