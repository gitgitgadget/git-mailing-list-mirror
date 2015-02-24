From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: Git Scaling: What factors most affect Git performance for a large
 repo?
Date: Tue, 24 Feb 2015 13:44:49 +0100
Message-ID: <54EC7241.7000500@alum.mit.edu>
References: <CAH8BJxEr_v+aitpZduXPC4oiRhMuySpc7Wb1aGcYe_p3mWjn+w@mail.gmail.com> <CACBZZX6A+35wGBYAYj7E9d4XwLby21TLbTh-zRX+fkSt_e2zeg@mail.gmail.com> <CACsJy8DkS65axQNY70FrfqR5s-49oOn8j7SAE9BTiRVNrm+ohQ@mail.gmail.com> <CACBZZX4T38j9YU3eiHTfkDoZKsgyJFrnJQNm5WBmb9RDenDOBg@mail.gmail.com> <CACBZZX45eCo6YS4EpHvMQjN32+-w5BztfoLiwh_rJTs7FydgoQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Stephen Morton <stephen.c.morton@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 24 13:52:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YQEy7-0007Is-2n
	for gcvg-git-2@plane.gmane.org; Tue, 24 Feb 2015 13:52:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752492AbbBXMv5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Feb 2015 07:51:57 -0500
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:51703 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750880AbbBXMv4 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Feb 2015 07:51:56 -0500
X-Greylist: delayed 422 seconds by postgrey-1.27 at vger.kernel.org; Tue, 24 Feb 2015 07:51:56 EST
X-AuditID: 12074414-f797f6d000004084-99-54ec7243f1a2
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id C6.F7.16516.3427CE45; Tue, 24 Feb 2015 07:44:51 -0500 (EST)
Received: from [192.168.69.130] (p5DDB21CD.dip0.t-ipconnect.de [93.219.33.205])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t1OCin0p003327
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Tue, 24 Feb 2015 07:44:50 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.4.0
In-Reply-To: <CACBZZX45eCo6YS4EpHvMQjN32+-w5BztfoLiwh_rJTs7FydgoQ@mail.gmail.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIKsWRmVeSWpSXmKPExsUixO6iqOtc9CbEYOcOdYu1z+4wWXRd6Way
	6J7yltFi+rFPjA4sHjtn3WX3+LxJLoApitsmKbGkLDgzPU/fLoE7Y+7VScwF2wUrmg/5NzD+
	5+1i5OCQEDCRmLG1uIuRE8gUk7hwbz1bFyMXh5DAZUaJN5PamSGc80wSB7Z/ZAOp4hXQljjb
	2sMIYrMIqEq0Nc4Ai7MJ6Eos6mlmArFFBYIkDp1+zAJRLyhxcuYTMFtEoEDi5Lu7YDXMAgkS
	T3cvZgexhQXCJLZOX80OsewJk8SMLfvAGjgFAiVWzPzABtGgLvFn3iVmCFteonnrbOYJjAKz
	kOyYhaRsFpKyBYzMqxjlEnNKc3VzEzNzilOTdYuTE/PyUot0LfRyM0v0UlNKNzFCgldkB+OR
	k3KHGAU4GJV4eA/IvAkRYk0sK67MPcQoycGkJMp7LB8oxJeUn1KZkVicEV9UmpNafIhRgoNZ
	SYR3SzRQjjclsbIqtSgfJiXNwaIkzvttsbqfkEB6YklqdmpqQWoRTFaGg0NJgte7EKhRsCg1
	PbUiLTOnBCHNxMEJMpxLSqQ4NS8ltSixtCQjHhSp8cXAWAVJ8QDtDQJp5y0uSMwFikK0nmJU
	lBLnFQVJCIAkMkrz4MbCUtIrRnGgL4V5y0GqeIDpDK77FdBgJqDBex6/AhlckoiQkmpgbC9e
	eerB9x2Mv18qzdgf9tNzwbUJn/qFkj0WHmfcwJQwv7l7w5STM7t72v7JiHGG9Mz6kH3nzL4M
	mWfZ20w763ZJFPSl3csS+KfsJPJt9az0qon/ChLXXz9itva2H6PL4t3dVv9WVuyr 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264326>

On 02/20/2015 03:25 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> On Fri, Feb 20, 2015 at 1:09 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmas=
on
> <avarab@gmail.com> wrote:
>> On Fri, Feb 20, 2015 at 1:04 AM, Duy Nguyen <pclouds@gmail.com> wrot=
e:
>>> On Fri, Feb 20, 2015 at 6:29 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarm=
ason
>>> <avarab@gmail.com> wrote:
>>>> Anecdotally I work on a repo at work (where I'm mostly "the Git gu=
y") that's:
>>>>
>>>>  * Around 500k commits
>>>>  * Around 100k tags
>>>>  * Around 5k branches
>>>>  * Around 500 commits/day, almost entirely to the same branch
>>>>  * 1.5 GB .git checkout.
>>>>  * Mostly text source, but some binaries (we're trying to cut down=
[1] on those)
>>>
>>> Would be nice if you could make an anonymized version of this repo
>>> public. Working on a "real" large repo is better than an artificial
>>> one.
>>
>> Yeah, I'll try to do that.
>=20
> tl;dr: After some more testing it turns out the performance issues we
> have are almost entirely due to the number of refs. Some of these I
> knew about and were obvious (e..g. git pull), but some aren't so
> obvious (why does "git log" without "--all" slow down as a function o=
f
> the overall number of refs?).

I'm assuming that you pack your references periodically. (If not, you
should, because reading lots of loose references is very expensive for
the commands that need to iterate over all references!)

On the other hand, packed refs also have a downside, namely that
whenever even a single packed reference has to be read, the whole
packed-refs file has to be read and parsed. One way that this can bite
you, even with innocuous-seeming commands, is if you haven't disabled
the use of replace references (i.e., using "git --no-replace-objects
<CMD>" or GIT_NO_REPLACE_OBJECTS). In that case, almost any Git command
has to read the "refs/replace/*" namespace, which, in turn, forces the
whole packed-refs file to be read and parsed. This can take a
significant amount of time if you have a very large number of reference=
s.

So try your experiments with replace references disabled. If that helps=
,
consider disabling them on your server if you don't need them.

Michael

--=20
Michael Haggerty
mhagger@alum.mit.edu
