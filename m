From: Reece Dunn <msclrhd@googlemail.com>
Subject: Re: Running 'git pull' from an unnamed branch
Date: Mon, 6 Apr 2009 13:04:39 +0100
Message-ID: <3f4fd2640904060504y452cd8a1pbb9170cd7a357e47@mail.gmail.com>
References: <3f4fd2640904051433u199587c3wc9bf080d138944e7@mail.gmail.com>
	 <7v3acmoalw.fsf@gitster.siamese.dyndns.org>
	 <3f4fd2640904060042m438a3a8en2d2746a6216b2b95@mail.gmail.com>
	 <20090406100305.GD20356@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: =?ISO-8859-1?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Mon Apr 06 14:07:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lqnah-0002yE-5X
	for gcvg-git-2@gmane.org; Mon, 06 Apr 2009 14:06:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755901AbZDFMEo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Apr 2009 08:04:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755329AbZDFMEn
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Apr 2009 08:04:43 -0400
Received: from fg-out-1718.google.com ([72.14.220.153]:58249 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755200AbZDFMEm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Apr 2009 08:04:42 -0400
Received: by fg-out-1718.google.com with SMTP id e12so779011fga.17
        for <git@vger.kernel.org>; Mon, 06 Apr 2009 05:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=UZdI/I+d3uz1TZNZrx/R43asHczrPtwKzlc7Ckdvjh8=;
        b=kqAbr1APINosmAhUTEWxPx4KYeGX9gfqBHTlT/8AVc5n/6M9Db/t/GGQv+gmerW9CJ
         AW0V2AOuYToQQAMJkrqq+nmHG1q0OiQgAAmNONh5pne1kvJsC6LWM9guoUmq/JjYtfJr
         l301XRvPYMl4xnTi6w8V7Fh6j5UCVzg8xhOVM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=DHH0OdVu7BAOq8T/T6JMFrTSSNuk2m5GfnVcPL/XDfWR+fkF6A3/v+u9XawG1+/iN0
         cU7PunrmqWzukjqcEq484lqlKiWaa5uARUXTYzeh+aCza6K5vA4WaIEyvJn9RtuHyDoB
         5y71Z1HNDCnj/b2WzmsGDWvlLDWdFKZTRJijs=
Received: by 10.239.156.193 with SMTP id n1mr99336hbc.43.1239019479070; Mon, 
	06 Apr 2009 05:04:39 -0700 (PDT)
In-Reply-To: <20090406100305.GD20356@atjola.homenet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115810>

2009/4/6 Bj=F6rn Steinbrink <B.Steinbrink@gmx.de>:
> On 2009.04.06 08:42:16 +0100, Reece Dunn wrote:
>> 2009/4/6 Junio C Hamano <gitster@pobox.com>:
>> > Reece Dunn <msclrhd@googlemail.com> writes:
>> >
>> >> diff --git a/git-pull.sh b/git-pull.sh
>> >> index 8a26763..00a72dd 100755
>> >> --- a/git-pull.sh
>> >> +++ b/git-pull.sh
>> >> @@ -97,6 +97,10 @@ error_on_no_merge_candidates () {
>> >> =A0 =A0 =A0 echo "try again (e.g. 'git pull <repository> <refspec=
>')."
>> >> =A0 =A0 =A0 echo "See git-pull(1) for details on the refspec."
>> >> =A0 =A0 =A0 echo
>> >> + =A0 =A0 echo "You may not be on a branch. In this case, you nee=
d to move"
>> >> + =A0 =A0 echo "onto the branch you want to pull to (usually mast=
er):"
>> >> + =A0 =A0 echo " =A0 =A0git checkout <branch>"
>> >> + =A0 =A0 echo
>> >
>> > I do not think that is necessarily what the user wanted to hear. =A0=
Often I
>> > create trial merges on a detached HEAD when I hear a pull-request =
from
>> > others (I have a few work trees that share the repository with my =
primary
>> > working area, made with contrib/workdir/git-new-workdir script, an=
d their
>> > HEAD are typically detached at the tip of the master), and in such=
 a use
>> > case, the first line of the instruction in the context in your pat=
ch is
>> > the right thing to give. =A0I do not want to have the resulting tr=
ial merge
>> > anywhere on my real branches, and do not want to be told to switch=
 to any
>> > of them.
>> >
>> > We really should teach people, especially the new ones early on, t=
hat "git
>> > push" and "git pull" are meant to be told where-to/from and what, =
and how
>> > to drive these commands with explicit arguments, before letting th=
em rely
>> > on the default configuration blindly without understanding the und=
erlying
>> > concepts.
>>
>> Ok, so how about something like:
>>
>> "You may not be on a branch. Because of this, you need to specify
>
> This should not say "may", either you are or you are not on a detache=
d
> HEAD, and git can tell that, so it should not let the user have to
> guess.
>
>> where you are pulling from and to. See git-pull(1) for how to do thi=
s.
>> Alternatively, you can move to a named branch using:
>> =A0 =A0 git checkout <branch>"
>
> Checking out a named branch won't solve the "problem" on its own.
> Consider this:
>
> git checkout origin/foo
> =A0 *do stuff*
>
> git pull
> =A0 *Oh! I need a named branch*
>
> git checkout -b foo
> git pull
> =A0 *Still fails*
>
> Maybe:
> You asked me to pull without telling me which branch you want to merg=
e
> with and as you have no branch checked out, I cannot look for any
> defaults to use. Please name which branch you want to merge on the
> command line and try again (e.g. 'git pull <repository> <refspec>'). =
See
> git-pull(1) for details on the refspec.

Sounds reasonable. I'll update the patch and resubmit later on today.

> That just adjusts the "you can set some defaults" part, replacing it
> with a message telling that a detached HEAD cannot have any defaults.
> Without implying anything about how the user might want to work, but
> giving a hint that a branch can have defaults for "git pull".
>
> Bj=F6rn

- Reece
