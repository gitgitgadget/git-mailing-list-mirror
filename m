From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [PATCH] Add "list" and "rm" sub commands to tg-depend
Date: Thu, 9 Apr 2009 19:34:06 +0200
Message-ID: <36ca99e90904091034m4d4d31dct78acb333612e678@mail.gmail.com>
References: <20090407133329.57b06727.weiny2@llnl.gov>
	 <20090408080824.GF8940@machine.or.cz>
	 <20090408083955.GA28482@pengutronix.de>
	 <20090408091949.8a648d83.weiny2@llnl.gov>
	 <20090409124337.GA6034@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ira Weiny <weiny2@llnl.gov>,
	Brian Behlendorf <behlendorf1@llnl.gov>,
	Git Mailing List <git@vger.kernel.org>
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
	<u.kleine-koenig@pengutronix.de>
X-From: git-owner@vger.kernel.org Thu Apr 09 19:36:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LryAb-0004YT-Qf
	for gcvg-git-2@gmane.org; Thu, 09 Apr 2009 19:36:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757480AbZDIReM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 9 Apr 2009 13:34:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756751AbZDIReK
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Apr 2009 13:34:10 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:35012 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756856AbZDIReI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Apr 2009 13:34:08 -0400
Received: by fxm2 with SMTP id 2so699866fxm.37
        for <git@vger.kernel.org>; Thu, 09 Apr 2009 10:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=A2LO+oVStjpZ9dJ8twQq6YQbSIWXW13X2BsBmRmA+jc=;
        b=cRK0HryBr9JWPVQEm2bdpJV3HX+f2Hxq7ToDSGY6EBLUlhTfDOCPexWC7SZvlhomPJ
         xvfCENvLw7OlANPTefXuMPbcumVZ+qZajp2Iq8FHPxX3nLzO5ShcclSOc8KLtAMvW1un
         hguX6fILD+iZh+vCURDhLi3KWX4NpwKj2aiac=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=nkNSTNG+bX2b5Xf3n1qNtyiv9ri7KQ8a9OHsKV+x6ED1AVUSXYGPyWx8KmohSKdOWE
         OVuMp5OuP71TolM+/+85SB1wbt7jtMlQyOmt5xMqEULO7LDgPCc7ZLDIEyD02s0TbYZa
         01AwttI7fixL+S80XMO7770CrkpZzC4OkxISk=
Received: by 10.223.116.77 with SMTP id l13mr842285faq.106.1239298446074; Thu, 
	09 Apr 2009 10:34:06 -0700 (PDT)
In-Reply-To: <20090409124337.GA6034@pengutronix.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116186>

2009/4/9 Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>:
> Hello Ira,
>
> On Wed, Apr 08, 2009 at 09:19:49AM -0700, Ira Weiny wrote:
>> On Wed, 8 Apr 2009 10:39:55 +0200
>> Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de> wrote:
>>
>> > Hello,
>> >
>> > On Wed, Apr 08, 2009 at 10:08:24AM +0200, Petr Baudis wrote:
>> > > > I tried to update the tg-depend.txt but it was listed in the .=
gitignore? =C2=A0I suspect that is because it is stored somewhere else?=
 =C2=A0I have attached a new version of that file as well. =C2=A0(Sorry=
 it is not in the patch.)
>> > tg-$command.txt is created by spliting README.
>>
>> Cool, thanks.
> You're welcome. =C2=A0I'm glad you're sending patches.
>
>> > > > + =C2=A0 =C2=A0 =C2=A0 fi
>> > > > + =C2=A0 =C2=A0 =C2=A0 TMPFILE=3D`mktemp` || exit 1
>> > > > + =C2=A0 =C2=A0 =C2=A0 echo $TMPFILE
>> > > > + =C2=A0 =C2=A0 =C2=A0 grep -v public-ibmad-port $root_dir/.to=
pdeps > $TMPFILE
>> > public-ibmad-port?
>>
>> Ok, I am pretty stupid for this one, sorry.
> np
>
>> > > > + =C2=A0 =C2=A0 =C2=A0 mv $TMPFILE $root_dir/.topdeps
>> > > > +else
>> > > > + =C2=A0 =C2=A0 =C2=A0 echo "$name" >>"$root_dir/.topdeps"
>> > > > +fi
>> > > > +
>> > > > +## commit it and update this branch
>> > > > =C2=A0git add -f "$root_dir/.topdeps"
>> > > > =C2=A0git commit -m"New TopGit dependency: $name"
>> > > > =C2=A0$tg update
>> > > > --
>> > > > 1.5.4.5
>> > I don't think the patch is correct. =C2=A0Just removing a branch f=
rom
>> > .topdeps is not enough.
>> >
>> > Did you try to export the tg-branch? =C2=A0The result will be that=
 the patch
>> > for that you deleted the dependency has the deleted change folded =
in.
>>
>> Indeed you are correct. =C2=A0It was working for me because I was mo=
ving a node
>> from one place to another. =C2=A0But the new location was still an a=
ncestor of the
>> dependency which was removed. =C2=A0I still think this can be automa=
ted but I will
>> have to work on it.
> So you mean that rm should only work if the patch is still a dependen=
cy?
>
> You might want to check
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0http://thread.gmane.org/gmane.comp.version=
-control.git/114581
>
> before investing time to implement it. =C2=A0(I cc:d Bert Wesarg.) =C2=
=A0If you
> had posted to git@vger.kernel.org Bert might have seen your mail alon=
e.
> (hint hint)
Uwe,

thanks for the Cc.

I really can't reconstruct this thread, could some one send me the
original patch. My interest is this, that I implemented a tg-prev
(lists all deps from given topic), tg-next (lists topics depending on
the given topic), and a tg-tsort (which gives a topological list of
dependencies, which is a little outdated after the --graphviz option)

The original message seems lost in the archive, the comments are still =
there:

http://thread.gmane.org/gmane.comp.version-control.git/96483

I can send an update on this.

I think the first two commands could be added as sub-commands to
tg-depend, with bash completion you don't need to type that much
nowadays.

As I said to tg-tsort, its probably outdated because of the graphviz
output, but may still provide valid information.  Btw. does anyone
know a console output driver for the graphviz tools, i.e. dot and co?

Bert

>
> Best regards
> Uwe

PS: Finally added git list to Cc:
