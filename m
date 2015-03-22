From: Koosha Khajehmoogahi <koosha@posteo.de>
Subject: Re: [PATCH 4/5] Add tests for git-log --merges=show|hide|only
Date: Sun, 22 Mar 2015 23:41:19 +0100
Message-ID: <550F450F.6070207@posteo.de>
References: <1427048921-28677-1-git-send-email-koosha@posteo.de>	<1427048921-28677-4-git-send-email-koosha@posteo.de>	<550F1E9F.40801@web.de>	<550F3D3B.7080104@posteo.de> <CAPig+cT-EJMBZN72N=DREZjn=c1rxgMsnJ=HNS4R3sGTUPUu0A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>,
	Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sun Mar 22 23:42:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YZoZU-0000yl-Bl
	for gcvg-git-2@plane.gmane.org; Sun, 22 Mar 2015 23:42:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751928AbbCVWmM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 22 Mar 2015 18:42:12 -0400
Received: from mx02.posteo.de ([89.146.194.165]:48679 "EHLO mx02.posteo.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751907AbbCVWmL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Mar 2015 18:42:11 -0400
Received: from dovecot03.posteo.de (unknown [185.67.36.28])
	by mx02.posteo.de (Postfix) with ESMTPS id A7DA125AF51A;
	Sun, 22 Mar 2015 23:42:09 +0100 (CET)
Received: from mail.posteo.de (localhost [127.0.0.1])
	by dovecot03.posteo.de (Postfix) with ESMTPSA id 3l9DNx2Nxjz5vNB;
	Sun, 22 Mar 2015 23:42:09 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.5.0
In-Reply-To: <CAPig+cT-EJMBZN72N=DREZjn=c1rxgMsnJ=HNS4R3sGTUPUu0A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266101>



On 03/22/2015 11:40 PM, Eric Sunshine wrote:
> On Sun, Mar 22, 2015 at 6:07 PM, Koosha Khajehmoogahi <koosha@posteo.=
de> wrote:
>> On 03/22/2015 08:57 PM, Torsten B=C3=B6gershausen wrote:
>>> On 22.03.15 19:28, Koosha Khajehmoogahi wrote:
>>>> Signed-off-by: Koosha Khajehmoogahi <koosha@posteo.de>
>>>> ---
>>>> diff --git a/t/t4202-log.sh b/t/t4202-log.sh
>>>> index 5f2b290..ab6f371 100755
>>>> --- a/t/t4202-log.sh
>>>> +++ b/t/t4202-log.sh
>>>> @@ -428,6 +428,147 @@ cat > expect <<\EOF
>>>>  * initial
>>>>  EOF
>>>>
>>>> +test_expect_success 'log with config log.merges=3Dshow' '
>>>> +    git config log.merges show &&
>>>> +    git log --pretty=3Dtformat:%s >actual &&
>>>> +    test_cmp both_commits_merges actual &&
>>>> +    git config --unset log.merges
>>> Do we need the unset here?
>>> The log.merges is nicely set up before each test case, so can we dr=
op the unset lines ?
>>> (Or do I miss something ?)
>>
>> Good point; we can drop only those unset lines whose next test sets =
the log.merges.
>> However, if the next test does not set it, we must unset it as it af=
fects the
>> default behavior of git-log.
>=20
> Such an approach would be too fragile. Tests may be re-ordered, added=
,
> or removed. Better is to make each test as self-contained as possible=
=2E
> See my review[1] of this patch for alternate suggestions.
>=20
> [1]: http://article.gmane.org/gmane.comp.version-control.git/266099
>=20

That's why I wrote them this way actually. Also, thanks for your
review. I will refactor my code to consider your suggestions.

Thanks.
--=20
Koosha
