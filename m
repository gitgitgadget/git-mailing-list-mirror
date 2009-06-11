From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: EasyGit Integration
Date: Thu, 11 Jun 2009 03:18:47 +0300
Message-ID: <94a0d4530906101718r4bd6b127y40e6e524afc5f38f@mail.gmail.com>
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
Cc: Theodore Tso <tytso@mit.edu>, Elijah Newren <newren@gmail.com>,
	Scott Chacon <schacon@gmail.com>,
	git list <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Jun 11 02:18:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MEY0O-0007Pf-Mr
	for gcvg-git-2@gmane.org; Thu, 11 Jun 2009 02:18:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759019AbZFKASr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Jun 2009 20:18:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758861AbZFKASq
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Jun 2009 20:18:46 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:12961 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758653AbZFKASq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jun 2009 20:18:46 -0400
Received: by fg-out-1718.google.com with SMTP id 16so358641fgg.17
        for <git@vger.kernel.org>; Wed, 10 Jun 2009 17:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=0OCChMbuBJMy4/f+hWvw1RsnwjBCofEuMR7zKAGDUdQ=;
        b=XOyI5h6B92bN3jiqewyPqbJPzCPdKrAisidGNHtinjCRB6nInEV+7AWyNabRix7ltC
         4ba4Kqn6ZLxc4wUsFo31/DEvP89dMjNGe4vMPzb9ZByYflDO/BEqkx/aPNXSisFlkmX/
         8PCUkdm9fQTox9sZQqZie/KisKDPSiB2hgGVQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=tOLqYZGtpwAuFXv0/ukkhgJX+ivF9w5qf23v7Gf/rCJFDLrDGLEZ8HnorS2Rcfd0u3
         /klmnI5ZxAPguyc68nlC+HkXU2dsvEpYJwfgwtPMbAkEXee2Of7GNC4fx2DdVfsb2Pbf
         482RaNXJGy5lKkssnDlNWSIRk3PqV2WKnES/A=
Received: by 10.86.23.20 with SMTP id 20mr1667332fgw.17.1244679527420; Wed, 10 
	Jun 2009 17:18:47 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.01.0906101555590.6847@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121320>

On Thu, Jun 11, 2009 at 2:04 AM, Linus
Torvalds<torvalds@linux-foundation.org> wrote:
>
>
> On Thu, 11 Jun 2009, Felipe Contreras wrote:
>
>> On Wed, Jun 10, 2009 at 7:03 AM, Linus
>> Torvalds<torvalds@linux-foundation.org> wrote:
>> >
>> >
>> > On Tue, 9 Jun 2009, Theodore Tso wrote:
>> >>
>> >> My personal opinion is this kind of overloading is actually more
>> >> confusing than simply adding a new name, such as "git revert-file".
>> >
>> > I'd agree, except I think it actually worked pretty well in "git
>> > checkout".
>> >
>> > The alternative was to add yet another command for that, or to teach
>> > people about the internal commands we did have. Adding the capability for
>> > checkout to check out individual files - in addition to commits and
>> > branches - I think worked pretty well.
>>
>> Why? What makes 'git checkout <commit>' and 'git checkout <commit> --
>> <path>' similar at all? I would expect 'git checkout <commit>' to be
>> the same as 'git checkout <commit> -- .'
>
> You don't understand.
>
> "git checkout" would be similar to "git revert", if we did that change.
>
> IOW, both would be "if you give it a commit, it acts at a commit level",
> and "if you give it pathnames, it acts on a pathname level".
>
> That is totally obvious, and not in the least confusing. They are two
> different things, but at the same time, there is no question about which
> is which.

I'm opposed to 'git revert -- <path>' for many reasons, one of which
is; you might want to grab some files that are in a future commit.
Reverting to the future is weird, unless you did a previous revert
backwards.

I do understand the two different 'git checkout' modes, that's not the
point, my point is the question you didn't answer; what does 'git
checkout <commit>' and 'git checkout -- <path>' have in common?

To me it seems the only thing they have in common is the name.

>> In my mind these are 2 completely different commands.
>
> They are two different things, but they both make sense within the
> _context_.
>
> Only earthworms and FOX news have no concept of "in context". So it does
> make sense to say "git checkout filename" (and expect it to check out that
> _filename_ - surprise surprise), and also say "git checkout branch" (and
> expect it to check out that branch - again, big surprise).
>
> Humans are generally _very_ good at seeing the same word in two different
> contexts, and not being confused at all. There is no confusion when I talk
> about SCM's in the context of git, even though "SCM" could also mean a
> Sceme interpreter, or "Saskatchewan College of Midwives".

Suppose you have a 'debian' branch, and a 'debian' directory, what
does this command do?
git checkout debian

Sure, I'm not an earthworm, so I can guess that command means checkout
the debian branch because it's a much more common action. But git
doesn't know that, you need to do:
git checkout debian --

If I know I want to checkout a branch I would like to do:
git <command to checkout a branch> debian

> In fact, it is often *much* better to accept context-awareness, than to
> try too hard to be "uniquely identifying" even without context.
>
> Of course, you do want things to also be unambiguous. But that's why we
> have things like that "--" thing, when we want to specify pathspecs
> explicitly and don't want to accept any kind of ambiguity. Most humans
> tend to leave them out, and that "--" thing shows up mostly in git
> scripts.

Yeah, unless git finds it ambiguous and the user is forced to learn a
new idiom in order to get rid of the ambiguity.

-- 
Felipe Contreras
