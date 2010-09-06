From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 00/17] Narrow clone v3 (was subtree clone)
Date: Mon, 6 Sep 2010 15:24:33 +1000
Message-ID: <AANLkTimyZfkMCFEeAX_Cpwscb0+EiZam0Hy0UBsB47C3@mail.gmail.com>
References: <1283669264-15759-1-git-send-email-pclouds@gmail.com>
	<AANLkTinNnm=Z=e_=P_auuNgSrDynt_P+FLiZgWeNNgps@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 06 07:24:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OsUCJ-0004wE-LQ
	for gcvg-git-2@lo.gmane.org; Mon, 06 Sep 2010 07:24:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751398Ab0IFFYf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Sep 2010 01:24:35 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:56354 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751119Ab0IFFYe convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Sep 2010 01:24:34 -0400
Received: by wyf22 with SMTP id 22so2522029wyf.19
        for <git@vger.kernel.org>; Sun, 05 Sep 2010 22:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Uo2QcU0ndc5fW0j3DvrWrUD5/vzNtQtZQYGsuzBPd8s=;
        b=iZlriUho6Kvu/AwdFjRRpxKf2Dk+jc+5qDa6h3+0QPUTQXR9GCV7f9jIeqot0HYbeA
         6UZEq/C1bBl726WiuO7hJynRYVZ54wAdW+yyMPnw31aT5UIdWnPHqxLxOfNvQ9gTJRvu
         4twfkUvMw8BHZSGvGsCjbHeqsNvheUicXk2Os=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=ZLimA5rfusyJS0sHg3g3X24mmpuMFvq5GSeXb7T/HPzyvERw+sjD4i7sGbw5zgpXEZ
         s25EcA42M32F/WjSWiW7PFhUWQzLDa4IzaVLlR4t3cdWT2Y1sT5EyAA1PvLAeGOf9sXz
         TvUHNWKRzEE+sx4ZEhW4EM4hLrCb/jd7VDYmg=
Received: by 10.227.135.211 with SMTP id o19mr2142833wbt.73.1283750673567;
 Sun, 05 Sep 2010 22:24:33 -0700 (PDT)
Received: by 10.216.184.17 with HTTP; Sun, 5 Sep 2010 22:24:33 -0700 (PDT)
In-Reply-To: <AANLkTinNnm=Z=e_=P_auuNgSrDynt_P+FLiZgWeNNgps@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155529>

2010/9/6 Elijah Newren <newren@gmail.com>:
> Hi,
>
> 2010/9/5 Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com=
>:
>> I'll describe differences between this series and Elijah's one [1].
>> I think it's more interesting. Changes from v2 [2] will follow later=
=2E
>
> So, I downloaded your patches and even made sure to sort them
> appropriately to fix the order, but I'm getting conflicts trying to
> apply them (on top of current pu). =C2=A0What version did you base th=
em on?

b5442ca (was master in Aug 24) with en/object-list-with-pathspec
applied on top. Sorry I don't want to change my base too often so it's
quite old.

>> Things that won't work:
>>
>> =C2=A0- Shell scripts that use "git write-tree"
>
> Yeah, write-tree didn't work in mine either; I had to make it throw a=
n
> error. =C2=A0But wouldn't your idea to make a tree object (referenced=
 for
> sha1sums outside the sparse/narrow paths) part of the index allow eve=
n
> write-tree to work?

Definitely.

>> =C2=A0- only send commits that have changes in narrow area and graft=
 it at
>> =C2=A0 client side
>
> After reviewing more of your changes, and replacing various patches o=
f
> mine with yours, this is fairly high on my priority list as well
> (whereas fsck & prune are a bit lower). =C2=A0Maybe we can discuss id=
eas on
> tackling this when we start working on it. =C2=A0I've got some rough
> initial ideas (though I have no idea if they'll pan out); I'll see if
> I can write some of them up in the next day or two.

Well, looking forward to your fake commit implementation. I think it's
more or less the same as graft.
--=20
Duy
