From: Aaron Boxer <boxerab@gmail.com>
Subject: Re: Git Stash stages files if there is a conflict
Date: Mon, 18 Oct 2010 13:56:47 -0400
Message-ID: <AANLkTinC_e=5RKQ2wiy3NtxmsXkiMYKv1+hXWGXd25Pn@mail.gmail.com>
References: <loom.20101015T220924-952@post.gmane.org>
	<4CBC8161.3080507@nextest.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Eric Raible <raible@nextest.com>
X-From: git-owner@vger.kernel.org Mon Oct 18 19:56:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P7txA-0003t6-3F
	for gcvg-git-2@lo.gmane.org; Mon, 18 Oct 2010 19:56:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753761Ab0JRR4u convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 18 Oct 2010 13:56:50 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:41142 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750848Ab0JRR4t convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 Oct 2010 13:56:49 -0400
Received: by bwz11 with SMTP id 11so166505bwz.19
        for <git@vger.kernel.org>; Mon, 18 Oct 2010 10:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=tpQzNLHCrY8IQ97dliG434cjRbagDI2T8O14pvtu+b8=;
        b=w/HgjJr3jOnZ/aeimT0LcogP+pnlBypoRVS09Ycw3f/govpLCIP7viQeCL2gHe8ltT
         WP1XeafYXFHvXKiYIXoIGLlhJ+dCUUmKcgzOKqi94R/8OgxAbNky/Xdnu7Ricwx2jkMK
         wpFqpbxutIHryxo7OeQsLZrmEXVCwn1SjYnxI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=btL6bdUnot+efwTJVdIvyhML8eDxO7egmy0KONy4h7TjRV1JsJJlIbjhs+L5gEYEiV
         QuwriqmhLkoMAhSJA02deUtBdN6tBuqhtQHaGZwsf7RWMXJqahFsUnVEN6XS/XhOWCem
         FkQDjfFIsTuYTApY3IljftzDmD180szlaoVpc=
Received: by 10.204.59.19 with SMTP id j19mr4716786bkh.124.1287424607788; Mon,
 18 Oct 2010 10:56:47 -0700 (PDT)
Received: by 10.204.46.198 with HTTP; Mon, 18 Oct 2010 10:56:47 -0700 (PDT)
In-Reply-To: <4CBC8161.3080507@nextest.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159273>

Thanks, Eric. The new git stash branch command you mentioned will come =
in handy.

=46rom a user's perspective, it doesn't make sense to stage unconflicte=
d
changes after stash apply.
When I stash changes, these changes are usually not ready for committin=
g.

I suppose git uses the index to differentiate between conflicted and
unconflicted changes.
So, its not a big deal. Just a bit surprising.

Thanks again for your help!




On Mon, Oct 18, 2010 at 1:18 PM, Eric Raible <raible@nextest.com> wrote=
:
> On 11:59 AM, Pretty Boy Floyd wrote:
>> Hello!
>>
>> I am running msysgit 1.7.3.1. =A0If I run stash apply, and there is =
a conflict,
>> all of my stash changes get staged. Is this the correct behaviour? I=
 found it a
>> little surprising.
>
> My tests indicate that the same thing happens as with any conflicted =
merge.
> Namely: non-conflicting changes get staged, and conflicting changes a=
re left
> only in the working directory (with conflict markers added as appropr=
iate).
>
> See http://progit.org/book/ch3-2.html#basic_merging,
> especially the part on conflicts.
>
>> Another question: if I have stashed 10 files, and there is a conflic=
t in one of
>> them, will stash apply abort when it has a conflict, or will it appl=
y all
>> non-conflicted files.
>
> Same as above. =A0In both cases the stash is unaffected, which allows
> you to reset and try again.
>
>> Finally, if I do the following:
>>
>> git stash
>> git pull
>> git stash apply
>>
>> and another developer has removed a file that I have stashed, then I=
 am unable
>> to apply the stash =A0on this file. How can I retrieve my changes fr=
om the stash?
>
> One nice (relatively new feature) is "git stash branch", which makes =
a new
> branch from an existing stash.
>
> HTH - Eric
>
