From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v3 1/3] lockfile.c: remove PATH_MAX limitation (except
 in resolve_symlink)
Date: Tue, 05 Aug 2014 09:10:24 -0700
Message-ID: <53E101F0.5090408@alum.mit.edu>
References: <1405858399-23082-1-git-send-email-pclouds@gmail.com> <1406814214-21725-1-git-send-email-pclouds@gmail.com> <1406814214-21725-2-git-send-email-pclouds@gmail.com> <xmqqfvhgw3q9.fsf@gitster.dls.corp.google.com> <xmqqtx5wuma8.fsf@gitster.dls.corp.google.com> <53DD2A54.1030403@web.de> <CACsJy8BAB3n5BRVaveTBrhdSDpiPBtm==TRjiv4ZR2P6iMne_w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Yue Lin Ho <yuelinho777@gmail.com>
To: Duy Nguyen <pclouds@gmail.com>,
	=?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 05 18:10:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XEhJo-0001ns-7d
	for gcvg-git-2@plane.gmane.org; Tue, 05 Aug 2014 18:10:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753583AbaHEQK2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 5 Aug 2014 12:10:28 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:43272 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753179AbaHEQK1 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 5 Aug 2014 12:10:27 -0400
X-AuditID: 1207440e-f79da6d0000002fc-62-53e101f28fa1
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 71.DF.00764.2F101E35; Tue,  5 Aug 2014 12:10:27 -0400 (EDT)
Received: from [192.168.1.18] (cpe-24-94-3-86.san.res.rr.com [24.94.3.86])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s75GAO9S026179
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Tue, 5 Aug 2014 12:10:25 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Icedove/24.5.0
In-Reply-To: <CACsJy8BAB3n5BRVaveTBrhdSDpiPBtm==TRjiv4ZR2P6iMne_w@mail.gmail.com>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrCKsWRmVeSWpSXmKPExsUixO6iqPuZ8WGwwZGjrBZdV7qZLBp6rzBb
	dE95y2ixe9oCNovOjq+MFm07jzA5sHnsnHWX3ePiJWWPxxNPsHp83iTncfvZNpYA1ihum6TE
	krLgzPQ8fbsE7ozVe+6yFbTxVJy+95KpgfEBZxcjJ4eEgInE4dvH2CFsMYkL99azgdhCApcZ
	Ja5P1O5i5AKyTzJJPHp3kgkkwSugLfF9+2GwIhYBVYmGw6eZQWw2AV2JRT3NYDWiAkESsz/P
	Y4eoF5Q4OfMJC8ggEYEpjBKTbvUzgjjMAt2MEn9OnQabJCyQILF2SQcrxOpXTBIt2/lBbE6B
	QIn5DW+BGjiAzhOX6GkMAjGZBdQl1s8TAqlgFpCXaN46m3kCo+AsJOtmIVTNQlK1gJF5FaNc
	Yk5prm5uYmZOcWqybnFyYl5eapGusV5uZoleakrpJkZIDPDtYGxfL3OIUYCDUYmHV0DtfrAQ
	a2JZcWXuIUZJDiYlUd7vvx8EC/El5adUZiQWZ8QXleakFh9ilOBgVhLhZb8NlONNSaysSi3K
	h0lJc7AoifOqLVH3ExJITyxJzU5NLUgtgsnKcHAoSfDGAGNdSLAoNT21Ii0zpwQhzcTBCTKc
	S0qkODUvJbUosbQkIx4Uv/HFwAgGSfEA7VUFaectLkjMBYpCtJ5iVJQS59VnAEoIgCQySvPg
	xsIS2ytGcaAvhXkNQdp5gEkRrvsV0GAmoMFmOvdBBpckIqSkGhjdbpyq1P9wwyFl/1eBJqWd
	/c53Kkz8t1WWSmTO8Z88cUJS9KwVT/eYnbzTtSjo7PQM0fjk0huP5v2a8GmV5Lll 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254809>

On 08/04/2014 03:13 AM, Duy Nguyen wrote:
> On Sun, Aug 3, 2014 at 1:13 AM, Torsten B=C3=B6gershausen <tboegi@web=
=2Ede> wrote:
> [...]
>> My first impression reading this patch was to rename
>> clear_filename() into free_and_clear_filename() or better free_filen=
ame(),
>> but I never pressed the send button ;-)
>>
>> Reading the discussion above makes me wonder if lk->filename may be =
replaced
>> by a strbuf
>> some day, and in this case clear_filename() will become reset_filenm=
ae() ?
>=20
> I didn't realize Mike is making a lot more changes in lockfile.c, par=
t
> of that is converting lk->filename to use strbuf [1]. Perhaps I shoul=
d
> just withdraw this series, wait until Mike's series is merged, then
> redo 3/3 on top. Or Mike could just take 3/3 in as part of his series=
=2E
>=20
> [1] http://thread.gmane.org/gmane.comp.version-control.git/246222/foc=
us=3D246232

I've neglected my patch series for ages (sorry!)  The last round of
review pointed out a couple of places where lock_file objects were stil=
l
being left in undefined states, and since then it also bit-rotted.

Over the past few days I re-rolled the patch series and fixed some more
code paths.  I still want to check it over before submitting it to the
list, but if you are interested the current version is here [1].

Duy, I'll try to look at your patches, but probably won't get to it
until next week when I return from vacation.

Michael

[1] https://github.com/mhagger/git branch "lock-correctness"

--=20
Michael Haggerty
mhagger@alum.mit.edu
