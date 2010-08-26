From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [RFD PATCH 00/32] subtree clone v2
Date: Thu, 26 Aug 2010 14:45:35 +1000
Message-ID: <AANLkTinZk-cF6ksN2UhAyHNwJAS=fm6eLKJEP+evdJGU@mail.gmail.com>
References: <1282688422-7738-1-git-send-email-pclouds@gmail.com>
	<20100824223741.GB2376@burratino>
	<AANLkTikipryFVf_XvvbHopWSo5Ey_mvgTevY2NAvhygQ@mail.gmail.com>
	<AANLkTinsNvVup43B6nQtU6dvJy789n8kQm6N6na0J9oa@mail.gmail.com>
	<AANLkTikkybj784PHoVCkVZyxo40q6BhdkOzFho-xBS6G@mail.gmail.com>
	<AANLkTikOtinR1EjzrzMqzR8Pn2hpDRVJrWDmx5b5tGQ_@mail.gmail.com>
	<AANLkTi=02T+60AjJON8MFt7DSbtA=bx39YKigZHq_b_u@mail.gmail.com>
	<AANLkTinQYfpWYJ8Lr3=VX+x2Xj+eQfYztT1GHh2AQKff@mail.gmail.com>
	<AANLkTi=3tGf=Gw6SnRLOSaURw7JX=qEPtLCzLhZN1D+y@mail.gmail.com>
	<AANLkTinH8UWbkCUBFa1yr1fOQJgs9rLOj_kcp2UR3iua@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>, git <git@vger.kernel.org>
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 26 06:46:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OoULb-0007ui-No
	for gcvg-git-2@lo.gmane.org; Thu, 26 Aug 2010 06:45:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753015Ab0HZEph convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 26 Aug 2010 00:45:37 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:44543 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751103Ab0HZEpg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 Aug 2010 00:45:36 -0400
Received: by wwb28 with SMTP id 28so1009221wwb.1
        for <git@vger.kernel.org>; Wed, 25 Aug 2010 21:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=emwz92sbpeBfRMgHOVohoKEVnheYxPOeJBaq0udRQjI=;
        b=wGOKxEavZLkJGHT/6Ta/GCQXSfXP7nPFz/phMLSBVhJc8/deLYvPHYEjrkJ0Q6kcdb
         4sYRjciWEIJEsOu98W4NcxARV6ubyYFFEKLh948vgrBOYTwoV4zDON5AvzMF6N1wiRol
         UIeHMXY+Mx3RjHblIiTc5KobKNSImEKcK/JG0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=EDFn5g5ueXvZ25aR+YYZ6PHx295i7OoLHOxXnCQX7w6n3GiIE5kZxTQdcZ5Ev9q2W6
         pje3izq7sSaq16IXtLC2fs2MnyqVQ7OzatBAzcOA3GL7QZNpvfFiRD7//SCwNmghrCgJ
         RDRy24NMzpcc/YZ6SBhkpNOEWn4rRFVF71+yE=
Received: by 10.216.11.202 with SMTP id 52mr8327326wex.28.1282797935519; Wed,
 25 Aug 2010 21:45:35 -0700 (PDT)
Received: by 10.216.184.17 with HTTP; Wed, 25 Aug 2010 21:45:35 -0700 (PDT)
In-Reply-To: <AANLkTinH8UWbkCUBFa1yr1fOQJgs9rLOj_kcp2UR3iua@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154507>

On Thu, Aug 26, 2010 at 2:39 PM, Elijah Newren <newren@gmail.com> wrote=
:
> On Wed, Aug 25, 2010 at 9:52 PM, Nguyen Thai Ngoc Duy <pclouds@gmail.=
com> wrote:
>> Let's say in "ancestor" tree, we have
>>
>> t1/f0
>> t2/t3/f0
>>
>> In "you" tree, we have
>>
>> t1/f0
>> t2/t3/f0
>> t2/t3/f1
>>
>> In "upstream" tree, we have
>>
>> t1/f0
>> t2/t3/f0
>> t2/t3/f2
>>
>> The narrow tree is t1, so we the trees we have are toplevel tree and
>
> How would you get the "you" tree? =C2=A0Since you don't have the data=
 for
> t2 or t2/t3, there's no way you can create and commit this tree.

"you" tree does not create that file. It's been there. It's the
"ancestor" tree that did not have that file. So if you happen to
choose an "upstream" tree that git-merge-base would give you that
particular "ancestor" tree, we're in this situation.
--=20
Duy
