From: Chris Packham <judge.packham@gmail.com>
Subject: Re: git fast-export/fast-import *facepalm*
Date: Thu, 27 May 2010 14:57:06 -0700
Message-ID: <AANLkTik9QxiAjZHigx0YS5ybZwj6U7l0fK-byUmBirnO@mail.gmail.com>
References: <AANLkTinV5mEACphA-nW9URce0Mh9xyu3UjWmfBqL6cLN@mail.gmail.com>
	<20100527210328.GN16470@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: GIT <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu May 27 23:57:25 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OHl4o-0003Dw-5I
	for gcvg-git-2@lo.gmane.org; Thu, 27 May 2010 23:57:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933056Ab0E0V5N convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 27 May 2010 17:57:13 -0400
Received: from mail-qy0-f183.google.com ([209.85.221.183]:65125 "EHLO
	mail-qy0-f183.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932994Ab0E0V5M convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 May 2010 17:57:12 -0400
Received: by qyk13 with SMTP id 13so686513qyk.1
        for <git@vger.kernel.org>; Thu, 27 May 2010 14:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=WrzG0IrUXH7k3mkdY+GtNATlFhP9xCDSRpj/guz30Wg=;
        b=aMD5vHVHuo9RKp58oVosFcBBDHmSJKPjcEWCKxBwEQ7chd4zz+4Ko6CHrsmj+xRnXw
         KlNye2qzyx0mXZKG4+xogq0pyBCovJuN4vZGrFPj0ajg1fgd10vmZ7vG1sc9+iqlUQEi
         Ybwz+gGMQkWqB9e5RHZvoaVU003jdWlIgeb10=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=akM58Huu/lHBxdMo/un2mbXI2a1Nv4sH5A7SV1YoIgObrdFm4CUVXgH+/jVrYxVJz2
         6X9QrvvKeStS5DXQz5E7fsXPc8/N9btkTTp51lo+BZeKSXppwv5SX0YKOo+SDkXXCZ8F
         FCKFaSPo9VKfsheR9fshDDYtfrbGp2asZN1UQ=
Received: by 10.224.19.9 with SMTP id y9mr6092993qaa.353.1274997427606; Thu, 
	27 May 2010 14:57:07 -0700 (PDT)
Received: by 10.229.26.74 with HTTP; Thu, 27 May 2010 14:57:06 -0700 (PDT)
In-Reply-To: <20100527210328.GN16470@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147901>

On Thu, May 27, 2010 at 2:03 PM, Shawn O. Pearce <spearce@spearce.org> =
wrote:
> Chris Packham <judge.packham@gmail.com> wrote:
>> What I've ended up with is a repository with a detached set of chang=
es i.e
>>
>> o -o =C2=A0 l - l - l - l - l - l =C2=A0 =C2=A0 o - master
>> =C2=A0 =C2=A0 =C2=A0\ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/
>> =C2=A0 =C2=A0 =C2=A0 o - o - o - o - o - o
>>
>> o =3D our commits
>> l =3D linux commits
>>
>> Because the code is common textually I think what I really should ha=
ve done is
>>
>> (cd linux-2.6.32.y; git format-patch v2.6.32.12..v2.6.32.14) | git a=
m
>>
>> Which I'll give a try in a minute. In the meantime is there anyway f=
or
>> me to safely remove the upstream linux commits without loosing our
>> commits in the process?
>
> If I read your diagram right, the l-l-l chain isn't connected at
> all to your graph, so it should just get removed with `git gc`.
>

Well it _looks_ detached in gitk I can't see any merge commits. I've
tried git gc but no joy. Maybe I need to tell it to be a bit more
thorough.

> But if it is connected due to a merge with your master, lookup the
> merge and find its parent which is your local stuff and `git reset
> --hard` to that commit.
>
> --
> Shawn.
>
