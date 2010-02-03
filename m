From: demerphq <demerphq@gmail.com>
Subject: Re: extra headers in commit objects
Date: Wed, 3 Feb 2010 20:01:17 +0100
Message-ID: <9b18b3111002031101p3385ecdfo638433bc269791aa@mail.gmail.com>
References: <20100203174041.GC14799@spearce.org>
	 <alpine.LFD.2.00.1002031311010.1681@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git <git@vger.kernel.org>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Wed Feb 03 20:01:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NckU3-0000mC-JZ
	for gcvg-git-2@lo.gmane.org; Wed, 03 Feb 2010 20:01:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757557Ab0BCTBV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Feb 2010 14:01:21 -0500
Received: from mail-bw0-f219.google.com ([209.85.218.219]:52706 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756905Ab0BCTBT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Feb 2010 14:01:19 -0500
Received: by bwz19 with SMTP id 19so380829bwz.28
        for <git@vger.kernel.org>; Wed, 03 Feb 2010 11:01:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=1TUnsEbD0jEV6TWRl+7pr2L92nZwFS+tLjiMOqFLGHM=;
        b=phIZrsnTtjTGJeasd7MAa03hW8veuUEujXQMa4DHn+JUa0t3UTcq1fIihZl37lqykj
         h4yYWB2WBAQlEd94pCVe8QsO4CMN9biMrGecSabm7SZr+6Lj9CgGhf2PPdnJnXER3x7I
         HuT2LzECMglZEotqs37RdDAyAshh3UqoSK0YY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=bEAYZBCkDwTwNdZJJ0mKw+zakBhnsaw4wfN4ZSFdDMQUy4nxn4EbO+DX235lnmNWqr
         MA69eObXteja6KdKy1kFuk6abkdhBYXadfMrR+k5lrL7/YToYOcFv4IeLyHH+t1twY2l
         6CUQGWEd4WI3be5GZkB75eZdjjjuC2fFlfFKM=
Received: by 10.239.188.133 with SMTP id p5mr806821hbh.100.1265223677576; Wed, 
	03 Feb 2010 11:01:17 -0800 (PST)
In-Reply-To: <alpine.LFD.2.00.1002031311010.1681@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138864>

On 3 February 2010 19:15, Nicolas Pitre <nico@fluxnic.net> wrote:
> On Wed, 3 Feb 2010, Shawn O. Pearce wrote:
>
>> Am I correct that core C developers are still under the opinion
>> that extra headers in a commit object aren't encouraged?
>
> I would say so.
>
> [...]
>> At the end of the day, is it a bug that C git doesn't support
>> working with extra commit headers? =A0IMHO, no, because, we've
>> rejected these in the past, and its not part of the Git standard.
>> And other implementations shouldn't be trying to sell it that way.
>
> Agreed. =A0And this was discussed in great length on this list on few
> occasions already (probably more than a year back).

One problem, is that if you take the approach you say then you
basically guarantee that a new git that DOES add new headers will
break an old git that doesnt know about the headers, and actually
doesnt care about them either.

So it would essentially mean that if you ever have to change the
commit format you will be in a position where new git commits will be
incompatible by design with old git commits.

Maybe I misunderstand, but this doesnt seem to accord with my reading
of the original design objectives and philosophy of git.

Shouldn't an old git just ignore headers from a new git?

I mean, forget about the fact that somebody is doing something naughty
with the git protocol, ask youself if you want this rule to basically
prevent any backwards compatible changes with older gits.

As a lurker here I understand completely if you ignore this mail
entirely. But this seems to me to be a decision that could bite you
later.

cheers,
Yves





--=20
perl -Mre=3Ddebug -e "/just|another|perl|hacker/"
