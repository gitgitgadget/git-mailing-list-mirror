From: demerphq <demerphq@gmail.com>
Subject: Re: Adding files to a git-archive when it is generated, and whats the 
	best way to find out what branch a commit is on?
Date: Wed, 29 Jul 2009 11:51:42 +0200
Message-ID: <9b18b3110907290251t4d8c83d3rf12d0ea9268c19bd@mail.gmail.com>
References: <9b18b3110907290115v1f30eeat748631bb09f92517@mail.gmail.com>
	 <adf1fd3d0907290141v24cf129eue3939bf1afd518d2@mail.gmail.com>
	 <9b18b3110907290221o8afc72s157969ef7d707d4d@mail.gmail.com>
	 <adf1fd3d0907290233y78514f98h89a2fca7bf68b4f2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git <git@vger.kernel.org>
To: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>
X-From: git-owner@vger.kernel.org Wed Jul 29 11:51:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MW5p9-0003hf-6O
	for gcvg-git-2@gmane.org; Wed, 29 Jul 2009 11:51:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753606AbZG2Jvo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 29 Jul 2009 05:51:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753489AbZG2Jvn
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Jul 2009 05:51:43 -0400
Received: from mail-gx0-f213.google.com ([209.85.217.213]:34480 "EHLO
	mail-gx0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753475AbZG2Jvn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 Jul 2009 05:51:43 -0400
Received: by gxk9 with SMTP id 9so1224453gxk.13
        for <git@vger.kernel.org>; Wed, 29 Jul 2009 02:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=WjP2KvPBD9mAUhZnN2FkdafkCodfkijI7kt05iqGBuE=;
        b=gyrVQ41r5nV/I5/JtUYzk/dexUrpmtd+AklHp11JiuTpXU5FBLUui1TQv+z97maVSq
         HbUcNAMTJiWB3quaZ7Z0A3q9lHsL9nnilnwvpyMKcL5y2rG+mOWmUJY38BjIAUE03MLB
         boxKDYhFbxAxXD6bJ8jLAmnqeOHSBScJxWvDA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=q9oJaviC1amP+ZMb5F3ya85Z85g5V+UdBHfGarsMteCIzUXS4ka7PgLHWBf+OjeIjA
         EzmkQ3ACRpMVk18wLZHGZ6mcPabxPVXeaW19cAaw1b2KagBk/lcMW0w3CXABHdxIkgRH
         DYRC1VOJIpXbiSUlAm7jlNOZYGNPqoFs1xf3k=
Received: by 10.231.15.77 with SMTP id j13mr2886594iba.1.1248861102860; Wed, 
	29 Jul 2009 02:51:42 -0700 (PDT)
In-Reply-To: <adf1fd3d0907290233y78514f98h89a2fca7bf68b4f2@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124340>

2009/7/29 Santi B=E9jar <santi@agolina.net>:
> 2009/7/29 demerphq <demerphq@gmail.com>:
>> 2009/7/29 Santi B=E9jar <santi@agolina.net>:
>>> 2009/7/29 demerphq <demerphq@gmail.com>:
>>>> Another question is whether anyone has any advice on the best way =
to
>>>> find out the "best" branch an arbitrary commit is on. Where best c=
an
>>>> be flexibly definied to handle commits that are reachable from
>>>> multiple branches. =A0I have hacked a solution involving git-log a=
nd
>>>> grep, but it performs quite poorly. I was wondering if there is a
>>>> better solution.
>>>
>>> The "best" tag is easy: git describe commit. For branches I think y=
ou
>>> could use "git name-ref --refs=3Drefs/heads/* commit", because git
>>> describe does not have a --branches flag.
>>
>> Dang, I guess this is from a newer release than mine. So now i have =
an
>> excuse to upgrade.
>
> No, it is quite old (the --refs flag since the v1.5.1). If the proble=
m
> is that you don't find the "git name-ref" command is because it is
> "git name-rev", oops.

Dang, guess i need a different excuse. :-)

But it doesn't seem to do what i need:

$ git name-rev --refs=3Drefs/heads/* faa7dc9f4d3a618b0ad8b3c95edd54e24c=
6976e7
faa7dc9f4d3a618b0ad8b3c95edd54e24c6976e7 undefined

But i think that just because in this case I need remote refs:

git name-rev --refs=3Drefs/remotes/* faa7dc9f4d3a618b0ad8b3c95edd54e24c=
6976e7
faa7dc9f4d3a618b0ad8b3c95edd54e24c6976e7 remotes/origin/maint-5.005~25

Which is definitely better. Can I safely strip the ~25 off the end to
get the real branch name?

BTW, this is the shell version of what I'm currently using:

$ for b in $(git branch -r); do git log --pretty=3D'format:%H' $b | gre=
p
faa7dc9f4d3a618b0ad8b3c95edd54e24c6976e7 && echo $b; done
faa7dc9f4d3a618b0ad8b3c95edd54e24c6976e7
origin/maint-5.005

The main difference with the real code I use (in perl) is that I can
specify the order of the branches to be searched, so that I can ensure
that if its on two it is reported to be "from" the most likely
candidate. And of course the perl version I use stops searching as
soon as it finds a match.

Anyway, if I can reliably strip off the ~25 then this is a big step
forward for me.

Thanks Santi, and of course thanks Johannes (author of name-rev).

cheers,
Yves

--=20
perl -Mre=3Ddebug -e "/just|another|perl|hacker/"
