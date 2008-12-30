From: "Jeff Whiteside" <jeff.m.whiteside@gmail.com>
Subject: Re: for newbs = little exercise / tutorial / warmup for windows and other non-sophisticated new Git users :-)
Date: Mon, 29 Dec 2008 21:33:06 -0800
Message-ID: <3ab397d0812292133r7955e892g6c19ca46629e7103@mail.gmail.com>
References: <gj68a0$u56$3@ger.gmane.org> <gj6kqq$nvh$4@ger.gmane.org>
	 <3ab397d0812291505v77824e6fvdecebc80f38a5f89@mail.gmail.com>
	 <gjc7qa$jdj$4@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Zorba <cr@altmore.co.uk>
X-From: git-owner@vger.kernel.org Tue Dec 30 06:34:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LHXFa-0008HQ-Fa
	for gcvg-git-2@gmane.org; Tue, 30 Dec 2008 06:34:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750858AbYL3FdW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 30 Dec 2008 00:33:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750804AbYL3FdV
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Dec 2008 00:33:21 -0500
Received: from qw-out-2122.google.com ([74.125.92.24]:39069 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750722AbYL3FdU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 30 Dec 2008 00:33:20 -0500
Received: by qw-out-2122.google.com with SMTP id 3so4006846qwe.37
        for <git@vger.kernel.org>; Mon, 29 Dec 2008 21:33:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=kNyx+tNT8Y9wy5uKKzIxwcyoxOJM1HCklKYAi8g6A34=;
        b=lihynbsSp5N1Q1AD0y0Fl7AdeuPaNvoZ3vaE1QKRrAImn1PQP4XpuJol0/OjSApFdt
         vF8mOTG8+8+GL6AWbAORORelEHA/UDh/T+afbIskOPBmMMKCikTXCdaAkNgA475q2Crw
         Dd5uQv7ukJqdXf0WdX8UGRvdpZ7Dekjylmoa0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=jy4V/clZRf59iTLzWedXK5Tbc+T42SECgxbd4aRLr7fkL1iMbP15KaNo9dbP4W0777
         mCE5G+/iHG6iqdWRcZw0K/aRs4yZvQnZ2nHXrjWNxrMvOc/RO3DqfOdP3lEUJ4Zx55S5
         P+VcVLT6gQLCKg4JgRq7ha6jBI9wycbsMgJlM=
Received: by 10.214.147.16 with SMTP id u16mr12012668qad.157.1230615186953;
        Mon, 29 Dec 2008 21:33:06 -0800 (PST)
Received: by 10.215.41.3 with HTTP; Mon, 29 Dec 2008 21:33:06 -0800 (PST)
In-Reply-To: <gjc7qa$jdj$4@ger.gmane.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104161>

> Thanks for your contrib. I'll pick these up for sure, but right now I=
'm
> despo to make some progress getting this confounded real-life project
> versioned.

np, i do understand totally.

> I've just made a commit I want to retract.

this is the purpose of git reset --soft/mixed/hard

> I have been using $ git reset --hard <version> as an escalator to asc=
end /
> descend the versions up and down

you should probably be using git checkout for this

> Surely it doesn't alter the history, as I can commit versionA, versio=
nB,
> versionC, and then reset to A, then reset to C, then reset to B.

i does alter the history.  i think this works because git isnt'
deleting the actual blob objects in the git dir until you use the git
prune, or gc or whatever (i never use it anyway).  but, you are
altering history, and just happen to be recovering.

> so when I reset to A, I've still got the ability to get to B or C aga=
in

with an uneasy conscience ;)

> Now I appreciate that if I commit a new change from versionA (lets ca=
ll it
> B1), then HEAD is now at B1, and B, C etc are lost, correct ?

