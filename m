From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>
Subject: Re: [PATCH 2/2] index-pack: handle duplicate base objects gracefully
Date: Sat, 30 Aug 2014 18:00:59 +0200
Message-ID: <5401F53B.6070707@web.de>
References: <20140829205538.GD29456@peff.net> <20140829205809.GB7060@peff.net> <xmqqegvz3qpp.fsf@gitster.dls.corp.google.com> <20140829220818.GA24834@peff.net> <CAJo=hJs3mM7=LcOop-WD=bipA=Wx-7MDh6ObQwFUE38tjurvcw@mail.gmail.com> <20140830131649.GA26833@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Martin von Gagern <Martin.vGagern@gmx.net>,
	git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>, Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Aug 30 18:01:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XNl5m-0006Qp-6l
	for gcvg-git-2@plane.gmane.org; Sat, 30 Aug 2014 18:01:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751700AbaH3QB0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 30 Aug 2014 12:01:26 -0400
Received: from mout.web.de ([212.227.17.12]:59955 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751677AbaH3QB0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Aug 2014 12:01:26 -0400
Received: from [192.168.178.27] ([79.253.135.121]) by smtp.web.de (mrweb102)
 with ESMTPSA (Nemesis) id 0MRlIL-1XpzBl2sVV-00SwxQ; Sat, 30 Aug 2014 18:01:16
 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.0
In-Reply-To: <20140830131649.GA26833@peff.net>
X-Provags-ID: V03:K0:d1GdlaMQ63/iC6NaUTgyvuwFA/BXwZxHJNthE3GYSHeNmoFLNmw
 xGHGABrJD6gAX+AIwn6Uf4+0WQx6H0XXHdDRUba4TExWAb7EFbevLtsqp30uY/cA+NO0sWX
 0s8CoVjGyk3kNAEavXr227+6j98kNJuF31AMbz3MJfWUNgwg9NLd4kK0XqUf00lSSWTE8Vf
 JUU6PP0SWuzFYd4sECuyg==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256256>

Am 30.08.2014 um 15:16 schrieb Jeff King:
> On Fri, Aug 29, 2014 at 07:59:32PM -0700, Shawn Pearce wrote:
>
>>> I agree it is probably a bug on the sending side, but I think last =
time
>>> this came up we decided to try to be liberal in what we accept.  c.=
f.
>>> http://thread.gmane.org/gmane.comp.version-control.git/232305/focus=
=3D232310
>>
>> IIRC they aren't valid pack files to contain duplicates.
>>
>> Once upon a time JGit had a bug and android.googlesource.com returne=
d
>> duplicate objects in a Linux kernel repository. This caused at least
>> some versions of git-core to fail very badly in binary search at
>> object lookup time or something. We had a lot of users angry with us=
=2E
>> :)
>>
>> I know Nico said its OK last year, but its really not. I don't think
>> implementations are capable of handling it.
>
> We do detect and complain if --strict is given. Should we make it the
> default instead? I think it is still worthwhile to have a mode that c=
an
> handle these packs. It may be the only reasonable way to recover the
> data from such a broken pack (and that broken pack may be the only co=
py
> of the data you have, if you are stuck getting it out of a broken
> implementation on a remote server).

Sounds reasonable; being able to extract code from broken repos --=20
especially in this real-world case -- is beneficial.

My only nit with patch 2: Petr Stodulka <pstodulk@redhat.com> and Marti=
n=20
von Gagern <Martin.vGagern@gmx.net> should be mentioned as bug reporter=
s.

Ren=C3=A9
