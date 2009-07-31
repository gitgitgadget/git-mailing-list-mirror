From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: From P4 to Git
Date: Fri, 31 Jul 2009 13:14:40 +0200
Message-ID: <81b0412b0907310414x7157fecey947da960ff8be1cc@mail.gmail.com>
References: <85ljm84lat.fsf@oqube.com> <m3fxcg3473.fsf@localhost.localdomain>
	 <85r5vxbd8e.fsf@oqube.com> <200907311122.43918.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Arnaud Bailly <abailly@oqube.com>, git@vger.kernel.org,
	Sam Vilain <sam@vilain.net>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 31 13:14:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MWq4Y-0002hC-E9
	for gcvg-git-2@gmane.org; Fri, 31 Jul 2009 13:14:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752487AbZGaLOm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 31 Jul 2009 07:14:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751920AbZGaLOm
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Jul 2009 07:14:42 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:56034 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751885AbZGaLOl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 31 Jul 2009 07:14:41 -0400
Received: by bwz19 with SMTP id 19so1126679bwz.37
        for <git@vger.kernel.org>; Fri, 31 Jul 2009 04:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=JXG4qbKRCoYAmge84LCKCI1owRY+SWIhOUk2VVdtD6Y=;
        b=mBs/0tZlq2bu8p51sRLqfNybMcp++5oCodjrvEPOM2InmwtmQPn1SelvOr96zedmeZ
         kWWGicmOVlAcvz7+Xnlzahk4+Yd9M/bN25mPMrmNHu/SiL+vJ/PwCCa9xyT6+mAb+3XY
         8I7CHzkw6gftKLpjWA72brzPhuFQD6uA+QZSc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=LXVNZefVVxSJedMq/VZVWf1DCd55W0K5gW88rCj+Gann/ti4vnq3ou1n3PM81QcTPS
         zS6rTNK+O8NEkNnpMvq7J0pttVCdjaBwva3RVB1gfv7ruw/K88nmUSfKEE9VfO2fX7go
         Uzx95UpMIvkoDmNmnCZ3p+udkpIzku4GqBcVA=
Received: by 10.204.124.19 with SMTP id s19mr2719541bkr.6.1249038880433; Fri, 
	31 Jul 2009 04:14:40 -0700 (PDT)
In-Reply-To: <200907311122.43918.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124543>

On Fri, Jul 31, 2009 at 11:22, Jakub Narebski<jnareb@gmail.com> wrote:
>> That's my biggest concern. We are actually using a single tree repos=
itory
>> approach with lot of branches. What led me to Git at first was the e=
ase
>> of branching and merging. I used branching and merging with Subversi=
on
>> and its painful.
>
> So it looks like you wouldn't _need_ to split source tree into separa=
te
> smaller repositories for performance reasons. =C2=A0Still it might be=
 good
> idea to put separate (sub)projects into separate repositories. =C2=A0=
But
> I guess you can do that even at later time (although it would be best
> to do this upfront).

It looks like they use P4 branches. Which are NOT branches as Git
understands it (a line of history). The P4 "branches" are just director=
ies
with some metadata regarding recording where the data in the directory
were before an act of "branching" (just a server-side recursive copy).

In this case (and this must be, as there are no other branches in P4),
they'll have to split their repository.
