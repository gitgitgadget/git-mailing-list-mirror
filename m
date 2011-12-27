From: Dov Grobgeld <dov.grobgeld@gmail.com>
Subject: Re: Git beginner - Need help understanding
Date: Tue, 27 Dec 2011 08:34:34 +0200
Message-ID: <CA++fsGHPKhzfd7-KohOZ4WpYatx_-EW0bjq46zwswbu8TomHCg@mail.gmail.com>
References: <1324955537875-7129186.post@n2.nabble.com>
	<CA++fsGGEv=jS4YNEUCxTwZ3pZc7HbbmoPbDH+MamrqamxrsADA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: chirin <takonatto@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 27 07:34:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RfQci-0004W6-Qv
	for gcvg-git-2@lo.gmane.org; Tue, 27 Dec 2011 07:34:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751329Ab1L0Geg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 27 Dec 2011 01:34:36 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:33719 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751278Ab1L0Gef convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Dec 2011 01:34:35 -0500
Received: by iaeh11 with SMTP id h11so19929788iae.19
        for <git@vger.kernel.org>; Mon, 26 Dec 2011 22:34:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=MuNk7K179Rl2oEFmDG0BTxjwuZK/Zqm5AB9hhOAKcgA=;
        b=Jb+mXxgTN/tUFNZ7EClgS1BOMtC2jUJ/lX+eGTTKmHaUKnHhXZCM55bwCfmuUH2cIX
         J7vWmT7dnK3KEtTkRV2/RiOnGrLcyFI5eKcHiNNaqm4sbQoBbE4ODiYMB5ocScubmLfK
         cQJZ8JKUPG7GvpACV7Zks1X0iA+3zITA2ppXk=
Received: by 10.50.219.234 with SMTP id pr10mr29115142igc.27.1324967674955;
 Mon, 26 Dec 2011 22:34:34 -0800 (PST)
Received: by 10.231.149.194 with HTTP; Mon, 26 Dec 2011 22:34:34 -0800 (PST)
In-Reply-To: <CA++fsGGEv=jS4YNEUCxTwZ3pZc7HbbmoPbDH+MamrqamxrsADA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187708>

The best way of understanding and also of asking questions, is if you
can reproduce the steps of exactly what you want and don't understand
by a sequence of commands like so:

 =C2=A0=C2=A0=C2=A0 # First create a bare repository
 =C2=A0=C2=A0=C2=A0 mkdir R
 =C2=A0=C2=A0=C2=A0 cd R
 =C2=A0=C2=A0=C2=A0 git init --bare .

 =C2=A0=C2=A0=C2=A0 # Clone it into A
 =C2=A0=C2=A0=C2=A0 git clone R A

 =C2=A0=C2=A0=C2=A0 # Clone it into B
 =C2=A0=C2=A0=C2=A0 git clone R B

 =C2=A0=C2=A0=C2=A0 # Now start doing changes for A and B, pulling and =
pushing into R
 =C2=A0=C2=A0=C2=A0 cd A
 =C2=A0=C2=A0=C2=A0 echo "Change #1" > hello.txt
 =C2=A0=C2=A0=C2=A0 git add hello.txt
 =C2=A0=C2=A0=C2=A0 git commit -m 'Commit #1'
 =C2=A0=C2=A0=C2=A0 git push origin master

 =C2=A0=C2=A0=C2=A0 # Get into B
 =C2=A0=C2=A0=C2=A0 cd ../B
 =C2=A0=C2=A0=C2=A0 git pull
 =C2=A0=C2=A0=C2=A0 echo "Change #2" >> hello.txt
 =C2=A0=C2=A0=C2=A0 git commit -a -m 'Commit #2'
 =C2=A0=C2=A0=C2=A0 git push

 =C2=A0=C2=A0=C2=A0 # Get into A and pull the changes done by B
 =C2=A0=C2=A0=C2=A0 cd ../A
 =C2=A0=C2=A0=C2=A0 git pull

In this sequence, which fulfills the scenario that you described,
there are no conflicts. So I suggest that you try to change the
command sequence to illustrate what you don't understand and ask
again.

 Regards,
 Dov



 On Tue, Dec 27, 2011 at 05:12, chirin <takonatto@gmail.com> wrote:
>
> I'm just beginning to use Git in my workplace, and (rather shamefully=
) have
> never heard of Git until now. While I pore over the stacks of documen=
tations
> for beginners, could someone help me understand this issue I've been =
having?
>
> Every time a colleague updates a file, I would not be able to pull du=
e to
> merge conflicts - even though I have never made any changes to the
> repository. I'd try =C2=A0and then =C2=A0again, but it would still gi=
ve the same merge
> conflict. The only way I could pull currently is to do a git commit (=
even
> without changes), and then git pull.
>
> If this was SVN, I could simply resolve this with Update. What am I m=
issing,
> and what should I be looking for?
>
> Thanks in advance..
>
> --
> View this message in context: http://git.661346.n2.nabble.com/Git-beg=
inner-Need-help-understanding-tp7129186p7129186.html
> Sent from the git mailing list archive at Nabble.com.
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
