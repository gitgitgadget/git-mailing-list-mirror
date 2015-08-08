From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: Error when cloning with weird local directory
Date: Sat, 8 Aug 2015 08:26:25 +0200
Message-ID: <55C5A111.6050902@web.de>
References: <CAFOYHZByteuPZwRvw9tzFWOD6vguw4wPK1J6rLZZvHzyZRBtSA@mail.gmail.com>
 <55C2F54A.7070702@web.de> <xmqqtwsczws6.fsf@gitster.dls.corp.google.com>
 <xmqqpp30zwhu.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Chris Packham <judge.packham@gmail.com>, GIT <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sat Aug 08 08:27:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZNxau-0000lC-3n
	for gcvg-git-2@plane.gmane.org; Sat, 08 Aug 2015 08:27:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932622AbbHHG0z convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 8 Aug 2015 02:26:55 -0400
Received: from mout.web.de ([212.227.15.3]:64567 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932610AbbHHG0y (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Aug 2015 02:26:54 -0400
Received: from macce.local ([213.66.56.100]) by smtp.web.de (mrweb003) with
 ESMTPSA (Nemesis) id 0MhUcU-1ZBOoD0Lre-00MgBM; Sat, 08 Aug 2015 08:26:27
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:38.0)
 Gecko/20100101 Thunderbird/38.1.0
In-Reply-To: <xmqqpp30zwhu.fsf@gitster.dls.corp.google.com>
X-Provags-ID: V03:K0:0rhaVDND8pLtgPDWiwwJQFmkIHNQt23uyueg9oV8XxyBx7fW6su
 q5rLvkcIZ/FvGrZ2KWdtQEbgSqlTS0O56T73axXOsdQM+Yci2d76chJROeoJlo1fcNQgqPN
 MpcANZmUzyKGT+UUqruTHPRId2YQspv4i7iUJzc3GaDUcbWHjtlldmQ4iEzOhou2tAB/p9F
 vlvYZc4Oxd7TAYryly4VA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:98dpFHcpcho=:UYISNyigpeIFp8bnXG24HS
 ybYphnodDX24X0ytcspIbawP+aWauuOS6cCPOc0Adx13Lex16K6V4nngWfWHmiRv6zbG8dOYb
 453plWMouK7sHJ+3fEjqlQeUSxuzlbola8yqmfqlA0Jcw+xP0r2/+xhYe85G9k/y7e08rElRD
 lCJrsNneH9eVaV2K5XXxfyMl0TmGI99LCV1/DUI29uxUiHmWNAim4qsziuKKXWssqGVyEE9V1
 qE+QocbW9SZGrEIVrreKGf/AqbQ4X1OTkCncN5IxcqnQw6XwNl4g4w4/OqF49dnBByAa2XnyL
 f8ljcJNZ12nxhu5w/9ECvh4S217MQzUgj72FxLgpx5yvFEzrr3KA+x0NvoXBj9Vs55p/EdjZL
 st0vn8BLYJTwtebVMkfN+c1cPVObOlR6fyvYmBXPVz9SG9qyhgO2PFVXnmH0BXyGG47+rnJXS
 GlU2KkfWAkMOyHkBv3wfj/0wPbb4pudT0/UD8GvzRf0dnauaomhoERxw+pKSYTIy0fmYHnHTT
 PZvhuOFKFVgeRrRXjZ/tU1rLbgk+H9FKTdTV9aPSZm7egta+kBobwruykT4UOZhLlHcWGSkJ6
 fzilXweKglupFB7oJNJN7AHDITuR9p1tBzZ/SW0TW+67DulDuUYhRcUdD6yCCbOourhurQjIb
 ZUDfiyErKdgsmJ4VZnRVh+lj8JucegifRFns8eYASjwCXclnzvhtIgJs9t7nGvpS0jUkbShCs
 nFrc5x3V1S53bw4t1k/HF+VIFuuxcvNlF6sMpQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275507>

On 2015-08-06 09.50, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>=20
>> Torsten B=C3=B6gershausen <tboegi@web.de> writes:
>>
>>> It looks as if
>>> static char *get_repo_path(const char *repo, int *is_bundle)
>>> in built/clone.c
>>> checks if there is a local directory structure looking like a
>>> .git directory.
>>> This is wrong.
>>
>> It is as designed, though, to allow cloning from a local directory
>> with any name.
I see the point, but this is what I would expect as a user:

git clone ssh://host/path         # Always ssh, never local
git clone ./ssh://host/path       # Always local
git clone host:path               # scp syntax, border case:
                                  # if a git repo host:path exists on d=
isc,
                                  # use it
git clone ./host:path             # local, not scp ('/' before ':')

Beside that, git fetch, git fetch-pack all use the transport helper fro=
m
transport.c:
transport
struct transport *transport_get(struct remote *remote, const char *url)

to let the URL being parsed and to make the decision if an URL without =
a scheme
is ssh or a local file.

So I think that git clone can be slighty more consistant here.




>>
>>> There should be a check for the scheme first.
>>
>> That will be wrong.
>=20
> It matters mostly when dealing with scp-like syntax, word:path.
>=20
> I _think_ taking notice of "word://" (with doubled slashes) and
> treating it specially will not introduce any new issue; while it is
> still OK for users to have a local directory called "word:", if they
> meant a subdirectory of it, they wouldn't have typed double-slashes
> there.
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
