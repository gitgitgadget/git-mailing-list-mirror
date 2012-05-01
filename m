From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: Newbie grief
Date: Tue, 1 May 2012 21:43:46 +0530
Message-ID: <CAMK1S_jN_WdZF4W4szzyJqLfC3FmnhKQ65XQiD-JS_jxwSm8_g@mail.gmail.com>
References: <4F9F128C.5020304@palm.com>
	<201204302331.q3UNVo7o032303@no.baka.org>
	<4F9F3919.6060805@palm.com>
	<CAMK1S_jwVsyKrGoL5uVAiuRrOa8bz79-DAueBmHZE2k=PpcJ2Q@mail.gmail.com>
	<20120501111415.GD5769@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Rich Pixley <rich.pixley@palm.com>,
	Seth Robertson <in-gitvger@baka.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: "Ted Ts'o" <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Tue May 01 18:13:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPFi4-0002fV-ER
	for gcvg-git-2@plane.gmane.org; Tue, 01 May 2012 18:13:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757936Ab2EAQNs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 May 2012 12:13:48 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:59385 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757058Ab2EAQNr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 May 2012 12:13:47 -0400
Received: by obbtb18 with SMTP id tb18so994066obb.19
        for <git@vger.kernel.org>; Tue, 01 May 2012 09:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=JrpkltOE8f8bDp6lsY/VDyK+6LxPvXNQomEzj+XC4CU=;
        b=QUoi550SqHZO/GKjnENDUuzDp1VuHVx8nKSnLyksMpsACNubeBb56d7wGdHVFlBdeX
         KZy4Y3PpgCe/emDegr3O+HRzEY+iykozRPaqtmJbBqO8+FYYw294IHNwDmmedn7N5lcs
         TIT06C5poZyyqO/6JJHnuIz/QKF5Kf82sE3JjPOnxoehy6vXybz405oAL9l1KeJ4CwOZ
         cy5gUjR9aDMZzhVEXKBdSOW6hE/aPAF1o6s5XunkPdGDsZwhPuU53Q6PYJNEmrCLDZa9
         U5XlSM2FY8BjOXuENiYvXAsGMedK4DFMhBFY34o0iYhTrFSXmp9wJTWTzn8RvkXkUBI8
         Z3XQ==
Received: by 10.182.72.38 with SMTP id a6mr25414843obv.38.1335888826692; Tue,
 01 May 2012 09:13:46 -0700 (PDT)
Received: by 10.182.108.67 with HTTP; Tue, 1 May 2012 09:13:46 -0700 (PDT)
In-Reply-To: <20120501111415.GD5769@thunk.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196688>

On Tue, May 1, 2012 at 4:44 PM, Ted Ts'o <tytso@mit.edu> wrote:
> On Tue, May 01, 2012 at 09:14:24AM +0530, Sitaram Chamarty wrote:
>>
>> > Multiple heads are the idea that a single commit can "branch" in t=
he
>> > repository and that both commits can be HEADS of the same branch a=
t once in
>> > a single repository. =C2=A0This allows a potential collision to ex=
ist in the
>> > repository and to be pushed and pulled through multiple repositori=
es. =C2=A0It
>>
>> That is bizarre; I have no other word for it.
>>
>> I teach git (occasionally), and if this feature existed I would
>> totally ignore it in my teaching material because I wouldn't know ho=
w
>> to defend or explain the need for "hydra branches".
>
> I wouldn't use the verb branch (and certainly not "hydra branch"),

I coined that phrase for what was described as "[multiple] HEADS of
the same branch at once in a single repository".

> it this way, it becomes obvious that a particular parent commit can
> have multiple child commits. =C2=A0(This seems to be what you are cal=
ling
> "hydra branches".)

No.  In git, the multiple child commits you mention are all either
different branches, tags, or they are detached/subject to GC.  At no
time do you actually have the situation he was talking about: a single
branch representing more than one leaf (no children) commit *at the
same time*.

> Git differs in that you can have a child commit which is not pointed
> to by a branch pointer, and which is referred to only by commit-id.
> These child commits can disappear on you, when you do a garbage
> collection; but it allows you to have multiple child commits hanging
> off of a single parent commit, and you can do diffs, cherry picks,
> etc. =C2=A0But they *do* have a unique name --- the commit id, which =
is a
> SHA1 hash of the contents of the diff.

Sure.

What the original poster wants is that all these unnamed commits be
magically associated with the branch they were born in, and be
propagated via pushes and pulls.

As I understand it, he would like a one -> many relationship between
branch name and SHA.
