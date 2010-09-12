From: Tor Arvid Lund <torarvid@gmail.com>
Subject: Re: git-p4
Date: Sun, 12 Sep 2010 21:54:07 +0200
Message-ID: <AANLkTi=NGsY3wDiTLwNLpw4TJMpiSY8A=az_=v2fYDLj@mail.gmail.com>
References: <4C8A8CE8.90600@borg.org>
	<20100910235323.773d2c5b@varda>
	<AANLkTinmG5BU+yswWQ8=cRKT5WL_h8vWuUCu2PjZYb87@mail.gmail.com>
	<4C8CF231.6090403@borg.org>
	<AANLkTi=yJ5kVA17+40xc6NpEczFjgmYh7=w5k=GL_U9w@mail.gmail.com>
	<4C8D14F9.90705@borg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?Q?Alejandro_Riveira_Fern=C3=A1ndez?= <ariveira@gmail.com>
To: Kent Borg <kentborg@borg.org>
X-From: git-owner@vger.kernel.org Sun Sep 12 21:54:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ousd1-0007Lk-G2
	for gcvg-git-2@lo.gmane.org; Sun, 12 Sep 2010 21:54:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753140Ab0ILTyN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 12 Sep 2010 15:54:13 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:37095 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752874Ab0ILTyM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 12 Sep 2010 15:54:12 -0400
Received: by iwn5 with SMTP id 5so4376082iwn.19
        for <git@vger.kernel.org>; Sun, 12 Sep 2010 12:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=aa25AjqUiRQJhP1Siv6GknicLWywYT/mmrBIW70p0d8=;
        b=pctPM32ruoHUammu/XLdYVlWOinynWNHV3Sur17v+Plywv76TBXL0EJ2Zf/4ZBUCS5
         GeBYkNCazkzaddP8h5rmWhvXmx8V8uDakdS10Zu3bAqe/ZXLU5Jh9TZfywAteGFxCBhl
         9po8pDSP7+Jjle+lkZeYNCJMfhPxnCuG0eM1c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=wdwRLsTeSTz8v++f1U1R7HyHhrg140dybqt2LR8O2OhslisE4Q5ibEHhkUioeTApMx
         +JvmKJ4oRQe013YLRptiWSqZOUyqSowQJIAST6x2Sh3L0aNAFQLf8SmLr1QS7HS0Gp0i
         nwl/3Xjpa2FsLIL7mzotnaQWt1vVDc+sF56ok=
Received: by 10.231.148.85 with SMTP id o21mr4918270ibv.26.1284321247221; Sun,
 12 Sep 2010 12:54:07 -0700 (PDT)
Received: by 10.231.178.139 with HTTP; Sun, 12 Sep 2010 12:54:07 -0700 (PDT)
In-Reply-To: <4C8D14F9.90705@borg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156046>

2010/9/12 Kent Borg <kentborg@borg.org>:
> Tor Arvid Lund wrote:
>> Ok, so if you call this on the cmd line, it should output sha1's on
>> all commits that will be submitted (in reverse order) to p4. If it
>> doesn't, this may well be a good place to dig for a solution.
>
> It does output the commits it wants to submit. =C2=A0In my broken cas=
e far
> too many.
>
> I created a simple working case to see what working looks like, and t=
he
> exact same command outputs just the one commit. =C2=A0Looking more ca=
refully
> at my gitg pictures in the good and bad cases, I realize that I in th=
e
> broken case I probably don't have the graph I need.
>
>
> Good case:
>
> =C2=A0(master)
> =C2=A0 |
> =C2=A0(p4/HEAD) =C2=A0(p4/master)
> =C2=A0 |
> =C2=A0initial test import from existing depot
>
>
> Bad case:
>
> =C2=A0(master) =C2=A0 trivial change I am trying to submit
> =C2=A0 |
> =C2=A0(tmp) =C2=A0commit with the "[git-p4: depot-paths =3D "//depot/=
[...blah
> blah...]": change =C2=A0=3D 160991]" string at the end of the descrip=
tion
> =C2=A0 |
> =C2=A0Merge remote branch 'p4/master'
> =C2=A0 | \
> =C2=A0 | =C2=A0(p4/HEAD) =C2=A0(p4/master) =C2=A0a commit that is rea=
l work
<snip>

Hmm.. Let's define a "commit that contains that [git-p4:
depot-paths=3D...] stuff" as a git/perforce commit. Then I would say
that p4/master should always point to the most recent git/perforce
commit. In your "Bad case", it seems that it doesn't do that, because
the most recent git/perforce commit is (tmp).

When messing about with git-p4 I have sometimes messed up that
p4/master ref myself. I can normally fix it by setting it manually: In
git, all existing branches are simply files with a sha1 in them (or
symbolic refs that point to other refs, like "ref:
refs/heads/master"). You should thus be able to put the sha1 of your
(tmp) commit into refs/remotes/p4/master.

You could try that and see if git rev-list gives the expected result.

> I think my understanding of merges and rebases needs more depth...and=
 I
> think I have mangled branches.
>
>
> I tried a checkout of master and a "git rebase remotes/p4/master" and
> that produced thousands of conflicts. =C2=A0Was that due to my initia=
l Linux
> sources put in on the Perforce side?

Well, when you do that, git will look back until it finds a common
ancestor commit of master and p4/master. I am guessing, that a common
ancestor for those branches does not exist in your case... If my guess
is correct, git will go back to the beginning of master (to linux
2.6.12-rc2) and try to apply each of those commits on top of
p4/master. Naturally, that will cause a world of pain and conflicts ;)

-Tor Arvid-
