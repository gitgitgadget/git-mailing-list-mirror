From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: Our merge bases sometimes suck
Date: Tue, 17 Jun 2014 17:44:36 +0200
Message-ID: <53A06264.9080205@alum.mit.edu>
References: <539A25BF.4060501@alum.mit.edu> <xmqq8uovo9pa.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git discussion list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 17 17:44:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WwvYy-0007lh-62
	for gcvg-git-2@plane.gmane.org; Tue, 17 Jun 2014 17:44:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933445AbaFQPok convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 17 Jun 2014 11:44:40 -0400
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:50792 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932989AbaFQPoj (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Jun 2014 11:44:39 -0400
X-AuditID: 1207440f-f79536d000000bcf-7d-53a0626688ac
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id BB.76.03023.66260A35; Tue, 17 Jun 2014 11:44:38 -0400 (EDT)
Received: from [192.168.69.130] (p5DDB2181.dip0.t-ipconnect.de [93.219.33.129])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s5HFiabs017383
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Tue, 17 Jun 2014 11:44:37 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Icedove/24.5.0
In-Reply-To: <xmqq8uovo9pa.fsf@gitster.dls.corp.google.com>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrAKsWRmVeSWpSXmKPExsUixO6iqJuWtCDYYO0efouuK91MFg29V5gd
	mDwuXlL2+LxJLoApitsmKbGkLDgzPU/fLoE7o21SI3vBUrGK6Wu3sTYwbhXsYuTkkBAwkZj4
	4RYThC0mceHeerYuRi4OIYHLjBJf1yxmh3DOM0n8+d7JAlLFK6AtcfN3HzOIzSKgKrG0fSYb
	iM0moCuxqKcZbJKoQJDE7M/z2CHqBSVOznwC1isioCYxse0QkM3BwQxU//BNIkhYGGjkghd/
	mUDCQgJREhPfWYCEOQWsJd6sW8UKEpYQEJfoaQyCaFSXWD9PCKSCWUBeonnrbOYJjIKzkKya
	hVA1C0nVAkbmVYxyiTmlubq5iZk5xanJusXJiXl5qUW6Jnq5mSV6qSmlmxghYcu/g7Frvcwh
	RgEORiUe3gey84OFWBPLiitzDzFKcjApifI+il8QLMSXlJ9SmZFYnBFfVJqTWnyIUYKDWUmE
	t0QcKMebklhZlVqUD5OS5mBREudVX6LuJySQnliSmp2aWpBaBJOV4eBQkuB9mwDUKFiUmp5a
	kZaZU4KQZuLgBBnOJSVSnJqXklqUWFqSEQ+K3PhiYOyCpHiA9uokguwtLkjMBYpCtJ5iNOY4
	dedYGxPHiScn25iEWPLy81KlxHmDQUoFQEozSvPgFsES1itGcaC/hXl1Qap4gMkObt4roFVM
	QKtUJs4DWVWSiJCSamDUUVznfe/rn/9HPRpW8y3ZwOHsNNP/au0D9SfGbWHXZVT3Wk7ZdzVZ
	0XiO14wtj3903Ln6+ead+z/UC7+90l4469uvXXeswz6fsnyU8r3r4wItLac9Ob9P 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251866>

On 06/17/2014 05:08 PM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
>=20
>> The "best" merge base
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>
>> But not all merge bases are created equal.  It is possible to define=
 a
>> "best" merge base that has some nice properties.
>>
>> Let's focus on the command
>>
>>     git diff $master...$branch
>>
>> which is equivalent to
>>
>>     git diff $(git merge-base $master $branch)..$branch
>> ...
>> I propose that the best merge base is the merge base "candidate" tha=
t
>> minimizes the number of non-merge commits that are in
>>
>>     git rev-list --no-merges $candidate..$branch
>>
>> but are already in master:
>>
>>     git rev-list --no-merges $master
>=20
> I welcome this line of thought very much.
>=20
> There is one niggle I find somewhat curious but am either too lazy
> or too stupid to think it through myself ;-)
>=20
> The "merge-base" is a symmetric operation, because the three-way
> merge, which is the primary customer of its result, fundamentally
> is.  From your description, it sounds like the "best" merge base
> however may not be symmetric at all.  The merge-base between A and B
> that makes "git diff A...B" the easiest to read by minimizing the
> distance between it and B may be different from the merge-base
> between A and B that makes the other diff "git diff B...A" the
> easiest to read.
>=20
> Or it may not be assymmetric---that is why I said I didn't think it
> through.  I am not saying that it is bad if the "best" merge-base is
> an asymmetric concept; I am curious if it is asymmetric, and if so
> if that is fundamental.

It just looks asymmetric, but actually it is symmetric, which was kindo=
f
surprising when I realized it.  The argument is in the next section
"Symmetry; generalization to more than two branches".  Michael Gruber
showed the same thing upthread using set notation, which is easier to
follow.  Here is his argument in symbolic notation.  We want to minimiz=
e

    N =3D |(branch - candidate) =E2=88=A7 master|

where "branch" represents the set of all commits in "branch" etc, "|x|"
represents the number of elements in set "x", and "=E2=88=A7" is set
intersection, and candidate is a merge base of branch and master.

    N =3D |(branch =E2=88=A7 =E2=88=BCcandidate) =E2=88=A7 master|
      =3D |(branch =E2=88=A7 master) =E2=88=A7 =E2=88=BCcandidate|

Since candidate is a common ancestor of branch and master,

    candidate =E2=8A=86 branch =E2=88=A7 master

so we have

    N =3D |branch =E2=88=A7 master| - |candidate|

Since "|branch =E2=88=A7 master|" is the same for all candidates, minim=
izing N
is the same as maximizing |candidate|, which is the same as

    git rev-list --count --no-merges $candidate

=2E  This is clearly symmetric in master vs. base.

Michael

--=20
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
