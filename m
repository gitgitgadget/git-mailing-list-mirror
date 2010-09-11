From: Tor Arvid Lund <torarvid@gmail.com>
Subject: Re: git-p4
Date: Sat, 11 Sep 2010 20:42:41 +0200
Message-ID: <AANLkTinmG5BU+yswWQ8=cRKT5WL_h8vWuUCu2PjZYb87@mail.gmail.com>
References: <4C8A8CE8.90600@borg.org>
	<20100910235323.773d2c5b@varda>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-kernel@vger.kernel.org, git@vger.kernel.org,
	=?UTF-8?Q?Alejandro_Riveira_Fern=C3=A1ndez?= <ariveira@gmail.com>
To: Kent Borg <kentborg@borg.org>
X-From: git-owner@vger.kernel.org Sat Sep 11 20:42:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OuV2O-0000m4-OT
	for gcvg-git-2@lo.gmane.org; Sat, 11 Sep 2010 20:42:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751827Ab0IKSmn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 11 Sep 2010 14:42:43 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:61509 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750903Ab0IKSmm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 11 Sep 2010 14:42:42 -0400
Received: by iwn5 with SMTP id 5so3466696iwn.19
        for <multiple recipients>; Sat, 11 Sep 2010 11:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=I+e+bWZSrC2KxhIL3Laxng6aSnd44BQDVyTJdOI1lrI=;
        b=rmEom8E3dsx+kNxLnJA1SXlTvv7avNXrE2xzu5uBJYbXzS2ZZEglxWpD1KCtaqBih0
         rb5vKf90DwkUzXDVz60MejHyvtNEuGapdZV2CJ7BYbbyM3tfe7WDdyPpMW92eAhltaeM
         GX0FWYbVmAHJrfqsyM1iS8ok7H/AKL6gdwQVI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=tAVlqivB91sUA2oU16SFF6QSmrnYRgaqWyKwaBLoZcespQpj0bCex9ixcBZeXCHBYW
         A73JHaJzJuOkYDGW1INQxExh2I1SovJBDLQAKRrgRb5RPqhigg/gSpHZYGZqpC3vePpu
         ELt6PJnHMXzdMG+i+/vD+ze7PPdfZc3UywvNk=
Received: by 10.231.146.212 with SMTP id i20mr3260188ibv.52.1284230561452;
 Sat, 11 Sep 2010 11:42:41 -0700 (PDT)
Received: by 10.231.112.20 with HTTP; Sat, 11 Sep 2010 11:42:41 -0700 (PDT)
In-Reply-To: <20100910235323.773d2c5b@varda>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156004>

2010/9/10 Alejandro Riveira Fern=C3=A1ndez <ariveira@gmail.com>:
> El Fri, 10 Sep 2010 15:54:16 -0400
> Kent Borg <kentborg@borg.org> escribi=C3=B3:
>
> =C2=A0[ CCing git mailing list. Looks like a better place to ask this=
 question]
>
>> I have a git-p4 question: I work in a Perforce shop and am doing Lin=
ux
>> kernel work, I need to share that work with colleagues who see the w=
orld
>> as a Perforce place. =C2=A0The kernel I have came from Linus' tree a=
nd has a
>> lot of history. =C2=A0When I try to do my first a "git p4 submit" it=
 chokes
>> as it looks back in the entire git history until it fails looking fo=
r
>> the ancestor of the first commit (linux-2.6.12-rc2!), I think it is
>> looking for the last time it did a git-p4 submit so it knows how far
>> back to go--but it has never done a submit in this new relationship
>> between p4 and git. =C2=A0There is plenty of git history that is not
>> reflected in p4, and I don't want it in p4, I just want new work in =
p4.

Yes, you are right in that git-p4 looks for the last point in history
where p4 and git were "in sync".

>> I fear that git-p4 is for git people to contribute to bits natively
>> p4-homed code, not this case where the code is natively git-homed co=
de
>> and it is the p4 people who will be contributing bits.

This is also correct, I'd say.

>> My attempt at a work around was this:
>>
>> =C2=A0- create a director on the p4 side, and from the p4 side submi=
t the
>> files that match my latest git submit.
>>
>> =C2=A0- sync with git-p4

This is how I would do it too...

>> =C2=A0- try to submit a file with git-p4...and that fails as it runs=
 all the
>> way back through the history. =C2=A0(Thank goodness it didn't succee=
d in
>> submitting kernel activity since 2005!)

Well, when you did the "sync with git-p4", did it create a branch in
refs/remotes/p4/master or something like that? I think that's
generally how it solves the issue of knowing what to submit to p4; On
the git side you have a number of commits that you _don't_ want to
submit, and the most recent of these commits should have a log message
that ends with:

[git-p4: depot-paths =3D "//Path/To/Your/Project/": change =3D 30049]

=2E. where the 'change' number is the number of the perforce changelist
you synced using git-p4.

So - work that you want to submit to p4 should be rebased on top of
such a commit. Then it should work to do git-p4 submit.

-Tor Arvid-
