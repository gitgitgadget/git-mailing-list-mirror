From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: What's cooking in git.git (Oct 2013, #07; Mon, 28)
Date: Wed, 30 Oct 2013 18:39:09 +0100
Message-ID: <5271443D.3070402@web.de>
References: <xmqqr4b5dwke.fsf@gitster.dls.corp.google.com> <5271392E.8020003@web.de> <CAFFjANT=-mQoKUU2KsPHo3Hcq7RAuyM1t4kvJu4OfiNeHrA+Ng@mail.gmail.com> <52713E67.3000202@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
To: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>,
	=?UTF-8?B?VmljZW50IE1hcnTDrQ==?= <tanoku@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 30 18:39:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VbZjo-0006jq-D7
	for gcvg-git-2@plane.gmane.org; Wed, 30 Oct 2013 18:39:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754244Ab3J3RjM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 30 Oct 2013 13:39:12 -0400
Received: from mout.web.de ([212.227.17.11]:64737 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751806Ab3J3RjK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Oct 2013 13:39:10 -0400
Received: from [192.168.209.26] ([78.72.74.102]) by smtp.web.de (mrweb103)
 with ESMTPA (Nemesis) id 0M0yeJ-1VwpH92r8R-00v7xj for <git@vger.kernel.org>;
 Wed, 30 Oct 2013 18:39:08 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:24.0) Gecko/20100101 Thunderbird/24.1.0
In-Reply-To: <52713E67.3000202@web.de>
X-Provags-ID: V03:K0:S3LTvel74A9yW7eBEmhqanUuV0jpRLhGOPhou6yaJv/qhZTdQhB
 uRafv6PIhbZ/tC/V/0OdM6YKfr+NYMf9DRiwTSazNtqTy5TA29wacVttiRuNwEr+OJVIYrr
 cJpk6Tt1lqvld/PE0LAz3HpVf27jLSBsBvu6UKwY3p8Nbe66SljhJvMUqplKbhZNMkn3WqG
 BG/Kmi5oHFxqEueNV9PTg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237045>

On 2013-10-30 18.14, Torsten B=C3=B6gershausen wrote:
> On 2013-10-30 18.01, Vicent Mart=C3=AD wrote:
>> On Wed, Oct 30, 2013 at 5:51 PM, Torsten B=C3=B6gershausen <tboegi@w=
eb.de> wrote:
>>> There is a name clash under cygwin 1.7 (1.5 is OK)
>>> The following "first aid hot fix" works for me:
>>> /Torsten
>>
>> If Cygwin declares its own bswap_64, wouldn't it be better to use it
>> instead of overwriting it with our own?
> Yes,
> this will be part of a longer patch.
> I found that some systems have something like this:
>=20
> #define htobe64(x) bswap_64(x)
> And bswap_64 is a function, so we can not detect it by "asking"
> #ifdef bswap_64
> ..
> #endif
>=20
>=20
> But we can use
> #ifdef htobe64
> ...
> #endif
> and this will be part of a bigger patch.
>=20
> And, in general, we should avoid to introduce functions which may hav=
e a
> name clash.
> Using the git_ prefix for function names is a good practice.
> So in order to unbrake the compilation error under cygwin 17,
> the "hotfix" can be used.
> /Torsten
I just realized that there seem to problems to compile pu under msysgit=
=2E
More investigation needed here.
