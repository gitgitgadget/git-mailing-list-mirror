From: Jacob Helwig <jacob.helwig@gmail.com>
Subject: Re: Unmodified submodules shows up as dirty with 1.6.6.443.gd7346
Date: Mon, 18 Jan 2010 09:14:55 -0800
Message-ID: <8c9a061001180914v42074056o3a5d077ac4cea70f@mail.gmail.com>
References: <4B547EA6.5070203@isy.liu.se> <8c9a061001180802t5ec0d389j2cae9f1771130c36@mail.gmail.com> 
	<4B549254.5090206@isy.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jens.Lehmann@web.de
To: Gustaf Hendeby <hendeby@isy.liu.se>
X-From: git-owner@vger.kernel.org Mon Jan 18 18:23:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NWvK9-0001EB-6n
	for gcvg-git-2@lo.gmane.org; Mon, 18 Jan 2010 18:23:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755385Ab0ARRV7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 18 Jan 2010 12:21:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755311Ab0ARRV5
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Jan 2010 12:21:57 -0500
Received: from mail-pw0-f42.google.com ([209.85.160.42]:47864 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755360Ab0ARRVy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 Jan 2010 12:21:54 -0500
Received: by pwj9 with SMTP id 9so1829997pwj.21
        for <git@vger.kernel.org>; Mon, 18 Jan 2010 09:21:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=Ua40IA52/tjsRenSLmy6bYRlQlM6C8VEMWXROjCOF2A=;
        b=Vs6jt415xwH99e6t+fB5ExmXa2tywoos+wwRbEppnT2TkONoJheSGeE+neTfnLjvSf
         ngovMrAgBiefh+wCKp7h59xjxFByuZlklKmcmJUo4LDY4n+86sH76SWYRnqwBvSqog01
         K4YbJZMYlCexS6fQvNp0zNQIPHZ5ACvRFXDqQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=T4BSefApKsBd1jaLs3LPyBQTeeXG8wSzHhIwk+Bzh4DRs/eD+Ba7ZB/uwLSiugQbad
         tYxWfBJR5+69PD372QqSHyBN2LGqU+YwiUriRX4myDZY5AAtVNj4p3DOOarAMYM2wrr3
         /eH9XZbugs19oeFvJEgzhZCPGZYJo2wXb+tbM=
Received: by 10.141.88.20 with SMTP id q20mr4452620rvl.198.1263834915174; Mon, 
	18 Jan 2010 09:15:15 -0800 (PST)
In-Reply-To: <4B549254.5090206@isy.liu.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137391>

On Mon, Jan 18, 2010 at 08:54, Gustaf Hendeby <hendeby@isy.liu.se> wrot=
e:
> Jacob Helwig wrote:
>> On Mon, Jan 18, 2010 at 07:30, Gustaf Hendeby <hendeby@isy.liu.se> w=
rote:
>>> Hi!
>>>
>>> I have been using submodules for a while, and been quite happy with
>>> them. =C2=A0Just updating to the latest next (1.6.6.443.gd7346), a =
strange
>>> problem has occurred. =C2=A0All my submodules (which are in fact un=
modified)
>>> show as modified and dirty
>>>
>>> diff --git a/extern/utils b/extern/utils
>>> --- a/extern/utils
>>> +++ b/extern/utils
>>> @@ -1 +1 @@
>>> -Subproject commit 6bad20e1419f1ca61bd5a6eef9b5937122e006f1
>>> +Subproject commit 6bad20e1419f1ca61bd5a6eef9b5937122e006f1-dirty
>>>
>>>
>> Do you have any untracked files in the submodule? =C2=A0git status i=
s
>> working as I would expect with the same version (1.6.6.443.gd7346).
>
> Yes, I do.
>
>>
>> If there is no output from git status in the submodule, then git
>> status in the superproject shows the submodule as being clean.
>> However, if there is _any_ output from git status (untracked files,
>> modified files, deleted files, new files), then the superproject sho=
ws
>> the submodule as being dirty.
>>
>
> Then the behavior of this feature differs from the one provided by
> GIT-VERSION-GEN that is used as part of the git build process. =C2=A0=
This is
> not an argument itself, but personally, I don't like this behavior, a=
nd
> think it should be reconsidered before inclusion into master.
>
> I have the following use case, which is affected. =C2=A0I have with i=
n a
> submodule some code that needs to be compiled, and hence generate som=
e
> object files and other files in the process. =C2=A0I don't want to in=
clude
> these files in a .gitignore as they are named differently on differen=
t
> systems. =C2=A0Hence, I include them in my .git/info/exclude file, wh=
ere I am
> developing the module. =C2=A0So now, unless I do the same thing for a=
ll
> places I checkout the repo as submodule, I end up with the module
> indicated as dirty after I compile it. =C2=A0This is a bit inconvenie=
nt.
>
> Am I the only one who uses submodules this way? =C2=A0Is there a bett=
er way
> to solve my problem that would provide a better work pattern in this =
case?
>
> /Gustaf
>

I don't really deal with compiled code, when I use submodules, so any
time there's a new file in one of my submodules, it's almost certainly
a new library file that should make the submodule be considered
"dirty".  Even though the current behavior is what I'd expect, and
want for my uses, that doesn't mean it's not wrong for some other use
cases.

That being said:
The .gitignore file supports shell globs.  Are the generated files
created with names that are so different that some simple shell globs
used in one or more .gitignore files couldn't cover them?

-Jacob
