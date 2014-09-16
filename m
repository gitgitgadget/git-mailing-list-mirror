From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>
Subject: Re: [PATCH 1/2] add macro REALLOCARRAY
Date: Tue, 16 Sep 2014 20:52:05 +0200
Message-ID: <541886D5.8060202@web.de>
References: <5415C89C.4090509@web.de> <CAPc5daXuYVXG=b3Mjn=8oE71FqE_PRZ=XHXW_0F5uHawWwy4HQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 16 20:52:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XTxrP-0005qv-4G
	for gcvg-git-2@plane.gmane.org; Tue, 16 Sep 2014 20:52:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754994AbaIPSwN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 16 Sep 2014 14:52:13 -0400
Received: from mout.web.de ([212.227.17.12]:54341 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754819AbaIPSwL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Sep 2014 14:52:11 -0400
Received: from [192.168.178.27] ([79.253.189.35]) by smtp.web.de (mrweb101)
 with ESMTPSA (Nemesis) id 0Lb1wz-1Y9wWH1oan-00kjoQ; Tue, 16 Sep 2014 20:52:08
 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.1.1
In-Reply-To: <CAPc5daXuYVXG=b3Mjn=8oE71FqE_PRZ=XHXW_0F5uHawWwy4HQ@mail.gmail.com>
X-Provags-ID: V03:K0:sOeovaxyM99WtQtK+nVxJ5x/6TVdWoxMT3GWJpPhFjW5Fq1J9Vc
 ypda7id4ycu362x7n9e3AN9XwTweSn/Kp568V32xGa6UT8kDTk7cAPtyujosJ7dON3eiPPH
 0z6rhOs0H7jUM0/bi2esrASaFlaEb3wj3nVmkvpYSkBjRqZmyEhdismkFjKqSAgumgSvBn/
 0JIYwJV5S+stWDYZ5OSYg==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257142>

Am 16.09.2014 um 05:04 schrieb Junio C Hamano:
> On Sun, Sep 14, 2014 at 9:55 AM, Ren=C3=A9 Scharfe <l.s.r@web.de> wro=
te:
>> +#define REALLOCARRAY(x, alloc) x =3D xrealloc((x), (alloc) * sizeof=
(*(x)))
>
> I have been wondering if "x" could be an expression that has an opera=
tor
> that binds weaker than the assignment '=3D'.  That may necessitate th=
e LHS
> of the assignment to be somehow marked as bound the tightest, i.e.
>
> #define REALLOC_ARRAY(x, alloc) (x) =3D xrealloc((x), (alloc) * sizeo=
f(*(x)))
>
> Or am I being overly silly?

ALLOC_GROW did well without that.  I can't think of a good use case for=
=20
a complex expression on the right-hand side.  That said, I think I stil=
l=20
have a spare matching pair of parentheses lying around here somewhere,=20
so let's play it safe and use them. :)

The added underscore is a good idea as well.

Ren=C3=A9
