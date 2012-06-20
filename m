From: Chris Packham <judge.packham@gmail.com>
Subject: Re: Blaming differences
Date: Wed, 20 Jun 2012 14:45:46 +1200
Message-ID: <CAFOYHZD9+P1Gkdu4QE01A+ytJsWdAs4f2f2-=QqHt7-ur092xA@mail.gmail.com>
References: <CABURp0omoLoNaOhD3Vx734aVtm5sbk0E7_2uaZJWrWs=_g84iA@mail.gmail.com>
	<CAFOYHZAyRUwnguvbkk_SDqiSJ=Z3mOdtDLZ+yQMep91cgK+Bww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=f46d04428edc6892dc04c2de6545
Cc: git@vger.kernel.org
To: Phil Hord <phil.hord@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 20 04:46:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ShAw8-0001Nq-Ju
	for gcvg-git-2@plane.gmane.org; Wed, 20 Jun 2012 04:46:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754313Ab2FTCps (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jun 2012 22:45:48 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:63567 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753472Ab2FTCps (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jun 2012 22:45:48 -0400
Received: by wibhn6 with SMTP id hn6so3922480wib.1
        for <git@vger.kernel.org>; Tue, 19 Jun 2012 19:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=PAVrcN2Ep6PACC3MINRP0zuj7b0BUq/kuBIN6cwtjlg=;
        b=M6QFg/E2w4SdiAGGbh/R8JY3mKnfEc3PrvxcsGvKKITDuiM6KxxATYKQ9dPXnjNU9K
         h0yFYl0O7B3no/JkGca8/o8ZGLLmj8VbnEDYIhji7MgRje6Zuzjh2FqvcsrCa1XEfjC9
         jPkE+rhgA5rDV0uXRIh9i0SSlBw4cA8QG3N72t6btu0G20zCHkhCZqF6EIyWijr3/NzY
         k7N0OXoYlG7beZ7AKtkTZenje5TCtF48JrvPPBEzBdcY9IPYVo5AIIVBd20oJ2XRm529
         fTVBi5/dFAOhNwM0K00W1S9t7gQq2m44VovpbaBBjBoYMMHW1cjxvJdHE1c4htki6+09
         b6iQ==
Received: by 10.180.98.201 with SMTP id ek9mr8071982wib.7.1340160346722; Tue,
 19 Jun 2012 19:45:46 -0700 (PDT)
Received: by 10.216.4.134 with HTTP; Tue, 19 Jun 2012 19:45:46 -0700 (PDT)
In-Reply-To: <CAFOYHZAyRUwnguvbkk_SDqiSJ=Z3mOdtDLZ+yQMep91cgK+Bww@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200282>

--f46d04428edc6892dc04c2de6545
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 20, 2012 at 12:35 PM, Chris Packham <judge.packham@gmail.com> w=
rote:
> On Tue, Jun 19, 2012 at 10:56 AM, Phil Hord <phil.hord@gmail.com> wrote:
>> I want something like a product of diff and blame. =C2=A0I want to see s=
ome
>> kind of "blame" output for each line of "diff -U0".
>>
>> I tried something like this:
>> =C2=A0 git blame $changed_files
>>
>> Is there such a command already?
>>
>> I'd also like to do something of the inverse operation: =C2=A0I want to
>> find commits within a range whose changes are NOT in some other
>> commit. =C2=A0 So, say I have these four commits
>> =C2=A0 A---B---C---D
>>
>> Where D was created by 'git revert B'.
>> I'd like to find out somehow that this is equivalent to
>> =C2=A0 A--C
>>
>> So that if I remove B and D completely, the with just A and C will get
>> me to the same end result.
>>
>> Something like 'git list-contributors HEAD' which would show me A and
>> C, since these are the only commits that appear in any 'git blame
>> $any_file'.
>>
>> Do these tools exist? =C2=A0Is it too expensive?
>>
>> Phil
>> --
>> To unsubscribe from this list: send the line "unsubscribe git" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.html
>
> I've just run into a situation at $dayjob where something like this
> would be useful for me so I thought I'd throw my use-case into the mix
> if anyone decides to pick this idea up.
>
> I'm doing a peer review of a modest project that's been developed off
> in a branch of it's own before it will be merged back to master. Our
> current policy is to let these project merges reflect reality warts an
> all (e.g. leave in commits and their reverts even if the net result is
> 0 lines changed). I don't want to waist too much time reviewing commit
> by commit, especially when one commit might heavily refactor code from
> an earlier one. However looking at the full 'git diff project
> ^origin/master' is a bit more code that I can keep in my brain at one
> time. What I'd find useful is the output of 'git diff project
> ^origin/master' marked up with the sha1s which I could then use as a
> leaping off point.
>
> Something like this could get me part way there
>
> =C2=A0for x in $(git diff --name-only project ^origin/master)
> =C2=A0do
> =C2=A0 =C2=A0echo git blame project ^origin/master -- $x >$x.ann
> =C2=A0done
>
> But I'd still have to figure out how to reduce the annotated files
> down to something useful. The git blame -L option might help if I
> could specify it multiple times and parse the diff output,
> alternatively since it's not a huge number of revs I multiple
> invocations of git blame would work for me. I'll have a go at hacking
> something up after lunch.

So here's my initial attempt. Definitely a long way to go but I think
it illustrates the concept. It actually throws away the diff output
and produces blame output for the lines modified as a result it
doesn't cover annotating lines that have been removed. Ideally the
whole diff would be marked up and we'd see annotations for lines that
are added or removed as well as for context lines (if present).

--f46d04428edc6892dc04c2de6545
Content-Type: application/x-sh; name="git-annotate-diff.sh"
Content-Disposition: attachment; filename="git-annotate-diff.sh"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_h3nsms5b0

IyEvYmluL3NoCiMgQ29weXJpZ2h0IDIwMTIgQ2hyaXMgUGFja2hhbSA8anVkZ2UucGFja2hhbUBn
bWFpbC5jb20+CiMKIyBUaGlzIGZpbGUgaXMgbGljZW5zZWQgdW5kZXIgdGhlIEdQTCB2MgoKVVNB
R0U9J3Jldi1saXN0JwpMT05HX1VTQUdFPSdQcm9kdWNlcyBhbiBhbm5vdGF0ZWQgZGlmZiB3aXRo
IHRoZSBjb21taXQgaW5mb3JtYXRpb24gdGhhdAppbnRyb2R1Y2VkIHRoZSBjaGFuZ2UnCgouICIk
KGdpdCAtLWV4ZWMtcGF0aCkvZ2l0LXNoLXNldHVwIgoKcmVxdWlyZV93b3JrX3RyZWUKCnBhcnNl
X2RpZmZfb3V0cHV0KCkKewoJZmlsZT0KCXdoaWxlIHJlYWQgbWFyayBvcmlnIGN1cnIgcmVzdAoJ
ZG8KCQljYXNlICIkbWFyayIgaW4KCQkiKysrIikKCQkJZmlsZT0iJHtvcmlnI1thYl1cL30iCgkJ
CTs7CgkJIkBAIikKCQkJc3RhcnQ9IiQoZWNobyAkY3VyciB8IGN1dCAtZCwgLWYxKSIKCQkJc3Rh
cnQ9JHtzdGFydCNbKy1dfQoJCQlvZmZzZXQ9IiQoZWNobyAkY3VyciB8IGN1dCAtZCwgLWYyKSIK
CQkJZ2l0IC0tbm8tcGFnZXIgYmxhbWUgLUwkc3RhcnQsKyRvZmZzZXQgIiRmaWxlIgoJCQk7OwoJ
CSopCgkJOzsKCQllc2FjCQkKCWRvbmUKfQoKZ2l0IGRpZmYgJEAgfCBwYXJzZV9kaWZmX291dHB1
dAo=
--f46d04428edc6892dc04c2de6545--
