From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Dropping '+' from fetch = +refs/heads/*:refs/remotes/origin/*?
Date: Thu, 1 Sep 2011 12:14:06 -0700
Message-ID: <CAJo=hJv55wVpgXjp4ZjiPSLahdPLS9TH+yWAd2ayf8wcHJFRGw@mail.gmail.com>
References: <7vliu8w25g.fsf@alter.siamese.dyndns.org> <7vhb4ww1id.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 01 21:14:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QzCif-0004Rg-9p
	for gcvg-git-2@lo.gmane.org; Thu, 01 Sep 2011 21:14:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757469Ab1IATO1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 1 Sep 2011 15:14:27 -0400
Received: from mail-yi0-f46.google.com ([209.85.218.46]:40691 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757297Ab1IATO1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 1 Sep 2011 15:14:27 -0400
Received: by yie30 with SMTP id 30so1652903yie.19
        for <git@vger.kernel.org>; Thu, 01 Sep 2011 12:14:26 -0700 (PDT)
Received: by 10.236.139.138 with SMTP id c10mr1325129yhj.62.1314904466151;
 Thu, 01 Sep 2011 12:14:26 -0700 (PDT)
Received: by 10.236.95.48 with HTTP; Thu, 1 Sep 2011 12:14:06 -0700 (PDT)
In-Reply-To: <7vhb4ww1id.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180564>

On Thu, Sep 1, 2011 at 11:39, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> Suggested reading:
>>
>> =A0 http://git-blame.blogspot.com/2011/08/how-to-inject-malicious-co=
mmit-to-git.html
>>
>> I am wondering if we are better off applying something along the lin=
es of
>> this patch, so that with the default configuration, users can notice=
 if
>> their upstream unexpectedly rewound their branches.
>>
>> It would produce
>>
>> =A0 =A0 =A0 [remote]
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 url =3D git://.../git.git/
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 fetch =3D refs/heads/*:refs/remotes/=
origin/*
>>
>> upon cloning from my repository, and your "git fetch" will fail beca=
use
>> the pu (proposed updates) branch is constantly unwinding, but that c=
an be
>> easily fixed with
>>
>>
>> =A0 =A0 =A0 [remote]
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 url =3D git://.../git.git/
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 fetch =3D refs/heads/*:refs/remotes/=
origin/*
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 fetch =3D +refs/heads/pu:refs/remote=
s/origin/pu
>>
>> as the explicit refspec trumps the wildcard one.
>
> It appears that we have a glitch somewhere in the implementation. We
> should make the explicit refspec trump the wildcarded ones.

This is a great idea. :-)

--=20
Shawn.
