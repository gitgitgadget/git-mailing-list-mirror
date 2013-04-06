From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: [PATCH v2 0/4] remote-helpers: trivial test fixes
Date: Sat, 06 Apr 2013 19:45:22 +0200
Message-ID: <51605F32.7080303@web.de>
References: <1365089779-9726-1-git-send-email-felipe.contreras@gmail.com> <51605546.3080503@web.de> <CAMP44s0Lbg-_JKPR6WF6Qhkz7cgweHejA-T_V3mCO73a4iXpNA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Max Horn <max@quendi.de>,
	Antoine Pelisse <apelisse@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 06 20:20:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UOXBI-00026r-CP
	for gcvg-git-2@plane.gmane.org; Sat, 06 Apr 2013 19:45:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755242Ab3DFRp3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 6 Apr 2013 13:45:29 -0400
Received: from mout.web.de ([212.227.15.3]:51219 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755090Ab3DFRp2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Apr 2013 13:45:28 -0400
Received: from [192.168.209.26] ([195.67.191.23]) by smtp.web.de (mrweb002)
 with ESMTPA (Nemesis) id 0M1noI-1UiwRd0TcY-00u0ab; Sat, 06 Apr 2013 19:45:24
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:17.0) Gecko/20130328 Thunderbird/17.0.5
In-Reply-To: <CAMP44s0Lbg-_JKPR6WF6Qhkz7cgweHejA-T_V3mCO73a4iXpNA@mail.gmail.com>
X-Provags-ID: V02:K0:SNxewAeSqAz7kYkvjaGW38qb6EpBq+XgsRG1KLxfQxT
 ElxyM3O2LowuekSIc1nMgo43FYKeW+QaCXnQosxkzw8UzvzJ06
 9e58DS6NaOr7hWWKDzZKG8ihFJ/f6iWg4dwr0lXaHV3s6wuQB6
 gzx5f65iGyak6sbWBoJwIEYnSJxonAcGH170jovUOQMDGYPetw
 6eQdPPnEB+NEJkjgz43KA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220259>

On 06.04.13 19:29, Felipe Contreras wrote:
> On Sat, Apr 6, 2013 at 11:03 AM, Torsten B=C3=B6gershausen <tboegi@we=
b.de> wrote:
>> On 04.04.13 17:36, Felipe Contreras wrote:
>>> Hi,
>>>
>>> A reroll, now we do some checks, just avoid test-lint-duplicates, a=
nd fix the
>>> outsanding shell portability issue. The rest is the same.
>>>
>>> Felipe Contreras (4):
>>>   remote-bzr: avoid echo -n
>>>   remote-helpers: fix the run of all tests
>>>   remote-bzr: remove stale check code for tests
>>>   remote-hg: fix hg-git test-case
>>>
>>>  contrib/remote-helpers/Makefile          |  1 +
>>>  contrib/remote-helpers/test-bzr.sh       | 16 +---------------
>>>  contrib/remote-helpers/test-hg-hg-git.sh |  1 -
>>>  3 files changed, 2 insertions(+), 16 deletions(-)
>>>
>> Sorry being late, now I installed bzr and hg on one of my machines
>>
>> One defect found: "\s" is not portable on all grep versions
>> A "*" is not a "basic regular expression", so we need to use egrep
>>
>>
>> diff --git a/contrib/remote-helpers/test-hg.sh b/contrib/remote-help=
ers/test-hg.sh
>> index 5f81dfa..2e80c11 100755
>> --- a/contrib/remote-helpers/test-hg.sh
>> +++ b/contrib/remote-helpers/test-hg.sh
>> @@ -115,7 +115,7 @@ test_expect_success 'update bookmark' '
>>    git push
>>    ) &&
>>
>> -  hg -R hgrepo bookmarks | grep "devel\s\+3:"
>> +  hg -R hgrepo bookmarks | egrep "devel[[:space:]]+3:"
>>  '
>=20
> I would rather use [ \t] instead.
That doesn't work on e.g. Mac OS.
[:space:] is actually portable
/Torsten