yes! but this is not true if you had done a git checkout (there are
measures to recover B and C, provided you haven't done a prune.  i
think git reflog has some answers here, but i'm still a newbie).

> Its pertinent to where I am right now, as I've goofed a commit, and w=
ant to
> reset, and commit again but I'm worried about leaveing garbage lying =
around
> (the commits for version B and C in the example above).

you've goofed what commit (a1?, c?, d3?)?  where are you now and what
do you want to do now? reset to what version?  if you're just worried
about space used by B and C, i think git prune will purge these (look
at man page, don't guess at the syntax).

i half suspect that you want to git branch at some point, but if
yo'ure just recretaing the other code bases' history form other files,
you shouldn't be able to break too much by git reset --hard, or git
prune.

> BTW: sdf=3DSyntax Definition Formalism?

hahahaha, no, i was just typing/copypasting garbage, because my gmail
woudln't' get out of bold mode and forgot to delete it at the end.
haha.

On Mon, Dec 29, 2008 at 8:24 PM, Zorba <cr@altmore.co.uk> wrote:
> Hi Jeff,
>
> Thanks for your contrib. I'll pick these up for sure, but right now I=
'm
> despo to make some progress getting this confounded real-life project
> versioned.
>
> But where I'm stuck now touches on your post.
>
> I've just made a commit I want to retract.
>
> I have been using $ git reset --hard <version> as an escalator to asc=
end /
> descend the versions up and down
> Surely it doesn't alter the history, as I can commit versionA, versio=
nB,
> versionC, and then reset to A, then reset to C, then reset to B.
>
> so when I reset to A, I've still got the ability to get to B or C aga=
in
>
> Now I appreciate that if I commit a new change from versionA (lets ca=
ll it
> B1), then HEAD is now at B1, and B, C etc are lost, correct ?
>
> Its pertinent to where I am right now, as I've goofed a commit, and w=
ant to
> reset, and commit again but I'm worried about leaveing garbage lying =
around
> (the commits for version B and C in the example above).
>
> NB if you read my latest posts you will see why I chose the example I=
 did
> for my "warm-up" as it closely models what I'm trying to do for real.
>
>
> BTW: sdf=3DSyntax Definition Formalism?
>
> "Jeff Whiteside" <jeff.m.whiteside@gmail.com> wrote in message
> news:3ab397d0812291505v77824e6fvdecebc80f38a5f89@mail.gmail.com...
>
> -"Rollback to each of the versions, starting with version A"
> this is bad.  you're saying rollback.  to others that have used scms,
> this will mean, "retrieve an older copy", but in git, this is DELETIN=
G
> all the versions after the version that you "rollback" to.  your blog
> post shouldn't discuss the git-reset --hard command at all, since
> you're rewriting history, which is dangerous.  afaik, most scms don't
> allow you to rewrite history.  to "rollback" to an older version you
> should use checkout the git-checkout command.  maybe the git reset
> -=96hard HEAD is okay to include... but it won't be immediately obvio=
us
> to new users why it does what it does... this nomenclature was likely
> not the best choice whenever it was made.
>
>
> gl with your gitting.
>
> whiteside
>
>
>
>
> u're talking sdf
>
>
>
>
> On Sat, Dec 27, 2008 at 5:29 PM, Zorba <cr@altmore.co.uk> wrote:
>>
>> tidied up the formatting, added a few more comments where needed, fi=
xed
>> errors/lack of clarity
>>
>> "Zorba" <cr@altmore.co.uk> wrote in message
>> news:gj68a0$u56$3@ger.gmane.org...
>> > Here is a little exercise / tutorial / warm-up for someone startin=
g out
>> > with Git. If you're anyting like me you may find the tutorials etc=
=2E on
>> > git.or.cz a bit daunting. I recommend you try this after reading t=
he
>> > user
>> > manual but before tearing your hair out trying to follow all the
>> > examples
>> > in the user manual. After you've followed this simple workflow, th=
en go
>> > back to the more advanced stuff  in the tutorials and user manuals=
 (like
>> > cloning repositories and creating and merging branches).
>> >
>> > I created this exercise to try and model our workflow and what we =
wanted
>> > to use git for =3D tracking a project with multiple files where th=
e
>> > filebase
>> > might change frequently from one version to the next.
>> >
>> > http://siliconmouth.wordpress.com/category/nerdy/
>> >
>> > look for December 27, 2008 or "git warmup"
>> >
>> >
>>
>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe git" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
