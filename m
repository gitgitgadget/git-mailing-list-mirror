From: Drew Northup <n1xim.email@gmail.com>
Subject: Re: git push tags
Date: Fri, 26 Oct 2012 09:37:33 -0400
Message-ID: <CAM9Z-n=+YeF3BaF-5UB5f2GBHYw7WDZEFDVT72RGSsDBaH4PJA@mail.gmail.com>
References: <CAB9Jk9DMOwhDf3SvMzTmTZiyZg_4pgXx-evrfWkB3U4w-KqtVw@mail.gmail.com>
	<CAM9Z-nkxCOyrtJ8vCF=00vrA_1eFr2-Fk7PXjYEx0HbVt0GPkQ@mail.gmail.com>
	<CAB9Jk9A95YrrtH8ue-CJ6Mqe9Z+3nfo=tjurLZjmecfiMFijvg@mail.gmail.com>
	<CAM9Z-nkosbe1NXYnu7x6v4seLqCnMBWg-jrdH2eJ9RetaZBTyQ@mail.gmail.com>
	<CAB9Jk9ApdbN+4Yk-6+u4Nje9+tbESSGGVj95iof1jnfG4Ga7GA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Angelo Borsotti <angelo.borsotti@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 26 15:37:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TRk6d-0001PH-Tn
	for gcvg-git-2@plane.gmane.org; Fri, 26 Oct 2012 15:37:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932877Ab2JZNhg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Oct 2012 09:37:36 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:38764 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932544Ab2JZNhf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Oct 2012 09:37:35 -0400
Received: by mail-bk0-f46.google.com with SMTP id jk13so1266663bkc.19
        for <git@vger.kernel.org>; Fri, 26 Oct 2012 06:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=R5R2POHtwRQFILa4yGhL9t3cRkYPGzaS/G/vpuQjZ9o=;
        b=AH0OHukBHG4DVzNm8KmKbwvgpVTe+lMQd68Kw5wN++Am5dcZ+/dka30xFBuFPbBnM8
         GvqGoPBM3DibDOpkV2GfHwmDsZZmBHP/5hkoEb175yvQNStkatEs4o4HuHMueGd2MJuw
         rTGKS+CfoYBPIDYW15VCAhYIYG26EXYrBVyum1DSW63Qqc1UAb69JVbr3fA7xsbupHSN
         EksHVSLTyYZjmKcLLTxsPkTlbuwna36gB5Vvq+ciOTNf4IkEylky6XjEZ0dX4wQiqDIa
         kdlyKgSle0cPikn16ZYW7zTlHGdfTXKz5ND7jfwruE797EiD4MsQ2gv7of41zx9NI7fY
         hjpw==
Received: by 10.204.11.70 with SMTP id s6mr7349822bks.63.1351258653872; Fri,
 26 Oct 2012 06:37:33 -0700 (PDT)
Received: by 10.205.122.144 with HTTP; Fri, 26 Oct 2012 06:37:33 -0700 (PDT)
In-Reply-To: <CAB9Jk9ApdbN+4Yk-6+u4Nje9+tbESSGGVj95iof1jnfG4Ga7GA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208443>

On Fri, Oct 26, 2012 at 2:42 AM, Angelo Borsotti
<angelo.borsotti@gmail.com> wrote:
> Hi Drew,
>
------Adding for clarity: On Thurs, Oct 25, 2012 at 17:16 EDT, Drew
Northup wrote:
>>
>> Changing the tag in the local repository is a tag modification
>> operation. Pushing that change to a remote repository DOES NOT execute
>> "git tag...." in the remote. Plain and simple the two are different
>> operations.
>>
>
> They are different for what concerns the implementation. They are not
> necessarily so for what concerns their semantics, and the most
> straightforward is to apply to the remote repository the changes done
> on the local one -- the changes that can legally done on it -- and
> changing a tag is not one allowed (unless forced).

So you want the rules of "git tag" to be forced upon "git push." I
heard (read) that already. By what means do you intend to enforce
that? Please go look at the code of "git push" (builtin/push.c) before
coming back with an answer.

> Obviously, the semantics of git-push is different, and then needs to
> be described clearly.
> Note that some (probably most) of the operations that are disallowed
> on the local repo are also disallowed by git-push, like, e.g. deleting
> the current branch. But the user cannot tell what is disallowed and
> what not if the man page does not state it.

If you think something is inadequately documented then do please
submit a patch proposing the changes you would like to see. Even if it
isn't quite right the first time you can get help from interested
people on the list getting it accepted. If nothing else you'll get
some constructive discussion going.

(As for deleting the current branch, you can't really do that on a
proper bare remote anyway as there is no such thing as a "current
branch" in that context.)

>> So here we come to the core argument. Is sounds to me like you want
>> changes to remote tags to work differently from push updates to ALL
>> other references. The required change, if I'm not mistaken, would be
>> for tags to not permit fast-forward updates while all other references
>> would be pushed normally. From my brief and un-enlightened look at the
>> push code I can't see that being as easy as it sounds.
>>
>
> No, I was hoping that git-push refused to change tags at all, unless
> forced (e.g. prefixing them with +), as it is on a local repository.

I'm not sure how you get to negate my statement and then restate it
and think that you are saying something different. Please go look at
the the source code. Tags are just a class of refs that we set aside
for human consumption while also providing them with meaning that the
computer can understand.

What are refs then? Refs are REFERENCES to specific objects (at this
point I know only of commits being _referenced_ that way) by their sha
hashes (literally, that's what the file contains) in the repository.
That's it. Git push/pull doesn't handle them any differently may they
be heads or tags. (Remote heads, aka tracking branches, are references
to objects in the repository that do not exist in a local branch. It
doesn't look like we push those, but I could be wrong.) What Git does
do is allow you the flexibility of pushing refs selectively (with some
caveats). Once tags are loaded into the queue of references to be
pushed they are handled like any other kind of reference.

If you think there would be a benefit to making the reference pushing
code "type aware" then do please look into the code and submit a
patch. I am not going to waste any more time arguing about how it
"should be" if you cannot go to the trouble of reading the code and
coming up with a solution that implements what you would like to see
happen. Frankly, if all you can come up with is pseudocode you still
will at least have a chance of working with the people here on this
list to to write up something that implements the behavior you would
like to see. The first step to that is understanding how it actually
works now.

-- 
-Drew Northup
--------------------------------------------------------------
"As opposed to vegetable or mineral error?"
-John Pescatore, SANS NewsBites Vol. 12 Num. 59
