From: Scott Chacon <schacon@gmail.com>
Subject: Re: Git Download/Bootstrap Suggestion
Date: Sun, 29 Mar 2009 16:29:38 +0100
Message-ID: <d411cc4a0903290829p7e7ad14aob62e222877956ba5@mail.gmail.com>
References: <49CD0841.9000602@gmail.com>
	 <fabb9a1e0903271621g392eefdeu85b46c655c1ad067@mail.gmail.com>
	 <49CE4BD2.4060808@drmicha.warpmail.net>
	 <fabb9a1e0903280915l512374ebt8a1f804666dfe87b@mail.gmail.com>
	 <8c9a060903280924h62f4d7aq47819bf3264e6ad6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Mike Gaffney <mr.gaffo@gmail.com>, git@vger.kernel.org
To: Jacob Helwig <jacob.helwig@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 29 17:31:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lnwyl-0004Vu-OM
	for gcvg-git-2@gmane.org; Sun, 29 Mar 2009 17:31:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758654AbZC2P3m convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 29 Mar 2009 11:29:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757810AbZC2P3m
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Mar 2009 11:29:42 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:51673 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757775AbZC2P3l convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 29 Mar 2009 11:29:41 -0400
Received: by fxm2 with SMTP id 2so1633816fxm.37
        for <git@vger.kernel.org>; Sun, 29 Mar 2009 08:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=qZPhyoKHNNnAVaBeJvve84sFLZLekuxfbZfcddGqrIk=;
        b=H148WOYIKirCDVtGZJhuCnkydoMAHJUbLB2WhniPrZ7dHkQW2zze3t8Q/9/ymfY4KQ
         ixaj8BoVTzRBiQTKUdZunox6dESfUq8VU2zQDqY7GAlR5kVjSUoJ0zYPQtQUrLGrDpwd
         3jiNSszf2Ab/Wu5icGP5IX/emGxOiSyFM9+z0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=ciw7h6nL6WWu+og/xHXixWRDGbhOou/oBvORIK/vPfLzcGJdTgXLD5heSRDKCeRaDt
         HpJe5LG4p/cyIKy0rhvS9Wci0qIcXOm6fdPe5jslXIGU0wM1sbM/816h3hia28mNNh0N
         1P27CyBkPwBcA9jnkHfKs/69+d6HHIvxMdZNY=
Received: by 10.223.112.202 with SMTP id x10mr3156502fap.68.1238340578456; 
	Sun, 29 Mar 2009 08:29:38 -0700 (PDT)
In-Reply-To: <8c9a060903280924h62f4d7aq47819bf3264e6ad6@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115029>

On Sat, Mar 28, 2009 at 5:24 PM, Jacob Helwig <jacob.helwig@gmail.com> =
wrote:
> So he can compile git from a git repo, and not have to download it
> (again) after compiling from a work tree. =C2=A0Saving a step, and
> re-compiling a bunch of files when he upgrades.
>

I'm a bit unclear why you would compile/install the second time - if
it's the latest tag, it should be the same as you got from the archive
on the website, the second step should just be re-installing the exact
same Git.  Why not just build it from source the first time and then
pull down the full source for the subsequent times - you're losing
seconds total in the process.  Unless you're doing this all the time,
in which case it seems like it makes more sense to just keep one repo,
build a package of some sort (rpm, deb, etc) and distribute that to
all the computers you're using.

I mean, if you really, really want it then you can :

a) clone the website source : git://github.com/schacon/gitscm
b) write the script that would do it on each release (scripts/ dir)
c) test it
d) write some code that would dynamically link that in the downloads
page at the bottom

If that works then I'll probably pull it in for you.

Scott

> On Sat, Mar 28, 2009 at 09:15, Sverre Rabbelier <srabbelier@gmail.com=
> wrote:
>> Heya,
>>
>> On Sat, Mar 28, 2009 at 17:09, Michael J Gruber
>> <git@drmicha.warpmail.net> wrote:
>>> No, I think he meant repo, not work tree.
>>
>> Why would he need the repo to bootstrap?
>>
>> --
>> Cheers,
>>
>> Sverre Rabbelier
>> --
>> To unsubscribe from this list: send the line "unsubscribe git" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.h=
tml
>>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
>
