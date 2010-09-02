From: Thiago Farina <tfransosi@gmail.com>
Subject: Re: [PATCH] help.c: Pull cmd_version out of this file.
Date: Wed, 1 Sep 2010 22:16:53 -0300
Message-ID: <AANLkTim1tyTQEUHHo-AuF789v72ag=waqC_V5K77VS2a@mail.gmail.com>
References: <2ae543604216146b742253584d8393c5e3179697.1283114573.git.tfransosi@gmail.com>
	<20100830023812.GA4010@burratino>
	<20100830024020.GB4010@burratino>
	<AANLkTimDjRz=JmiVn+ybQ5ewaj=7N5tp48fUArD5vG_H@mail.gmail.com>
	<7v1v9e803a.fsf@alter.siamese.dyndns.org>
	<AANLkTinHJHzcoFFjv-TaQ+DYVyqn46fqA802m8Lq5anp@mail.gmail.com>
	<7v39tt552b.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 02 03:17:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OqyQJ-0007JO-If
	for gcvg-git-2@lo.gmane.org; Thu, 02 Sep 2010 03:17:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753910Ab0IBBQz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 1 Sep 2010 21:16:55 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:61072 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751204Ab0IBBQz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Sep 2010 21:16:55 -0400
Received: by qwh6 with SMTP id 6so7020504qwh.19
        for <git@vger.kernel.org>; Wed, 01 Sep 2010 18:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=S5Qh7FzEO8WbEjb4vC4rfDbmqwh55mdkePazn+T2X08=;
        b=FDRc/6c7KdAqxagLTN+3C7vxU4SfAFn7t8Bd0U7aa5/jq/zRv1BAL3Krwk0hFfWdsO
         8GFdPhj/rPtdE5BPv66yXvdhHOhSPzMb1hG4fYcdshRYHPxvRWg8QfIGaebqolkNZfJJ
         a3ySJbIiMrQimbNvkFeudhfWMqkEjT4iUjKGQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=P8Kmng5UUHjRWzuberngGvEzlP4OFfw3bgWqbE1HFGQWwFVzHXUE9p3UnEy7itLfS4
         mCvh0RER+HWfSb5eg7xMjmBK4fkAwtH7pueoXgru1Nd19bXENFcEwISbWPacOLJ0D8U3
         iBHl5IG1ttWxf7i2cSkU7sQl3cPBicbxhTktI=
Received: by 10.229.247.16 with SMTP id ma16mr6484519qcb.90.1283390214117;
 Wed, 01 Sep 2010 18:16:54 -0700 (PDT)
Received: by 10.229.245.202 with HTTP; Wed, 1 Sep 2010 18:16:53 -0700 (PDT)
In-Reply-To: <7v39tt552b.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155100>

On Wed, Sep 1, 2010 at 10:04 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Thiago Farina <tfransosi@gmail.com> writes:
>
>>>risk causing broken builds?
>> Hum, how such trivial change can cause that?
>
> Imagine if we had this in help.c:
>
But we don't have.

> =C2=A0 =C2=A0 =C2=A0 =C2=A0int cmd_version(int argc, const char **arg=
v, const char *prefix)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0printf("git ve=
rsion %s\n", GIT_VERSION);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>
> which were compiled with this rule in Makefile:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0help.o: help.c GIT-VERSION-FILE
>
But it's not.

> and then you moved the function to a new file without touching the
> dependency.
That would be a mistake no?

> =C2=A0Especially because the change is trivial (just moving a
> function from here to there), you don't immediately notice the broken
> dependency.
>
As far as I know that does not go unnoticed.


> I just spent 15+ minutes explaining this to you (and another 10+ minu=
tes
> checking that the above is _not_ the actual case before giving the sa=
me
> explanation to you last night).
Thanks for being so careful.

> =C2=A0Now is this still a trivial change that
> costs nothing?
>
Why you impose so much obstacles to a trivial change like this?

>>>What did we gain through this exercise? =C2=A0Did we fix any real pr=
oblem?
>> All patches should just fix real problems?
>
> There is a "cost vs benefit" ratio you need to consider.
>
Thanks.
