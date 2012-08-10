From: Phil Hord <phil.hord@gmail.com>
Subject: Re: merging confusion and question
Date: Fri, 10 Aug 2012 15:37:22 -0400
Message-ID: <CABURp0q6OXF5Mu3m20z5ZwL4kz0A0HgZynVMLZZBMNXtga01Vg@mail.gmail.com>
References: <5021B20D.2030702@palm.com> <7v393yupjp.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Rich Pixley <rich.pixley@palm.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 10 21:38:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Szv1u-0000aw-Uy
	for gcvg-git-2@plane.gmane.org; Fri, 10 Aug 2012 21:37:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756219Ab2HJTho (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Aug 2012 15:37:44 -0400
Received: from mail-qc0-f174.google.com ([209.85.216.174]:61780 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755604Ab2HJThn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Aug 2012 15:37:43 -0400
Received: by qcro28 with SMTP id o28so1178467qcr.19
        for <git@vger.kernel.org>; Fri, 10 Aug 2012 12:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Epsz3ukwcp0JlILgdbqmgfKbfio2s/3+D6eTkDeXzeo=;
        b=vmQJI6aBwkxXXj6ywc4QXTJKTq5C+LFFNGZnCaRrW3oLWss0z7LE7sN+KTHQ7nqNoh
         oJIJlhvUAvQ5wKOZifWGz8OfIDOZkfBSeQgBsg67lwZYkcmUHa3mRrBqi0c25HStzP26
         H1ovCcJdb5vnyaosN2GDECZ9Siu+LA01XUyvH7znoD7HdRTI/xFy0z36RkETZ9miZTCS
         p3LX32ocBU1tCNIsNVYEYIM13BfU60VeXX8OAHC8qpqmhiQhpjUQ+XB3nK8wnCuj0x1A
         xfwZfnSeyQuaRiSVHuRpskrox03ZGxsCoyWKwSzihiRymzHXT2yFomcjy8i3+in29tGw
         7n6w==
Received: by 10.224.195.199 with SMTP id ed7mr9876827qab.22.1344627462399;
 Fri, 10 Aug 2012 12:37:42 -0700 (PDT)
Received: by 10.229.52.77 with HTTP; Fri, 10 Aug 2012 12:37:22 -0700 (PDT)
In-Reply-To: <7v393yupjp.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203251>

On Tue, Aug 7, 2012 at 9:43 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Rich Pixley <rich.pixley@palm.com> writes:
>
>> I'm confused.
>>
>> What is the intended work flow here?  Ie, aside from trashing my
>> repository and starting over, what does one do to recover?
>>
>> rich@cobra> git clone /home/rich/repos/webos webos
>> Cloning into 'webos'...
>> done.
>> rich@cobra> cd webos
>> rich@cobra> git remote add central git@github.com:openwebos/webos.git
>> rich@cobra> git co master
>> Already on 'master'
>> rich@cobra> git pull central master
>> X11 forwarding request failed on channel 0
>> remote: Counting objects: 22, done.
>> remote: Compressing objects: 100% (19/19), done.
>> remote: Total 21 (delta 12), reused 11 (delta 2)
>> Unpacking objects: 100% (21/21), done.
>> From github.com:openwebos/webos
>>  * branch            master     -> FETCH_HEAD
>> warning: Failed to merge submodule meta-webos (not checked out)
>> Auto-merging meta-webos
>> CONFLICT (submodule): Merge conflict in meta-webos
>> Auto-merging README.md
>> Automatic merge failed; fix conflicts and then commit the result.
>> rich@cobra> git commit -a
>
> Why isn't there any "fix conflicts and then" step between this line
> and the friendly insn message on the previous line?

I think I know the answer.  I remember it from my newbie days.

The reason is that "fix conflicts" is confusing to new users. The new
user didn't really want to merge here, perhaps, which is why there
were so many conflicts.  Git "helpfully" points out each one of the
conflicts, but he doesn't explain what happened as a result (change
markers in the file, etc.).  For the newbie, this is not intuitive;
the barrage of conflict details is intimidating.

"Fix conflicts"?  If I do not know how the conflicts are represented
yet, I also do not know how to fix them.

"Commit the result"?  Result of what?  Commit how?

Adding insult to injury, newbies can find no obvious way to "undo and
try again."  Each command they think should move forward or "do over"
is met with "cannot do that. conflicts exist.  fix this mess and try
again."

Imagine your mom on the web for the first time encountering a "404".
Now imagine that once this happens her browser refuses to work
insisting she "fix the web" first.

I do not know a better description which would not rub the gurus the
wrong way.  When I try to think of one, the hint always involves
something called "git undo".  So I guess the status quo is good for
now, which is "google git merge conflict"

I agree that 'git reset --hard' should be mentioned in the hint for
newbies, but this conflicts with my desire to avoid giving chainsaws
to toddlers.

Phil
