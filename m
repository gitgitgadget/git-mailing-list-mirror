From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 0/4] Fix prune/gc problem with multiple worktrees
Date: Thu, 2 Jun 2016 13:26:55 +0200
Message-ID: <575017FF.1020901@alum.mit.edu>
References: <574D382A.8030809@kdbg.org>
 <20160601104519.16563-1-pclouds@gmail.com>
 <xmqqshwwzyee.fsf@gitster.mtv.corp.google.com>
 <CACsJy8DjKo-HcyG6sKhhvx8vtySn6VTTP-E6vX2uKNEJgjouZg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>,
	David Turner <dturner@twopensource.com>
To: Duy Nguyen <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 02 13:27:12 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8QmN-0000Hb-Hl
	for gcvg-git-2@plane.gmane.org; Thu, 02 Jun 2016 13:27:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752134AbcFBL1A convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 2 Jun 2016 07:27:00 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:51057 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750862AbcFBL1A (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Jun 2016 07:27:00 -0400
X-AuditID: 12074411-e2bff70000000955-d9-57501802b520
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 2F.EB.02389.20810575; Thu,  2 Jun 2016 07:26:58 -0400 (EDT)
Received: from [192.168.69.130] (p508EAEB0.dip0.t-ipconnect.de [80.142.174.176])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u52BQtgt029621
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Thu, 2 Jun 2016 07:26:56 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Icedove/38.8.0
In-Reply-To: <CACsJy8DjKo-HcyG6sKhhvx8vtySn6VTTP-E6vX2uKNEJgjouZg@mail.gmail.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrIKsWRmVeSWpSXmKPExsUixO6iqMskERBusGuZicX8TScYLbqudDNZ
	NPReYbZ4Mvcus0X3lLeMFj9aepgd2Dx2zrrL7vHwVRe7x7PePYweFy8peyx4fp/d4/MmuQC2
	KG6bpMSSsuDM9Dx9uwTujD9/utkK2iQrtq6ay9jAOEOki5GTQ0LAROL1rkWsXYxcHEICWxkl
	bvy4xgjhnGeSePruFyNIlbCAq8TUhn5WEFtEwE1iws73UB1nGCW2PP7OBuIwC0xllHi+fB9Y
	B5uArsSinmYmEJtXQFtixusl7CA2i4CKROPi62CTRAVCJM6v28oKUSMocXLmExYQm1MgUOL2
	zUNgvcwC6hJ/5l1ihrDlJZq3zmaewMg/C0nLLCRls5CULWBkXsUol5hTmqubm5iZU5yarFuc
	nJiXl1qka6qXm1mil5pSuokREuSCOxhnnJQ7xCjAwajEw7tC0z9ciDWxrLgy9xCjJAeTkijv
	yjKgEF9SfkplRmJxRnxRaU5q8SFGCQ5mJRFeZdGAcCHelMTKqtSifJiUNAeLkjgv3xJ1PyGB
	9MSS1OzU1ILUIpisDAeHkgRvpjhQo2BRanpqRVpmTglCmomDE2Q4l5RIcWpeSmpRYmlJRjwo
	LuOLgZEJkuIB2psN0s5bXJCYCxSFaD3FqMtxZP+9tUxCLHn5ealS4rzVYkBFAiBFGaV5cCtg
	Ke0VozjQx8K8t0GqeIDpEG7SK6AlTEBLCh75gywpSURISTUwmrBdv7pVIK3iyeovUQ+1Hbjn
	3/LZmR3idou5SNvzwXSrbaqz5x7f+qBkXfCn4G9fTE4FVG3/PHFvktf9LUy3xLQ2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296195>

On 06/02/2016 11:53 AM, Duy Nguyen wrote:
> (from patch 4/4 mail)
>=20
> On Wed, Jun 1, 2016 at 10:51 PM, Michael Haggerty <mhagger@alum.mit.e=
du> wrote:
>>> +     path =3D xstrdup(worktree_git_path(wt, "logs/refs/bisect"));
>>> +     if (file_exists(path))
>>> +             handle_one_reflog(path, NULL, 0, &cb);
>>> +     free(path);
>>> +}
>>
>> `refs/bisect` is not a single reference. It is a namespace that cont=
ains
>> references with names like `refs/bisect/bad` and
>> `refs/bisect/good-66106691a1b71e445fe5e4d6b8b043dffc7dfe4c`.
>=20
> Yeah I missed that. I'm not going to write another directory walker t=
o
> collect all logs/refs/bisect/*. I didn't add pending objects for
> refs/bisect/* of other worktrees either. At that point waiting for th=
e
> new ref iterator makes more sense...
>=20
> On Wed, Jun 1, 2016 at 11:06 PM, Junio C Hamano <gitster@pobox.com> w=
rote:
>> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> write=
s:
>>
>>> This series makes sure that objects referenced by all worktrees are
>>> marked reachable so that we don't accidentally delete objects that =
are
>>> being used. Previously per-worktree references in index, detached H=
EAD
>>> or per-worktree reflogs come from current worktree only, not all
>>> worktrees.
>>
>> I'll let this topic simmer on the list for now, instead of picking
>> it up immediately to 'pu', as Michael in $gmane/296068 makes me
>> wonder if we want to keep piling on the current "worktree ref
>> iterations are bolted on" or if we want to first clean it up, whose
>> natural fallout hopefully would eliminate the bug away.
>=20
> So what should be the way forward? My intention was having something
> that can fix the problem for now, even if a bit hacky while waiting
> for ref iterator to be ready, then convert to use it and clean things
> up, because I don't how long ref-iterator would take and losing data
> is serous enough that I'd like to fix it soon. If we go with "fix soo=
n
> then convert to ref-iterator later", then I will drop the
> logs/bisect/* check, checking logs/HEAD alone should be good enough.
> Otherwise I'll prepare a series on top of ref-iterator.

=46ixing reachability via the index and detached HEADs feels relatively
important.

=46ixing refs/bisect/* feels a bit less urgent, because (1) usually
bisections don't take very long, and (2) if the commits that one is
bisecting are not otherwise reachable anymore, then the bisection is
probably not interesting anymore. However, these are real references, s=
o
if they get broken, the worktree will be seen as corrupt and recovery i=
s
not super obvious (I guess most people would end up deleting the whole
worktree).

=46ixing the reflogs for HEAD and (especially) refs/bisect/* in worktre=
es
feels even less important, because reflogs are not nearly as important
as current ref values, Git is relatively tolerant of broken reflog
entries, and there are easy ways to prune them if breakage occurs.

It's hard for me to predict when the ref-iterator stuff will be merged.
It is a big change, but so far the feedback seems pretty good. I can
tell you that pushing it and ref-stores forward is high on my priority =
list.

Michael
